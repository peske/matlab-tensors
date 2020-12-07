function result = wholeNumbers( x )
%WHOLENUMBERS Returns `true` if all of the elements of `x` are whole numbers.
%
%   The difference comparing to 
%   <a href="matlab:web('https://www.mathworks.com/help/matlab/ref/isinteger.html')">isinteger</a> 
%   function is that the later takes into account the data type, and will 
%   return `false` if the input is a floating point number, even if it is 
%   a whole number. In other words, `isinteger(5)` will return `false` 
%   (because `5` is a floating point number), while `wholeNumbers(5)` will 
%   return `true`.
%
% Input arguments:
%
%  x - Value to check.
%
% Output arguments:
%
%  result - Boolean tensor of the same size as `x`, with `true` elements at 
%           the position of whole-number elements in `x`, `false` in other 
%           positions.
%

    result = and(isfinite(x), x == floor(x));

end

