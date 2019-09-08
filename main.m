%%%%%%%%%%%%%%%%%%%%%%%%%%%Melanoma Tracking Tool%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$September 6 2019%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

%%%Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_images = 4;
threshold = 80;

%%%Body%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
area_vector = zeros(1,num_images);

for img_num = 1:num_images
    
    image_name = strcat('img',num2str(img_num),'.jpg');
    [img, map] = imread(image_name);
    img_height = size(img, 1);
    img_width = size(img, 2);

    img_grayscale = rgb2gray(img);

    count = 0;
    for i = 1:img_height
        for j = 1:img_width
            if img_grayscale(i, j) < threshold
                count = count + 1;
            end
        end
    end
    
    [centers,radii] = imfindcircles(img_grayscale,[20 60],'Sensitivity',0.94);
    imshow(img_grayscale, map);
    h = viscircles(centers,radii);
    
    avg_radii = mean(radii);
    count_final = count/avg_radii;
    area_vector(img_num) = count_final;
    
end

disp(area_vector);

%%%Display%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
graph = bar(area_vector, 0.5, 'b');
title('Track of Melanoma Growth Over Time');
xlabel('Day') 
ylabel('Relative Area')




