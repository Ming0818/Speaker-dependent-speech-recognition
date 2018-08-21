
% Speaker Recognition: Testing Stage
%
% Input:
%       testdir : string name of directory contains all test sound files
%       n       : number of test files in testdir
%       code    : codebooks of all trained speakers
%
% Note:
%       Sound files in testdir is supposed to be: 
%               s1.wav, s2.wav, ..., sn.wav
%
% Example:
%       >> test('C:\data\test\', 8, code);

% for k = 1:n                     % read test sound file of each speaker
  %file = sprintf('s4.wav');
 function test(testdir, n, code) 
 myVoice = audiorecorder(44100,16,2,1);%stereo form right and left ear
disp('Start speaking.');
recordblocking(myVoice, 3);
disp('End of recording. Playing back ...');

play(myVoice);
s=getaudiodata(myVoice);
audiowrite('userInput.wav',s,35100);
%%%%corerelation between the input wave
    [s, fs] = audioread(file);      
    s=PreProcess(s,fs);    
    v = mfcc(s, fs);            % Compute MFCC's
   
    distmin = inf;
    k1 = 0;
   
    for l = 1:length(code)      % each trained codebook, compute distortion
        d = disteu(v, code{l}); 
        dist = sum(min(d,[],2)) / size(d,1);
      
        if dist < distmin
            distmin = dist;
            k1 = l;
        end      
    end
    disp('hello');
     disp(distmin);
            disp(dist);
    if(distmin>3)
        msg=    sprintf('Speaker doesnt match');
           disp(msg);
        else 
   
    msg = sprintf('Speaker matches with speaker %d', k1);
    disp(msg);
    end
