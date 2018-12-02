//
//  SecondViewController.swift
//  tabbedTools
//
//  Created by superw on 25/11/2018.
//  Copyright © 2018 superw. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    //variable (array de enteros) que irá guardando los números de fibonacci generados inicializandola con los dos números enteros obligarotios
    var fibonacci : [Int] = [0,1]
    //variable para guardar cuantos números de fibonacci quiero generar
    var fibID = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        //según se cargue la vista, es decir, el usuario haga tap en la segunda pestaña se ejecuta este código
        fibID = 92 //establezco el fibID en el máximo que me es capaz de almacenar en un tipo Int
        generateFibonacciNumbers() //llamo a la función que me genera los números
    }
    
    func generateFibonacciNumbers() {
        //si el número a generar es menor o igual que uno no tiene sentido generarlos porque ya hemos inicializado con [0,1] el array.
        //también limitamos por encima de los 92 primeros números por motivos computacioinales no vamos a calcularlos
        //FYI: El último número de fibonacci que cabe en un tipo Int es el 7540113804746346429 que corresponde con el número 92 de la serie de fibonacci
        if (fibID <= 1) || (fibID > 92) {
            print(" >>> ABORTANDO.. FUERA DE RANGO <<< ")
            return //si fibID no está en el rango permitido simplemente salimos
        }
        //a partir de aquí ya podemos trabajar con el fibID para generar números de fibonacci
        //antes de nada restablecemos la colección
        fibonacci = [0,1]
        //vamos recorriendo el array
        for i in 2...fibID { //desde el número 2 hasta el fibID incluido
            //para cada elemento agregamos la suma de los dos anteriores
            fibonacci.append(fibonacci[i-1]+fibonacci[i-2])
            print("posición \(i): \(fibonacci[i])")
            //imprimimos el elemento añadido cada vez
        }
        //print(fibID)
        //print(fibonacci)
    }
    


}

