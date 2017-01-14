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
        stageView.chainAnimator.basic.property("transform.scale").fromValue(0.9).toValue(1).duration(0.5).combineBasic().property("transform.rotation").byValue(M_PI/18).duration(0.1).autoreverses().repeatCount(2).combineBasic().beginTime(0.1).property("transform.rotation").byValue(-M_PI/15).duration(0.1).autoreverses().repeatCount(2).start()
        
        stageLabel.chainAnimator.basic.property("transform.scale").fromValue(0.9).toValue(1).duration(0.5).combineBasic().property("transform.rotation").byValue(M_PI/18).duration(0.1).autoreverses().repeatCount(2).combineBasic().beginTime(0.1).property("transform.rotation").byValue(-M_PI/15).duration(0.1).autoreverses().repeatCount(2).start()
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
