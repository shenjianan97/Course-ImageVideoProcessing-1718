function [ OUT ] = BUPT_log( IN, sigma, kernel )
%6 Implement the LoG operator as a parametric function of the variance
%   Input:
%       IN: input matrix
%       sigma: variance of Gaussian filter
%       kernel: kernel size
%   Output:
%       OUT: output matrix

strTitle = strcat('sigma=', num2str(sigma));

if nargin == 2
    kernel = 10*sigma; % empirically
else
	strTitle = strcat(strTitle, ',  kernel=', num2str(kernel));
end



% lapT=[-1 -1 -1;
%     -1 8 -1;
%     -1 -1 -1];
% p2=[kernel, kernel];
% siz = (p2-1)/2;
% std2 = sigma^2;
% [x, y] = meshgrid(-siz(2):siz(2),-siz(1):siz(1));
% arg   = -(x.*x + y.*y)/(2*std2);
% T     = exp(arg);
% T(T<eps*max(T(:))) = 0;
% sumh = sum(T(:));
% if sumh ~= 0,
%     T  = T/sumh;
% 
% % display(T);
% OUT = imfilter(IN,T);
% OUT = imfilter(OUT,lapT);
% 
% OUT = round(OUT/255)*255;


[h, w] = size(IN);

k = [kernel, kernel];

% the Gaussian filter
range = (k-1)/2;
std = sqrt(sigma);
[x,y] = meshgrid(-range(2):range(2),-range(1):range(1));
filter = -1/(pi*(std^4))*(1-(x.*x+y.*y)/(2*std^2)).*exp(-(x.*x+y.*y)/(2*std^2));

% go though the filter
IN_new = filter2(filter,IN);

% figure, imshow(uint8(IN_new)); title('IN_new');

% judge
OUT = zeros(h,w);
T = 0.75*mean2(abs(IN_new(2:h-1,2:w-1)));
for i=2:h-1
    for j=2:w-1
        if IN_new(i,j)<0
            if IN_new(i+1,j)>0||IN_new(i,j+1)>0||IN_new(i,j-1)>0||IN_new(i-1,j)>0
                if max([IN_new(i+1,j) IN_new(i,j+1) IN_new(i,j-1) IN_new(i-1,j)])-IN_new(i,j)>T
                    OUT(i,j)=1;
                end
            end
        else if IN_new(i,j)==0
                if (IN_new(i+1,j)*IN_new(i-1,j)<0&&abs(IN_new(i+1,j)-IN_new(i-1,j))>2*T)||(IN_new(i,j+1)*IN_new(i,j-1)<0&&abs(IN_new(i,j+1)-IN_new(i,j-1))>2*T)
                    OUT(i,j)=1;
                end
            end
        end
    end
end

OUT = OUT*255;  % thresholding

figure, imshow(uint8(OUT)); title(strTitle);

end

