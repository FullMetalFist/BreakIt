//
//  GameViewController.swift
//  BreakIt
//
//  Created by Michael Vilabrera on 4/11/17.
//  Copyright © 2017 Michael Vilabrera. All rights reserved.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {
    
    var scnView: SCNView!
    var game = GameHelper.sharedInstance
    var scnScene: SCNScene!
    
    var horizontalCameraNode: SCNNode!
    var verticalCameraNode: SCNNode!
    
    override func viewDidLoad() {
        
        setupScene()
        setupNodes()
        setupSounds()
    }
    
    func setupScene() {
        scnView = self.view as! SCNView
        scnView.delegate = self
        
        scnScene = SCNScene(named: "Breaker.scnassets/Scenes/Game.scn")
        scnView.scene = scnScene
    }
    
    func setupNodes() {
        scnScene.rootNode.addChildNode(game.hudNode)
        
        horizontalCameraNode = scnScene.rootNode.childNode(withName: "HorizontalCamera", recursively: true)!
        verticalCameraNode = scnScene.rootNode.childNode(withName: "VerticalCamera", recursively: true)!
    }
    
    func setupSounds() {
        
    }
    
    override var shouldAutorotate: Bool { return true }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    // 1
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // 2
        let deviceOrientation = UIDevice.current.orientation
        switch deviceOrientation {
        case .portrait:
            scnView.pointOfView = verticalCameraNode
        default:
            scnView.pointOfView = horizontalCameraNode
        }
    }
}

extension GameViewController: SCNSceneRendererDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        game.updateHUD()
    }
}
