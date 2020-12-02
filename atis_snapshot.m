function img=atis_snapshot(aps_data, start_time, duration, sx, sy)
% img = atis_snapshot(aps_data, from, win, sx=304, sy=240)
%
% Makes a snapshot of the gray levels contained in an aps_data structure.
% This snapshot consists of the last gray level value contained in aps_data
% for each pixel from 'start_time' and for 'duration' (all given in uS)
%
% 'sx' and 'sy' represent the size of the generated image and defaults to
% the size of the ATIS sensor when non-specified

if ~exist('sx','var')
    sx = 304;
end
if ~exist('sy','var')
    sy = 240;
end

img = zeros(sy,sx);
start = find(aps_data.ts>=start_time, 1, 'first');
end_time = start_time+duration;

for i=start:length(aps_data.ts)
    if (aps_data.ts(i) > end_time)
        break;
    end
    img(aps_data.y(i)+1,aps_data.x(i)+1) = aps_data.gray(i);
end
