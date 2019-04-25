
import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var labelCloudant: UILabel!
    
    
    @IBAction func botao(_ sender: Any) {
        
        UmidadeDAO.getUmidade { (umidade) in
            self.labelCloudant.text = String(describing: umidade.valor)
        }
        
    }
    func mudaLabel (){
        
    
    }
}


