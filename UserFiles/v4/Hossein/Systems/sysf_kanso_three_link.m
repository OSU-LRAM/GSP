function output = sysf_kanso_three_link(input_mode)

	% Default arguments
	if ~exist('input_mode','var')
		
		input_mode = 'name';
		
	end
	
	%%%%%%%
	
	switch input_mode

		case 'name'

			output = 'High Re 3-link with coupling'; % Display name

		case 'dependency'

			output.dependency = {'HighRE_toolbox/high_re_three_link_connection_kanso.m'};

		case 'initialize'

			%%%%%

			%Functional representation of local connection
			s.A_num = @Conn_num;

			%%%
			%Processing details

			%Mark that system has a singularity that needs to be accounted for
			s.singularity = 0;

			%Range over which to evaluate connection
			s.grid_range = [-1,1,-1,1]*2.5;

			%densities for various operations
			s.density.vector = [11 11]; %density to display vector field
			s.density.scalar = [21 21]; %density to display scalar functions
			s.density.eval = [21 21];   %density for function evaluations
			s.finite_element_density = 31;
			% power metric
			s.metric = @(x,y) eye(2);
			%%%
			%Display parameters

			%shape space tic locations
			s.tic_locs.x = [-1 0 1]*1.5;
			s.tic_locs.y = [-1 0 1]*1.5;
			


			%%%%
			%Save the system properties
			output = s;

	end

end

function A_num = Conn_num(a1,a2)

	%Apply the inverse multiplication
	wb = waitbar2a(0,['Building ' num2str(size(a1)) ' connection matrix']);
	Ar_cell = cell(size(a1));
	for i = 1:numel(a1);
		Ar_cell{i} = A_num_helper(a1(i),a2(i));
		waitbar2a(i/numel(a1));
	end
	
	close(wb)
	
	%Ar_cell = arrayfun(@(a1,a2) A_num_helper(a1,a2),a1,a2,'UniformOutput',false);

	%Pull Ar values into a matrix
	Ar_woven = cell2mat(Ar_cell);

	%Rearrange the A matrix
	A_num = [ Ar_woven(1:3:end,1:2:end) Ar_woven(1:3:end,2:2:end);
		  Ar_woven(2:3:end,1:2:end) Ar_woven(2:3:end,2:2:end);
		   Ar_woven(3:3:end,1:2:end) Ar_woven(3:3:end,2:2:end)];

end


function A = A_num_helper(a1,a2)


    addpath(genpath('/Users/rlhatton/Documents/MATLAB/HighRE_toolbox/'))
    A = high_re_three_link_connection_kanso(a1,a2);


                
end