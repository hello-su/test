
function outmate = PairIndex(inedges, inmaxcardinality)


global DEBUG  mate nedge edges maxcardinality nvertex endpoint neighbend label labelend inblossom blossomparent blossomchilds blossombase blossomendps bestedge blossombestedges unusedblossoms dualvar queue allowedge;

DEBUG = false;

if ~exist('inmaxcardinality')
    inmaxcardinality = false;
end

% Deal swiftly with empty graphs.
if isempty(inedges)
    outmate = [];
    return;
end
edges = inedges;
maxcardinality = inmaxcardinality;

% Count vertices.
nedge = size(edges, 1);
nvertex = 0;
for k = 1:nedge
    %         assert i >= 0 and j >= 0 and i ~= j
    i = edges(k,1);
    j = edges(k,2);
    if i > nvertex
        nvertex = i;
    end
    if j > nvertex
        nvertex = j;
    end
end

% Find the maximum edge weight.
maxweight = max(edges(:,3));

% If p is an edge endpoint,
% endpoint(p) is the vertex to which endpoint p is attached.
% Not modified by the algorithm.
for p = 1:2*nedge
    endpoint(p) = edges(floor((p+1)/2),mod(p+1,2)+1);
end

% If v is a vertex,
% neighbend(v) is the list of remote endpoints of the edges attached to v.
% Not modified by the algorithm.
neighbend = {};
for i = 1:nvertex
    neighbend{i} = [];
end
for k = 1:size(edges, 1)
    i = edges(k,1);
    j = edges(k,2);
    neighbend{i} = [neighbend{i} 2*k];
    neighbend{j} = [neighbend{j } 2*k-1];
end
mate = -1* ones(1,nvertex);
label = zeros(1,2 * nvertex);
labelend = -1* ones(1,2 * nvertex);
inblossom = 1:nvertex;
blossomparent = -1*ones(1,2 * nvertex);
blossomchilds = {};
for i = 1:(2*nvertex)
    blossomchilds{i} = [];
end


blossombase = [1:nvertex -1*ones(1,nvertex)];
blossomendps = {};
for i = 1:(2*nvertex)
    blossomendps{i} = [];
end


bestedge = -1*ones(1,2 * nvertex);
blossombestedges = {};
for i = 1:(2*nvertex)
    blossombestedges{i} = [];
end


unusedblossoms = (nvertex+1):(2*nvertex);

dualvar = [maxweight*ones(1,nvertex) zeros(1,nvertex)];

allowedge = zeros(1,nedge);

queue = [ ];

