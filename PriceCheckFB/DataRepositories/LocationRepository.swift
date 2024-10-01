// Created by Prof. H in 2022
// Part of the PriceCheckFB project
// Using Swift 5.0
// Qapla'


import Combine
// import Firebase modules here
import Firebase
//import FirebaseCore
import FirebaseFirestore



class LocationRepository: ObservableObject {
  // Set up properties here

  private let store = Firestore.firestore()
  private let path = "location_scans"
  @Published var locations: [Location] = []
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    get()
  }

  func get() {
    // Complete this function
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting books: \(error.localizedDescription)")
          return
        }
        
        self.locations = querySnapshot?.documents.compactMap {
          document in
          try? document.data(as: Location.self)
        } ?? []
      }
  }
}
