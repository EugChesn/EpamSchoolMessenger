//
//  ViewController.swift
//  AdventureTomb
//
//  Created by Admin on 09.03.2020.
//  Copyright © 2020 MaximMasov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let eventsVC = EventsViewController()
    var gameCell = GameCell()
    var playerPosition = 0
    var gameTags = EventsDescription()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView.register(GameCell.self, forCellWithReuseIdentifier: "gameCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameTags.events.count
    }
    

   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (view.frame.width)/5
        return CGSize(width: width, height: width)
    
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.00
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? GameCell else {
            fatalError("wrong cell")
        }
       //let playerPos = indexPath[playerPosition]
        cell.changeColor()
        if indexPath.row == playerPosition {
            cell.playerMove()
        }
        return cell
    }
    
    

    @IBAction func nextButton(_ sender: UIButton) {
        playerPosition += 1
        if playerPosition >= (gameTags.events.count - 1){
            playerPosition = (gameTags.events.count - 1)
        }
        print(gameTags.events[playerPosition])
       // let popUpVC = UIStoryboard(name: "EventsViewController", bundle: nil).instantiateViewController(withIdentifier: "popUpVCid") as! EventsViewController

        gameCell.playerMove()
        collectionView.reloadData()
        let popUpVC = UIStoryboard(name: "EventsViewController", bundle: nil).instantiateInitialViewController() as! EventsViewController
        self.addChild(popUpVC) // 2
               popUpVC.view.frame = self.view.frame  // 3
               self.view.addSubview(popUpVC.view) // 4
        popUpVC.textToDisplay.text = gameTags.events[playerPosition].textToDisplay
        popUpVC.didMove(toParent: self)
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        playerPosition -= 1
        if playerPosition <= 0 {
            playerPosition = 0
        }
        print(gameTags.events[playerPosition])
        gameCell.playerMove()
        collectionView.reloadData()
    }
    
}

