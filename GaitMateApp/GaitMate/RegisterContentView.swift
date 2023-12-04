import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn

struct RegisterContentView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var passwordMatchError = false
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
                .bold()
                .padding()
                .foregroundColor(.black)
            
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: confirmPassword) { newValue in
                    passwordMatchError = password != newValue
                }
                .foregroundColor(passwordMatchError ? .red : .black)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(passwordMatchError ? Color.red : Color.clear, lineWidth: 1)
                )
            
            if passwordMatchError {
                Text("Passwords do not match")
                    .foregroundColor(.red)
                    .padding(.bottom, 5)
            }
            
            Button("Register") {
                if !passwordMatchError {
                    registerUser()
                }
            }
            .foregroundColor(.white)
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            .padding()
            
//            GoogleSignInButton { user, error in
//                if let error = error {
//                    print("Google Sign-In failed: \(error.localizedDescription)")
//                    // Handle Google Sign-In failure (e.g., show an error message)
//                } else if let user = user {
//                    // Handle Google Sign-In success (you may want to link the Google account to the Firebase account)
//                    print("Google Sign-In successful. User ID: \(user.userID ?? "")")
//                }
//            }
            .frame(width: 200, height: 50)
            .padding()
            
            Spacer()
        }
        .padding()
    }
    
    func registerUser() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Registration failed: \(error.localizedDescription)")
                // Handle registration failure (e.g., show an error message)
            } else {
                print("Registration successful")
                // Optionally, you can perform additional actions upon successful registration
            }
        }
    }
}

struct RegisterContentView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterContentView()
    }
}
