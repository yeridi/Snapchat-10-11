//
//  ViewController.swift
//  Snapchat
//
//  Created by mbtec22 on 5/13/21.
//


import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextFIeld: UITextField!
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextFIeld.text!, completion: { (user,error) in
            print("Intentamos Iniciar Sesión")
            if error != nil {
                print("Tenemos el siguiente error:\(error)")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextFIeld.text!, completion: { (user,error) in
                    print("Intentamos Crear un Usuario")
                    if error == nil{
                        print("El usuario fue creado existosamente")
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    }else{
                        print("Tenemos el siguiente error:\(error)")
                        Database.database().reference().child("usuarios").child(user!.user.uid)
                            .child("email").setValue(user!.user.email)
                    }
                })
            }else{
                print("Inicio de Sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

