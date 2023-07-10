using Godot;
using System;

public partial class Menu : Sprite2D
{
	private CheckBox checkBox;
	private int players = 2;
	private bool check;
	private bool check2;

	public override void _Ready()
	{
		checkBox = GetNode<CheckBox>("CheckBox"); 
	}

	
	private void _on_check_box_2_toggled(bool button_pressed)
	{
		
		if (button_pressed)
		{
			GetNode<Sprite2D>("Jogador3").Show();
			players = 3;
			check2 = true;
		}
		else{
			if(!check){
				GetNode<Sprite2D>("Jogador3").Hide();
				players = 3;
			}
			check2 = false;
		}
		
	}
	private void _on_check_box_3_toggled(bool button_pressed)
	{
		if (button_pressed)
		{
			GetNode<Sprite2D>("Jogador4").Show();
			GetNode<Sprite2D>("Jogador3").Show();
			players = 4;
			check = true;
		}
		else
		{
			GetNode<Sprite2D>("Jogador4").Hide();
			players = 3;
			check = false;
			if(!check2){
				GetNode<Sprite2D>("Jogador3").Hide();
			}
		}
	}
	private void _on_button_2_pressed()
	{
		if(players ==2){
			GetTree().ChangeSceneToFile("res://dois_jogadores .tscn"); 
		} else if(players ==3){
			GetTree().ChangeSceneToFile("res://tres_jogadores .tscn");
		} else if(players ==4){
			GetTree().ChangeSceneToFile("res://quatro_jogadores .tscn");
		}
		
	}
}









