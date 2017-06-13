import Firebase

class UserDataAPIClient {
    
    static func createUserAccount(email: String, password: String) {
        let setData = SetData()
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            guard let uid = user?.uid else { return }
            setData.setup(email: email, id: uid)
            setData.setup(userPlaytime: 0, id: uid)
        }
    }
    
    static func loginToAccount(email: String, password: String, completion: @escaping(User) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            guard let user = user else { return }
            completion(user)
        }
    }
}