for t = 1:nvertex
    
    if DEBUG  disp(sprintf('STAGE %d', t-1)); end;
    
    label = zeros(1, 2 * nvertex);
    
    bestedge = -1*ones(1,2 * nvertex);
    for i = (nvertex+1):(2*nvertex)
        blossombestedges{i} = [];
    end
    
    allowedge = zeros(1,nedge);
    
    queue = [ ];
    
    for v = 1:nvertex
        if mate(v) == -1 && label(inblossom(v)) == 0
            assignLabel(v, 1, -1);
        end
    end
    
    augmented = 0;
    while 1
        
        if DEBUG disp(sprintf('SUBSTAGE')); end;
        
        while ~isempty(queue) && ~augmented
            v = queue(end);
            queue(end) = [];
            if DEBUG disp(sprintf('POP v=%d', v-1)); end; 

            for p = neighbend{v}
                k = floor((p+1) / 2);
                w = endpoint(p);
                if inblossom(v) == inblossom(w)
                    continue;
                end
                if ~allowedge(k)
                    kslack = slack(k);
                    if kslack <= 0
                        allowedge(k) = true;
                    end
                end
                if allowedge(k)
                    if label(inblossom(w)) == 0
                        assignLabel(w, 2, otherEnd(p))
                    elseif label(inblossom(w)) == 1
                        base = scanBlossom(v, w);
                        if base >= 0
                            addBlossom(base, k);
                        else
                            augmentMatching(k);
                            augmented = 1;
                            break
                        end
                    elseif label(w) == 0
                        label(w) = 2;
                        labelend(w) = otherEnd(p);
                    end
                elseif label(inblossom(w)) == 1
                    b = inblossom(v);
                    if bestedge(b) == -1 || kslack < slack(bestedge(b))
                        bestedge(b) = k;
                    end
                elseif label(w) == 0
                    if bestedge(w) == -1 || kslack < slack(bestedge(w))
                        bestedge(w) = k;
                    end
                end
            end
        end
        
        if augmented
            break
        end
        
        deltatype = -1;
        delta = [];
        deltaedge = [];
        deltablossom = [];
        if ~maxcardinality
            deltatype = 1;
            delta = min(dualvar(1:nvertex));
        end

        for v = 1:nvertex
            if label(inblossom(v)) == 0 && bestedge(v) ~= -1
                d = slack(bestedge(v));
                if deltatype == -1 || d < delta
                    delta = d;
                    deltatype = 2;
                    deltaedge = bestedge(v);
                end
            end
        end
        
        for b = 1:(2 * nvertex)
            if ( blossomparent(b) == -1 && label(b) == 1 && bestedge(b) ~= -1)
                kslack = slack(bestedge(b));
                d = kslack / 2;
                if deltatype == -1 || d < delta
                    delta = d;
                    deltatype = 3;
                    deltaedge = bestedge(b);
                end
            end
        end
        
        for b = (nvertex+1):(2*nvertex)
            if ( blossombase(b) >= 0 && blossomparent(b) == -1 && label(b) == 2 && (deltatype == -1 || dualvar(b) < delta) )
                delta = dualvar(b);
                deltatype = 4;
                deltablossom = b;
            end
        end
        
        if deltatype == -1
            deltatype = 1;
            delta = max(0, min(dualvar(1:nvertex)));
        end
        
        for v  = 1:nvertex
            if label(inblossom(v)) == 1
                % S-vertex: 2*u = 2*u - 2*delta
                dualvar(v) = dualvar(v) - delta;
            elseif label(inblossom(v)) == 2
                % T-vertex: 2*u = 2*u + 2*delta
                dualvar(v) = dualvar(v) + delta;
            end
        end
        for b = (nvertex+1):(2*nvertex)
            if blossombase(b) >= 0 && blossomparent(b) == -1
                if label(b) == 1
                    % top-level S-blossom: z = z + 2*delta
                    dualvar(b) = dualvar(b) + delta;
                elseif label(b) == 2
                    % top-level T-blossom: z = z - 2*delta
                    dualvar(b) = dualvar(b) - delta;
                end
            end
        end
        
        % Take action at the point where minimum delta occurred.
        if DEBUG disp(sprintf('delta%d=%f',deltatype, delta)); end;
        if deltatype == 1
            % No further improvement possible; optimum reached.
            break
        elseif deltatype == 2
            % Use the least-slack edge to continue the search.
            allowedge(deltaedge) = true;
            i = edges(deltaedge,1); j = edges(deltaedge,2); wt = edges(deltaedge,3);
            if label(inblossom(i)) == 0
                m = i;
                i = j;
                j = m;
            end
            %                 assert label[inblossom(i)] == 1
            queue = [queue i];
        elseif deltatype == 3
            % Use the least-slack edge to continue the search.
            allowedge(deltaedge) = true;
            i = edges(deltaedge,1); j = edges(deltaedge,2); wt = edges(deltaedge,3);
            %                 assert label[inblossom(i)] == 1
            queue = [queue i];
        elseif deltatype == 4
            % Expand the least-z blossom.
            expandBlossom(deltablossom, false);
        end
        
        % End of a this substage.
    end
    % Stop when no more augmenting path can be found.
    if ~augmented
        break
    end
    
    % End of a stage; expand all S-blossoms which have dualvar = 0.
    for b = (nvertex+1):2*nvertex
        if ( blossomparent(b) == -1 && blossombase(b) >= 0 && label(b) == 1 && dualvar(b) == 0 )
            expandBlossom(b, true);
        end
    end
end

% Transform mate[] such that mate(v) is the vertex to which v is paired.
for v = 1:nvertex
    if mate(v) >= 0
        mate(v) = endpoint(mate(v));
    end
end

outmate = mate;

