//
//  ThirdViewController.swift
//  tabbedTools
//
//  Created by superw on 26/11/2018.
//  Copyright © 2018 superw. All rights reserved.
//

import UIKit

//class ThirdViewController: UIViewController {
class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    //las tareas de la table view no las va a llevar a cabo la table view sino el view controller de modo que hay que configurar dos protocolos: UITableViewDelegate que se encarga de responder cuando hay interacciones, por ejemplo cuando se hace scroll, se seleciona una celda.. y UITableViewDatasource se encarga de la fuente de datos, es decir, con qué vamos a rellenar la tabla.
    //para configurar que el ThirdViewController será el delegado tanto para el delegate como para el datasource, es necesario arrastrar (2 veces) con el control pulsado desde la Table View y soltar en el primer icono de la caja de arriba, en el desplegable que aparece al soltar se selecciona el que corresponda. De esta forma queda indicado que el ThirdViewController sera tanto el delegate como el datasource.
    //además, el protocolo datasource requiere implementar dos métodos obligatorios (los pondermos más abajo donde definimos funciones con una MARCA llamada Métodos del protocolo UIViewDatasource)
    
    //aunque esta variable no va a mutar su valor como es global, si hiciera constante con let tendría que inicializarla sobreescribiendo un método Init (contructor de la clase), así que se queda como variable global
    var families : [String] = [] //esto es un array de String y la inicializo vacía
    var fonts : [String:[String]] = [:] //esto es un diccionario de String como clave y array de String como valor, esta sí que tiene que ser variable porque iremos agregando fuentes mientras recorremos el array de familias
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n >>> ESTAMOS EN LA TERCERA PESTAÑA: FUENTES <<< ")
        //invocamos a la clase UIFont para recuperar el nombre de todas las familias de fuentes
        //comento la siguiente línea porque ahora voy a recuperar los nombres de las fuentes en orden descendente: Los String son comparables con su nombre lexico-grafico
        //self.families = UIFont.familyNames //inicializo este array de String global con el nombre de todas las mamilias de fuentes
        self.families = UIFont.familyNames.sorted(by: { (s1, s2) -> Bool in
            return s1 < s2
        })
        for fam in families { //para cada familia, voy accediendo a sus nombres de fuente
            let currentFont = UIFont.fontNames(forFamilyName: fam)
            fonts[fam] = currentFont
            /*print("\n")
            print(fam)
            print("__________________")
            print(currentFont)*/
        }
        print(" >>> COLECCIÓN DE FAMILIAS Y FUENTES (fonts) <<< ") //después del bucle imprimo 1 vez todas las fuentes que he ido guardando en el diccionario fonts
        print(" _______________________________________________ \n")
        print(fonts) //imprimo todo el diccionario
        print("\n*******************")
        print("Número de familias o de parejas clave-valor del diccionario (fonts.count): >> \(fonts.count) <<")

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

    // MARK: - Métodos del protocolo UITableViewDataSource
    
    //este no es obligatorio pero lo ponemos para ver las secciones de una table: por defecto una tabla tiene una sección, las secciones están separadas por separadores (por ejemplo, la app de contactos) y para cada sección puede haber varias filas
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //de momento sólo habrá una sección
    }
    //numberOfRowsInSection sirve para decidir cuantas filas hay en cada sección, no lo escribimos en una variable sino que es un método del protocolo que lo gestiona automáticamente. El número de filas de la sección normalmente suele ir ligado al modelo de datos que utlicemos, en este caso a familia de fuentes.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.families.count //habrá tantas filas como familias tengo
    }
    
    //cellForRowAt indexPath: A cada una de las celdas le tenemos que dar un identificador para reutilizarlas, para poder encolar y desencolar las celdas cuando se muestran y se dejan de mostrar (al hacer scroll, por ejemplo) y todo se hace a través de este identificador que se define en la TableView Cell del Storyboard en la propiedad identifier (reuse identifier). En este caso, hemos definido este idenrificador como FontFamilyCell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //lo primero es recuperar la celda: desencolamos la celda reutilizable con el identificador FontFamilyCell en la posición indexPath que me llega por parámetro. Este objeto sabemos que va a existir y que es del tipo UITableViewCell, de hecho el propio método espera que devuelvas una celda de este tipo
        let cell = tableView.dequeueReusableCell(withIdentifier: "FontFamilyCell", for: indexPath)
        //podría simplemente devolver la celda sin hacer nada con ella, pero me interesa poner en ella algo de texto antes, evidentemete.
        //utilizamos la propiedad text del textLabel de la celda para imprimir el nombre de la familia que haya en el array de familias en la posición que me indique el indexPath (recordamos que la tabla tiene tantas filas como elementos (count) tiene el array families. IndexPath tiene row con la fila en la que estamos y section con la seccion en la que estamos, ahora mismo section no nos interesa puesto que la configuramos en una (estaríamos en la sección cero, puesto que solo hay una)
        let fontFamily = families[indexPath.row]
        //cambiamos el tipo de fuente de la celda haciéndolo coincidir con el nombre de la fuente que está mostrando
        cell.textLabel?.text = fontFamily
        cell.textLabel?.font = UIFont(name: fontFamily, size: 20.0)
        //devolvemos la celda
        return cell
        //con este método definido así estaríamos llenando la tabla con el nombre de las familias de las fuentes
    }
    
    /* Cuando tenemos una tabla el objetivo es mostrar elementos en sus celdas, la tabla no se rellena automáticamente sino que DELEGA esa tarea en otro elemento, el UIViewController. Hemos implementado tres métodos que no son propios, son de UIViewTableDataSource. Estos métodos se comunican con la tabla para que haga una tarea concreta:
        1.- El primer método le dice a la tabla que prepare una sección, recibe la tabla y devuelve un entero con el número de secciones. No es obligatorio definir este método
        2.- El segundo método es obligatorio y define el número de filas en cada sección.
        3.- El tercer método es obligatorio. Una vez que tenemos el número de secciones y el número de filas hay que configurar el contenido que cada celda, que es lo que hace este tercer método. Para ello necesita de un identificador de celda reutilizable que hemos de haber definido previamente en las propiedades de la celda prototipo que tenemos en el storyboard. Este metodo recibe por parámetro un cellForRowAt IndexPath, este elemento tiene sección por un lado y fila por otro. De esta, dentro de este método,  pordemos acceder a cada una de las celdas desencolandola utilizando el método dequeueReusableCell */

    //MARK: Métodos del protocolo UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row //recupero la posición de la celda que ha seleccionado el usurio
        print(">>> ESTE ES EL VALOR DE indexPath.row >>> \(row) <<<")
        let fontFamily = families[row] //recuperamos el nombre de la familia
        let fontsLocal = self.fonts[fontFamily]! //recupero las fuentes pertenecientes a la familia, estando seguro ! de que no será nil, en el caso de que no haya fuentes en la familia seleccionada devolverá un array de String vacío, pero no nil, por eso indico ! de esta forma al imprimir en consola tampoco aparecera Optinal al imprimir familias sin fuentes, directamente imprimirá [] (Array vacío). Con ! forzamos que un valor opcional sea obligatorio ("yo programador", estoy seguro seguro de que esto no será nunca nulo. Si me equivoco la app tendrá un error en ejecución)
        print("\n>>> EL USUARIO HA SELECCIONADO: <<< ")//y lo imprimimos por consola para comprobar que lo hace lo que se espera
        print("\tLa FAMILIA >>> \(fontFamily) <<<") //la familia
        print("\tque contiene estas FUENTES:\n\t\t \(fontsLocal)") //y las fuentes de esa familia
    }
}
