function img=generate_em_snapshot(em_data, start_time, duration, sx, sy)
% img = generate_em_snapshot(em_data, from, win, sx=304, sy=240)
%
% Makes a snapshot of the gray levels contained in an em_data structure.
% This snapshot consists of the last gray level value contained in em_data
% for each pixel from 'start_time' and for 'duration' (all given in uS)
%
% 'sx' and 'sy' represent the size of the generated image and defaults to
% the size of the GEN1 sensor when non-specified

if ~exist('sx','var')
    sx = 304;
end
if ~exist('sy','var')
    sy = 240;
end

img = zeros(sy,sx);
start = find(em_data.ts>=start_time, 1, 'first');
end_time = start_time+duration;

for i=start:length(em_data.ts)
    if (em_data.ts(i) > end_time)
        break;
    end
    img(em_data.y(i)+1,em_data.x(i)+1) = em_data.gray(i);
end
