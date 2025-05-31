import Foundation

final class TournamentViewModel: ObservableObject {
    @Published var selectedDogs: [Dog] = []
    @Published var bracket: [[Dog]] = []
    @Published var currentRound: Int = 0
    @Published var rounds: [[[Dog]]] = []
    @Published var winners: [Dog] = []
    @Published var currentMatchIndex: Int = 0
    @Published var isTournamentFinished: Bool = false
    @Published var phase: TournamentPhase = .idle
    @Published var shelters: [Shelter] = []

    
    enum TournamentPhase {
        case idle
        case loading
        case inProgress
        case finished
    }

    var currentMatch: [Dog]? {
        guard currentMatchIndex < bracket.count else { return nil }
        let match = bracket[currentMatchIndex]
        return match.isEmpty ? nil : match
    }


    var matchProgressText: String {
        return "Round \(currentMatchIndex + 1) of \(bracket.count)"
    }

    private let userService: UserStorageService
    private let matchingService: TournamentMatchingService
    private let engine: TournamentEngineProtocol
    private let winnersStorage: PastWinnersStorageService

    init(
        userService: UserStorageService = UserStorageService(),
        matchingService: TournamentMatchingService = TournamentMatchingService(),
        engine: TournamentEngineProtocol = TournamentEngine(),
        winnersStorage: PastWinnersStorageService = PastWinnersStorageService()
    ) {
        self.userService = userService
        self.matchingService = matchingService
        self.engine = engine
        self.winnersStorage = winnersStorage
    }

    func startNewTournament(dogs: [Dog], shelters: [Shelter]) {
        phase = .loading

        let user = userService.load()
        let eligibleDogs = dogs.filter { !winnersStorage.load().contains($0.id) }
        let matchedDogs = matchingService.match(user: user, dogs: eligibleDogs, shelters: shelters)

        print("✅ Matched dogs: \(matchedDogs.count)")

        let bracket = engine.generateSeedingBracket(from: matchedDogs)
        print("✅ Bracket created with \(bracket.count) matches")

        guard bracket.count > 0 else {
            print("❌ Bracket was empty — aborting tournament")
            phase = .finished
            return
        }

        self.selectedDogs = matchedDogs
        self.bracket = bracket
        self.rounds = [bracket]
        self.currentRound = 0
        self.currentMatchIndex = 0
        self.winners = []
        self.isTournamentFinished = false
        self.phase = .inProgress
        self.shelters = shelters
    }


    func selectWinner(_ dog: Dog) {
        winners.append(dog)
        currentMatchIndex += 1

        if currentMatchIndex >= bracket.count {
            advanceRound()
        }
    }
    
    func shelter(for dog: Dog) -> Shelter? {
        shelters.first(where: { $0.id == dog.shelterId })
    }


    private func advanceRound() {
        if winners.count == 1 {
            winnersStorage.save(newWinners: [winners.first!])
            isTournamentFinished = true
            phase = .finished
            return
        }

        let next = engine.generateNextBracket(from: winners)
        rounds.append(next)
        currentRound += 1
        bracket = next
        currentMatchIndex = 0
        winners = []
    }
}
