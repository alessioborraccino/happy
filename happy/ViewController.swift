//
//  ViewController.swift
//  happy
//
//  Created by Alessio Borraccino on 22/12/2016.
//  Copyright © 2016 Gambero. All rights reserved.
//

import SpriteKit

class ViewController: UIViewController {

    private(set) lazy var skView : SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsFPS = true
        view.showsNodeCount = true
        return view
    }()
    
    private(set) lazy var gameScene : GameScene = {
        return GameScene.make()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(skView)
        skView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        skView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        skView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        skView.presentScene(gameScene)
    }
}

