// Playground - noun: a place where people can play
// Think as below as your Main class, basically the Stage

// this imports higher level APIs like Starling
import SpriteKit
import XCPlayground



// our main logic inside this class
class GameScene: SKScene {
    var levelData = [
        "eewwwwwe",
        "wwweeewe",
        "weseweww",
        "weweehew",
        "weeeewew",
        "wwswheew",
        "ewpeewww",
        "ewwwwwee"
    ]
    
    // properties initialization
    // note that the spriteNode property below is not initialized
    // we initialize it through the init initializer below
    var playerNode: SKSpriteNode
    var levelNodes: SKSpriteNode[]
    var osci = 0.0
    
    // this is our initializer, called once when the scene is created
    // we do our initialization/setup here
    init(size: CGSize){
        playerNode = SKSpriteNode()
        levelNodes = SKSpriteNode[]()
        for line in levelData {
            for var i = 0; i < line.length; i++ {
                var symbol = line.substrFrom(i, len: 1)!
                var entity: NSString
                switch symbol {
                case "e":
                    entity = "empty"
                case "w":
                    entity = "wall"
                case "s":
                    entity = "stone"
                case "h":
                    entity = "hole"
                case "p":
                    entity = "player"
                default:
                    entity = ""
                }
                var urlString = "https://googledrive.com/host/0B8NAfZJXviA1SFRXY2xYRFBYdlE/sokoban/\(entity).png"
                var propSprite = SKSpriteNode(texture: SKTexture(image:
                        NSImage(contentsOfURL:
                            NSURL(string:urlString))))
                levelNodes.append(propSprite)
                switch entity {
                case "player":
                    playerNode = propSprite
                    playerNode.position = CGPoint(x:10, y:10)
                default:nil
                }
                
//                var playerS = "player"
//                if entity == playerS {
//                    playerNode = propSprite
//                    playerNode.position = CGPoint(x:10, y:10)
//                }
            }
        }
        
        // we complete the initialization by initializating the superclass
        super.init(size: size)
    }
    
    // this gets triggered automtically when the scene is presented by the view
    override func didMoveToView(view: SKView) {
        // let's add it to the display list
        self.addChild(playerNode)
    }
    
    // we override update, which is like an Event.ENTER_FRAME or advanceTime in Starling
    override func update(currentTime: CFTimeInterval) {
        osci += 0.1
        // oscillation with sin, like Math.sin
        var osc = 1.5 + sin(CDouble(osci))
        // let's scale it
        playerNode.setScale(CGFloat(osc))
    }
}

// we create our scene (from our GameScene above), like a main canvas
let scene = GameScene(size: CGSize(width: 500, height: 500))

// we need a view
let view = SKView(frame: NSRect(x: 0, y: 0, width: 500, height: 500))

// we link both
view.presentScene(scene)

// display it, XCPShowView is a global function that paints the final scene
XCPShowView("result", view)
