




import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct ContentView: View {
    @StateObject var viewModel = MainViewViewModel()

    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            TabView {
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                        Text("Profil")
                    }
                AddWordView()
                    .tabItem {
                        Image(systemName: "plus.rectangle.on.rectangle")
                        Text("Kelime Ekle")
                    }
                WordListView()
                    .tabItem {
                        Image(systemName: "text.word.spacing")
                        Text("Listele")
                    }
                QuizView()
                    .tabItem {
                        Image(systemName: "questionmark.circle.fill")
                        Text("Quiz")
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Ayarlar")
                    }
            }
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

    
    
    
  

