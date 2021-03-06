/// @description menu items
display_set_gui_size(VIEW_W, VIEW_H);

invalidKeys = [vk_enter, vk_escape, vk_backspace, vk_control, vk_alt, vk_lcontrol, vk_lalt];

enum MENU_ITEMS {
	MAIN,
	SAVES,
	SETTINGS,
	AUDIO,
	GRAPHICS,
	CONTROLS,
	LEVELS,
	CREDITS,
	QUIT
}

enum MENU_ELEMENT_TYPE{
	SCRIPT,
	TRANS,
	SLIDER,
	SHIFT,
	TOGGLE,
	INPUT
}
ini_open("settings.ini");
var volume = ini_read_real("settings","volume",1);
var resolution = ini_read_real("settings","resolution",1);

//Create menu pages
ds_main_menu = create_menu_page(
	["PLAY",		MENU_ELEMENT_TYPE.TRANS,	MENU_ITEMS.SAVES],
	["SETTINGS",	MENU_ELEMENT_TYPE.TRANS,	MENU_ITEMS.SETTINGS],	
	["CREDITS",		MENU_ELEMENT_TYPE.SCRIPT,	room_goto,		Credits,[Credits]],
	["QUIT",		MENU_ELEMENT_TYPE.SCRIPT,	game_end]
);

ds_saves = create_menu_page(
	["SAVES",		MENU_ELEMENT_TYPE.SHIFT,	load_data,				0,		["PROFILE 1","PROFILE 2","PROFILE 3"]],
	["Back",		MENU_ELEMENT_TYPE.TRANS,	MENU_ITEMS.MAIN]
);

ds_settings = create_menu_page(
	["Audio",		MENU_ELEMENT_TYPE.TRANS,	MENU_ITEMS.AUDIO],
	["Graphics",	MENU_ELEMENT_TYPE.TRANS,	MENU_ITEMS.GRAPHICS],
	["Controls",	MENU_ELEMENT_TYPE.TRANS,	MENU_ITEMS.CONTROLS],
	["Reset to default", MENU_ELEMENT_TYPE.SCRIPT, reset_default],
	["Back",		MENU_ELEMENT_TYPE.TRANS,	MENU_ITEMS.MAIN]
);

ds_audio = create_menu_page(
	["Master",		MENU_ELEMENT_TYPE.SLIDER,	audio_master_gain,		volume,		[0,1]],
	["Back",		MENU_ELEMENT_TYPE.TRANS,	MENU_ITEMS.SETTINGS]
);

ds_graphics = create_menu_page(
	["Resolution",	MENU_ELEMENT_TYPE.SHIFT,	set_view_size,			resolution,		["640X360","1280x720","1920x1080","2560X1440"]],
	["Fullscreen",	MENU_ELEMENT_TYPE.TOGGLE,	window_set_fullscreen,	window_get_fullscreen(),		["WINDOWED","FULLSCREEN"]],
	["Back",		MENU_ELEMENT_TYPE.TRANS,	MENU_ITEMS.SETTINGS]
);

ds_controls = create_menu_page(
	["Up",			MENU_ELEMENT_TYPE.INPUT,	"KEY_UP",				ini_read_real("movement", "KEY_UP", vk_up)],
	["Down",		MENU_ELEMENT_TYPE.INPUT,	"KEY_DOWN",				ini_read_real("movement", "KEY_DOWN", vk_down)],
	["Left",		MENU_ELEMENT_TYPE.INPUT,	"KEY_LEFT",				ini_read_real("movement", "KEY_LEFT", vk_left)],
	["Right",		MENU_ELEMENT_TYPE.INPUT,	"KEY_RIGHT",			ini_read_real("movement", "KEY_RIGHT", vk_right)],
	["Attack",		MENU_ELEMENT_TYPE.INPUT,	"KEY_ATTACK",			ini_read_real("movement", "KEY_ATTACK", ord("Z"))],
	["Jump",		MENU_ELEMENT_TYPE.INPUT,	"KEY_JUMP",				ini_read_real("movement", "KEY_JUMP", ord("C"))],
	["Special",		MENU_ELEMENT_TYPE.INPUT,	"KEY_SPECIAL",			ini_read_real("movement", "KEY_SPECIAL", ord("X"))],
	["Back",		MENU_ELEMENT_TYPE.TRANS,	MENU_ITEMS.SETTINGS]
);
ini_close();

page = 0;
menu_pages = [ds_main_menu, ds_saves, ds_settings, ds_audio, ds_graphics, ds_controls];

var i = 0, array_len = array_length_1d(menu_pages);
repeat(array_len) {
	menu_option[i] = 0;
	i++;
}
inputting = false;