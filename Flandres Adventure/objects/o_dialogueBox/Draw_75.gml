/// @description 
c = c_white;
draw_set_halign(fa_left);

if portrait != noone {
	draw_sprite_ext(portrait, 0, x_start, y_start-184,1.5,1.5,0,c_white,1);
}
draw_set_font(font);
draw_sprite_stretched_ext(s_textBox,0,x_start,y_start,width,height,c_white,alpha);
draw_text_ext_color(x_start+margin,y_start+margin, currText, line_sep, line_width,c,c,c,c,1);
if drawArrow {
	draw_sprite(s_dialogueArrow,0,GUI_W/2,GUI_H-35);	
}
