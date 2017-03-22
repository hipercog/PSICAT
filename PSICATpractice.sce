/**
DESCRIPTION: SCENARIO FILE PROVIDES DEFAULTS, GRAPHICAL OBJECTS, AND TRIAL
             DEFINITIONS FOR A BLOCKED EXPERIMENT OF PRIMED KANIZSA SHAPES
Author :	Ben Cowley
Created:	01-05-2012
Modded :	28-03-2017
*/

#########------------#############-----------##########-----------##########----
# HEADER PARAMETERS
#########------------#############-----------##########-----------##########----
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




#########------------#############-----------##########-----------##########----
# GLOBALS
#########------------#############-----------##########-----------##########----
# Colors need to be defined both here (in SDL) and in PCL (see PSICAT.pcl)
$FORE_COL = "255, 255, 255"; #foreground color
$BACK_COL = "0, 0, 0"; #background color
$LINE_COL = "1, 0, 0"; #primer line color


## PSICAT PROTOCOL CODES
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
# Fixed parallel port codes, do not use these for anything else!
$TASK_START	= 254;
$TASK_END	= 255;


## TIMING CONSTANTS FOR PROTOCOL
$FIXA_DUR = 100;
$SOA_DUR = 500;
$INTF_DUR = 150;
$KNZA_DUR = 2000;

begin;




#########------------#############-----------##########-----------##########----
# General stimuli TEXT, PICS and SOUNDS
#########------------#############-----------##########-----------##########----

## EMPTY PICTURE
picture {} default ;


## FIXATION CROSS PRECEDES EACH TRIAL
picture {
	line_graphic { coordinates = -30, 0, 30, 0; line_width = 3; }; x = 0; y = 0;
	line_graphic { coordinates = 0, -30, 0, 30; line_width = 3; }; x = 0; y = 0;
	ellipse_graphic{
    ellipse_width = 20;	ellipse_height = 20; color = 0,0,0;
  }; x = 0; y = 0;
} eyes_open2;


## LINE, ELLIPSE AND ANNULI GRAPHICS FOR POLYGONS
# COLORS ARE OVERRIDEN IN PCL CODE.
line_graphic {
  background_color = 120, 0, 0;
  transparent_color = 120, 0, 0;
} lyne;
ellipse_graphic {
  background_color = 120, 0, 0;
  transparent_color = 120, 0, 0;
} pacman_e;
annulus_graphic {
  background_color = 120, 0, 0;
  transparent_color = 120, 0, 0;
} annulus1;
annulus_graphic {
  background_color = 120, 0, 0;
  transparent_color = 120, 0, 0;
} annulus2;


## BITMAP GRAPHICS
bitmap	{ filename = "./Stimuli/noncepad.png"; }	rPadPic;
# Example (not-)collinear Kanizsa shapes not used as they're shown in practice
#bitmap	{ filename = "./Stimuli/W3CON_1.png";}	PSIC_instr_shapePic;
#bitmap	{ filename = "./Stimuli/W3INCON_1.png";}	PSIC_instr_nonshapePic;


