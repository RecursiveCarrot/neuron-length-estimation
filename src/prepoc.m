V = VideoReader('imgs/Patch0/MAX_CompositeNeuron+NDRotatetest.avi');
I0 = readFrame(V);
green=imadjust(I0(:,:,2));
a = zeros(size(I0, 1), size(I0, 2));
I1 = cat(3, a, green, a);
I = imtophat(I1,strel('disk',18));
%I = imopen(I,strel('line',16, 0));
%I = imtophat(I,strel('line',10, 0));
I = imtophat(I,strel('line',10, -45));
imshowpair(I0,I,'montage')
% imshow(I)
