function [ isTsr, tSize ] = isTensor3( tsr )
%ISTENSOR3 It is a special case of 'isTensor' function, with 'order' argument set to 3.
%   Detailed explanation goes here

    if nargout > 1
        [isTsr, tSize] = isTensor(tsr, 3);
    else
        isTsr = isTensor(tsr, 3);
    end

end
