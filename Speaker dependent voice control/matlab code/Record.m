function m=Record()

myVoice = audiorecorder(44100,16,2,1);%stereo form right and left ear
fs=44100;
disp('Start speaking.');
recordblocking(myVoice, 3);
disp('End of recording. Playing back ...');

%play(myVoice);
s=getaudiodata(myVoice);
audiowrite('userInput.wav',s,35100);
gong = audioplayer(s,44100);
play(gong);
m=s;