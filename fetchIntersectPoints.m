function [x, y] = fetchIntersectPoints(boundary, varargin)
    % FETCHINTERSECTPOINTS(varargin)
    %
    % Fetches the intersect points of a bacterial swimmer from a random starting point within the boundary.
    %
    % INPUTS:
    %   - boundary          Must be of the form (2, N)
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                   PARSE INPUTS                        %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    p = inputParser;

    % Add boundary
    boundaryVerification = @(x) validateattributes(x, 'double', {'size', [2, NaN]});
    p.addRequired('boundary', boundaryVerification);
    

    % Verify initial point
    initPointVerification = @(x) validateattributes(x, 'double', {'size', [2 1]});
    initPointDefault = [0, 0];
    p.addOptional('initialPoint', initPointDefault, initPointVerification);

    % Verify initial trajectory
    initTrajectoryVerification = @(x) validateattributes(x, 'double', {'size', [2, 1]});
    initTrajectoryDefault = [1, 0];
    p.addOptional('initialTrajectory', initTrajectoryDefault, initTrajectoryVerification);

    % TO DO: Make sure trjacetory is unit vector

    % Parse inputs
    parse(p, boundary, varargin{:});




    %  ---------------------------------------------------- %
    %   Fetch inputs
    %  ---------------------------------------------------- %
   
    boundary        = p.Results.boundary;
    initPoint       = p.Results.initialPoint;
    initTrajectory  = p.Results.initialTrajectory;

    numberOfBounces = 20;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                   MAIN METHOD                         %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % We want to find the intersect points of everything...

    % ASSUME: Boundary forms a closed curve.
    [~, R] = cart2pol(boundary(1, :), boundary(2, :));
    maxR = max(R);

    % Update the current points/trajectory with initial values
    X = initPoint;
    P = initTrajectory;

    % Initialise number of bounces and points 
    currentBounces      = 0;

    x = initPoint(1);
    y = initPoint(2);

    mag = @(k) sqrt(dot(k, k));
    dotAngle = @(a, b) acos(dot(a, b)/norm(a)/norm(b));

    while currentBounces < numberOfBounces

        %  ---------------------------------------------------- %
        %   Find the intersection point
        %  ---------------------------------------------------- %
        
        % Setting the next point and setting the intersection line
        nextPoint       = X + 2*maxR*P;
        intersectLine   = [linspace(X(1), nextPoint(1)); linspace(X(2), nextPoint(2))];

        % Find the intersection between the boundary and the intersection line
        I = InterX(boundary, intersectLine(:, 2:end));
        
        if length(I(:)) > 2
            % Locate the nearest intersect point away from the current point
            np = 1;
            M = norm(X - I(:, np));
            for i = 1:length(I(1, :))
                bx = I(1, i);
                by = I(2, i);
    
                if norm([bx; by] - X) < M
                    M = norm(X - I(:, i));
                    np = i;
                end
            end
            I = I(:, np);
            
        end

        % Locate the closest boundary point
        np = 1;
        M = norm(I - boundary(:, np));
        for i = 1:length(boundary(1, :))
            bx = boundary(1, i);
            by = boundary(2, i);

            if norm([bx; by] - I) < M
                M = norm([bx; by]- I);
                np = i;
            end
        end

        Bx = boundary(1, np);
        By = boundary(2, np);

        % Update the current point to the intersect point
        X = [Bx; By];

        % Add the intersection points to the list of bacteria bounces
        x = [x, Bx];
        y = [y, By];

        %  ---------------------------------------------------- %
        %   Find next trajectory
        %  ---------------------------------------------------- %

        % Find the gradient of the boundary
        dx = gradient(boundary(1, :));
        dy = gradient(boundary(2, :));
        

        % SPECIAL CASE: Deal with constant-y or constant-x boundaries
        if dx(np) == 0 && dy(np) ~= 0
            T = [0; 1];
            N = [1; 0];
        elseif dy(np) == 0 && dx(np) ~= 0
            N = [0; 1];
            T = [1; 0];
        elseif dy(np) == 0 && dx(np) == 0
            error('Undefined boundary gradient')
        else
            % Fetch m
            m = dy(np)/dx(np);

            % Set up tangent vector
            tx = 1;
            T = [tx; m*tx];
            T = T/norm(T);
    
            % Set up the normal vector
            N = [tx; -1/m*tx];
            N = N/norm(N);
        end

        % We now want the acute angle between the normal and the current trajectory
        xi = dotAngle(P, N);
        
        % Here, A is the acute angle, N is the normal, and s*N will always give us the outward pointing normal.
        if xi > pi/2
            A = pi - xi;
            s = -1;
        else
            A = xi;
            s = 1;
        end

        % Now we can set the angle of incidence
        theta_r = pi/2 - A;

        % And the reflection angle
        if theta_r > deg2rad(45)
            theta_i = 0.9*theta_r;
        else
            theta_i = deg2rad(45);
        end

        
        % Next, we calculate the polar angle of the normal in our frame of reference
        phi_N = cart2pol(s*N(1), s*N(2));
        
        % And the polar angle of our trajectory
        phi_P = cart2pol(P(1), P(2));

        % Using these, we can work out if our approach angle is to the left or right of the normal and apply any rules
        % to the reflection angle. P is minus this as it's a reflection.
        if phi_N > phi_P
            P = -[cos(phi_N + pi/2 - theta_i); sin(phi_N + pi/2 - theta_i)];
        else
            P = -[cos(phi_N - (pi/2 - theta_i)); sin(phi_N - (pi/2 - theta_i))];
        end

        

        


        
        currentBounces = currentBounces + 1;
                                                        


        

    end

    

    



    
    


    










    





end