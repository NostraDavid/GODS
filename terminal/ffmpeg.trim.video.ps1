# -to time_stop
# Time in HH:mm:ss
# -i input
# -c codec
# Because of copy, creating the new file won't take that long.
.\ffmpeg.exe -to 05:36:48 -i '.\input.mkv' -c copy output.mkv