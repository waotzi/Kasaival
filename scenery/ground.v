module scenery

import vraylib
import lyra

struct Tile {
	p1    C.Vector2
	p2    C.Vector2
	p3    C.Vector2
	color C.Color
}

pub struct Ground {
mut:
	tiles  []Tile
	rows   int = 9
}

fn get_color(i int, cs [][]int) C.Color {
	grv := vraylib.get_random_value
	r := grv(cs[i][0], cs[i][1])
	g := grv(cs[i][2], cs[i][3])
	b := grv(cs[i][4], cs[i][5])
	return C.Color{byte(r), byte(g), byte(b), 255}
}

pub fn (mut self Ground) load(mut eye lyra.Eye, width int, cs [][]int) {
	eye.gh = lyra.game_height * .5
	mut y := lyra.game_height - eye.gh
	w := eye.gh / self.rows
	h := w
	start_x := lyra.start_x - w
	end_x := lyra.start_x + width + w
	eye.gw = start_x + end_x
	for y < lyra.game_height + h {
		mut x := start_x
		for x < end_x {
			mut cs_i := 0
			self.tiles << Tile{C.Vector2{x - w * .5, y}, C.Vector2{x, y + h}, C.Vector2{x +
				w * .5, y}, get_color(cs_i, cs)}
			self.tiles << Tile{C.Vector2{x + w * .5, y}, C.Vector2{x, y + h}, C.Vector2{x + w, y +
				h}, get_color(cs_i, cs)}
			x += w
		}
		y += h
	}
}

[live]
pub fn (mut self Ground) update() {
}

[live]
pub fn (self &Ground) draw() {
	for tile in self.tiles {
		vraylib.draw_triangle(tile.p1, tile.p2, tile.p3, tile.color)
	}
}

[live]
pub fn (self &Ground) unload() {
}