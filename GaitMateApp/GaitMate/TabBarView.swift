import SwiftUI
import FirebaseAuth

struct TabbarView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    var body: some View {
        Group {
            if isLoggedIn {
                TabView {
                    NavigationView {
                        ExoView()
                    }
                    .tag(0)
                    .tabItem {
                        Image("bionicLeg")
                            .resizable()
                        Text("My Exoskeleton")
                    }

                    NavigationView {
                        AccountView()
                    }
                    .tag(2)
                    .tabItem {
                        Image("account")
                        Text("Account")
                    }
                }
            } else {
                WelcomeView()
            }
        }
        .onAppear {
            checkUserLoggedIn()
        }
    }

    func checkUserLoggedIn() {
        isLoggedIn = Auth.auth().currentUser != nil
    }
}
