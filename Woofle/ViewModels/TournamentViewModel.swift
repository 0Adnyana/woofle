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

    var matchProgressText: String {
        return "Match \(currentMatchIndex + 1) of \(bracket.count)"
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
        let user = userService.load()
        let eligibleDogs = dogs.filter { !winnersStorage.load().contains($0.id) }
        let topDogs = matchingService.match(user: user, dogs: eligibleDogs, shelters: shelters)

        self.selectedDogs = topDogs
        self.bracket = engine.generateSeedingBracket(from: topDogs)
        self.rounds = [bracket]
        self.currentRound = 0
        self.currentMatchIndex = 0
        self.winners = []
        self.isTournamentFinished = false
    }

    func selectWinner(_ dog: Dog) {
        winners.append(dog)
        currentMatchIndex += 1

        if currentMatchIndex >= bracket.count {
            advanceRound()
        }
    }

    private func advanceRound() {
        if winners.count == 1 {
            winnersStorage.save(newWinners: [winners.first!])
            isTournamentFinished = true
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
