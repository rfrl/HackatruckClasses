
import Foundation

class Umidade {
    var valor: String
    
    init(json: [String: String]) {
        self.valor = json["payload"] ?? ""
    }
}

class UmidadeDAO {
    
    static func getUmidade (callback: @escaping ((Umidade) -> Void)) {
        
        let endpoint: String = "https://plantaiot14.mybluemix.net/getUmi"
        
        guard let url = URL(string: endpoint) else {
            print("Erroooo: Cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if error != nil {
                print("Error = \(String(describing: error))")
                return
            }
            
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            print("responseString = \(String(describing: responseString))")
            
            DispatchQueue.main.async() {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
                        
                        let umidade = Umidade(json: json[json.count-1] as! [String : String])
                        
                        print("\(umidade.valor) Umidades")
                        
                        callback(umidade)
                        
                    }else {
                        print("JSON ERRADO")
                    }
                } catch let error as NSError {
                    print("Error = \(error.localizedDescription)")
                }
            }
            
            
        })
        
        task.resume()
    }
}
