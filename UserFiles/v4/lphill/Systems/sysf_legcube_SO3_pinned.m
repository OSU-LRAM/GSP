function output = sysf_legcube_SO3_pinned(input_mode)
%Return the system properties for a diffdrive car

	% Default arguments
	if ~exist('input_mode','var')
		
		input_mode = 'name';
		
	end
		
	%%%%%%%
	
	switch input_mode

		case 'name'

			output = 'LegCube Pinned SO3'; % Display name

		case 'dependency'

			output.dependency = {'Systems/LegCube_SO3_loc_conn.m'}; 
			% For system files depending on other files in the Systems
			% directory, list those filenames here for the dependency
			% checker

		case 'initialize'

			%%%
			% Local connection (functions at end of file)
			% Denominator is optional unless the local connection has a
			% singularity. Here, it is defined as all 1s, for illustrative
			% purposes
			s.A_num = @Conn_num;
			%s.A_den = @Conn_den; 


			%%%
			%Processing details

			%Mark that system has no singularities. This is optional, with
			%a default value of zero assumed by the code.
			s.singularity = 0;

			%Range over which to evaluate connection
			s.grid_range = [-1,1,-1,1]*2.5;

			%densities for various operations
			s.density.vector = [10 10]; %density to display vector field
			s.density.scalar = [31 31]; %density to display scalar functions
			s.density.eval = [21 21];   %density for function evaluations



			%%%
			%Display parameters

			%shape space tic locations
			s.tic_locs.x = [-2 0 2 4 ];
			s.tic_locs.y = [-2 0 2 4];


			%Don't optimize the reference point (turn this off for
			%non-carlike systems)
			s.xy_no_opt = 1;

			%%%%
			%Output the system properties
			output = s;
		
	end
    
end

function Ar = Conn_num(a1,a2)
% Numerator of the local connection (remember, in this case, the
% denominator is trivial). 
%
% Note that the function returns a single large array of values for the
% local connection:
% 
% if a1 and a2 are each NxM matrices of joint angles, A is a 3x2 collection
% of NxM matrices, each corresponding to the i,jth component of A


%Apply the inverse multiplication
    wb = waitbar2a(0,['Building ' num2str(size(a1)) ' connection matrix']);   
    Ar_cell = cell(size(a1));
    for i = 1:numel(a1);
		Ar_cell{i} = LegCube_SO3_loc_conn(zeros(3,1), [a1(i);a2(i)]);
		waitbar2a(i/numel(a1));
    end
    
    close(wb)
	
	%Ar_cell = arrayfun(@(a1,a2) A_num_helper(a1,a2),a1,a2,'UniformOutput',false);

	%Pull Ar values into a matrix
	Ar_woven = cell2mat(Ar_cell);

	%Rearrange the A matrix
	Ar = [ Ar_woven(1:3:end,1:2:end) Ar_woven(1:3:end,2:2:end);
		  Ar_woven(2:3:end,1:2:end) Ar_woven(2:3:end,2:2:end);
		   Ar_woven(3:3:end,1:2:end) Ar_woven(3:3:end,2:2:end)];
	
end