//
//  AboutViewController.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 06/04/18.
//  Copyright © 2018 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit
import Reachability
import StoreKit

class AboutViewController: UIViewController {
    
    @IBOutlet var btnDonate: UIButton?
    
    private var productsRequest = SKProductsRequest()
    private var productDonate: SKProduct?
    private var reachability = Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        btnDonate?.isHidden = true
        reachability?.whenReachable = { _ in
            DispatchQueue.global(qos: .background).async {
                self.fetchAvailableProducts()
            }
        }

        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @IBAction func btnDonate_Touch(_ sender: UIButton) {

        if SKPaymentQueue.canMakePayments() {
            purchaseDonate()
        }
    }

    func productPurchased() {
        btnDonate?.isHidden = false
        btnDonate?.setTitle("Thanks for your donation!", for: .normal)
        btnDonate?.isUserInteractionEnabled = false
    }

    // MARK: In-App Purchase
    func fetchAvailableProducts() {
        // Product Identifiers must be created in App Store Connect\Features\In-App Purchases
        let productIdentifiers = NSSet(objects: "Donate")

        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
        productsRequest.delegate = self
        productsRequest.start()
    }

    func restorePurchase() {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    func purchaseDonate() {

        if let product = productDonate {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        }
    }
}

extension AboutViewController: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {

        if (response.products.count > 0) {
            btnDonate?.isHidden = false

            productDonate = response.products[0]
            if let product = productDonate {
                let numberFormatter = NumberFormatter()
                numberFormatter.formatterBehavior = .behavior10_4
                numberFormatter.numberStyle = .currency
                numberFormatter.locale = product.priceLocale
                let price1Str = numberFormatter.string(from: product.price)

                // Donate
                let message = "\(product.localizedDescription) \(price1Str!)"
                btnDonate?.setTitle(message, for: .normal)
            }
        }

    }

    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        productPurchased()
    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                case .purchased:
                    // Purchased
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    productPurchased()
                    break
                case .failed:
                    // Failed
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                case .restored:
                    // Restored
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    productPurchased()
                    break

                default: break
                }
            }
        }
    }
}
