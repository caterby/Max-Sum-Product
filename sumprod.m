function Z=sumprod(A,w,its)

size1=size(A);
size_w=size(w);
k=size_w(2);
N=size1(1);
M=N*N;

%Step 1 (start point): calculate the message matrix, which is squre(n)*k dimension
C=zeros(M,k);

function r1=phi(xi)
r1=exp(w(xi));
end

function r2=psi2(xi,xj)
if (xi==xj)
    r2=0;
else
    r2=1;
end
end

for i=1:N
    for j=1:N
        index0=(i-1)*N+j;
        
        if (A(i,j)==1) 
            
            C(index0,:)=1;
        end
    end
end

flag_v=zeros(M,1);

for i=1:M
    if (C(i,1)==1)
        flag_v(i,1)=1;
    end
end

for iteration=1:its
for i=1:N
    for j=1:N
        index1=(i-1)*N+j;
        
        if (flag_v(index1,1)~=0)
            index1_sum=0;
              
            for l=1:k
                temp_message1=0;
                for m=1:k
                    phi_value=phi(m);
                    psi_value=psi2(m,l);
                    temp_message2=phi_value*psi_value;
                    for q=1:N
                        temp1=(q-1)*N+i;
                        temp2=C(temp1,m);
                        if ((temp2~=0) && (q~=j))
                            temp_message2=temp_message2*temp2;
                        end
                    end
                 temp_message1=temp_message1+temp_message2;
                end
            
                C(index1,l)=temp_message1;
                index1_sum=index1_sum+C(index1,l);
            end
        
            for l=1:k
                
                C(index1,l)=C(index1,l)/index1_sum;
                
            end
        
        end
    end
end

end

display(C); % end of Step 1: calculating the message matrix;


%Step 2: start point: calculating the singleton and pairwise matrices;
B=zeros(N,k);

for i=1:N
    message_total1_sum=0;
    for j=1:k
        message_total1=phi(j);
        for l=1:N
            index11=(l-1)*N+i;
            if (C(index11,j)~=0)
                message_total1=message_total1*C(index11,j);
            end
        end
        B(i,j)=message_total1;
        message_total1_sum=message_total1_sum+B(i,j);
    end
    
        
    for j=1:k
        B(i,j)=B(i,j)/message_total1_sum;
    end
end

display(B);

temp5=N*(N-1)/2;
E=zeros(temp5,k*k);

for i=1:(N-1)
    for j=(i+1):N
        E_index1=(2*N-i)*(i-1)/2+(j-i);
        if (A(i,j)~=0)
            
            for l=1:k
                for m=1:k
                
                    message_total2=phi(l)*phi(m)*psi2(l,m);
                
                    for r=1:N
                        index21=(r-1)*N+i;
                        if ((C(index21,l)~=0) && (r~=j))
                            message_total2=message_total2*C(index21,l);
                        end
                    end
                        
                    for s=1:N
                        index22=(s-1)*N+j;
                        if ((C(index22,m)~=0) && (s~=i))
                            message_total2=message_total2*C(index22,m);
                        end
                    end
                    
                    E_index2=(l-1)*k+m;
                    E(E_index1,E_index2)=message_total2;
                end
            end
        end
    end
end


size2=size(E);

row_n=size2(1);
column_n=size2(2);

for i=1:row_n
    sum_row=sum(E(i,:));
    if (sum_row~=0)
        for j=1:column_n
            E(i,j)=E(i,j)/sum_row;
        end
    end
end

display(E); % end of Step 2

%Step 3: start point: calculating the partition function
sum_part1=0.0;

for i=1:N
    for j=1:k
        temp1=B(i,j);
        temp2=log(temp1);
        temp3=temp1*temp2;
        temp4=temp1*j;
        temp5=temp4-temp3;
        sum_part1=sum_part1+temp5;
    end
end


for i=1:(N-1)
    for j=(i+1):N
        for l=1:k
            for m=1:k
                P_index1=(2*N-i)*(i-1)/2+(j-i);
                P_index2=(l-1)*k+m;
                
                if (E(P_index1,P_index2)~=0)
                    temp1=E(P_index1,P_index2);
                    temp2=B(i,l);
                    temp3=B(j,m);
                    temp4=temp1/(temp2*temp3);
                    temp5=temp1*log(temp4);
                    sum_part1=sum_part1-temp5;
                end
            end
        end
    end
end

Z=exp(sum_part1);

display(Z); %end of Step 3;

end
