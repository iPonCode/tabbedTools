//
//  FirstViewController.swift
//  tabbedTools
//
//  Created by superw on 25/11/2018.
//  Copyright © 2018 superw. All rights reserved.
//

import UIKit

//Aquí indicamos a este view controller que puede responder a eventos a través de un textField con UITextFieldDelegate.
//Además, el textField tendrá que dar permiso al view controller para delegar y realizar acciones en su nombre, esto se hace desde el interfaz gráfica de xcode arrastrando el textField con la tecla control pulsada y soltandolo en la zona de permisos del viewcontroller (en la caja que hay encima, en el primer icono de la izquierda de los tres que hay), al soltar vemos que en la sección de Outlets hay una opción de delegate. Esta es la forma de que el textFiel de permiso de delegado al FirstViewController
class FirstViewController: UIViewController, UITextFieldDelegate {
    //la conexión con la etiqueta cerca del slider para poder manejar su valor por código
    @IBOutlet weak var labelSliderNum: UILabel!
    //la conexión con el slider para poder recoger su valor y actualizar la variable global que luego utlizaré para actualizar las etiquetas
    @IBOutlet weak var sliderNum: UISlider!
    //una variable que utlizo para guardar el valor que selecciona el usuario al deslizar el slider, no es estrictamente necesario pero lo voy hago así porque me gusta más para hacer el casting a entero
    var userNum = -1 //inicializo con cualquier valor
    //usa variable que utilizo para guardar el valor que introduce el usuario en el textField
    var userKey = "" //inicializo con una cadena vacía

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n >>> ESTAMOS EN LA PRIMERA PESTAÑA: CLAVES <<< ")
        //utilizamos nuestra propia función para hacer las tareas de actualizar las etiquetas con el valor por defecto que tenga el slider al principio, según se carga
        updateSliderNumLabel()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //metodo que permite o previene la edición del contenido del campo de texto
    //esto se ejecutará según se haga tap en el campo de texto
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print ("1.- Antes de convertirse en el primer respondedor: Esto es ShouldBeginEditing")
        return true
    }
    
    //
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //notifica al objeto que ya ha cumplido su función y deja de ser protagonista, por tanto todo lo que estuviera haciendo (incluido usar el teclado) deja de ser relevante. Es decir, se derrará el teclado al darle al botón Aceptar.
        textField.resignFirstResponder()
        print ("Hemos pulsado la tecla ACEPTAR en un textField")
        //hacemos el casting seguro antes de mostrar
        //si me dejas crear la constante theText a partir del texto del textField, entonces la imprimo
        //esto no sería extrictamente necesario ya que el botón aceptar no se activa (no se puede pulsar) si el usuario no escribe nada
        if let theText = textField.text {
            //imprimo por consola el valor escrito por el usuario
            print ("El contenido del textField es: ")
            print (theText)
            //y lo actualizo o lo guardo en la variable global para tenerlo disponible cuando lo necesite
            self.userKey = theText
        }
        //devolvemos
        return true
    }
    
    //Acción mover para el slider
    @IBAction func sliderNumMoved(_ sender: UISlider) {
        //utilizamos nuestra propia función para hacer las tareas de actualizar las etiquetas con el valor seleccionado por el usuario
        updateSliderNumLabel()
    }
    
    func updateSliderNumLabel (){
        //recogemos el valor seleccionado con el slider en nuestra variable haciendo el casting a entero
        self.userNum = Int(self.sliderNum.value)
        //imprimimos el valor por consola cada vez que el usuario mueva el slider
        print(self.userNum)
        //y cambiamos el texto de la etiqueta correspondiente con el valor seleccionado por el usuario
        self.labelSliderNum.text = "\(self.userNum)"
        //tanto self. no sería estrictamente necesario..

    }

    //esto es lo que ocurrirá cuando el usuario pulse y suelte el botón de validar los datos
    @IBAction func validateData(_ sender: UIButton) {
        //queremos validar dos cosas, una si la palabra clave del textField es correcto y si el valor seleccionado en el slider es correcto
        let shouldUserAccess = (userKey == "clave") && userNum == 7 // menos restrictivo con || ya que sólo se tendrían que cumplir una de las condiciones
        if shouldUserAccess {
            print(" >>> ACCESO CONCEDIDO <<< ")
            self.view.backgroundColor = UIColor(red: 0.1, green: 1.0, blue: 0.3, alpha: 0.6)
            //self.view.backgroundColor = green

        } else {
            print (" >>> ACCESO DENEGADO <<< ")
            //self.view.backgroundColor = UIColor(red: 234.0/255.0, green: 119.0/255.0, blue: 10.0/255.0, alpha: 0.4)
            self.view.backgroundColor = UIColor(red: 1.0, green: 0.1, blue: 0.3, alpha: 0.6)
        }
        
        //dejo comentada la versión preliminar
        /*if userKey == "clave" {
            print(" >>> ACCESO CONCEDIDO por CLAVE<<< ")
            self.view.backgroundColor = UIColor(red: 49.0/255.0, green: 237.0/255.0, blue: 93.0/255.0, alpha: 0.4)
        } else {
            if userNum == 7 {
                print(" >>> ACCESO CONCEDIDO por NUMERO<<< ")
                self.view.backgroundColor = UIColor(red: 50.0/255.0, green: 160.0/255.0, blue: 250.0/255.0, alpha: 0.4)
            } else {
                print (" >>> ACCESO DENEGADO <<< ")
                self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 0.4)
            }
        }*/
    }
    
    @IBAction func swipeLeftResetBackground(_ sender: UISwipeGestureRecognizer) {
        print (" >>> FONDO RESTABLECIDO <<< ")
        self.view.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    }
    
}