end

function val = pindex(thearray, index)
val = thearray(mod(index,length(thearray))+1);

end

% Return 2 * slack of edge k (does not work inside blossoms).
function theslack = slack(k, edges, dualvar)
global DEBUG edges dualvar;
i = edges(k,1);
j = edges(k,2);
wt = edges(k,3);
theslack = dualvar(i) + dualvar(j) - 2 * wt;

end


% Generate the leaf vertices of a blossom.
function leaves = blossomLeaves(b)
global DEBUG nvertex blossomchilds;

if b <= nvertex
    leaves = b;
else
    leaves = [];
    childList = blossomchilds{b};
    for t = 1:length(childList)
        if childList(t) <= nvertex
            leaves = [leaves childList(t)];
        else
            leafList = blossomLeaves(childList(t));
            for v = 1:length(leafList)
                leaves = [leaves leafList(v)];
            end
        end
    end
end

end

function assignLabel(w, t, p)
global DEBUG inblossom label labelend bestedge queue blossombase endpoint mate;

if DEBUG 
    if p == -1
        disp(sprintf('assignLabel(%d,%d,%d)', w-1, t, -1)); 
    else
        disp(sprintf('assignLabel(%d,%d,%d)', w-1, t, p-1)); 
    end
end

b = inblossom(w);
%         assert label(w) == 0 and label(b) == 0
label(w) = t;
label(b) = t;
labelend(w) = p;
labelend(b) = p;
bestedge(w) = -1;
bestedge(b) = -1;
if t == 1
    % b became an S-vertex/blossom; add it(s vertices) to the queue.
    queue = [queue blossomLeaves(b)];
    
    if DEBUG disp(sprintf('PUSH [%d] ', blossomLeaves(b)-1)); end;                
elseif t == 2
    % b became a T-vertex/blossom; assign label S to its mate.
    % (If b is a non-trivial blossom, its base is the only vertex
    % with an external mate.)
    base = blossombase(b);
    %             assert mate(base) >= 0
    assignLabel(endpoint(mate(base)), 1, otherEnd(mate(base)))
end

end

% Trace back from vertices v and w to discover either a new blossom
% or an augmenting path. Return the base vertex of the new blossom or -1.
function base = scanBlossom(v, w)
global DEBUG label endpoint blossombase inblossom labelend;

if DEBUG disp(sprintf('scanBlossom(%d,%d)',v-1, w-1)); end;


% Trace back from v and w, placing breadcrumbs as we go.
path = [ ];
base = -1;
while v ~= -1 || w ~= -1
    % Look for a breadcrumb in v's blossom or put a new breadcrumb.
    b = inblossom(v);
    if bitand(label(b), 4)
        base = blossombase(b);
        break
    end
    %             assert label(b) == 1
    path = [path b];
    label(b) = 5;
    % Trace one step back.
    %             assert labelend(b) == mate[blossombase(b)]
    if labelend(b) == -1
        % The base of blossom b is single; stop tracing this path.
        v = -1;
    else
        v = endpoint(labelend(b));
        b = inblossom(v);
        %                 assert label(b) == 2
        % b is a T-blossom; trace one more step back.
        %                 assert labelend(b) >= 0
        v = endpoint(labelend(b));
        
    end
    % Swap v and w so that we alternate between both paths.
    if w ~= -1
        m = v;
        v = w;
        w = m;
    end
    % Remove breadcrumbs
end
for b = path
    label(b) = 1;
end
% Return base vertex, if we found one.


end

function addBlossom(base, k)
global DEBUG nvertex inblossom unusedblossoms blossombase blossomparent blossomchilds blossomendps label labelend queue neighbend blossombestedges edges endpoint bestedge;
v = edges(k,1);
w = edges(k,2);
wt = edges(k,3);

bb = inblossom(base);
bv = inblossom(v);
bw = inblossom(w);
% Create blossom.
b = unusedblossoms(end);
unusedblossoms(end) = [];

if DEBUG disp(sprintf('addBlossom(%d,%d) (v=%d w=%d) -> %d', base-1, k-1, v-1, w-1, b-1)); end;
            
