
import SpriteKit

class LevelFinishedScene: PaperScene {
  
  var level: Int?
  let OKButtonName = "ok"
  
  override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    
    // Static paper background
    setupBackground(false)
    
    // Stop background music.
    SoundManager.stopBackgroundMusic()
    
    // Add a title.
    let titleLabel = SKLabelNode(text: "Level Finished!")
    titleLabel.fontColor = UIColor(red: 0.5, green: 0, blue: 0, alpha: 1)
    titleLabel.fontName = "Noteworthy"
    titleLabel.fontSize = 24
    titleLabel.position = CGPoint(x: 0.5, y: 0.7)
    titleLabel.xScale = getSceneScaleX()
    titleLabel.yScale = getSceneScaleY()
    addChild(titleLabel)
    
    if level != .None {
      let points = ScoreManager.getScoreForLevel(level!)
      if points != .None {
        // Add a score.
        let scoreLabel = SKLabelNode(text: "You scored \(points) points!")
        scoreLabel.fontColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1)
        scoreLabel.fontName = "Noteworthy"
        scoreLabel.fontSize = 18
        scoreLabel.position = CGPoint(x: 0.5, y: 0.5)
        scoreLabel.xScale = getSceneScaleX()
        scoreLabel.yScale = getSceneScaleY()
        addChild(scoreLabel)
      }
    }
    
    // Add an back button button.
    let spriteAtlas = SKTextureAtlas(named: "Sprites")
    let backButton = SKSpriteNode(texture: spriteAtlas.textureNamed(OKButtonName))
    backButton.color = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    backButton.name = OKButtonName
    backButton.position =  CGPoint(x: 0.5, y: 0.3)
    backButton.xScale = getSceneScaleX()
    backButton.yScale = getSceneScaleY()
    addChild(backButton)
    
    // Convert the level into sketches
    convertToSketch()
  }
  
  // Convert to 8.3
  // override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    for touch: AnyObject in touches {
      let node = self.nodeAtPoint(touch.locationInNode(self))
      if node.name == OKButtonName || node.parent?.name == OKButtonName {
        SKNode.cleanupScene(self)
        if let view = view {
          view.presentScene(LevelSelectScene(size: CGSize(width: view.frame.width, height: view.frame.height)))
        }
      }
    }
  }
  
}