function [ out_vector ] = normalize( in_vector )
%NORMALIZE Summary of this function goes here
%   Detailed explanation goes here

vector_min = min(in_vector);
vector_max = max(in_vector);
out_vector  = ( double(in_vector) - vector_min ) / (vector_max  - vector_min +1e-5);
end

