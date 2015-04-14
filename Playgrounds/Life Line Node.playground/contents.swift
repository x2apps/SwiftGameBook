//:Importing the required frameworks. We definetly need SpriteKit!

// Images do not load in Playground in Xcode 6.1
// Please wait for the next version or try this playground in an older 6.0.1 version of Xcode

import SpriteKit
import Foundation
import XCPlayground

//: ### Define Global Helper Function and Extension
/*: 
Creating a global **callbackAfter** function that calls a function after x seconds.

Also defining extensions for **getSceneScale**.
*/


func callbackAfter(seconds: Float, callback: () -> ()) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(Float(NSEC_PER_SEC) * seconds)), dispatch_get_main_queue(), callback)
}

extension SKScene {
    
    func getSceneScale() -> CGSize {
        return CGSize(width: getSceneScaleX(), height: getSceneScaleY())
    }
    
    func getSceneScaleX() -> CGFloat {
        return frame.width / view!.frame.width
    }
    
    func getSceneScaleY() -> CGFloat {
        return frame.height / view!.frame.height
    }
}


/*:
### Life Line Node Class
We define the life line node class and its implementation.
*/


public class LifeLineNode: SKCropNode {
    
    private var lifeLine: CGFloat = 1.0
    private var gameScene: SKScene?
    
    convenience init(forScene scene: SKScene) {
        self.init()
        
        gameScene = scene
        
        // Start reducing led from the pencil
        callbackAfter(0.10, subtractLifeLine)
      
        let healthSprite = SKSpriteNode(imageNamed: "health")
        healthSprite.xScale = scene.getSceneScaleX()
        healthSprite.yScale = scene.getSceneScaleY()
        addChild(healthSprite)

        position.x = scene.frame.width - 100
        position.y = scene.frame.height - 100
                
        // Create the maskNode
        maskNode = SKSpriteNode(color: SKColor.whiteColor(), size: healthSprite.size)
    }
    
    private func subtractLifeLine() {
        lifeLine -= 0.01
        maskNode!.yScale = lifeLine
        if lifeLine > 0 {
            callbackAfter(0.1, subtractLifeLine)
        } else {
            println("Game Over")
        }
    }
    
    public func addLifeLine(life: CGFloat) {
        // Give more led till Mr Pencil reaches the end
        if lifeLine + life > 1 {
            lifeLine = 1.0
        } else {
            lifeLine += life
        }
        maskNode!.yScale = lifeLine
    }
    
}

/*:
### Creating the Scene
We create the scene and present it in the **SceneView**.
*/


let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 850, height: 638))
let scene = SKScene(fileNamed: "GameScene")
scene.scaleMode = .AspectFill
sceneView.presentScene(scene)

/*:
### Run the Scene
Finally we add the lifeLineNode to the scene and show that scene view. Press (Command + Option + Return) to view the scene.
*/


let lifeLineNode = LifeLineNode(forScene: scene)
scene.addChild(lifeLineNode)

XCPShowView("Life Line", sceneView)
