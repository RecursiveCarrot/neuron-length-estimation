function imgroup(arrs, titles, a, b)

% imgroup - Helper function, 
%
% Example of usages:
%   imgroup(arrs,titles,1,2); 
%   please ensure lenth(arrs)<a*b

for n = 1:length(arrs)
    subplot(a, b, n);
    imshow(arrs{n});
    title(titles{n});
end