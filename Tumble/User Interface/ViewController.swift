//
//  ViewController.swift
//  Tumble
//
//  Created by Daniel Kweon on 12/10/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - User Interface Components

    @IBOutlet weak var label_tumble: UILabel!
    @IBOutlet weak var view_board: UIView!
    @IBOutlet weak var view_gesture: UIView!

    @IBOutlet weak var button_setting: UIButton!
    @IBOutlet weak var button_palette: UIButton!
    @IBOutlet weak var button_grid: UIButton!

    @IBOutlet weak var button_undo: UIButton!
    @IBOutlet weak var button_clear: UIButton!
    @IBOutlet weak var button_rotateCW: UIButton!
    @IBOutlet weak var button_rotateCCW: UIButton!

    @IBOutlet weak var label_score: UILabel!
    @IBOutlet weak var label_scoreValue: UILabel!
    @IBOutlet weak var label_bestScore: UILabel!
    @IBOutlet weak var label_bestScoreValue: UILabel!

    // MARK: - Variables

    var swipeGestures: [UISwipeGestureRecognizer] = []
    var dragGestures: [UISwipeGestureRecognizer] = []
    var gameService: GameService = GameService()
    var backTiles: [[BackTile?]] = []
    var tiles: [[Tile?]] = []
    var buttonsEnabled: Bool = false

    // MARK: - Main Entry Point

    override func viewDidLoad() {
        super.viewDidLoad()
        startGameplay()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil )
    }

    @objc func didEnterBackground() {
        stopGameplay()
    }

}
