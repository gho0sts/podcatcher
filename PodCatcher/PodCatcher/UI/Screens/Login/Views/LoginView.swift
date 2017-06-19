import UIKit

final class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    var model: LoginViewModel! {
        didSet {
            submitButton.isEnabled = model.validContent
            submitButton.backgroundColor = model.buttonColor
            dump(model.buttonColor)
        }
    }
    
    // MARK: - UI Elements
    
    var usernameField: UITextField = {
        var usernameField = UnderlineTextField()
        usernameField.placeholder = "Email"
        return usernameField
    }()
    
    private var passwordField: UnderlineTextField = {
        var passwordField = UnderlineTextField()
        passwordField.isSecureTextEntry = true
        return passwordField
    }()
    
    fileprivate var submitButton: UIButton = {
        var borderColor = UIColor.lightText.cgColor
        let submitButton = BasicButtonFactory(text: "Login", textColor: .white, borderWidth: 2, borderColor: borderColor, backgroundColor: .lightText)
        return submitButton.createButton()
    }()
    
    // MARK: - Configuration Methods
    
    override func layoutSubviews() {
        tag = 1
        super.layoutSubviews()
        backgroundColor = .white
        usernameField.delegate = self
        passwordField.delegate = self
        passwordField.setupPasswordField()
        passwordField.setup()
        var emailField = usernameField as! UnderlineTextField
        emailField.setupEmailField()
        emailField.setup()
        usernameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        setup(usernamefield: usernameField)
        setup(passwordField: passwordField)
        setup(submitButton: submitButton)
        submitButton.layer.cornerRadius = 10
        submitButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    func configure(model: LoginViewModel) {
        self.model = model
        usernameField.text = "Link@link.com"
        passwordField.text = "123456"
        submitButton.isEnabled = true
    }
    
    private func sharedLayout(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: LoginViewConstants.sharedLayoutHeightMultiplier).isActive = true
        view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: LoginViewConstants.sharedLayoutWidthMultiplier).isActive = true
    }
    
    private func setup(usernamefield: UITextField) {
        sharedLayout(view: usernameField)
        usernamefield.topAnchor.constraint(equalTo: topAnchor, constant: LoginViewConstants.usernameFieldTopOffset).isActive = true
    }
    
    private func setup(passwordField: UITextField) {
        sharedLayout(view: passwordField)
        passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: LoginViewConstants.passwordFieldTopOffset).isActive = true
    }
    
    private func setup(submitButton: UIButton) {
        sharedLayout(view: submitButton)
        submitButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: LoginViewConstants.submitButtonTopOffset).isActive = true
    }
    
    func loginButtonTapped() {
        guard let username = usernameField.text, let password = passwordField.text else { return }
        delegate?.userEntryDataSubmitted(with: username, and: password)
    }
}
