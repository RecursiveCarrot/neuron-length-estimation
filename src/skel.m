%% Processing, Skeletonization, Masking and Path Chacterisation.

%% Set Up

getd = @(p)path(p,path);
addpath('../gramm/')

% Read patch image, saved as RGB tiff
original = imread('../sample/patch02.tif');
n = length(original);

figure(1)
imshow(original)

red = original(:,:,1);
green = original(:,:,2);
blue = original(:,:,3);

figure(2)
imgroup({ red green blue }, {'R' 'G' 'B'}, 1, 3);

%% Image Pre-processing
% This has to be done manually for each image. The noise in each image
% varies wildly, need to use different methods/thresholds to  seperate the 
% neuron signal from background.

% Clean up the background noise

% Tranform color space and apply color filter

% Sharpen, mask and correct image

%% Skeletonisation

% Skeletonise
% Tune the threshold. This will depend on the neuron width.
binGreen = imbinarize(green, 0.35);

% Lets see how blurring the image compares.
% 0.6 is blur, 0.25 is threshold
gaussBinGreen = imbinarize(imgaussfilt(green,0.6),0.25);
greenSkel = bwskel(binGreen);

% Try two different skeletonisation methods.
gaussGreenSkel = bwskel(gaussBinGreen);
gaussGreenSkelMethod2 = bwmorph(gaussBinGreen, 'skel', Inf);
figure(3)
imgroup({ gaussGreenSkel gaussGreenSkel2 }, {'Skeleton' 'Gaussian Preprocess'}, 1, 2);

% Compare each method to the base image.
figure(4)
imshowpair(gaussGreenSkel,  green);

figure(6)
imshowpair(gaussGreenSkel2, green);

%% Path Detection
% Scan from top to bottom and left to right on a 3x3 pixel grid.
% Convolution with a neighbour kernel lets us identify the starts/ends, 
% middles and branches of each path.
% A start/end will have only one neighbour, a middle will have two neighbours, 
% and a branch will have three or more neighbours.
% We output each into a csv for path identification in the
% alignment_processing mathematica notebook.

smoothing = [1 1 1;
            1  0 1;
            1  1 1];
path_key = conv2(gaussGreenSkel,smoothing,'same').*gaussGreenSkel;
singletons = path_key == 0;
ends = path_key == 1;
middles = path_key == 2;
branches = path_key > 2;

[row,col] = find(ends);
csvwrite("../output/ends.csv", [row,col])
[row,col] = find(middles);
csvwrite("../output/middles.csv", [row,col])
[row,col] = find(branches);
csvwrite("../output/branches.csv", [row,col])

figure(5)
segments = cat(3,255*ends, 255*middles, 255*branches);
imgroup({ segments green }, {'Paths' 'Original'}, 1,2);
