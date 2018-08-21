
% Speaker Recognition: Training Stage
%
% Input:
%       traindir : string name of directory contains all train sound files
%       n        : number of train files in traindir
%
% Output:
%       code     : trained VQ codebooks, code{i} for i-th speaker
%
% Note:
%       Sound files in traindir is supposed to be: 
%                       s1.wav, s2.wav, ..., sn.wav
% Example:
%       >> code = train('C:\data\train\', 8);
function code = train(traindir, n)
k = 16;                         % number of centroids required

for i = 1:n                     % train a VQ codebook for each speaker
    file = sprintf('s%d.wav',i);           
    disp(file);
   
    [x, fs] = audioread(file);
    
    len=length(x);
for i=1:2
for j=2:len-1
x(j,i) = (x(j-1,i) + x(j,i) + x(j+1,i))/3 ;
end
end
% Creating Gaussian window of size 20
g = gausswin(20);
% Apply convolution using Gaussian filter
g = g/sum(g);
y= conv(x(:,1), g, 'same');
% Apply signal smoothing using Savitzky-Golay smoothing filter.
result=sgolayfilt(y,1,17);
% resultant signal can be write to the new file
audiowrite('result.wav',result,fs);
% plot the resultant and original signal
plot(x);title('original');
figure; plot(result); title('resultant signal');
v = mfcc(x, fs);            % Compute MFCC's
code{i} = vqlbg(v, k);      % Train VQ codebook
end