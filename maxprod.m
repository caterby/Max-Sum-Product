function X = maxprod(A,w,its)

    [n m] = size(A);
    [m k] = size(w);
    X = zeros(1,n);

    % phi function
    phi = @(x) exp(w(x));
    
    % psi function
    function psi_value = psi_function(x,y)
        psi_value = 1;
        if x == y
             psi_value = 0;
        end
    end

  % initialize message value to 1
    message = zeros(n,n,k);
    for i = 1:n
        for j = 1:n
            for h = 1:k
                message(i,j,h) = rand(1);
            end
        end
    end

    for it = 1:its
        old_message = message;
        for i = 1:n
            for j = 1:n
                if i == j
                    continue;
                end
                ita = 0;
                for x_j_color = 1:k
                    message(i,j,x_j_color) = 0;
                    max_message = 0;
                    for x_i_color = 1:k
                        current_message = 1;
                        current_message = current_message * phi(x_i_color) * psi_function(x_i_color,x_j_color);
                        for r = 1:n
                            if A(r,i) == 1
                                if r ~= j && r ~= i
                                    current_message = current_message * old_message(r,i,x_i_color); 
                                end
                            end
                        end
                        if max_message < current_message
                            max_message = current_message;
                        end
                    end
                    message(i,j,x_j_color) = max_message;

                    ita = ita + message(i,j,x_j_color);
                end

                message(i,j,:) = message(i,j,:)/ita;
            end
        end
    end
    % initialize node and edge beliefs
    node_belief = zeros(n,k);
    edge_belief = zeros(n,n,k,k);

    % compute node beliefs
    for i = 1:n
        normconst = 0;
        for i_color = 1:k 
            node_belief(i,i_color) = phi(i_color);
            for r = 1:n
                if r == i 
                    continue;
                end
                if A(r,i) == 1
                     node_belief(i,i_color) = node_belief(i,i_color) * message(r,i,i_color);
                end
            end
            normconst = normconst + node_belief(i,i_color); 
        end
        % normalize
        node_belief(i,:) = node_belief(i,:) / normconst;
    end

    %compute edge beliefs
    for i = 1:n
        for j = 1:i
            normconst = 0;
            for i_color = 1:k 
                for j_color = 1:k
                    edge_belief(i,j,i_color,j_color) = phi(i_color) * phi(j_color) * psi_function(i_color,j_color);
                    for r = 1:n
                        if r == i || r == j
                            continue;
                        end
                        if A(r,i) == 1
                             edge_belief(i,j,i_color,j_color) = edge_belief(i,j,i_color,j_color) * message(r,i,i_color);
                        end
                    end
                    for r = 1:n
                        if r == i || r == j
                            continue;
                        end
                        if A(r,j) == 1
                             edge_belief(i,j,i_color,j_color) = edge_belief(i,j,i_color,j_color) * message(r,j,j_color);
                        end
                    end
                    normconst = normconst + edge_belief(i,j,i_color,j_color); 
                end
            end

            % normalize
            edge_belief(i,j,:,:) = edge_belief(i,j,:,:) / normconst;

        end
    end
    
    for i = 1:n
        max_belief = 0;
        max_index = 0;
        no_of_max_value = 0;
        for i_color = 1:k
            if node_belief(i,i_color) > max_belief
                max_belief =  node_belief(i,i_color);
                max_index = i_color;
                no_of_max_value = 1;
            elseif node_belief(i,i_color) == max_belief
                no_of_max_value = no_of_max_value + 1;
            end
            
        end
        
        if no_of_max_value == 1
            X(i) = max_index;
        elseif no_of_max_value > 1               
            X(i) = 0;            
        end         
    end
    disp(X);
 
end
