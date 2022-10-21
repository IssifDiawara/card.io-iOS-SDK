//
//  CardScannerView.swift
//  UIComponents
//
//  Created by Issif DIAWARA on 19/10/2022.
//  Copyright © 2022 Publicis Sapient Engineering. All rights reserved.
//

import SwiftUI

public struct CardScannerView: UIViewControllerRepresentable {

    let didProvide: ((CardIOCreditCardInfo) -> Void)

    public func updateUIViewController(_ uiViewController: CardIOPaymentViewController, context: Context) {}

    public func makeUIViewController(context: Context) -> CardIOPaymentViewController {
        let viewController = CardIOPaymentViewController(paymentDelegate: context.coordinator) ?? CardIOPaymentViewController()
        viewController.hideCardIOLogo = true
        viewController.suppressScannedCardImage = true
        viewController.guideColor = .clear
        viewController.scanInstructions = "Centrez votre carte dans le cadre"
        return viewController
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

}

public extension CardScannerView {

    class Coordinator: NSObject, CardIOPaymentViewControllerDelegate {

        private let scanner: CardScannerView

        init(_ scanner: CardScannerView) {
            self.scanner = scanner
        }

        public func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
            paymentViewController?.dismiss(animated: true, completion: nil)
        }

        public func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
            guard let cardInfo else {
                paymentViewController?.dismiss(animated: true, completion: nil)
                return
            }

            scanner.didProvide(cardInfo)
            paymentViewController?.dismiss(animated: true, completion: nil)
        }

    }
}
