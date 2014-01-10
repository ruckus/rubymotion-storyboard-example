class PlayersViewController < UITableViewController
  CELL_ID = "PlayerCell"
  TAG_CELL = 100
  attr_accessor :players

  def init
    super
    self
  end

  def viewDidLoad
    view.dataSource = view.delegate = self
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @players.size
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID)

    player = @players[indexPath.row]
    cell.nameLabel.text = player.name
    cell.gameLabel.text = player.game

    cell
  end

  def prepareForSegue(segue, sender:sender)
    playerDetailsViewController = nil

    if ['AddPlayer', 'EditPlayer'].include?(segue.identifier)
      navigationController = segue.destinationViewController
      playerDetailsViewController = navigationController.viewControllers[0]
      playerDetailsViewController.delegate = self
    end

    # for editing load up a player
    if segue.identifier == 'EditPlayer' && playerDetailsViewController
      # get the current selected row
      indexPath = self.tableView.indexPathForSelectedRow
      playerDetailsViewController.player = @players[indexPath.row]
      playerDetailsViewController.editing_index = indexPath.row
    end
  end

  def playerDetailsViewControllerDidCancel(controller)
    self.dismissViewControllerAnimated(true, completion:nil)
  end

  def didAddPlayer(player)
    @players << player
    self.dismissViewControllerAnimated(true, completion:nil)
    view.reloadData
  end

  def editPlayerAt(index, name, game)
    @players[index].name = name
    @players[index].game = game
    self.dismissViewControllerAnimated(true, completion:nil)
    view.reloadData
  end

end