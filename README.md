# Kanizsa_Prime
This repository contains Neurobs Presentation scripts to present completely configurable 3 and 4 vertex Kanizsa stimuli, i.e. Pac-Man shapes delineating triangular or square, regular or irregular, gestalt shapes. Shapes primers can be displayed before each stimulus, consisting of two red lines per Pac-Man, of the same angle and length as the angular Pac-Man inset ('mouth').

The code is freely available to use or modify under the MIT licence. For more detailed documentation of the Presentation environment, programming languages, and usage see \url{https://www.neurobs.com/pres_docs/html/03_presentation/01_getting_started/index.html}.

The protocol has been reported here:
_Cowley, B. (2017) The PSICAT protocol - Primed Subjective Illusory Contour Attention Task for studying integrated functional cognitive basis of sustained attention. Behavioural Research Methods, X, Y_
If the protocol or any part of the code is used in published research, authors should cite the publication above in full, and link to this repository for the benefit of their readers to validate their work.

## Scenarios
Two scenario files are included:
* PSICAT.sce
  * The main protocol scenario, which defines the Presentation objects (header parameters, stimuli, trials), and links to PSICAT.pcl to actually run the protocol.
* PSICATpractice.sce
  * A practice scenario, contains the same SDL code as PSICAT.sce, but defines its own PCL structure for just 12 trial presentations.

## PCL code
Five PCL code files are included:
*


## Localisation
The protocol is localised, meaning that any language can be used for instructions if the text strings and audio wavefiles are provided. Text objects and audio instruction files are defined in `PSICAT.sce` to be in Finnish. The function `localise()` will reset the text captions and audio wavefile filenames, given an argument string of the preferred language name. Currently only English is supported, and not for audio; audio instruction files are provided only in Finnish. However the function shows the complete example code which needs only to be uncommented once audio files are available.
