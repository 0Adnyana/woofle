import Foundation

final class TournamentViewModel: ObservableObject {
    @Published var selectedDogs: [Dog] = []
    @Published var bracket: [[Dog]] = []
    @Published var currentRound: Int = 0
    @Published var rounds: [[[Dog]]] = []
    @Published var winners: [Dog] = []

    private let pastWinnersFileName = "past_winners.json"

    func startNewTournament(user: UserProfile, dogs: [Dog], shelters: [Shelter], pastWinners: [UUID]) {
        let eligibleDogs = dogs.filter { !pastWinners.contains($0.id) }
        let result = TournamentSelector.run(user: user, dogs: eligibleDogs, shelters: shelters)
        self.selectedDogs = eligibleDogs.filter { result.dogIds.contains($0.id) }
        self.bracket = generateSeedingBracket(from: selectedDogs)
        self.rounds = [bracket]
        self.currentRound = 0
        saveToUserDefaults(result.dogIds)
    }

    private func generateSeedingBracket(from dogs: [Dog]) -> [[Dog]] {
        let count = dogs.count
        return (0..<count / 2).map { i in
            [dogs[i], dogs[count - 1 - i]]
        }
    }

    func advanceRound(withWinners winners: [Dog]) {
        self.winners = winners

        if winners.count == 1 {
            saveFinalWinner(winner: winners.first!)
        }

        if winners.count > 1 {
            let nextBracket = generateNextBracket(from: winners)
            rounds.append(nextBracket)
            currentRound += 1
        }
    }

    private func generateNextBracket(from dogs: [Dog]) -> [[Dog]] {
        let count = dogs.count
        return (0..<count / 2).map { i in
            [dogs[i * 2], dogs[i * 2 + 1]]
        }
    }

    func generateTournament(user: UserProfile, dogs: [Dog], shelters: [Shelter]) {
        let result = TournamentSelector.run(user: user, dogs: dogs, shelters: shelters)
        self.selectedDogs = dogs.filter { result.dogIds.contains($0.id) }
        saveToUserDefaults(result.dogIds)
    }

    func loadPreviousTournament(dogs: [Dog]) {
        guard let data = UserDefaults.standard.data(forKey: "tournament_dog_ids"),
              let ids = try? JSONDecoder().decode([UUID].self, from: data) else {
            return
        }
        self.selectedDogs = dogs.filter { ids.contains($0.id) }
    }

    private func saveToUserDefaults(_ ids: [UUID]) {
        if let encoded = try? JSONEncoder().encode(ids) {
            UserDefaults.standard.set(encoded, forKey: "tournament_dog_ids")
        }
    }

    private func saveFinalWinner(winner: Dog) {
        let fileManager = FileManager.default
        guard let docURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = docURL.appendingPathComponent(pastWinnersFileName)

        var savedIDs: [UUID] = []

        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([UUID].self, from: data) {
            savedIDs = decoded
        }

        savedIDs.append(winner.id)

        if let encoded = try? JSONEncoder().encode(savedIDs) {
            try? encoded.write(to: fileURL)
        }
    }
}
