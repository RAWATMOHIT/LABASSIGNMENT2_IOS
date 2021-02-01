import UIKit

class myproductlist: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var myproduct: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkProductsFromPlist()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? specificationproduct {
            controller.product = sender as? Product
        }
    }
    
    func checkProductsFromPlist()  {
        let isInsertData = UserDefaults.standard.bool(forKey: "insertData")
        if isInsertData {
        if let product = mainbase().AllProducts() {
        self.myproduct.append(contentsOf: product)
            }
        }
else {
    if let path = Bundle.main.path(forResource: "product", ofType: "plist"), let data = NSData(contentsOfFile: path) {
                do {
                    let pListData = try PropertyListSerialization.propertyList(from: data as Data, options: .mutableContainers, format: nil)
                    if let pListData = pListData as? [[String : String]] {
                        for product in pListData {
                            mainbase().enterProducts(product )
                        }
                        if let product = mainbase().AllProducts() {
                            self.myproduct.append(contentsOf: product)
                        }
                        UserDefaults.standard.set(true, forKey: "insertData")
                    }
                }
                catch {
                    print(error)
                }
            }
        }
    }
}

extension myproductlist: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myproduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let labelItem = cell.viewWithTag(10) as? UILabel// tage of label is 10
        let product = myproduct[indexPath.row]
        labelItem?.text = product.productName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = myproduct[indexPath.row]
        self.performSegue(withIdentifier: "productListToDetail", sender: product)
    }

}

extension myproductlist: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string).lowercased()
            
            if let product = mainbase().AllProducts() {
                if updatedText.isEmpty {
                    self.myproduct.removeAll()
                    self.myproduct.append(contentsOf: product)
                }
                else {
                    let items = product.filter({($0.productName!.lowercased().contains(updatedText))})
                    self.myproduct.removeAll()
                    self.myproduct.append(contentsOf: items)
                }
                self.tblView.reloadData()
            }
        }
        return true
    }
    
    func FieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