## TEXTUAL GRAPHICS, IN FINNISH WITH ENGLISH MEANINGS.
# SEE Localise() FUNCTION TO CHANGE LANGUAGE.
# HERE SWAP THE WORDS OIKEAA, VASENTA (RIGHT, LEFT) WHEN SWAPPING THE HANDEDNESS
# OF RESPONDING FOR COUNTER-BALANCING IN A GROUP STUDY
/**
Press the RIGHT key when the Pac-Man objects together form an invisible 3 or
 4-cornered shape, and the LEFT key when there is no shape.

There will be five rounds, with a break between each

Try to be fast, but accurate.
*/
text { caption = "Paina OIKEAA näppäintä kun kulmista
muodostuu yhtenäinen nelikulmio tai kolmio
ja paina VASENTA näppäintä kun yhtenäistä
kuviota ei muodostu.

Koekertoja on yhteensä viisi.
Voit pitää tauon koekierrosten välillä.

Yritä olla mahdollisimman nopea
sekä mahdollisimman tarkka.
"; } PSIC_text_0;

/**
When you are ready, press any key to begin.
*/
text { caption = "Kun olet valmis, paina mitä tahansa
näppäintä aloittaaksesi."; } PSIC_text_1c;

/**
Now you have a moment to rest and clear your head. Another block of stimuli will
 be presented when you press the button, and your task will remain the same.
-
When you are ready, press any key to begin.
*/
text { caption = "Nyt sinulla on hetki aikaa levätä
ja tyhjentää ajatuksesi.
Kun painat nappia, käymme taas läpi samanlaisen
koetilanteen kuin äsken. Tehtäväsi pysyy edelleen samana.
-
Kun olet valmis, paina mitä tahansa
näppäintä aloittaaksesi."; } PSIC_text_2;

/**
...four/three/two/one rounds remaining.
*/
text { caption = "Jäljellä on neljä kierrosta."; font_size = 40; } PSIC_text_2a;
text { caption = "Jäljellä on kolme kierrosta."; font_size = 40; } PSIC_text_2b;
text { caption = "Jäljellä on kaksi kierrosta."; font_size = 40; } PSIC_text_2c;
text { caption = "Jäljellä on yksi kierros."; font_size = 40; } PSIC_text_2d;


## AUDIO CLIP STIMULI
sound{
  wavefile {filename = "./Stimuli/instrWavs/instructions2.wav";} sound1_wav;
  attenuation = .10;
}	sound1_resp;
sound{
  wavefile {filename = "./Stimuli/instrWavs/relax.wav";} sound2_wav;
  attenuation = .10;
}	sound2_relax;
sound{
  wavefile {filename = "./Stimuli/instrWavs/responsepad.wav";} sound3_wav;
  attenuation = .10;
}	sound3_resPad;




#########------------#############-----------##########-----------##########
# THE TRIAL SET...
#########------------#############-----------##########-----------##########----
## FIRST TRIAL: SEND START CODE TO PORT.
trial {
	trial_duration = 1000;
	stimulus_event {
		nothing {};
	} stev; nothing {};
	port_code = $TASK_START;
	code = "Start task";
} startAll;

## LAST TRIAL: SEND END CODE TO PORT.
trial {
  trial_duration = 50;
  nothing {};
  port_code = $TASK_END;
  code = "End task";
} endAll;

## EMPTY PICTURE AND TRIAL FOR HOLDING KANIZSA TARGET STIMULI
trial {
   trial_duration = $KNZA_DUR;
	trial_type = first_response;
	stimulus_event {
		picture {} pyc;
	} ev;
}Kanizsa;

## FIXATION PERIOD
trial {
	trial_duration = $FIXA_DUR;
	# Fixation cross for eyes open measurement
	picture eyes_open2;
	port_code = $FIXA;
	code = "Fixation Cross";
}fixation_trial;

## GENERAL SOA TRIAL
trial {
  trial_duration = $SOA_DUR;
  picture default;
	port_code = $SOA;
	code = "SOA";
} SOA_trial;

## SAVE THE PROTOCOL EVENTS TO LOGFILE
trial {
  save_logfile {};
  time = 0;
	code = "SAVE LOGFILE";
} save_trial;

## PRESENT WRITTEN INSTRUCTIONS
trial {
	trial_duration = stimuli_length;
	/*	Audio instructions */
	stimulus_event{
		sound sound3_resPad;
	} PSIC_instrAud_ev;
	/* Text instructions */
	picture {
		text 	PSIC_text_0; x=0; y=0;
		#text 	PSIC_text_1; x=-200; y=200; #y=250
		#bitmap	PSIC_instr_shapePic;  x=250; y=190;  #x=350 y=250
		#text 	PSIC_text_1a; x=-200; y=50;  #y=100
		#bitmap	PSIC_instr_nonshapePic;  x=250; y=10;  #x = 300
		#text 	PSIC_text_1b; x=0; y=-250; #y=-200
	} PSIC_instrPic;
	time = 0; code = "PSICAT Instructions";
} PSIC_instr_trial;

trial{
	trial_duration = forever;
	trial_type = first_response;
	/*	Audio instructions */
	stimulus_event{
		sound sound1_resp;
	} PSIC_respAud_ev;
	/* Text instructions */
	picture {
		text	PSIC_text_1c; x=0; y=100;
		bitmap	rPadPic; x=0; y=-200;
	} PSIC_respPic;
	time = 0; code = "Press to begin";
} PSIC_resp_trial;




#########------------#############-----------##########-----------##########----
#	PCL PROGRAM
#########------------#############-----------##########-----------##########----
begin_pcl;
logfile.add_event_entry( date_time("ddmmyyyyhhnnsszz"));

include "Kanizsa.pcl"

# Number of trials per block
int t = 3;

# Call this function to localise instructions to preferred language
# localise( "english" );

PSIC_instr_trial.present();

# Block of 3 irregular, elliptical Kanizsas
kanizsaBlock( false, "ellipse", 0, t );

# Block of 3 irregular, elliptical Kanizsas
kanizsaBlock( false, "ellipse", 10, t );

# Block of 3 irregular, elliptical Kanizsas
kanizsaBlock( false, "ellipse", 20, t );

# Block of 3 irregular, elliptical Kanizsas
kanizsaBlock( false, "ellipse", 30, t );
