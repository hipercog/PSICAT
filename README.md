![PSICAT logo](https://raw.githubusercontent.com/zenBen/Kanizsa_Prime/master/Stimuli/psicat.png)

# Description

This repository contains the code for PSICAT, a sustained attention test. PSICAT is built on Neurobs Presentation scripts to present completely configurable 3 and 4 vertex Kanizsa stimuli, i.e. Pac-Man shapes delineating triangular or square, regular or irregular, gestalt shapes. Shapes primers can be displayed before each stimulus, consisting of two red lines per Pac-Man, of the same angle and length as the angular Pac-Man inset ('mouth').

The code is freely available to use or modify under the MIT licence.

## Reporting and testing

The protocol and its validation testing has been reported in a preprint, and is pending peer-reviewed publication:

_Cowley, B. U. (2017). The PSICAT protocol - Primed Subjective-Illusory-Contour Attention Task for studying integrated functional cognitive basis of sustained attention. Open Science Framework, preprint(gd5p4). Retrieved from ![osf.io/gd5p4](https://osf.io/gd5p4/)_

If the protocol or any part of the code is used in published research, authors should cite the latest publication given above, and link to this repository for the benefit of their readers to validate their work.

The data used to test the protocol is ![available from Figshare](https://figshare.com/account/projects/28047/articles/5759487)

## Code Files
Two scenario files are included:
* `PSICAT.sce` - The main protocol scenario, which defines the Presentation objects (header parameters, stimuli, trials), and links to `PSICAT.pcl` to actually run the protocol.
* `PSICATpractice.sce` - A practice scenario, contains the same SDL code as `PSICAT.sce`, but defines its own PCL structure for just 12 trial presentations.

Five PCL code files are included (listed in order of compilation):
* `PSICAT.pcl` - defines globals related to colour, timing, and screen dimensions; and contains two subroutines:
  * `kanizsaBlock()` - this draws a single block of Kanizsa shapes, with parameters that define shape appearance and number
  * `PSICATprotocol()` - defines the overall protocol structure, including number of blocks and breaks between
* `Localise.pcl` - contains just 1 subroutine, to switch language of instruction materials (see below).
* `Shapes.pcl` - contains two subroutines, which draw the individual shapes and primers
  * `kanizsaShape()` - generates a Kanizsa stimuli with randomly oriented Pac-Man shapes
  * `polyfilla()` - for drawing polygons of specified dimension
* `Utilities.pcl` - contains four subroutines that perform various useful functions
  * `rotateMat()` - rotates a matrix about one of its own vertices
  * `correctTri()` - checks that a triangle covers an ellipse to make a Pac-Man shape, if not returns a rectangle necessary to correct.
  * `euc()` - finds the Euclidean distance between two points
  * `triFill()` - returns the triangle needed to fit over an ellipse to get a Pac-Man shape
* `Randomness.pcl` - contains two subroutines to generate random screen locations and rotation angles that respect screen dimensions
  * `randCS()` - returns an [i][2] array of randomized coordinates
  * `randR()` - generates randomized rotation angles for non-shape Kanizsas

An experiment file is included `PSICAT.exp` - this is only for illustrative purposes, as experiments should anyway be defined by each user for their own experiment machine, ports, response device, etc etc.

A setdef file `kanizsa_setdef.sdf` is included, but has not been tested.

## Stimulus files

PSICAT presents entirely computer-generated test stimuli. Thus the only stimulus files included are for instructions. There are several .png image files:
* an example picture for the response device, this could be updated by the user to their own device
* example pictures of Kanizsa shapes and non-shapes: in our experiments these were removed from the automated instructions in favour of showing on a sheet of paper by the research assistant. Users should decide their own approach.

There are also instruction audio files in Finnish, recorded by and copyright of Kristiina Juurmaa. The content of the recordings matches the text instructions to be found in PSICAT.sce. To localise, users should record their own audio and edit `Localise.pcl` to enable switching of the file pointers. Audio wav files are linked under `Stimuli\instrWavs\`, but are tracked with git LFS; for those who wish to clone without heavy downloads do 

```git lfs clone https://github.com/zenBen/PSICAT.git```

## Localisation
The protocol is localised, meaning that any language can be used for instructions if the text strings and audio wavefiles are provided. Text objects and audio instruction files are defined in `PSICAT.sce` to be in Finnish. The subroutine `localise()` will reset the text captions and audio wavefile filenames, given an argument string of the preferred language name. Currently only English is supported, and not for audio; audio instruction files are provided only in Finnish. However the function shows the complete example code which needs only to be uncommented once audio files are available.

## Output
The protocol is configured to write the following port codes:

* 144 = Stimulus onset asynchrony (or intertrial interval)
* 143 = fixation cross display
* 254 = task start
* 255 = task end
* 190, 199 = Response pad buttons for 2 target classes

Each of five blocks are preceded by 'Start block' codes with triggers: 145, 146, 147, 148, 149
Condition codes for block 1 will be as below. All following blocks increment these codes by +10, giving 161-168, 171-178, etc.

* 151	:	shape primer for congruent shape target
* 152	:	shape target with congruent shape primer
* 153	:	nonshape primer for incongruent shape target
* 154	:	shape target with incongruent nonshape primer
* 155	:	nonshape primer for congruent nonshape target
* 156	:	nonshape target with congruent nonshape primer
* 157	:	shape primer for incongruent nonshape target
* 158	:	nonshape target with incongruent shape primer

The protocol also writes extra details to the Presentation log file, including the number and screen coordinates of the shape vertices.
