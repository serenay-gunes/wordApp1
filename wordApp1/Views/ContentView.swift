




import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct ContentView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
            BView()
        } else {
            LoginView()
        }
    }
        
        
        
       /* Te xt("Hello, Firebase!")
            .onAppear {
                // Firebase kullanımı örneği
                let auth = Auth.auth()
                let db = Firestore.firestore()
                let storage = Storage.storage()
                print(auth, db, storage)
            }
        */
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

