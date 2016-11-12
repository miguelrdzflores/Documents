function diffusion(tfinal)

%% Discretization of time and space (s < 0.5 for stability)

% Spatial grid
J = 41;
L = pi;
X = linspace(0,L,J);

% Stability
s = 0.45;
hx = X(2)-X(1);   ht = s*hx^2;

% Time grid
T = 0:1000; N = length(T);

% Initialize solution
u = zeros(N,J);

%% Explicit scheme for u_t = u_xx

% Initial condition
u0 = [X(1:floor(J/2)), L - X(floor(J/2)+1:J)];  % triangular initial condition
u(1,:) = u0;

% Propagation

for n=1:N-1
    for j=2:J-1
        u(n+1,j) = s*(u(n,j+1) + u(n,j-1)) + (1-2*s)*u(n,j);
    end
    % Visualize solution
    drawnow; plot(X,u(n+1,:)); xlim([0 L]); ylim([0 L/2]);
end


