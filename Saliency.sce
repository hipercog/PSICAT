/**
DESCRIPTION: SCENARIO FILE PROVIDES DEFAULTS, GRAPHICAL OBJECTS, AND TRIAL
             DEFINITIONS FOR A BLOCKED EXPERIMENT OF PRIMED KANIZSA SHAPES
Author :	Ben Cowley
Created:	01-05-2012
Modded :	28-03-2017
*/

scenario = "PSICAT";
pcl_file = "PSICAT.pcl"; #code that actually runs the protocol

write_codes = true; # Write all codes to parallel port (for EEG acquisition)
pulse_width = 16; # Seems to work fine
default_font_size = 20;
default_font = "Verdana";
active_buttons = 2;
button_codes = 190, 199;	# Response pad buttons for 2 target classes
response_port_output = true;

## Test event
stimulus_properties = coords, string, cond, number, congruency, string, shape, string, pritar, string, vertices, number;
event_code_delimiter = ";";


# foreground and background colors need to be defined in both SDL (as below) and
# in PCL (at the beginning of pcl sequence)
$fg = "255, 255, 255"; #foreground color
$bg = "0, 0, 0"; #background color
$transparent = "1, 0, 0"; #transparency

# Fixed parallel port codes, do not use these for anything else!
$TASK_START	= 254;
$TASK_END	= 255;

# PSICAT Protocol codes
$SOA	= 144;	# Stimulus onset asynchrony (or intertrial interval)
$FIXA	= 143;	# fixation cross display.
/**
Blocks are preceded by 'Start block' codes with triggers: 145, 146, 147, 148, 149
Block 1 will be as follows -
151	:	shape primer for congruent shape target
152	:	shape target with congruent shape primer
153	:	nonshape primer for incongruent shape target
154	:	shape target with incongruent nonshape primer
155	:	nonshape primer for congruent nonshape target
156	:	nonshape target with congruent nonshape primer
157	:	shape primer for incongruent nonshape target
158	:	nonshape target with incongruent shape primer

All following blocks use the same pattern but add +10 to the codes.
*/

# Timing constants for saliency task - DUR is for saliency protocol
$FIXA_DUR = 100;
$SOA_DUR = 500;
$INTF_DUR = 150;
$KNZA_DUR = 2000;

begin;

#########------------#############-----------##########-----------##########
# General stimuli TEXT, PICS and SOUNDS

/**
Native Graphics
*/
# Empty picture
picture {} default ;

# Fixation cross precedes each trial
picture {
	line_graphic {		coordinates = -30,0,30,0;		line_width = 3;		}; x=0;y=0;
	line_graphic {		coordinates = 0, -30, 0, 30;	line_width = 3;		}; x=0;y=0;
	ellipse_graphic {	ellipse_width = 20;	ellipse_height = 20; color = 0,0,0;		}; x=0; y=0;
} eyes_open2;

## Line, ellipse and annuli graphics for polygons
line_graphic { background_color = 120, 0, 0; transparent_color = 120, 0, 0; } lyne;
ellipse_graphic { background_color = 120, 0, 0; transparent_color = 120, 0, 0; } pacman_e;
annulus_graphic { background_color = 120, 0, 0; transparent_color = 120, 0, 0; } annulus1;
annulus_graphic { background_color = 120, 0, 0; transparent_color = 120, 0, 0; } annulus2;

/**
Bitmap Graphics
*/
bitmap	{ filename = "./Stimuli/noncepad.png"; }	rPadPic;
#bitmap	{ filename = "./Stimuli/W3CON_1.png";}	sCRT_instr_shapePic;
#bitmap	{ filename = "./Stimuli/W3INCON_1.png";}	sCRT_instr_nonshapePic;

/**
Textual Graphics
*/
/**
Next you will be shown a series of pictures of Pacman-style objects, which
together will form either an invisible 3 or 4-sided shape, or no shape.
This is exactly the same as you were shown before starting.
Your task is to press the RIGHT key when you see a shape,
and the LEFT key when you see a non-shape. Try to be fast, but accurate.
*/

