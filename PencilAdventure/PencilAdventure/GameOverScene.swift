
import SpriteKit

public class GameOverScene: PaperScene {
  
  var level: Int?
  let OKButtonName = "ok"
  
  public override func didMoveToView(view: SKView) {
    super.didMoveToView(view)
    
    // Static paper background
    showGameOver()
    
    // Stop background music.
    SoundManager.stopBackgroundMusic()
    
    // Add a OK button.
    let spriteAtlas = SKTextureAtlas(named: "Sprites")
    let okButton = SKSpriteNode(texture: spriteAtlas.textureNamed(OKButtonName))
    okButton.name = OKButtonName
    okButton.color = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    okButton.position =  CGPoint(x: 0.8, y: 0.3)
    okButton.xScale = getSceneScaleX()
    okButton.yScale = getSceneScaleY()
    okButton.zPosition = HeroZPosition
    addChild(okButton)
    
    // Convert the level into sketches
    convertToSketch()
  }
  
  // Convert 8.3
  //public override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
  public override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
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
  
  func showGameOver() {
    // Our texture for the outdoor background
    let background = SKTexture(imageNamed: "GameOver")
    
    // Make it cheap to draw
    background.filteringMode = SKTextureFilteringMode.Nearest
    
    let frameCenter = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
    let bgSprite = SKSpriteNode(texture: background)
    bgSprite.size = frame.size
    bgSprite.position = CGPoint(x: frame.size.width/2.0, y: frame.size.height/2.0)
    bgSprite.zPosition = SceneBackgroundZPosition
    addChild(bgSprite)
  }
  
}