class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    players = []

    player1 = Player.new
    player1.name = "Bill Evans"
    player1.game = "Tic-Tac-Toe"
    player1.rating = 4
    players << player1

    player2 = Player.new
    player2.name = "Oscar Petterson"
    player2.game = "Chess"
    player2.rating = 5
    players << player2

    player3 = Player.new
    player3.name = "John Smith"
    player3.game = "Solitaire"
    player3.rating = 2
    players << player3

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    storyboard = UIStoryboard.storyboardWithName("Main", bundle:nil)
    rootVC = storyboard.instantiateViewControllerWithIdentifier("Main")

    # dig into the storyboard and find our PlayersViewController
    navigationController = rootVC.viewControllers[0]
    playersViewController = navigationController.viewControllers[0]
    playersViewController.players = players

    @window.rootViewController = rootVC
    @window.makeKeyAndVisible

    true
  end
end
