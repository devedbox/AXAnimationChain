//
//  StageAnimationsViewController.swift
//  AXAnimationChain
//
//  Created by devedbox on 2017/1/14.
//  Copyright © 2017年 devedbox. All rights reserved.
//

import UIKit

class StageAnimationsViewController: UIViewController {

    @IBOutlet weak var stageLabel: UILabel!
    @IBOutlet weak var stageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        stageView.chainAnimator.basic.property("cornerRadius").toValue(8.0).duration(0.8).start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func animate(_ sender: UIButton) {
        let alert = UIAlertController(title: "Effects", message: nil, preferredStyle: .actionSheet);
        alert.addAction(UIAlertAction(title: "Tada", style: .default, handler: { (action :UIAlertAction) in
            self.stageView.tada()
            self.stageLabel.tada()
        }))
        alert.addAction(UIAlertAction(title: "Bonuce", style: .default, handler: { (action :UIAlertAction) in
            self.stageView.bonuce()
            self.stageLabel.bonuce()
        }))
        alert.addAction(UIAlertAction(title: "Pulse", style: .default, handler: { (action :UIAlertAction) in
            self.stageView.pulse()
            self.stageLabel.pulse()
        }))
        alert.addAction(UIAlertAction(title: "Shake", style: .default, handler: { (action :UIAlertAction) in
            self.stageView.shake()
            self.stageLabel.shake()
        }))
        alert.addAction(UIAlertAction(title: "Snap", style: .default, handler: { (action: UIAlertAction) in
            self.stageView.snap()
            self.stageLabel.snap(from: .top)
        }))
        alert.addAction(UIAlertAction(title: "Expand", style: .default, handler: { [unowned self](action) in
            self.stageLabel.expand {
                print("Finished expand animation effect on stage label.")
            }
            self.stageView.expand()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
