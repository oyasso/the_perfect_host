extends Node3D

func crawl():
	$AnimationPlayer.play("Armature TorsoAction")
	
	var tween : Tween = create_tween()
	tween.tween_property(self, "position:x", -36, 6.5)
