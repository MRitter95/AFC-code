function [ maxposition, maxvalue ] = maxpoly( p )
%maxpoly finds the x value of the maximum of a polynomial of order 2 or 3
%   Detailed explanation goes here
sizep = size(p);
order = sizep(2)-1;
if order == 2
    maxposition = -p(2)/(2*p(1));
    maxvalue = p(1)*maxposition^2 + p(2)*maxposition +p(3);
elseif order == 3  % This is the only one used so the others are not complete
    a = 3*p(1);
    b = 2*p(2);
    c = p(3);
    if (b^2 - 4*a*c) >0 % Checks to see if radical is positive
        %negative sqrt root is chosen
        maxposition = (-b-sqrt(b^2 - 4*a*c))/ (2*a);
        signsecondderiv = sign(2*a*maxposition + b); % must be positive to be max
        if signsecondderiv == 1
            maxposition = (-b+sqrt(b^2 - 4*a*c))/ (2*a); % positive try other soln
            disp('help maxpoly initially found min instead of max so it chose the other root');
        end
        maxvalue = p(1)*maxposition^3 + p(2)*maxposition^2 +p(3)*maxposition + p(4);
        
    else
        maxposition = NaN;
        maxvalue = NaN;
        disp('help maxpoly found imaginary value');
    end
    
    
else
    maxposition = NaN;
    maxvalue = NaN;
    
end

end