import Foundation

final class TournamentViewModel: ObservableObject {
    @Published var selectedDogs: [Dog] = []
    @Published var bracket: [[Dog]] = []
    @Published var currentRound: Int = 0
    @Published var rounds: [[[Dog]]] = []
    @Published var winners: [Dog] = []
    @Published var currentMatchIndex: Int = 0
    @Published var isTournamentFinished: Bool = false

    var currentMatch: [Dog]? {
        guard currentMatchIndex < bracket.count else { return [] }
        return bracket[currentMatchIndex]
    }

    var isFinalRound: Bool {
        return bracket.count == 1 && currentRound == rounds.count - 1
    }
    
    var hasMoreRounds: Bool {
        return currentRound < rounds.count
    }

    var numberOfRounds: Int {
        return rounds.count
    }

    var isBracketEmpty: Bool {
        return bracket.isEmpty
    }
    
    var matchProgressText: String {
        return "Match \(currentMatchIndex + 1) of \(bracket.count)"
    }

    var finalWinner: Dog? {
        isFinalRound ? winners.first : nil
    }
    
    var currentMatchIsResolved: Bool {
        winners.count > currentMatchIndex
    }

    private let pastWinnersVM: PastWinnersViewModel

    init(pastWinnersVM: PastWinnersViewModel) {
        self.pastWinnersVM = pastWinnersVM
    }

    func startNewTournament(user: UserProfile, dogs: [Dog], shelters: [Shelter]) {
        let eligibleDogs = dogs.filter { !pastWinnersVM.winnerIds.contains($0.id) }
        print(eligibleDogs.count)
        let result = TournamentSelector.run(user: user, dogs: eligibleDogs, shelters: shelters)
        self.selectedDogs = result.dogs
        self.bracket = TournamentEngine.generateSeedingBracket(from: selectedDogs)
        self.rounds = [bracket]
        self.currentRound = 0
        saveDogsToUserDefaults(result.dogs)
    }

    func generateSeedingBracket(from dogs: [Dog]) -> [[Dog]] {
        let count = dogs.count
        return (0..<count / 2).map { i in
            [dogs[i], dogs[count - 1 - i]]
        }
    }

    private func advanceRound(withWinners winners: [Dog]) {
        self.winners = winners

        if winners.count == 1 {
            pastWinnersVM.addWinners([winners.first!])
            isTournamentFinished = true
        } else {
            let nextBracket = TournamentEngine.generateNextBracket(from: winners)
            rounds.append(nextBracket)
            currentRound += 1
            self.bracket = nextBracket
        }
    }

    
    func selectWinner(_ dog: Dog) {
        winners.append(dog)
        currentMatchIndex += 1

        if currentMatchIndex >= bracket.count {
            advanceRound(withWinners: winners)
            currentMatchIndex = 0
            winners = []
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
        self.selectedDogs = result.dogs
        saveDogsToUserDefaults(result.dogs)
    }

    func loadPreviousTournamentDogs() {
        guard let data = UserDefaults.standard.data(forKey: "tournament_dogs"),
              let decoded = try? JSONDecoder().decode([Dog].self, from: data) else {
            return
        }

        self.selectedDogs = decoded
    }


    private func saveDogsToUserDefaults(_ dogs: [Dog]) {
        if let encoded = try? JSONEncoder().encode(dogs) {
            UserDefaults.standard.set(encoded, forKey: "tournament_dogs")
        }
    }

}
