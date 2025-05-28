////
////  TournamentListView.swift
////  WoofleTesting
////
////  Created by I Made Bayu Putra Adnyana on 20/05/25.
////
//
//import SwiftUI
//
//struct TournamentListView: View {
//    @StateObject private var pastWinnerVM = PastWinnersViewModel()
//    @StateObject private var viewModel = TournamentViewModel(pastWinnersVM: pastWinnerVM)
//    @StateObject private var dogListVM = DogListViewModel(dogs: DummyData.dogs)
//    @StateObject private var userVM = UserViewModel()
//    @StateObject private var shelterListVM = ShelterListViewModel()
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(viewModel.selectedDogs, id: \.id) { dog in
//                    VStack(alignment: .leading) {
//                        Text(dog.name).font(.headline)
//                        Text(dog.breed).font(.subheadline)
//                    }
//                }
//    
//            }
//            .navigationTitle("Top 16 Dogs")
//            .toolbar {
//                Button("Generate") {
//                    viewModel.generateTournament(
//                        user: userVM.user,
//                        dogs: dogListVM.dogs,
//                        shelters: shelterListVM.shelters
//                    )
//                }
//            }
////            .onAppear {
////                viewModel.loadPreviousTournament(dogs: dogListVM.dogs.map { $0.dog })
////            }
//        }
//    }
//}
//
//#Preview {
//    TournamentListView()
//}
