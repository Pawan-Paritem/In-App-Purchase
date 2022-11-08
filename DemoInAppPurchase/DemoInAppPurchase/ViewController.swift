//
//  ViewController.swift
//  DemoInAppPurchase
//
//  Created by Pawan iOS on 08/11/2022.
//

import UIKit
import StoreKit

enum Product: String, CaseIterable {
    case unlock = "com.DemoInAppPurchase.unlock"
}

class ViewController: UIViewController {

    private var model = [SKProduct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fatchProduct()
        SKPaymentQueue.default().add(self)
    }
    
    @IBAction func appPurchaseButton(_ sender: UIButton) {
        let payment = SKPayment(product: model[0])
        SKPaymentQueue.default().add(payment)
    }
}


extension ViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
        
            print(response.products)
            self.model = response.products
        }
    }
    
    
    private func fatchProduct() {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({ $0.rawValue })))
        request.delegate = self
        request.start()
    }
    
}