text { caption = "Paina OIKEAA näppäintä kun kulmista
muodostuu yhtenäinen nelikulmio tai kolmio
ja paina VASENTA näppäintä kun yhtenäistä
kuviota ei muodostu.


Koekertoja on yhteensä viisi.
Voit pitää tauon koekierrosten välillä.


Yritä olla mahdollisimman nopea
sekä mahdollisimman tarkka.
"; } sCRT_text_0;

/**
There will be five rounds, with a break between each
-
When you are ready, press any key to begin.
*/
text { caption = "Kun olet valmis, paina mitä tahansa
näppäintä aloittaaksesi."; } sCRT_text_1c;


/**
Now you have a moment to rest and clear your head.
Another block of stimuli will presented when you press the button,
and your task will remain the same.
-
When you are ready, press any key to begin.
*/
text { caption = "Nyt sinulla on hetki aikaa levätä
ja tyhjentää ajatuksesi.
-
Kun painat nappia, käymme taas läpi samanlaisen
koetilanteen kuin äsken. Tehtäväsi pysyy edelleen samana."; } sCRT_text_2;

# FIXME: provide English versions
text { caption = "Jäljellä on neljä kierrosta."; font_size = 40; } sCRT_text_2a;
text { caption = "Jäljellä on kolme kierrosta."; font_size = 40; } sCRT_text_2b;
text { caption = "Jäljellä on kaksi kierrosta."; font_size = 40; } sCRT_text_2c;
text { caption = "Jäljellä on yksi kierros."; font_size = 40; } sCRT_text_2d;

/**
Audio clip stimuli:
*/
sound{wavefile {filename = "./Stimuli/instrWavs/instructions2.wav";};	attenuation = .10;}	sound1_resp;
sound{wavefile {filename = "./Stimuli/instrWavs/relax.wav";};		attenuation = .10;}	sound2_relax;
sound{wavefile {filename = "./Stimuli/instrWavs/responsepad.wav";};attenuation = .10;}	sound3_resPad;

#########------------#############-----------##########-----------##########
# THE TRIAL SET...

# First trial: send start code to port.
trial {
	trial_duration = 1000;
	stimulus_event {
		nothing {};
	} stev; nothing {};
	port_code = $TASK_START;
	code = "Start task";
} startAll;

# Last trial: send end code to port.
trial { trial_duration = 50; nothing {}; port_code = $TASK_END;	code = "End task"; } endAll;

## Empty picture and trial for holding Kanizsa target stimuli
trial {
   trial_duration = $KNZA_DUR;
	trial_type = first_response;
	stimulus_event {
		picture {} pyc;
	} ev;
}Kanizsa;

## fixation period
trial {
	trial_duration = $FIXA_DUR;
	# Fixation cross for eyes open measurement
	picture eyes_open2;
	port_code = $FIXA;
	code = "Fixation Cross";
}fixation_trial;

# general SOA trial
trial {	trial_duration = $SOA_DUR;  picture default;	port_code = $SOA;	code = "SOA"; } SOA_trial;

# Save the thing.
trial {   save_logfile {};   time = 0;	code = "SAVE LOGFILE"; } save_trial;

# Present written instructions
trial {
	trial_duration = stimuli_length;
	/*	Audio instructions */
	stimulus_event{
		sound sound3_resPad;
	} sCRT_instrAud_ev;
	/* Text instructions */
	picture {
		text 	sCRT_text_0; x=0; y=0;
		#text 	sCRT_text_1; x=-200; y=200; #y=250
		#bitmap	sCRT_instr_shapePic;  x=250; y=190;  #x=350 y=250
		#text 	sCRT_text_1a; x=-200; y=50;  #y=100
		#bitmap	sCRT_instr_nonshapePic;  x=250; y=10;  #x = 300
		#text 	sCRT_text_1b; x=0; y=-250; #y=-200
	} sCRT_instrPic;
	time = 0; code = "PSICAT Instructions";
} sCRT_instr_trial;

trial{
	trial_duration = forever;
	trial_type = first_response;
	/*	Audio instructions */
	stimulus_event{
		sound sound1_resp;
	} sCRT_respAud_ev;
	/* Text instructions */
	picture {
		text	sCRT_text_1c; x=0; y=100;
		bitmap	rPadPic; x=0; y=-200;
	} sCRT_respPic;
	time = 0; code = "Press to begin";
} sCRT_resp_trial;
