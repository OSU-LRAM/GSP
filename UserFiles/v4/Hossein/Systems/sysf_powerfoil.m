function output = sysf_powerfoil(input_mode)
%Return the system properties for a diffdrive car

	% Default arguments
	if ~exist('input_mode','var')
		
		input_mode = 'name';
		
	end
		
	%%%%%%%
	
	switch input_mode

		case 'name'

			output = 'Simple power foil'; % Display name

		case 'dependency'

			output.dependency = {}; 
			% For system files depending on other files in the Systems
			% directory, list those filenames here for the dependency
			% checker

		case 'initialize'

			%Initialize a kinematic snake with unit values for L and R

			%%%
			% Local connection (functions at end of file)
			% Denominator is optional unless the local connection has a
			% singularity. Here, it is defined as all 1s, for illustrative
			% purposes
			s.A_num = @Conn_num;
			s.A_den = @Conn_den; 


			%%%
			%Processing details

			%Mark that system has no singularities. This is optional, with
			%a default value of zero assumed by the code.
			s.singularity = 0;

			%Range over which to evaluate connection
			s.grid_range = [-1,1,-1,1]*pi/2;

			%densities for various operations
			s.density.vector = [5 5]; %density to display vector field
			s.density.scalar = [31 31]; %density to display scalar functions
			s.density.eval = [101 101];   %density for function evaluations



			%%%
			%Display parameters

			%shape space tic locations
			s.tic_locs.x = [-1 0 1]*1;
			s.tic_locs.y = [-1 0 1];


			%Don't optimize the reference point (turn this off for
			%non-carlike systems)
			s.xy_no_opt = 1;

			%%%%
			%Output the system properties
			output = s;
		
	end
    
end

function A_num = Conn_num(a1,a2)
% Numerator of the local connection (remember, in this case, the
% denominator is trivial). 
%
% Note that the function returns a single large array of values for the
% local connection:
% 
% if a1 and a2 are each NxM matrices of joint angles, A is a 3x2 collection
% of NxM matrices, each corresponding to the i,jth component of A

	A_num = [zeros(size(a1)) -(sin(2*a1).*abs(sin(a1))) ;
		zeros(size(a1)) zeros(size(a1));
		zeros(size(a1)) zeros(size(a1))];
	
end

function A_den = Conn_den(a1,a2)

	A_den = repmat(ones(size(a1)),3,2);

end