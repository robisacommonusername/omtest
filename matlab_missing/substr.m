function s = substr(ss,a,b)
    if a<0
        a=length(ss)+a;
    end;
    if b<0
        b=length(ss)+b;
    end;
    s = ss(a:b);
end