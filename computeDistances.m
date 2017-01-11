function D=computeDistances(W,pts)
nb_iter_max =  1.2*max(size(W))^3;
[D,S,Q,stPoints] = perform_front_propagation_2d_color(W,pts-1,[],nb_iter_max, [], []);
Q = Q+1;
stPoints=stPoints+1;

end