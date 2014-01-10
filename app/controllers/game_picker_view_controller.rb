class GamePickerViewController < UITableViewController
  CELL_ID = "GameCell"

  attr_accessor :game, :games, :selected_index, :delegate

  def viewDidLoad
    super

    @games = ["Chess", "Solitaire", "Pinochle"]
    @_selected_index = @games.find_index(@game)
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @games.size
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID)

    game = @games[indexPath.row]
    cell.textLabel.text = game

    if indexPath.row == @_selected_index
      cell.accessoryType = UITableViewCellAccessoryCheckmark
    else
      cell.accessoryType = UITableViewCellAccessoryNone
    end

    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    # deselect row
    tableView.deselectRowAtIndexPath(indexPath, animated:true)

    # remove the checkmark from the previously selected row
    if @_selected_index != nil
      index = NSIndexPath.indexPathForRow(@_selected_index, inSection:0)
      cell = tableView.cellForRowAtIndexPath(index)
      cell.accessoryType = UITableViewCellAccessoryNone
    end

    @_selected_index = indexPath.row

    # add the checkmark to the current selected row
    cell = tableView.cellForRowAtIndexPath(indexPath)
    cell.accessoryType = UITableViewCellAccessoryCheckmark

    # finally notify our delegate that a user selected this row / game
    game = @games[indexPath.row]
    @delegate.didSelectGame(game)
  end

end