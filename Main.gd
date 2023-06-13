extends Node2D

var turn = 1
var dicePose = [573,748,1379,744,1372,340,575,336]
var diceFace
var playerRun = [0,0,0,0]
var outBox = [0,0,0,0]
var globPos =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var worldPose =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var playerDie = [1,11,16,21,31,36,41,51,56,61,71,76]
var iniPose = [754.053,714.947,667.1,806.993,753.102,808.948,669.054,716.992,1156.088,736.704,1239.017,824.702,1152.969,825.655,1240.064,738.704,757,336,670,250.001,759,250,671,334,1137.097,234.363,1228.41,318.933,1142.517,323.204,1223.041,231.091]
@export var exVar = 0
func _ready():
	$DiceRoll.hide()
	pass # Replace with function body.

func _on_Dice_pressed():
	if turn != 0:
		$DiceRoll.show()
		$Dice.hide()
		$DiceRoll.play("DiceRoll")

func _on_DiceRoll_animation_finished():
	randomize()
	diceFace = randi()% 6+1
	$DiceRoll.stop()
	$DiceRoll.hide()
	$Dice.show()
	$Dice.set_frame(diceFace-1)
#	if turn==1:
#		_on_playDoneBlue(diceFace)
#	elif turn==2:
#		_on_red_play_done_red(diceFace)	
#	elif turn==3:
#		_on_yellow_play_done_yellow(diceFace)	
#	elif turn==4:
#		_on_green_play_done_green(diceFace)	
#	turn=0
	if outBox[turn-1] == 1:	
		playerRun[turn-1] = 1
		turn=0
	elif diceFace == 6:
		playerRun[turn-1] = 1
		turn=0
	else:
		playerRun[turn-1] = 0
		var set= turn*2
		if turn==4:
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
		if turn ==5:
			turn =1
		
func _on_playDoneBlue(playerPose,x,DiceFace,chkkill,killPose):
	playerRun[0] = 0
	if chkkill == 1:
		player_kill(killPose)
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
	
func _on_red_play_done_red(playerPose,x,DiceFace,chkkill,killPose):
	playerRun[1] = 0
	if chkkill == 1:
		player_kill(killPose)
	if DiceFace == 6:
		turn = 2
	else:
		turn = 3
		$Dice.position.x=dicePose[4]
		$Dice.position.y=dicePose[5]
		$DiceRoll.position.x=dicePose[4]
		$DiceRoll.position.y=dicePose[5]
	globPos[x+4] += DiceFace

func _on_yellow_play_done_yellow(playerPose,x,DiceFace,chkkill,killPose):
	playerRun[2] = 0
	if chkkill == 1:
		player_kill(killPose)
	if DiceFace == 6:
		turn = 3
	else:
		turn = 4
		$Dice.position.x=dicePose[6]
		$Dice.position.y=dicePose[7]
		$DiceRoll.position.x=dicePose[6]
		$DiceRoll.position.y=dicePose[7]
	globPos[x+8] += DiceFace

func _on_green_play_done_green(playerPose,x,DiceFace,chkkill,killPose):
	playerRun[3] = 0
	if chkkill == 1:
		player_kill(killPose)
	if DiceFace == 6:
		turn = 4
	else:
		turn = 1
		$Dice.position.x=dicePose[0]
		$Dice.position.y=dicePose[1]
		$DiceRoll.position.x=dicePose[0]
		$DiceRoll.position.y=dicePose[1]
	globPos[x+12] += DiceFace
 
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
	
func _on_yellow_out_box_yellow(x,y):
	outBox[2] = 1
	turn = 3
	playerRun[2] = 0
	globPos[x] = 41
	
func _on_green_out_box_green(x,y):
	outBox[3] = 1
	turn = 4
	playerRun[3] = 0
	globPos[x] = 61

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
	
func _on_G1_pressed():
	if playerRun[3] == 1:
		$Green.playRun(0, diceFace,globPos)


func _on_G2_pressed():
	if playerRun[3] == 1:
		$Green.playRun(1, diceFace,globPos)


func _on_G3_pressed():
	if playerRun[3] == 1:
		$Green.playRun(2, diceFace,globPos)


func _on_G4_pressed():
	if playerRun[3] == 1:
		$Green.playRun(3, diceFace,globPos)


func _on_Y1_pressed():
	if playerRun[2] == 1:
		$Yellow.playRun(0, diceFace,globPos)


func _on_Y2_pressed():
	if playerRun[2] == 1:
		$Yellow.playRun(1, diceFace,globPos)


func _on_Y3_pressed():
	if playerRun[2] == 1:
		$Yellow.playRun(2, diceFace,globPos)


func _on_Y4_pressed():
	if playerRun[2] == 1:
		$Yellow.playRun(3, diceFace,globPos)

func player_kill(x):
	var pathPlayer = [$Blue/B1,$Blue/B2,$Blue/B3,$Blue/B4,$Red/R1,$Red/R2,$Red/R3,$Red/R4,$Yellow/Y1,$Yellow/Y2,$Yellow/Y3,$Yellow/Y4,$Green/G1,$Green/G2,$Green/G3,$Green/G4]
	pathPlayer[x].position.x = iniPose[x*2]
	pathPlayer[x].position.y = iniPose[(x*2)+1]
