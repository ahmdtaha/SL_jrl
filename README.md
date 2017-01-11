# Seeded Laplacian Version 2
This MATLAB code is the latest version of Seeded Laplacian approach for interactive image segmentation. This version doesn't include the robot-user evaluation part, we plan to release that soon. It is important to note that this code needs a lot of refactoring and style improvement. It is just pushed for those interested in verifying its results. I plan to push further commit with better documentation and style.


# Datasets
This code works with the collection of annotated datasets of images we prepared. This collection comprise of 
- Geodesic Star Convexity
- Weizmann Horses
- Weizmann Single Object
- Weizmann Two objects
- BSD 100
You can download the collected annotated datasets from this [link](https://drive.google.com/file/d/0B-WgKier2PaCV0x6QldFc2lROUU/view?usp=sharing). For copyright purpose, we don't distribute the original or ground-truth images. If you can't find these online, you can contact us to help you with that. 

# Results

| Method |  Geodesic |  Horses | Single  |  Two | BSD 100 |
|---|---|---|---|---|---|
|BJ|0.49 ± 0.26|0.60 ± 0.23|0.66 ± 0.24|0.48 ± 0.27|0.53 ± 0.25|
|RW|0.53 ± 0.21|0.55 ± 0.15|0.42 ± 0.26|0.63 ± 0.25|0.49 ± 0.23|
|PP|0.59 ± 0.25|0.60 ± 0.24|0.68 ± 0.23|0.71 ± 0.25|0.59 ± 0.24|
|RW|0.61 ± 0.25|0.57 ± 0.22|0.69 ± 0.23|0.70 ± 0.25|0.57 ± 0.25|
|GSC|0.61 ± 0.24|0.55 ± 0.21|0.67 ± 0.22|0.68 ± 0.25|0.56 ± 0.25|
|ESC|0.56 ± 0.16|0.51 ± 0.11|0.48 ± 0.16|0.61 ± 0.20|0.52 ± 0.15|
|SP-IG|0.59 ± 0.22|0.48 ± 0.20|0.57 ± 0.24|0.60 ± 0.25|0.55 ± 0.23|
|SP-SIG|0.62 ± 0.17|0.57 ± 0.12|0.57 ± 0.18|0.70 ± 0.18|0.59 ± 0.15|
|**SL**|**0.68 ± 0.17**|**0.63 ± 0.15**|**0.70 ± 0.17**|**0.75 ± 0.17**|**0.63 ± 0.17**|

## Setup
- Download the latest push.
- Run the scribble_script MATLAB script file
For help, please contact ahmdtaha [@] cs dot umd dot edu

## Contributor list

1. [Ahmed Taha](http://www.cs.umd.edu/~ahmdtaha/) 
2. [Marwan Torki](http://www.eng.alexu.edu.eg/~mtorki/) 

## License
Copyright (c) 2016, Ahmed Taha (ahmdtaha [@] cs dot umd dot edu)
All rights reserved.
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
- Re distributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
- Re distributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.


# Scribble Segmentation Call sequence
- scribble_script
	- scribble_image {for each image} , return Jaccard Index
 		- colorandspatialaffinity {calculate features and eFunc} , return filled Image and erroded Image.
 		- Currently Feature Vector contains {RGB Affinity_Distance Affinity_LAB Affinity_IC Affinity (neg - pos) ,LAB,RGB}
 			- processf_efunc(efunc) , return filled Image 
 			- if input percentile = -1 then processf_efunc calculate min_percentile plot
 			 else processf_efunc uses the input parameter 
