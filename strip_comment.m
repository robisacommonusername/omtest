function stripped = strip_comment(line)
	in_string = false;
	escaped = false;
	N = length(line);
	
	stripped = line;
	
	for ii = 1:N
		if line(ii) == '\\' && ~escaped
			escaped = true;
		else
			escaped = false;
		end
		
		if (line(ii) == '"' || line(ii) == '''') && ~escaped
			in_string = ~in_string;
		end
		
		if line(ii) == '%' && ~escaped && ~in_string
			stripped = substr(line, 1, ii-1);
			break;
		end
	end
end