blossombase(b) = base;
blossomparent(b) = -1;
blossomparent(bb) = b;
% Make list of sub-blossoms and their interconnecting edge endpoints.
blossomchilds{b} = [];
path = [ ];
blossomendps{b} = [];
endps = [ ];
% Trace back from v to base.
while bv ~= bb
    % Add bv to the new blossom.
    blossomparent(bv) = b;
    path = [path bv];
    endps = [endps labelend(bv)];
    v = endpoint(labelend(bv));
    bv = inblossom(v);
end
% Reverse lists, add endpoint that connects the pair of S vertices.
path = [path bb];
path = fliplr(path);
endps = fliplr(endps);
endps = [endps (2*k)-1];
% Trace back from w to base.
while bw ~= bb
    % Add bw to the new blossom.
    blossomparent(bw) = b;
    path = [path bw];
    endps = [endps otherEnd(labelend(bw))];
    %             assert (label(bw) == 2 or
    %                     (label(bw) == 1 and labelend(bw) == mate[blossombase(bw)]))
    %             % Trace one step back.
    %             assert labelend(bw) >= 0
    w = endpoint(labelend(bw));
    bw = inblossom(w);
end
% Set label to S.
%         assert label(bb) == 1
label(b) = 1;
labelend(b) = labelend(bb);
% Set dual variable to zero.
dualvar(b) = 0;
% Relabel vertices.
blossomchilds{b} = path;
leaves = blossomLeaves(b);
for v = leaves
    if label(inblossom(v)) == 2
        % This T-vertex now turns into an S-vertex because it becomes
        % part of an S-blossom; add it to the queue.
        queue = [queue v];
    end
    inblossom(v) = b;
end
% Compute blossombestedges(b).
bestedgeto = -1*ones(1,2 * nvertex);
for bv = path
    if isempty(blossombestedges{bv})
        % This subblossom does not have a list of least-slack edges;
        % get the information from the vertices.
        nblists = [];
        blossomchilds{b} = path;
        leaves = blossomLeaves(bv);
        for v  = leaves
            for p = neighbend{v}
                nblists = [nblists floor((p+1)/2)];
            end
        end
    else
        % Walk this subblossom's least-slack edges.
        nblists = blossombestedges{bv};
    end
    for k = nblists
        i = edges(k,1); j = edges(k,2); wt = edges(k,3);
        if inblossom(j) == b
            m = j;
            j = i;
            i = m;
            
        end
        
        bj = inblossom(j);
        if (bj ~= b && label(bj) == 1 && (bestedgeto(bj) == -1 || slack(k) < slack(bestedgeto(bj))))
            bestedgeto(bj) = k;
        end
    end
    
    % Forget about least-slack edges of the subblossom.
    blossombestedges{bv} = [];
    bestedge(bv) = -1;
end

be = [];
for k = bestedgeto
    if k ~= -1
        be = [be k];
    end
end
blossombestedges{b} = be;

% Select bestedge(b).
bestedge(b) = -1;
for k = blossombestedges{b}
    if bestedge(b) == -1 || slack(k) < slack(bestedge(b))
        bestedge(b) = k;
    end
end

blossomchilds{b} = path;
blossomendps{b} = endps;

if DEBUG disp(sprintf('blossomchilds[%d]=%s', b-1, num2str(blossomchilds{b}-1))); end;

end


% Expand the given top-level blossom.
function expandBlossom(b, endstage)
global DEBUG dualvar label nvertex endpoint  blossomchilds blossomparent blossomendps labelend blossombase bestedge unusedblossoms allowedge inblossom mate;
         
if DEBUG disp(sprintf('expandBlossom(%d,%d) %s', b-1, endstage, num2str(blossomchilds{b}-1))); end;
% Convert sub-blossoms into top-level blossoms.
for s = blossomchilds{b}
    blossomparent(s) = -1;
    if s <= nvertex
        inblossom(s) = s;
    elseif endstage && dualvar(s) == 0
        % Recursively expand this sub-blossom.
        expandBlossom(s, endstage);
    else
        leaves = blossomLeaves(s);
        for v = leaves
            inblossom(v) = s;
        end
    end
