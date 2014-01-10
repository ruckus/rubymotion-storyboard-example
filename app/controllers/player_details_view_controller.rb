class PlayerDetailsViewController < UITableViewController
  extend IB

  outlet :nameTextField, UITextField
  outlet :detailLabel, UILabel

  attr_accessor :_game, :delegate, :player, :editing_index

  def viewDidLoad
    super

    if @player
      @nameTextField.text = @player.name
      @detailLabel.text = @player.game
      @_game = @player.game
    end
  end

  def init
    super

    @_game = "Chess" # default game

    self
  end

  def viewWillAppear(animated)
    super
  end

  def done(sender)
    name = @nameTextField.text.strip
    if name.length == 0
      alert = UIAlertView.alloc.init
      alert.message = "Please enter a Name"
      alert.addButtonWithTitle "OK"
      alert.show
    else
      if @editing_index != nil
        # we're editing an existing player
        @delegate.editPlayerAt(@editing_index, @nameTextField.text, @_game)
      else
        # add new player
        player = Player.new
        player.name = @nameTextField.text
        player.game = @_game
        @delegate.didAddPlayer(player)
      end
    end
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    if indexPath.section == 0
      @nameTextField.becomeFirstResponder
    end
  end

  def cancel(sender)
    @delegate.playerDetailsViewControllerDidCancel(self)
  end

  def didSelectGame(game)
    @_game = game

    @detailLabel.text = game
    self.navigationController.popToRootViewControllerAnimated(true)
  end

  def prepareForSegue(segue, sender:sender)
    if segue.identifier == "PickGame"
      controller = segue.destinationViewController
      controller.delegate = self
      controller.game = @_game
    end
  end

end