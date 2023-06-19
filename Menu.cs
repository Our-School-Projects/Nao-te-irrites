using Godot;
using System;

public partial class Menu : Sprite2D
{
	private CheckBox checkBox;
	private int players = 2;

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
			}
			else
			{
				GetNode<Sprite2D>("Jogador3").Hide();
				players = 3;
			}
	}
	private void _on_check_box_3_toggled(bool button_pressed)
	{
		if (button_pressed)
		{
			GetNode<Sprite2D>("Jogador4").Show();
				players = 4;
		}
		else
		{
			GetNode<Sprite2D>("Jogador4").Hide();
			players = 4;
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