end
% If we expand a T-blossom during a stage, its sub-blossoms must be
% relabeled.
if (~endstage) && label(b) == 2
    entrychild = inblossom(endpoint(otherEnd(labelend(b))));
    % Decide in which direction we will go round the blossom.
    j = find(blossomchilds{b} == entrychild)-1;
    if bitand(j, 1)
        % Start index is odd; go forward and wrap.
        j = j - length(blossomchilds{b});
        jstep = 1;
        endptrick = 0;
    else
        % Start index is even; go backward.
        jstep = -1;
        endptrick = 1;
    end
    % Move along the blossom until we get to the base.
    p = labelend(b);
    
    
    %%
    while j ~= 0
        % Relabel the T-sub-blossom.
        label(endpoint(otherEnd(p))) = 0;
        ptemp = pindex(blossomendps{b},j-endptrick);
        ptemp = whichEnd(ptemp,endptrick);
        ptemp = otherEnd(ptemp);
        label(endpoint(ptemp)) = 0;
        assignLabel(endpoint(otherEnd(p)), 2, p);
        % Step to the next S-sub-blossom and note its forward endpoint.
        ptemp = pindex(blossomendps{b},j-endptrick);
        edge = floor((ptemp+1)/2);
        allowedge(edge) = true;
        j = j + jstep;
        p = whichEnd(pindex(blossomendps{b},j-endptrick), endptrick);
        % Step to the next T-sub-blossom.
        allowedge(floor((p+1)/2)) = true;
        j = j + jstep;
    end
    if DEBUG disp(sprintf('label: %s',num2str(label))); end;
    if DEBUG disp(sprintf('allowedge: %s',num2str(allowedge))); end;
    
    %%
    
    bv = pindex(blossomchilds{b},j);
    label(bv) = 2;
    label(endpoint(otherEnd(p))) = label(bv);
    labelend(bv) = p;
    labelend(endpoint(otherEnd(p))) = labelend(bv);
    bestedge(bv) = -1;
    % Continue along the blossom until we get back to entrychild.
    if DEBUG disp(sprintf('label: %s',num2str(label))); end;
    if DEBUG disp(sprintf('allowedge: %s',num2str(allowedge))); end;
    j = j + jstep;
    while pindex(blossomchilds{b},j) ~= entrychild
        bv = pindex(blossomchilds{b},j);
        if label(bv) == 1
            % This sub-blossom just got label S through one of its
            % neighbours; leave it.
            j = j + jstep;
            continue
        end
        leaves = blossomLeaves(bv);
        for v = leaves
            if label(v) ~= 0
                break
            end
        end
        % If the sub-blossom contains a reachable vertex, assign
        % label T to the sub-blossom.
        if label(v) ~= 0
            %                     assert label(v) == 2
            %                     assert inblossom(v) == bv
            label(v) = 0;
            label(endpoint(mate(blossombase(bv)))) = 0;
            assignLabel(v, 2, labelend(v));
        end
        j = j + jstep;
    end
    if DEBUG disp(sprintf('label: %s',num2str(label))); end;
    if DEBUG disp(sprintf('allowedge: %s',num2str(allowedge))); end;
end
% Recycle the blossom number.
labelend(b) = -1;
label(b) = -1;
blossomchilds{b} = {};
blossomendps{b} = {};
blossombase(b) = -1;
blossombestedges{b} = {};
bestedge(b) = -1;
unusedblossoms = [unusedblossoms b];
end

% Swap matched/unmatched edges over an alternating path through blossom b
% between vertex v and the base vertex. Keep blossom bookkeeping consistent.
function augmentBlossom(b, v)
global DEBUG blossomparent nvertex blossomchilds blossomendps blossombase endpoint mate;

if DEBUG disp(sprintf('blossomchilds{b}: %s',num2str(blossomchilds{b}-1))); end;
if DEBUG disp(sprintf('blossomendps{b}: %s',num2str(blossomendps{b}-1))); end;
if DEBUG disp(sprintf('blossombase: %s',num2str(blossombase-1))); end;
if DEBUG disp(sprintf('mate: %s',num2str(mate-1))); end;

