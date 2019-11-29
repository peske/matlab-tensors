function [wholeNumber] = isWholeNumber(number)
%ISWHOLENUMBER Returns true if the input argument is a whole number.
%   Checks if 'number' is a whole number. The difference comparing to <a 
%   href="matlab:web('https://www.mathworks.com/help/matlab/ref/isinteger.html')">isinteger</a> function is that the 
%   later takes into account the data type, and will return false if the input is a floating point number, even if it is 
%   a whole number. In other words, isinteger(5) will return false (because 5 is a floating point number), while 
%   isWholeNumber(5) will return true.

    wholeNumber = isfinite(number) & number == floor(number);

end
