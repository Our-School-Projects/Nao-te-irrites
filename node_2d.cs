using Godot;
using System;

public partial class node_2d : Node2D
{
    private int turn = 1;
    private int[] dicePose = { 573, 748, 1379, 744, 1372, 340, 575, 336 };
    private int diceFace;
    private int[] playerRun = { 0, 0, 0, 0 };
    private int[] outBox = { 0, 0, 0, 0 };
    private int[] globPos = new int[16];
    private int[] worldPose = new int[16];
    private int[] playerDie = { 1, 11, 16, 21, 31, 36, 41, 51, 56, 61, 71, 76 };
    private float[] iniPose = { 754.053f, 714.947f, 667.1f, 806.993f, 753.102f, 808.948f, 669.054f, 716.992f, 1156.088f, 736.704f, 1239.017f, 824.702f, 1152.969f, 825.655f, 1240.064f, 738.704f, 757, 336, 670, 250.001f, 759, 250, 671, 334, 1137.097f, 234.363f, 1228.41f, 318.933f, 1142.517f, 323.204f, 1223.041f, 231.091f };
    [Export]
    public int exVar = 0;

    public override void _Ready()
    {
        GetNode<Node2D>("DiceRoll").Hide();
    }

    public void _on_Dice_pressed()
    {
        if (turn != 0)
        {
            GetNode<Node2D>("DiceRoll").Show();
            GetNode<Node2D>("Dice").Hide();
            ((AnimationPlayer)GetNode("DiceRoll")).Play("DiceRoll");
        }
    }

    public void _on_DiceRoll_animation_finished()
    {
        diceFace = (int)(GD.Randi() % 6) + 1;
        ((AnimationPlayer)GetNode("DiceRoll")).Stop();
        GetNode<Node2D>("DiceRoll").Hide();
		// GetNode<AnimationPlayer>("Dice").SetAnimationProcessMode(AnimationPlayer.AnimationProcessMode.Frame);
		// GetNode<AnimationPlayer>("Dice").CurrentAnimation = "DiceRoll";
		// GetNode<AnimationPlayer>("Dice").CurrentFrame = diceFace - 1;


        if (outBox[turn - 1] == 1)
        {
            playerRun[turn - 1] = 1;
            turn = 0;
        }
        else if (diceFace == 6)
        {
            playerRun[turn - 1] = 1;
            turn = 0;
        }
        else
        {
            playerRun[turn - 1] = 0;
            int set = turn * 2;
            if (turn == 4)
            {
                GetNode<Node2D>("Dice").Position = new Vector2(dicePose[0], dicePose[1]);
                GetNode<Node2D>("DiceRoll").Position = new Vector2(dicePose[0], dicePose[1]);
            }
            else
            {
                GetNode<Node2D>("Dice").Position = new Vector2(dicePose[set], dicePose[set + 1]);
                GetNode<Node2D>("DiceRoll").Position = new Vector2(dicePose[set], dicePose[set + 1]);
            }
            turn = turn + 1;
            GD.Print(turn);
            if (turn == 5)
            {
                turn = 1;
            }
        }
    }

    public void _on_playDoneBlue(int playerPose, int x, int DiceFace, int chkkill, int killPose)
    {
        playerRun[0] = 0;
        if (chkkill == 1)
        {
            player_kill(killPose);
        }
        GD.Print(DiceFace);
        if (DiceFace == 6)
        {
            turn = 1;
        }
        else
        {
            turn = 2;
            GetNode<Node2D>("Dice").Position = new Vector2(dicePose[2], dicePose[3]);
            GetNode<Node2D>("DiceRoll").Position = new Vector2(dicePose[2], dicePose[3]);
        }
        globPos[x] += DiceFace;
        worldPose[x] = playerPose;
    }

    public void _on_red_play_done_red(int playerPose, int x, int DiceFace, int chkkill, int killPose)
    {
        playerRun[1] = 0;
        if (chkkill == 1)
        {
            player_kill(killPose);
        }
        if (DiceFace == 6)
        {
            turn = 2;
        }
        else
        {
            turn = 3;
            GetNode<Node2D>("Dice").Position = new Vector2(dicePose[4], dicePose[5]);
            GetNode<Node2D>("DiceRoll").Position = new Vector2(dicePose[4], dicePose[5]);
        }
        globPos[x + 4] += DiceFace;
    }

