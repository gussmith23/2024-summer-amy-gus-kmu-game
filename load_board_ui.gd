extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  pass


func _on_button_pressed():
  print("button pressed")


func _on_from_json_button_pressed():
  print($JSONTextEdit.text)
  var json = JSON.parse_string($JSONTextEdit.text)
  if json == null:
    print("JSON parse error")
  else:
    var board = json_to_board(json)

    load_board_ui(board)
  

func json_to_board(json_obj):
  print_debug(json_obj)

  assert(json_obj.has("grid"), "grid is missing")
  var grid = json_obj["grid"]
  assert(grid != null, "grid is null")
  assert(grid == "tri4", "tri4 is the only supported grid")

  assert(json_obj.has("deck"), "deck is missing")
  assert(json_obj["deck"].has("properties"), "deck.properties is missing")
  var deck = {}
  for key in json_obj["deck"]["properties"].keys():
    deck[key] = Array(json_obj["deck"]["properties"][key])

  print_debug(deck)

  return BoardState.new(grid, deck, null, null, null)

class BoardState:
  var grid = null
  var deck = null
  var movement = null
  var feedback = null
  var win = null

  func _init(grid, deck, movement, feedback, win):
    self.grid = grid
    self.deck = deck
    self.movement = movement
    self.feedback = feedback
    self.win = win

  func print_debug():
    print("grid: ", self.grid)
    print("deck: ", self.deck)
    print("movement: ", self.movement)
    print("feedback: ", self.feedback)
    print("win: ", self.win)


func load_board_ui(board):
  assert(board != null, "board is null")
  assert(board.grid == "tri4", "tri4 is the only supported grid")

  if board.grid == "tri4":
    get_tree().change_scene_to_file("res://tri4.tscn")

  var idxs = []
  for i in range(board.deck.keys().size()):
    idxs.push_back(0)
  var num_cards = board.deck.keys().reduce(func(acc, x): return acc * board.deck[x].size(), 1)
  for i in range(num_cards):

    # Insert card into scene.
    var card_scene = load("res://card.tscn")
    var card = card_scene.instantiate()
    add_child(card)

    print(card)
    

    
    # Increase idxs by manually adding 1 and carrying over where necessary.
    idxs[0] += 1
    for j in range(board.deck.keys().size()):
      if idxs[j] == board.deck[board.deck.keys()[j]].size():
        idxs[j] = 0
        if j+1 < board.deck.keys().size():
          idxs[j+1] += 1
        if j+1 == board.deck.keys().size():
          # Just a sanity check.
          assert(i == num_cards-1)