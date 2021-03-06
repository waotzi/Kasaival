module stages

fn desert() []Scene {
	mut scene := Scene{}
	scene.ground.width += 3000
	scene.ground.cs = [
	// desert
		[190, 200, 130, 150, 80, 105],
		[170, 200, 115, 140, 80, 84],
		[200, 220, 115, 140, 75, 80],
		[220, 230, 105, 122, 54, 80]
	]
	// add saguaro spawner to spawners
	scene.spawners << get_spawner(.kali, 100)
	// return all scenes
	return [scene]
}
