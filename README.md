# Kanizsa_Prime
This repository contains Neurobs Presentation scripts to present completely configurable 3 and 4 vertex Kanizsa stimuli, i.e. Pac-Man shapes delineating triangular or square, regular or irregular, gestalt shapes. Shapes primers can be displayed before each stimulus, consisting of two red lines per Pac-Man, of the same angle and length as the angular Pac-Man inset ('mouth').

The code is freely available to use or modify under the MIT licence.

The protocol is to be reported in a publication:

_Cowley, B. (2017) The PSICAT protocol - Primed Subjective Illusory Contour Attention Task for studying integrated functional cognitive basis of sustained attention. Behavioural Research Methods, X, Y_

If the protocol or any part of the code is used in published research, authors should cite the publication above in full, and link to this repository for the benefit of their readers to validate their work.

## Scenarios
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


## Localisation
The protocol is localised, meaning that any language can be used for instructions if the text strings and audio wavefiles are provided. Text objects and audio instruction files are defined in `PSICAT.sce` to be in Finnish. The subroutine `localise()` will reset the text captions and audio wavefile filenames, given an argument string of the preferred language name. Currently only English is supported, and not for audio; audio instruction files are provided only in Finnish. However the function shows the complete example code which needs only to be uncommented once audio files are available.
