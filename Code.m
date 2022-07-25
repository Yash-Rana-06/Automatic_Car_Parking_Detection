% Matlab Code
% Implementation Of Automatic Car Parking Indicator System
% Made By - 

%   19BCE220 : Yash Rana  : Nirma University

% Working Flow:
% Colored Image -> Grayscale image -> Extract features -> Binary image ->
%  Detection -> Blob Analysis -> Empty slots 

%----------------------------------------------------------------

%Note: After executing once, just cancel out the figure2 followed by
%      figure 1 then, wait for sometime, automatically detect for other
%       images also.
clc;
clear all;
close all;

% demonstrate with different images 
cars=["p2.jpg" , "p3.jpg" , "p4.jpg" , "p5.jpg" , "p10.jpg"];

for i=cars
    
    c=char(i);
    c=c(2);
    if(c=='1')
        text='Original-Image having 10 cars.';
    else
        text="Original-Image having "+c+" cars.";
    end
     
    % Reding the Image with car parks
    img=imread(i);
    
    % Reduce the atmosphere haze of the color-image...
    %return the dehazed image
    img=imreducehaze(img);
    
    %set the background image
    bkgImg=imread('empty.jpg');
    
    %Transforming the image from rgb into gray scale
    %For the detection and to extract the features, converting 3 channels(RGB) into 1 channel-gray scale
    image_cars=(rgb2gray(img));
    
    %Taking the height and the width of the Image(Consists of cars parking)
    [ height , width ]= size(image_cars);
    
    %Resize the Background Image(making the similar width/height)
    bkgImg=imresize(bkgImg,[height,width]);
    
    %Converting bckImg to gray scale 
    % RGB to 1 channel - Intensity
    bg=(rgb2gray(bkgImg));
    
    tiledlayout(2,2);
    % show the images
    figure(1);
    
    subplot(2,2,1);
    imshow(img);
    ylabel('RGB');
    set(get(gca,'YLabel'),'Rotation',0)
    title(text)
    
    
    subplot(2,2,2);
    imshow(image_cars);
    title('Grascale-Image')
    
    subplot(2,2,3);
    imshow(bg);
    title('Background-Image')
    
    subplot(2,2,4);
    imhist(image_cars);
    title('Histogram')
    %here input as an grascale-image -> so the range:0-255
    %At each point of intensity-> depicts the pixel value ranges 
    
    %-----------------------------------------------------
    
    % 2 parallel lan Having 5 slots each 
    % So, total 10 parking slots in our project to demonstrate 
    
    TotalCarSlots=10;
    
    %Now, Segementation part to make distinction between Cars-Image and
    %background Image
    
    %Whenever it finds the car it will make edges and detect the cars
    t=bg-image_cars;
    image_cars=t;
    
    
    figure(2);
    %image=imnoise(double(image),"salt & pepper");
    
    %Want binary image for the blob analysis-detection and do analysis 
    % after trail and Error : 50 is the thresold valueS
    image_cars=image_cars>50; 
    % coverting into binary image
    %  0 : Black,  1 : white 
    
    
    subplot(1,2,1);
    imshow(image_cars);
    title('Binary Image(car detection)');
    impixelinfo;
    
    % bwareaopen will remove connected componets that have pixels less
    %than 500 value-remove small objects from the bw image-make it more clearer
    bw3 = bwareaopen(image_cars,500);
    
    
    labeled_Image = bwlabel(bw3,8);
    
    %measures a set of properties for each labeled region in label image
    %labeled
    blobMeasurements = regionprops(labeled_Image,'all');
    
    %Finding out the empty slots from the above analysis
    NumberOfCars = size(blobMeasurements, 1);
    EmptyCars=sprintf('Total Empty Slots = %d',TotalCarSlots-NumberOfCars);
    subplot(1,2,2) , imagesc(labeled_Image), title (EmptyCars);
    hold off;
    waitfor(figure(1));

end

   %        Thank You           %
   %           END              %



