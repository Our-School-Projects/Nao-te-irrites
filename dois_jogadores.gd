extends Node2D

var turn = 1
var dicePose = [573,748,1379,744,1372,340,575,336]
var diceFace
var playerRun = [0,0,0,0]
var outBox = [0,0,0,0]
var globPos =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var worldPose =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var playerDie = [1,11,16,21,31,36,41,51,56,61,71,76]
var iniPose = [754.053,714.947,667.1,806.993,753.102,808.948,669.054,716.992,1156.09,736.704,1239.02,824.702,1152.97,825.655,1240.06,738.704,757,336,670,250.001,759,250,671,334,1137.1,234.363,1228.41,318.933,1142.52,323.204,1223.04,231.091]

@export var exVar = 0
func _ready():
	$DiceRoll.hide()

func _on_Dice_pressed():
	if turn != 0:
		$DiceRoll.show()
		$Dice.hide()
		$DiceRoll.play("DiceRoll")

func _on_DiceRoll_animation_finished():
	randomize()
	diceFace = randi()%6-1
	$DiceRoll.stop()
	$DiceRoll.hide()
	$Dice.show()
	$Dice.set_frame(diceFace-1)
	if outBox[turn-1] == 1:	
		playerRun[turn-1] = 1
		turn=0
	elif diceFace == 6:
		playerRun[turn-1] = 1
		turn=0
	else:
		playerRun[turn-1] = 0
		var set= turn*2
		if turn==2:
			$Dice.position.x=dicePose[0]
			$Dice.position.y=dicePose[1]
			$DiceRoll.position.x=dicePose[0]
			$DiceRoll.position.y=dicePose[1]
		else:
			$Dice.position.x=dicePose[set]
			$Dice.position.y=dicePose[set+1]
			$DiceRoll.position.x=dicePose[set]
			$DiceRoll.position.y=dicePose[set+1]
		turn = turn+1
		print(turn)
		if turn ==3:
			turn =1
		
func winPoseFunc(x):
	pass
func _on_playDoneBlue(playerPose,x,DiceFace,chkkill,killPose):
	playerRun[0] = 0
	print(killPose)
	print(x)
	print(chkkill)
	print(DiceFace)
	if DiceFace == 6:
		turn = 1
	else:
		turn = 2
		$Dice.position.x=dicePose[2]
		$Dice.position.y=dicePose[3]
		$DiceRoll.position.x=dicePose[2]
		$DiceRoll.position.y=dicePose[3]
	globPos[x] += DiceFace
	worldPose[x] = playerPose
	if chkkill == 1:
		player_kill(killPose)
	
func _on_red_play_done_red(playerPose,x,DiceFace,chkkill,killPose):
	playerRun[1] = 0
	if DiceFace == 6:
		turn = 2
	else:
		turn = 3
		$Dice.position.x=dicePose[0]
		$Dice.position.y=dicePose[1]
		$DiceRoll.position.x=dicePose[0]
		$DiceRoll.position.y=dicePose[1]
	globPos[x+4] += DiceFace
	if chkkill == 1:
		player_kill(killPose)

func _on_blue_out_box_blue(x,y):
	outBox[0] = 1
	turn = 1
	playerRun[0] = 0
	globPos[x] = 1
			
func _on_red_out_box_red(x,y):
	outBox[1] = 1
	turn = 2
	playerRun[1] = 0
	globPos[x] = 21

func _on_button_pressed():
	if playerRun[0] == 1 :
		$Blue.playRun(0,diceFace,globPos)

func _on_button_2_pressed():
	if playerRun[0] == 1 :
		$Blue.playRun(1,diceFace,globPos)	

func _on_button_3_pressed():
	if playerRun[0] == 1 :
		$Blue.playRun(2,diceFace,globPos)

func _on_button_4_pressed():
	if playerRun[0] == 1 :
		$Blue.playRun(3,diceFace,globPos)

func _on_R1_pressed():
	if playerRun[1] == 1 :
		$Red.playRun(0,diceFace,globPos)

func _on_R2_pressed():
	if playerRun[1] == 1 :
		$Red.playRun(1,diceFace,globPos)	

func _on_R3_pressed():
	if playerRun[1] == 1 :
		$Red.playRun(2,diceFace,globPos)

func _on_R4_pressed():
	if playerRun[1] == 1 :
		$Red.playRun(3,diceFace,globPos)

func player_kill(x):
	var pathPlayer = [$Blue/B1,$Blue/B2,$Blue/B3,$Blue/B4,$Red/R1,$Red/R2,$Red/R3,$Red/R4]
	pathPlayer[x].position.x = iniPose[x*2]
	pathPlayer[x].position.y = iniPose[(x*2)+1]

