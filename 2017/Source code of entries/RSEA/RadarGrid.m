function [Site,RLoc] = RadarGrid(P,div)
% Calcualte the index of radar grid of each solution

% Copyright 2015-2017 Cheng He
     [N,M]  = size(P);
    %% Calculate the radar coordinate of each solution
    theta     = 0 : 2*pi/M : 2*pi/M*(M-1);
    RLoc(:,1) = sum(P.*repmat(cos(theta),N,1),2)./sum(P,2);
    RLoc(:,2) = sum(P.*repmat(sin(theta),N,1),2)./sum(P,2);
    RLoc      = (RLoc+1)/2;
    YL        = min(RLoc,[],1);                                             %Lower bounary of the transferred points
    YU        = max(RLoc,[],1);                                             %Upper bounary of the transferred points  
    if any(YU==YL)
        NRLoc = RLoc;
    else
        NRLoc     = (RLoc-repmat(YL,N,1))./repmat(YU-YL,N,1);                   %Normalized points
    end
    %% Identify the index of grid of each solution
    GLoc            = floor(NRLoc.*div);
    GLoc(GLoc>=div) = div - 1;
    UniqueGLoc      = sortrows(unique(GLoc,'rows'));
    [~,Site]        = ismember(GLoc,UniqueGLoc,'rows');
end