//
//  FontDetailViewController.swift
//  tabbedTools
//
//  Created by superw on 05/12/2018.
//  Copyright © 2018 superw. All rights reserved.
//

import UIKit

class FontDetailViewController: UIViewController {
    
    //variables IBOulet para el control por código de los elementos del interfaz grafico. Necesitamos motificar el contenido de la etiqueta del título y conocer qué fuente ha elegido el usuario en el picker para poder cambiar el texto del text view y configurarlo con la fuente seleccionada
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var pickerFonts: UIPickerView!
    @IBOutlet weak var textView: UITextView!
    
    //esto ocurrirá según se muestre este FontDetailViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n >>> ESTAMOS EN LA PESTAÑA: DETALLE DE LA FAMILIA DE LA FUENTE <<< ")

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        //cerramos el view controller de forma animada, el segundo parámetro completion handler puede ser nil o incluso se puede borrar
        self.dismiss(animated: true, completion: nil)
    }
}
