using Godot;
using System;

public partial class Menu : Sprite2D
{
	private CheckBox checkBox;

	public override void _Ready()
	{
		checkBox = GetNode<CheckBox>("CheckBox"); 
	}

	
	private void _on_check_box_2_toggled(bool button_pressed)
	{
		if (button_pressed)
			{
				GetNode<Sprite2D>("Jogador3").Show();
			}
			else
			{
				GetNode<Sprite2D>("Jogador3").Hide();
			}
	}
	private void _on_check_box_3_toggled(bool button_pressed)
	{
		if (button_pressed)
		{
			GetNode<Sprite2D>("Jogador4").Show();
		}
		else
		{
			GetNode<Sprite2D>("Jogador4").Hide();
		}
	}
}






