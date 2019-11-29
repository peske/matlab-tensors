function [ isTsr, tSize ] = isTensor4( tsr )
%ISTENSOR4 It is a special case of 'isTensor' function, with 'order' argument set to 4.
%   Detailed explanation goes here

    if nargout > 1
        [isTsr, tSize] = isTensor(tsr, 4);
    else
        isTsr = isTensor(tsr, 4);
    end

end
