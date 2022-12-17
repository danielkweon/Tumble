//
//  VCSegues.swift
//  Tumble
//
//  Created by Daniel Kweon on 9/11/21.
//

import UIKit

extension ViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {

        case Constants.segue_GameOver:
            let gameOverVC = segue.destination as! GameOverViewController
            gameOverVC.completionHandler = { () in
                self.gameService.clear()
                self.enableUserInteraction()
            }
            gameOverVC.tryAgainHandler = { () in
                self.showButtons()
            }

        case Constants.segue_Confirmation:
            let confirmationVC = segue.destination as! ConfirmationViewController
            confirmationVC.confirmationText = "Are you sure you would like to clear the board?"
            confirmationVC.confirmButtonText = "Clear"
            confirmationVC.completionHandler = { () in
                self.enableUserInteraction()
            }
            confirmationVC.confirmHandler = { () in
                self.gameService.clear()
            }

        case Constants.segue_Colors:
            let colorsVC = segue.destination as! ColorsViewController
            colorsVC.completionHandler = { () in
                self.changeTileColors()
            }

        case Constants.segue_Grids:
            let gridsVC = segue.destination as! GridsViewController
            gridsVC.completionHandler = { () in
                self.gameService.clear()
            }

        default:
            break
        }
    }

    func handleGameOver() {
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { _ in
            self.performSegue(withIdentifier: Constants.segue_GameOver, sender: self)
            self.hideButtons()
        }
    }

    func handleClear() {
        self.performSegue(withIdentifier: Constants.segue_Confirmation, sender: self)
    }

}