    public void _on_yellow_play_done_yellow(int playerPose, int x, int DiceFace, int chkkill, int killPose)
    {
        playerRun[2] = 0;
        if (chkkill == 1)
        {
            player_kill(killPose);
        }
        if (DiceFace == 6)
        {
            turn = 3;
        }
        else
        {
            turn = 4;
            GetNode<Node2D>("Dice").Position = new Vector2(dicePose[6], dicePose[7]);
            GetNode<Node2D>("DiceRoll").Position = new Vector2(dicePose[6], dicePose[7]);
        }
        globPos[x + 8] += DiceFace;
    }

    public void _on_green_play_done_green(int playerPose, int x, int DiceFace, int chkkill, int killPose)
    {
        playerRun[3] = 0;
        if (chkkill == 1)
        {
            player_kill(killPose);
        }
        if (DiceFace == 6)
        {
            turn = 4;
        }
        else
        {
            turn = 1;
            GetNode<Node2D>("Dice").Position = new Vector2(dicePose[0], dicePose[1]);
            GetNode<Node2D>("DiceRoll").Position = new Vector2(dicePose[0], dicePose[1]);
        }
        globPos[x + 12] += DiceFace;
    }

    public void _on_blue_out_box_blue(int x, int y)
    {
        outBox[0] = 1;
        turn = 1;
        playerRun[0] = 0;
        globPos[x] = 1;
    }

    public void _on_red_out_box_red(int x, int y)
    {
        outBox[1] = 1;
        turn = 2;
        playerRun[1] = 0;
        globPos[x] = 21;
    }

    public void _on_yellow_out_box_yellow(int x, int y)
    {
        outBox[2] = 1;
        turn = 3;
        playerRun[2] = 0;
        globPos[x] = 41;
    }

    public void _on_green_out_box_green(int x, int y)
    {
        outBox[3] = 1;
        turn = 4;
        playerRun[3] = 0;
        globPos[x] = 61;
    }

    public void _on_button_pressed()
    {
        if (playerRun[0] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Blue"),0, diceFace, globPos);
        }
    }

    public void _on_button_2_pressed()
    {
        if (playerRun[0] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Blue"),1, diceFace, globPos);
        }
    }

    public void _on_button_3_pressed()
    {
        if (playerRun[0] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Blue"),2, diceFace, globPos);
        }
    }

    public void _on_button_4_pressed()
    {
        if (playerRun[0] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Blue"),3, diceFace, globPos);
        }
    }

    public void _on_R1_pressed()
    {
        if (playerRun[1] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Red"),0, diceFace, globPos);
        }
    }

    public void _on_R2_pressed()
    {
        if (playerRun[1] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Red"),1, diceFace, globPos);
        }
    }

    public void _on_R3_pressed()
    {
        if (playerRun[1] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Red"),2, diceFace, globPos);
        }
    }

    public void _on_R4_pressed()
    {
        if (playerRun[1] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Red"),3, diceFace, globPos);
        }
    }

    public void _on_G1_pressed()
    {
        if (playerRun[3] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Green"),0, diceFace, globPos);
        }
    }

    public void _on_G2_pressed()
    {
        if (playerRun[3] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Green"),1, diceFace, globPos);
        }
    }

    public void _on_G3_pressed()
    {
        if (playerRun[3] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Green"),2, diceFace, globPos);
        }
    }

    public void _on_G4_pressed()
    {
        if (playerRun[3] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Green"),3, diceFace, globPos);
        }
    }

    public void _on_Y1_pressed()
    {
        if (playerRun[2] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Yellow"),0, diceFace, globPos);
        }
    }

    public void _on_Y2_pressed()
    {
        if (playerRun[2] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Yellow"),1, diceFace, globPos);
        }
    }

    public void _on_Y3_pressed()
    {
        if (playerRun[2] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Yellow"),2, diceFace, globPos);
        }
    }

    public void _on_Y4_pressed()
    {
        if (playerRun[2] == 1)
        {
            Call("playRun",GetNode<AnimationPlayer>("Yellow"),3, diceFace, globPos);
        }
    }

    public void player_kill(int killPose)
    {
    //     if (killPose < 20)
    //     {
    //         GetNode<AnimationPlayer>("Blue").PlayHome(killPose - 1, iniPose);
    //         globPos[killPose - 1] = 0;
    //     }
    //     else if (killPose < 40)
    //     {
    //         GetNode<AnimationPlayer>("Red").PlayHome(killPose - 21, iniPose);
    //         globPos[killPose - 1] = 0;
    //     }
    //     else if (killPose < 60)
    //     {
    //         GetNode<AnimationPlayer>("Yellow").PlayHome(killPose - 41, iniPose);
    //         globPos[killPose - 1] = 0;
    //     }
    //     else
    //     {
    //         GetNode<AnimationPlayer>("Green").PlayHome(killPose - 61, iniPose);
    //         globPos[killPose - 1] = 0;
    //     }
    }
}
