//
//  FontDetailViewController.swift
//  tabbedTools
//
//  Created by superw on 05/12/2018.
//  Copyright © 2018 superw. All rights reserved.
//

import UIKit

class FontDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    //variables IBOulet para el control por código de los elementos del interfaz grafico. Necesitamos motificar el contenido de la etiqueta del título y conocer qué fuente ha elegido el usuario en el picker para poder cambiar el texto del text view y configurarlo con la fuente seleccionada
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var pickerFonts: UIPickerView!
    @IBOutlet weak var textView: UITextView!
    
    //Estas dos variables globales quedarán configuradas a través del segue y me van a permitir guardar la información que me pase el ThirdViewController cuando el usuario pulse una celda de la tabla. Podrían ser constantes pero tendríamos que inicializarlas sobreescribiendo un método Init y da mucha pereza. Accederemos a ellas instanciando un objeto de esta clase FontDetailViewController en ThirdViewController. De esta forma pasamos la info que necesitamos de un view controller a otro (en medio existe un navigation controller que tendremos que tener en cuenta a la hora acceder al segue, esto lo haremos en ThirdViewController)
    var familyNameVarFDVC : String = "" //guardará el nombre de la familia seleccionada
    var fontsVarFDVC : [String] = [] //guardará todos los nombres de fuentes de esa familia
    
    //esto ocurrirá según se muestre este FontDetailViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n >>> ESTAMOS EN LA PESTAÑA: DETALLE DE LA FAMILIA DE LA FUENTE <<< ")
        self.labelTitle.text = familyNameVarFDVC //actualizamos el título de la etiqueta con el nombre de la familia recibida por el segue
        self.labelTitle.font = UIFont(name: familyNameVarFDVC, size: 20.0) //definimos la fuente de la etiqueta título con el nombre de la misma fuente que ha seleccionado el usuario y que recibimos por el segue
        
        //esto es para indicar el delegado y data source por codigo en lugar de hacerlo a través de la interface gráfica de xcode arrastrando con la tecla control pulsada
        self.pickerFonts.dataSource = self //la fuente de datos de la variable global pickerFonts va a ser mi propia clase FontDetailViewController
        self.pickerFonts.delegate = self //el delegado de la variable global pickerFonts también va a ser mi propia clase FontDetailViewController

        //controlar con este condicional si no hay nombres de fuentes en una familia escondemos el pickerView
        if fontsVarFDVC.count == 0 {
            pickerFonts.isHidden = true //por ejemplo, la familia "Bangla Sangam MN" no tiene nombres de fuentes, si seleccionamos esta familia en el tableView al entrar en el FontDetailViewController se debería esconder (no mostrar) el PickerView puesto que no hay nada que mostrar
        }
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation
     
     //este método se ejecuta siempre que se llama a un segue donde se hace la transición hacia el navigation controller (y luego a la vista detalle)
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        }
    }
    */

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        //cerramos el view controller de forma animada, el segundo parámetro completion handler puede ser nil o incluso se puede borrar
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Métodos del UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //el número de componentes es el número de columnas, que en nuestro caso será sólo una (por ejmplo, un picker de fecha tiene 3 componentes dia mes año)
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //tendremos tantas filas como número de fuentes haya
        return self.fontsVarFDVC.count
    }
    
    //con esta función pintaremos los títulos de cada fila del picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //devuelvo el contenido de la fila que es un String con el nombre de las fuentes
        return fontsVarFDVC[row]
    }
}
