% Particle Swarm Optimization
clear all
clc
    
popsize = 30;       % No. of particles
npar = 2;           % Dimension of th eproblem
c =  0.05;          % constriction factor
c2 = 2;             % Cognitinve Coefficint
c3 = 2;             % Social Coefficient
maxit = 250;        % No. of iteratiom


% Initializing Population and velocity
par = -100 + 200*rand(popsize,npar);     % initial population
v(popsize,npar) = 0;                % initial velocity


for j=1:maxit

    c1 = (maxit - j)/maxit;
    
    
% Cost calculation but wrinting it as coast as cost is name of cost script
    for i= 1:popsize
        coast(i,1)=cost(par(i,1),par(i,2));
    end
    minc(j) = min(coast);

    % Local minimum calculation
    

    
         if j>1
         for i=1:popsize
            if coast(i)< cost(par(i,1),par(i,2))
                localpar(i,:) = par(i,:);
            else
                localpar(i,:) = parp(i,:);
            end
          end
     else
         localpar=par;
     end
%     Global minimum calculation
    for i=1:popsize
        if i==1
            for i=1:popsize
                icost(i)=cost(localpar(i,1),localpar(i,2));
            end
                [icost index]=sort(icost);
                globalpar=localpar(index,:);
                globalpar=globalpar(1,:);
                gcost=icost(1);
        else
            if cost(localpar(i,1),localpar(i,2))<gcost
             globalpar =  localpar(i,:);
            else
                globalpar = globalpar;
            end
        end
    end

 % Calculation of velocities of particles

    v = c*(c1*v + c2*rand(popsize,npar).*(localpar-par)+c3*rand(popsize,npar).*(repmat(globalpar,popsize,1)-par));


% calculation of new particles

    fpar = par + v;
    parp=par ;        %particles in previous iteration
    par=fpar;         %particles for next iteration    
end
globalpar
min(coast)
plot(minc)