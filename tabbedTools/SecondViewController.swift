//
//  SecondViewController.swift
//  tabbedTools
//
//  Created by superw on 25/11/2018.
//  Copyright © 2018 superw. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    //el outlet para controlar por código la etiqueta que represente el número que el usuario elige con el stepper
    @IBOutlet weak var labelNum: UILabel!
    //el outlet para controlar por código el textView donde se mostrará la secuencia de fibonacci hasta el número que el usuario haya seleccionado
    @IBOutlet weak var textViewResult: UITextView!
    //este outlet del stepper es para poder tomar el valor del mismo luego más tarde en el viewdidload, necesitamos referenciarlo para acceder a su valor según se cargue
    @IBOutlet weak var stepper: UIStepper!
    //este outlet es para controlar por código la etiqueta donde se muestra el número de oro si el usuario lo ha seleccionado en el switch
    @IBOutlet weak var labelGoldNum: UILabel!
    
    //variable (array de enteros) que irá guardando los números de fibonacci generados inicializandola con los dos números enteros obligarotios
    var fibonacci : [Int] = [0,1]
    //variable para guardar cuantos números de fibonacci quiero generar, será un Int y tengo que inicializarla con algún valor
    var fibID : Int = 1
    //variable booleana que guarda el estado del switch con la decisión del usuairo de si quiere o no calcular el número de oro
    var wantsGoldNum : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        //según se cargue la vista, es decir, el usuario haga tap en la segunda pestaña, entonces se ejecuta este código
        //comento la siguiente línea porque ya no quiero inicializar fibID así, ahora que tenemos un stepper, lo haré de otra forma en la función updateLabel
        /*fibID = 92 //establezco el fibID en el máximo que me es capaz de almacenar en un tipo Int*/
        
        //inicializo el fibID con el valor inicial que tenga el stepper haciendo el casting a Int ya que el valor del stepper será double utilizando la función updateLabel
        updateLabel(id: Int(self.stepper.value))
    }
    
    func generateFibonacciNumbers() {
        //si el número a generar es menor o igual que uno no tiene sentido generarlos porque ya hemos inicializado con [0,1] el array.
        //también limitamos por encima de los 92 primeros números por motivos computacioinales no vamos a calcularlos
        //FYI: El último número de fibonacci que cabe en un tipo Int es el 7540113804746346429 que corresponde con el número 92 de la serie de fibonacci
        //este if ya no será necesario y se deja comentado ya que ahora los valores máximos y mínimo los controlamos desde el Stepper
        /*if (fibID <= 1) || (fibID > 92) {
            print(" >>> ABORTANDO.. FUERA DE RANGO <<< ")
            return //si fibID no está en el rango permitido simplemente salimos
        }*/
        //a partir de aquí ya podemos trabajar con el fibID para generar números de fibonacci
        //antes de nada restablecemos la colección
        fibonacci = [0,1]
        //vamos recorriendo el array
        print("fibID: \(fibID)")
        print("array fibonacci: \(fibonacci)")
        for i in 2...fibID { //desde el número 2 hasta el fibID incluido
            //para cada elemento agregamos la suma de los dos anteriores
            fibonacci.append(fibonacci[i-1]+fibonacci[i-2])
            //imprimimos el elemento añadido cada vez
            print("número \(i+1): \(fibonacci[i])")
        }
        
        //aquí utilizamos métodos nuevos implementados en Swift 4 Map, Filter y Reduce. En realidad utilizamos sus variantes compactMap y joined para obtener la versión array de String del array de Int con la serie de fibonacci y luego convertirlo todo en un solo String agregando un separador entre los elementos para poder mostrarlo en el textView
        //creamos un array de String a partir del array de Int, se utiliza un clousure donde dado un número entero devuelve la versión stringuizada del mismo, uno por uno pasando como parámetro $0. Este clousure es un mapeo o transformación de todos los elementos del array por eso indicamos $0. Es lo mismo que si hiciérmos un bucle for in que recorriera todos los elementos
        let fibStr : [String] = fibonacci.compactMap({ String($0)})
        //creamos un solo String que guardará todo el array un elemento detrás de otro separado por el caracter indicado utilizando joined
        let result : String = fibStr.joined(separator: "·")
        //finalmente mostramos el String en el textView al usuario
        textViewResult.text = result
    }
    
    //action para controlar el evento cuando se pulsan los botones del stepper
    @IBAction func stepperPressed(_ sender: UIStepper) {
        //sender es el stepper y tiene una variable value que es double y habrá que hacer un casting a Int pasándoselo a la funcion updateLbel
        updateLabel(id: Int(sender.value))
    }
    
    //acción para controlar el evento cuando se desliza (o se mueve) el switch
    @IBAction func switchMoved(_ sender: UISwitch) {
        self.wantsGoldNum = sender.isOn //cuando el usario deslice actulizamos la variable global
        calculateGoldNum() //y calculamos el número de oro si procede
    }
    
    //funcion que actualiza la etiqueta del stepper y llama a generateFibonacciNumbers para generarlos
    func updateLabel(id : Int){
        //actualizadmos fibID con el parámetro que recibimos, self. no sería necesario pero lo ponemos para indicar que fibID es una variable de clase
        self.fibID = id
        //actualizamos la etiqueta del stepper, en realidad muestro uno más que el fibID en la etiqueta del stepper porque el número la posición 0 en el corresponde con el primer número de la sucesión, el de la posición 1 corresponde con el segundo número de la sucesión, etc..
        self.labelNum.text = "\(self.fibID+1)"
        //interesa también que cada vez que se actualizan las etiquetas se generen los números de fibonacci
        generateFibonacciNumbers()
        //y se calcule el número de oro si es que el usuairo lo ha seleccionado en el switch
        calculateGoldNum()
    }
    
    //función que calcula el número de oro si el usuario lo ha seleccionado en el switch
    func calculateGoldNum () {
        //si el usuario quiere número de oro
        if (self.wantsGoldNum) {
            //hay que calcular el número de oro como cociente entre los dos últimos de la sucesión de fibonacci y mostrarlo en la etiqueta
            let previous = Double(fibonacci[fibonacci.count-2])
            let last = Double(fibonacci[fibonacci.count-1])
            let goldNum = last / previous //calculamos el número de oro en un Double
            self.labelGoldNum.text = String(goldNum) //lo mostramos en la etiqueta como String
            print(" >>> QUIERE número áureo <<< \(goldNum)")

        } else {
            //no hay que calcular el número de oro y hay que restablecer el texto de la etiqueta
            print(" >>> NO QUIERE número áureo <<< ")
            self.labelGoldNum.text = "" //limpiamos la etiqueta
        }
    }


}

