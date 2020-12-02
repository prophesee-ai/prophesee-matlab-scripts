# MATLAB scripts

In this repo you will find some basic scripts to show how to work with data from Prophesee sensors in [MATLAB](https://www.mathworks.com/products/matlab.html).
These scripts require a [DAT file](https://docs.prophesee.ai/data_formats/file_formats/dat.html) as an input with data recorded with [one of our camera](https://docs.prophesee.ai/hw/index.html). 

If you only have a RAW file, you need to convert it to DAT format first. To this end, use our application [metavision_raw_to_dat](https://docs.prophesee.ai/metavision_sdk/modules/driver/guides/raw_to_dat.html)
which is part of [Metavision Intelligence Suite](https://www.prophesee.ai/metavision-intelligence/).

To try out those scripts, you can also download and use one of the [RAW and DAT file we provide](https://docs.prophesee.ai/datasets.html).

## Main features

The provided MATLAB scripts allow to:
  * `load_atis_data.m`: upload CD events to MATLAB
  * `load_atis_aps.m`: upload EM events to MATLAB (deprecated for the current sensor generation)
  * `load_ext_trigger_data.m`: upload data from external triggers to MATLAB
  * `play_cd_recording.m`: generate a video from CD events
  * `atis_snapshot.m`: generate gray-scale images from EM events (deprecated for the current sensor generation)

Note that by default the provided scripts will attempt to upload the entire DAT files into memory. 
Therefore, it will be useful to split your DAT file into several smaller files at first, or modify the Matlab scripts to limit the memory requirements.


## Uploading CD data to MATLAB

  * `load_atis_data.m` script provides an example of uploading CD events to MATLAB.
  * `load_atis_data` function requires the following input arguments:
    * path to DAT file with recorded CD events
    * flipX flag - for flipping data over the X axis (0 by default)
    * flipY flag - for flipping data over the Y axis (0 by default)

The script returns a data structure containing the following fields for every CD event:

  * x - x-position of the event in the sensor matrix
  * y - y-position of the event in the sensor matrix
  * ts - timestamp of the event
  * p - polarity of the event

Example of running the script:
```
cd_data = load_atis_data("/path/to/my_record.dat")
```

## Generating a video and frames from CD events

  * `play_cd_recording.m` script provides an example of generating a video from CD events and replaying this video.
  * `play_cd_recording` function requires the following input arguments:
    * path to a DAT file with recorded CD events
    * the width of the sensor
    * the height of the sensor
    * the outcome frame rate
    * the accumulation time (in microseconds) - duration during which each event will be shown

As an outcome, the script returns a structure, such as a sequence of frames generated by iteratively accumulating
the information from the CD events. Each frame shows the CD events generated by the sensor over the given 
accumulation time duration preceding the timestamp associated with the frame. For instance, if the given frame rate 
is 1000 FPS (frames per seconds) and the accumulation time is 10000 µs (microseconds), each CD event will be displayed
during 10 frames.

For example, for a Gen3 sensor, the following command will generate a 25 FPS video with the accumulation time of 10000 µs:
```
play_td_recording('/path/to/my_record.dat',640,480,25,10000)
```

## Contact
This code is open to contributions, thus do not hesitate to propose pull requests or create/fix bug reports.
In case of any issue, please add it here on GitHub. 

For any other information, [contact us](https://www.prophesee.ai/contact-us/) 

