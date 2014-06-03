%Matlab and Octave have incompatible testing frameworks

%Lets make the problem worse by creating one of our own,
%implemented in pure matlab/octave

%This function runs unit tests located in the "tests" folder
%It can be called with arguments specifying the unit tests to
%run, otherwise it will just run all the tests it finds in the
%tests folder

function results = cross_test(varargin)
	addpath('./tests');
	
	%get list of tests to run
	if nargin > 0
		%user specified tests
		t = varargin{1};
		if ischar(t)
			tests(1).name = t;
			tests(1).args = {};
		else
			tests = t;
		end;
	else
		test_m_files = dir('./tests/test*.m');
		%TODO: subdirectories
		test_i = 1;
		for ii = 1:length(test_m_files)
			m_file = test_m_files(ii);
			len = length(m_file.name);
			%remove .m from filename
			tests(test_i).name = substr(m_file.name,1,len-2);
			tests(test_i).args = {};
			test_i = test_i+1;
		end;
	end;
	
	%run tests and report results
	verbose = 1;
	result_i = 1;
	for test = tests
		fprintf('Beginning test %s\n\n', test.name);
		tic();
		test_fn = str2func(test.name);
		battery_results = test_fn(test.args);
		time = toc();
		%display summary of test results from this battery
		fprintf('%d passed, %d failed\n\n', ...
			length(battery_results.passed), ...
			length(battery_results.failed));
		
		%Display detailed error messages
		if (verbose)
			for msg = battery_results.messages
				fprintf('%s: %s\n', msg.name, msg.text);
			end;
		end;
		
		results(result_i) = battery_results;
		result_i = result_i+1;
		fprintf('Test complete. Elapsed time: %f\n\n', time);
	end;
end
