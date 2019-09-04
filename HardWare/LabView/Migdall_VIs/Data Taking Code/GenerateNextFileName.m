function nfn = GenerateNextFileName (fn)
a = dir ([fn '*']);
ext = strfind (fn,'\');
if (isempty(ext)==0)
    xfn=fn(ext(end)+1:end);
else
    xfn=fn;
end
if (isempty(a)==0)
    nmax=0;
    for i=1:length(a)
       ext = strfind (a(i).name,'.');
       if (isempty(ext)==0)
           strpart = a(i).name(length(xfn)+1:ext(end)-1);
       else
           strpart = a(i).name(length(xfn)+1:end);
       end
       if (str2num(strpart)>nmax)
           nmax = str2num(strpart);
       end
    end
    nfn = [fn num2str(nmax+1)];
else
    nfn = [fn '1'];
end
end