if DEBUG disp(sprintf('augmentBlossom(%d,%d)', b-1, v-1)); end;
% Bubble up through the blossom tree from vertex v to an immediate
% sub-blossom of b.
t = v;
while blossomparent(t) ~= b
    t = blossomparent(t);
end
% Recursively deal with the first sub-blossom.
if t > nvertex
    augmentBlossom(t, v);
end
% Decide in which direction we will go round the blossom.
i = find(blossomchilds{b}==t)-1;
j = i;
if bitand(i,1)
    % Start index is odd; go forward and wrap.
    j = j - length(blossomchilds{b});
    jstep = 1;
    endptrick = 0;
else
    % Start index is even; go backward.
    jstep = -1;
    endptrick = 1;
end
% Move along the blossom until we get to the base.
while j ~= 0
    % Step to the next sub-blossom and augment it recursively.
    j = j + jstep;
    t = pindex(blossomchilds{b},j);
    p = whichEnd(pindex(blossomendps{b},j-endptrick), endptrick);
    if t > nvertex
        augmentBlossom(t, endpoint(p));
    end
    % Step to the next sub-blossom and augment it recursively.
    j = j + jstep;
    t = pindex(blossomchilds{b},j);
    if t > nvertex
        augmentBlossom(t, endpoint(otherEnd(p)));
    end
    % Match the edge connecting those sub-blossoms.
    mate(endpoint(p)) = otherEnd(p);
    mate(endpoint(otherEnd(p))) = p;
    
    if DEBUG disp(sprintf('PAIR %d %d (k=%d)', endpoint(p), endpoint(otherEnd(p)), floor((p+1)/2))); end;
end
% Rotate the list of sub-blossoms to put the new base at the front.
blossomchilds{b} = [blossomchilds{b}((i+1):end),  blossomchilds{b}(1:i)];
blossomendps{b}  = [blossomendps{b}((i+1):end),  blossomendps{b}(1:i)];
blossombase(b) = blossombase(blossomchilds{b}(1));



%         assert blossombase(b) == v
end

function augmentMatching(k)
global DEBUG edges inblossom endpoint labelend mate nvertex;
v = edges(k,1); w = edges(k,2); wt = edges(k,3);
if DEBUG disp(sprintf('augmentMatching(%d) (v=%d w=%d)', k-1, v-1, w-1)); end;
if DEBUG disp(sprintf('PAIR %d %d (k=%d)', v-1, w-1, k-1)); end;
%         for (s, p) in ((v, 2*k+1), (w, 2*k)):
% if DEBUG disp(sprintf('Mate %s', num2str(mate))); end;
% if DEBUG disp(sprintf('Labelend %s', num2str(labelend))); end;

for i = 1:2
    if i == 1
        s = v;
        p = 2*k;
    else
        s = w;
        p = 2*k-1;
    end
    while 1
        bs = inblossom(s);
        %                 assert label(bs) == 1
        %                 assert labelend(bs) == mate[blossombase(bs)]
        % Augment through the S-blossom from s to base.
        if bs > nvertex
            augmentBlossom(bs, s)
        end
        % Update mate(s)
        mate(s) = p;
        % Trace one step back.
        if labelend(bs) == -1
            % Reached single vertex; stop.
            break
        end
        t = endpoint(labelend(bs));
        bt = inblossom(t);
        %                 assert label(bt) == 2
        % Trace one step back.
        %                 assert labelend(bt) >= 0
        s = endpoint(labelend(bt));
        j = endpoint(otherEnd(labelend(bt)));
        % Augment through the T-blossom from j to base.
        %                 assert blossombase(bt) == t
        if bt > nvertex
            augmentBlossom(bt, j);
        end
        % Update mate(j)
        mate(j) = labelend(bt);
        % Keep the opposite endpoint;
        % it will be assigned to mate(s) in the next step.
        p = otherEnd(labelend(bt));
        if DEBUG disp(sprintf('PAIR %d %d (k=%d)', s-1, t-1, floor((p+1)/2)-1)); end;
    end
end
end


function p = otherEnd(p)
p = bitxor(p-1,1)+1;
end

function p = whichEnd(p,otherOne)
if otherOne
    p = otherEnd(p);
end
end
