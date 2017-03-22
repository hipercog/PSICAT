/**
DESCRIPTION: SCENARIO RUNS A BLOCKED EXPERIMENT OF PRIMED KANIZSA SHAPES
Author :	Ben Cowley
Created:	01-05-2012
Modded :	28-06-2012
*/

scenario = "Saliency";

write_codes=true; # Write all codes to parallel port (for EEG acquisition)
pulse_width=16; # Seems to work fine
default_font_size = 20;
default_font = "Verdana";
active_buttons = 2;
button_codes = 190, 199;	# 190, 199 = Response pad buttons (for 2 saliency target classes);
response_port_output=true;

# foreground and background colors need to be defined in both SDL (as right below) and PCL (at the beginning of pcl sequence)
#foreground color
$fg = "255, 255, 255";
#background color
$bg = "0, 0, 0";
#transparency
$transparent = "1, 0, 0";

# Saliency Protocol codes
$SOA		= 144;	# Stimulus onset asynchrony for saliency proc

# Timing constants for saliency task - DUR is for saliency protocol
$FIXA_DUR = 100;
$SOA_DUR = 500;
$INTF_DUR = 100;
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
bitmap	{ filename = "Salience/noncepad.png"; }	rPadPic;
bitmap	{ filename = "Salience/W3CON_1.png";}	sCRT_instr_shapePic;
bitmap	{ filename = "Salience/W3INCON_1.png";}	sCRT_instr_nonshapePic;

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
text { caption =
"Seuraavaksi näet joukon valkoisia palloja, joiden
päällä on mustia kolmion tai nelikulmion kärkiä. "; } sCRT_text_0;

text { caption =
"Toisinaan kärjet kuuluvat
yhtenäiseen  kuvioon muodostaen
kolmion tai nelikulmion..."; } sCRT_text_1;

text { caption = "...ja toisinaan eivät."; } sCRT_text_1a;

text { caption = 
"Tehtävänäsi on havaita, milloin kärjet
kuuluvat samaan nelikulmioon tai kolmioon.

Kuviot voivat olla säännöllisiä tai epäsäännöllisiä.

Paina OIKEAA näppäintä kun kulmista muodostuu
yhtenäinen nelikulmio tai kolmio ja VASENTA näppäintä
kun yhtenäistä kuviota ei muodostu."; } sCRT_text_1b;

/**
There will be five rounds, with a break between each
-
When you are ready, press any key to begin.
*/
text { caption = "Koekertoja on yhteensä viisi.
Voit pitää tauon koekierrosten välillä.
 
  
Yritä olla mahdollisimman nopea
sekä mahdollisimman tarkka.
 
 
Kun olet valmis, paina mitä tahansa
näppäintä aloittaaksesi."; } sCRT_text_1c;

/**
Audio clip stimuli:
*/
sound{wavefile {filename = "Salience/instrWavs/0_intro.wav";};		attenuation = .10;}	sound0_intro;
sound{wavefile {filename = "Salience/instrWavs/instructions2.wav";};	attenuation = .10;}	sound1_resp;

#########------------#############-----------##########-----------##########
# THE TRIAL SET...

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
}fixation_trial;

# general SOA trial
trial {	trial_duration = $SOA_DUR;  picture default;	port_code = $SOA;	code = "SOA"; } SOA_trial;

# Present written instructions
trial {
	trial_duration = stimuli_length;
	/*	Audio instructions */
	stimulus_event{
		sound sound0_intro;
	} sCRT_instrAud_ev;
	/* Text instructions */
	picture { 
		text 	sCRT_text_0; x=0; y=350; 
		text 	sCRT_text_1; x=-200; y=200; 
		bitmap	sCRT_instr_shapePic;  x=250; y=190;
		text 	sCRT_text_1a; x=-200; y=50;
		bitmap	sCRT_instr_nonshapePic;  x=250; y=10;
		text 	sCRT_text_1b; x=0; y=-250;
	} sCRT_instrPic;
	time = 0; code = "SaliencyInstructions";
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
		bitmap	rPadPic; x=0; y=-150;
	} sCRT_respPic;
	time = 0; code = "Press to begin";
} sCRT_resp_trial;


#########------------#############-----------##########-----------##########
#	PCL PROGRAM 
#
begin_pcl; 
logfile.add_event_entry( date_time("ddmmyyyyhhnnsszz")); 

include "Kanizsa.pcl"

# Number of trials per block
int t = 3;

sCRT_instr_trial.present();

# Block of 3 irregular, elliptical Kanizsas
saliency( false, "ellipse", 0, t );

# Block of 3 irregular, elliptical Kanizsas
saliency( false, "ellipse", 10, t );

# Block of 3 irregular, elliptical Kanizsas
saliency( false, "ellipse", 20, t );

# Block of 3 irregular, elliptical Kanizsas
saliency( false, "ellipse", 30, t );
