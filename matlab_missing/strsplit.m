function arr = strsplit(s,delim,varargin)
    %todo - escape special characters in delim
    %pipe together c
    arr = regexp(s,delim,'split');
end