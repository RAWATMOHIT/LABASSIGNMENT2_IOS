import UIKit

class specificationproduct: UIViewController
{
    @IBOutlet var labelItems: [UILabel]!
    var product: Product?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        labelItems[0].text = "Product ID: " + String(product?.productId ?? 0)
        labelItems[1].text = "Product Name: " + (product?.productName ?? "")
        labelItems[2].text = "Product Description: " + (product?.productDescription ?? "")
        labelItems[3].text = "Product Price: " + String(product?.productPrice ?? 0)
        labelItems[4].text = "Product Provider: " + (product?.productProvider ?? "")
    }

}
