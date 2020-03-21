//
//  EventsViewController.swift
//  AdventureTomb
//
//  Created by Admin on 15.03.2020.
//  Copyright © 2020 MaximMasov. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {

    @IBOutlet weak var textToDisplay: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textToDisplay.text = "Hello!"
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
