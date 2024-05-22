import Foundation
import Firebase
import SwiftUI
import FirebaseFirestore

class WordListViewModel: ObservableObject {
    @Published var words = [Word]()
    @Published var isLoading = true
    @Published var errorMessage: String = ""

    init() {
        fetchWords()
    }

    func fetchWords() {
        guard let userId = Auth.auth().currentUser?.uid else {
            self.errorMessage = "Kullanıcı oturumu açılmamış."
            self.isLoading = false
            return
        }

        let db = Firestore.firestore()
        db.collection("words").getDocuments { snapshot, error in
            if let error = error {
                self.errorMessage = "Veriler alınırken hata oluştu: \(error.localizedDescription)"
                self.isLoading = false
                return
            }

            guard let documents = snapshot?.documents else {
                self.errorMessage = "Veri bulunamadı."
                self.isLoading = false
                return
            }

            self.words = documents.compactMap { doc -> Word? in
                var word = try? doc.data(as: Word.self)
                word?.id = doc.documentID // Belgenin ID'sini Word modeline ekler
                return word
            }
            self.isLoading = false
        }
    }
}
