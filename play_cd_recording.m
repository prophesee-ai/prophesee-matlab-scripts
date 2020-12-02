function mov = play_cd_recording(filename, width, height, framerate, acc_time)
% Function to replay of file of CD events
%
%    mov = play_cd_recording(filename, width, height, framerate, acc_time)
%  filename: path and name of the file to replay
%  width, height: resolution of the sensor, defaults to 304 and 240
%  framerate: framerate of the generated images in frames per second (defaults to 25)
%  acc_time: time to leave the events in the frames in microseconds (defaults to 10000 us)
%
% returns a movie which can be used by the 'movie' command

if ~exist('width', 'var')
    width = 304;
end
if ~exist('height', 'var')
    height = 240;
end
if ~exist('framerate', 'var')
    framerate = 25;
end
if ~exist('acc_time', 'var')
    acc_time = 10000;
end


% Load data from the give file
cd_data = load_atis_data(filename);
% Make the pixel index start at 1 for compatibility for Matlab matrices
% indexes (in the files pixels coordinates start at 0)
cd_data.x = cd_data.x + 1;
cd_data.y = cd_data.y + 1;

% Compute internal parameters
frame_time = floor(1/framerate * 1e6); % in microseconds

% Initialize state storage
cd_img = 0.5*ones(height, width);
ts_img = zeros(height, width);
last_frame_ts = 0;
frame_idx = 1;

% Build a figure for movie display and store the first empty frame
figure();
image(cd_img);
colormap gray;
colormap_size = size(colormap, 1);
mov(frame_idx) = getframe(gcf);
frame_idx = frame_idx+1;

% Go through all events in file
for i=1:length(cd_data.ts)
    % Get timestamp of current event
    cur_ts = cd_data.ts(i);
    % Check if images should be generated
    while (cur_ts > last_frame_ts + frame_time)
        % Update frame by removing old events
        last_frame_ts = last_frame_ts + frame_time;
        cd_img(ts_img < last_frame_ts - acc_time) = 0.5;
        % scale and display image
        image(colormap_size*cd_img);
        mov(frame_idx) = getframe();
        frame_idx = frame_idx+1;
    end
    % Add event to state
    if cd_data.p(i) == 1
        % Put a white dot for ON events
        cd_img(cd_data.y(i), cd_data.x(i)) = 1;
    else
        % Put a black dot for OFF events
        cd_img(cd_data.y(i), cd_data.x(i)) = 0;
    end
    ts_img(cd_data.y(i), cd_data.x(i)) = cur_ts;
end