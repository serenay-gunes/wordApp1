import SwiftUI

struct SettingsView: View {
    @State private var quizSize: Int = UserDefaults.standard.integer(forKey: "QuizSize")
    @State private var showAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("Quiz Ayarları")) {
                Stepper(value: $quizSize, in: 1...20) {
                    Text("Quiz Boyutu: \(quizSize)")
                }
            }
            
            Button(action: {
                saveQuizSize()
            }) {
                Text("Kaydet")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Ayarlar Kaydedildi"), message: Text("Quiz boyutu \(quizSize) olarak ayarlandı."), dismissButton: .default(Text("Tamam")))
            }
        }
        .navigationTitle("Ayarlar")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Quiz Boyutu Kaydedildi"), message: Text("Quiz boyutu \(quizSize) olarak kaydedildi."), dismissButton: .default(Text("Tamam")))
        }
    }
    
    func saveQuizSize() {
        UserDefaults.standard.set(quizSize, forKey: "QuizSize")
        showAlert = true
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
