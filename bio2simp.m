function [X] = bio2simp(connectivity,Xo,Yo,N_elements,trielements)

X = zeros(N_elements,1);

Xtri = Xo(trielements);
Ytri = Yo(trielements);

count = 1;

for i = 1:connectivity.edges.Nedges

    if connectivity.edges.type(i) == 'I'

        verts = connectivity.edges.vertices(i,:);

        if connectivity.vertices.coords(verts(1),1) == connectivity.vertices.coords(verts(2),1)
            line(count*1000-999:count*1000,:) = [connectivity.vertices.coords(verts(1),1)*ones(1000,1),[connectivity.vertices.coords(verts(1),2):(connectivity.vertices.coords(verts(2),2)-connectivity.vertices.coords(verts(1),2))/999:connectivity.vertices.coords(verts(2),2)]'];
        elseif connectivity.vertices.coords(verts(1),2) == connectivity.vertices.coords(verts(2),2)
            line(count*1000-999:count*1000,:) = [[connectivity.vertices.coords(verts(1),1):(connectivity.vertices.coords(verts(2),1)-connectivity.vertices.coords(verts(1),1))/999:connectivity.vertices.coords(verts(2),1)]',connectivity.vertices.coords(verts(1),2)*ones(1000,1)];
        else
            line(count*1000-999:count*1000,:) = [[connectivity.vertices.coords(verts(1),1):(connectivity.vertices.coords(verts(2),1)-connectivity.vertices.coords(verts(1),1))/999:connectivity.vertices.coords(verts(2),1)]',[connectivity.vertices.coords(verts(1),2):(connectivity.vertices.coords(verts(2),2)-connectivity.vertices.coords(verts(1),2))/999:connectivity.vertices.coords(verts(2),2)]'];
        end

        count = count + 1;

    end

end

for i = 1:length(X)
    IN = inpolygon(line(:,1),line(:,2),Xtri(i,:),Ytri(i,:));
    if sum(IN)
        X(i) = 1;
    end
end
% 
% top = reshape(top,N,M)';
% for i = 2:M
%     for j = 1:N-1
%         if top(i,j)
%             if top(i-1,j+1) && top(i,j+1) == 0 && top(i-1,j) == 0
%                 top(i,j+1) = 1;
%             end
%         end
%     end
% end
% for i = 1:M-1
%     for j = 1:N-1
%         if top(i,j)
%             if top(i+1,j+1) && top(i,j+1) == 0 && top(i+1,j) == 0
%                 top(i+1,j) = 1;
%             end
%         end
%     end
% end
% for i = 1:M-1
%     for j = 2:N
%         if top(i,j)
%             if top(i+1,j-1) && top(i,j-1) == 0 && top(i+1,j) == 0
%                 top(i,j-1) = 1;
%             end
%         end
%     end
% end
% for i = 2:M
%     for j = 2:N
%         if top(i,j)
%             if top(i-1,j-1) && top(i,j-1) == 0 && top(i-1,j) == 0
%                 top(i-1,j) = 1;
%             end
%         end
%     end
% end
% 
% 
% top = reshape(top',M*N,1);
% X = top(top2==0);
% Xid = [1:M*N]'; Xid = Xid(top2==0);
% 
