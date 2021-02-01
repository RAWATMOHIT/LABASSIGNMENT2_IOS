import Foundation
import CoreData

class mainbase {
    
    func enterProducts(_ item: [String:String])  {
        let context = basedata.sharedCoreData.persistentContainer.viewContext
        let product = self.myRecord("Product", context: context) as? Product
        let productId = item["productId"] ?? "0"
        let productPrice = item["productPrice"] ?? "0"
        product?.productId = Int16(productId) ?? 0
        product?.productName = item["productName"] ?? ""
        product?.productDescription = item["productDescription"] ?? ""
        product?.productProvider = item["productProvider"] ?? ""
        product?.productPrice = Double(productPrice) ?? 0
        basedata.sharedCoreData.text()
    }
    
    func AllProducts() -> [Product]? {
        let context = basedata.sharedCoreData.persistentContainer.viewContext
        return self.productdata(fromCoreData: "Product", context: context) as? [Product]
    }
    
    func productdata(fromCoreData table: String, context: NSManagedObjectContext) -> [Any] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let entity = NSEntityDescription.entity(forEntityName: table, in: context)
        fetchRequest.entity = entity
        fetchRequest.returnsObjectsAsFaults = false
        let records: [Any]? = try? context.fetch(fetchRequest)
        return records!
    }
    
    func myRecord(_ table: String, context: NSManagedObjectContext) -> Any? {
        return NSEntityDescription.insertNewObject(forEntityName: table, into: context)
    }
}
