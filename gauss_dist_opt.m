function [ y ] = gauss_dist_opt(x,meu,sigma)
%GAUSS_DIST function for gaussian distribution
expterm=exp(-(bsxfun(@rdivide,(bsxfun(@minus,x,meu).^2),(2.*sigma))));
y=bsxfun(@times,(1./(sqrt(2*pi.*sigma))),expterm);
end