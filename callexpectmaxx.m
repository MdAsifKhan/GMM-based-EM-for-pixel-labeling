clc
clear all
close all
tic
%To perform this operation on an image use following lines 
im_1=imread('tire.tif');
imc_1=double(im_1);
[U,V]=size(imc_1);
data=reshape(imc_1',[1 U*V]);   
k=2;		%Number of classes
[meu,sigma,wt1]=expectmaxx_opt(data,k);
y=zeros(length(data),k);
%To calculate probabilities for data with respect to all classes using optimized value of meu sigma and weight
      y1=gauss_dist_opt(data,meu,sigma);
      prob_new=reshape(max(y1)',[V U])';
%Labeling the elements of data into classes on the basis of maximum probabilty
    label=zeros(U,V);
    label=prob_new-reshape(y1(1,:)',[V U])';
    label(label~=0)=2;
    label(label==0)=1;      
     save('label_im','label');
     save('newprob_im','new_prob');
    figure,imshow(im_1);
    figure,imagesc(label);
toc 