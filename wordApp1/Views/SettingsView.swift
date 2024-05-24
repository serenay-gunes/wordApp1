import SwiftUI

struct SettingsView: View {
    @AppStorage("quizSize") private var quizSize: Int = 10
    @State private var showAlert: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Quiz Ayarları")) {
                Stepper(value: $quizSize, in: 1...20) {
                    Text("Quiz Boyutu: \(quizSize)")
                }
            }

            Button(action: {
                // Quiz boyutunu kaydet
                showAlert = true
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
    }
}

#Preview {
    SettingsView()
}
