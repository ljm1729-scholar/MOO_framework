function  [bestx, bestold] = IMODE_basic(f,D, Space_min, Space_max, max_iter)
disp_iter=0;
Par.n=D;
Par.n_opr=3;  %% number of operators 

if ~exist('max_iter','var')
    if Par.n == 1
        Par.Max_FES = 10000;
        Par.Gmax = 500;
    elseif Par.n == 2
        Par.Max_FES = 20000;
        Par.Gmax = 1000;
    elseif Par.n==5
        Par.CS=100; %% cycle
        Par.Max_FES=50000;
        Par.Gmax = 2163;
    elseif Par.n==10
        Par.CS=100; %% cycle
        Par.Gmax = 2745;
        Par.Max_FES=1000000;
    elseif Par.n==15
        Par.CS=100; %% cycle
        Par.Gmax = 3022;
        Par.Max_FES=3000000;
    elseif Par.n==20
        Par.Max_FES=10000000;
        Par.CS=100; %% cycle
        Par.Gmax = 3401;
    else
        error('Dimension D can only be 1, 2, 5, 10, 15, 20')
    end
else
    Par.Max_FES = max_iter;
    Par.CS=100; %% cycle
    Par.Gmax = 500*Par.n;
end

Par.xmin = Space_min;
Par.xmax = Space_max;

Par.PopSize=6*Par.n*round(sqrt(Par.n)); %% population size
Par.MinPopSize=4;

Par.prob_ls=0.1;

%% printing the detailed results- this will increase the computational time
Par.Printing=1; %% 1 to print; 0 otherwise

run = 1;
iter=0;             %% current generation
current_eval=0;             %% current fitness evaluations
PS1=Par.PopSize;            %% define PS1

%% Initalize x 
x=repmat(Par.xmin,Par.PopSize,1)+repmat((Par.xmax-Par.xmin),Par.PopSize,1).*rand(Par.PopSize,Par.n);

%% calc. fit. and update FES
tic;
fitx = zeros(1, Par.PopSize);
for i = 1 : Par.PopSize
        fitx(i) = f(x(i,:));
end
%fitx= cec20_func(x',I_fno);
current_eval =current_eval+Par.PopSize;
res_det= min(repmat(min(fitx),1,Par.PopSize), fitx); %% used to record the convergence

%% store the best
[bestold, bes_l]=min(fitx);
bestx= x(bes_l,:);

%% IMODE
EA_1= x(1:PS1,:);   
EA_obj1= fitx(1:PS1);   
EA_1old = x(randperm(PS1),:);

%% ===== prob. of each DE operator =====
probDE1=1./Par.n_opr .* ones(1,Par.n_opr);

%% ===================== archive data ====================================
arch_rate=2.6;
archive.NP = arch_rate * PS1; % the maximum size of the archive
archive.pop = zeros(0, Par.n); % the solutions stored in the archive
archive.funvalues = zeros(0, 1); % the function value of the archived solutions

%% ==================== to adapt CR and F =================================
hist_pos=1;
memory_size=20*Par.n;
archive_f= ones(1,memory_size).*0.2;
archive_Cr= ones(1,memory_size).*0.2;
archive_T = ones(1,memory_size).*0.1;
archive_freq = ones(1, memory_size).*0.5;

%%
stop_con=0;
avgFE=Par.Max_FES; 
InitPop=PS1; 
%thrshold=1e-08;

cy=0;
indx = 0;
F = normrnd(0.5,0.15,1,PS1);
cr= normrnd(0.5,0.15,1,PS1);

%% main loop
while stop_con==0
    % if current_eval/Par.Max_FES>=disp_iter
    %     home; disp(['IMODE progression: ',num2str(round(current_eval/Par.Max_FES*100)),'%'])
    %     disp_iter=disp_iter+0.01;
    % end
    iter=iter+1;
    cy=cy+1; % to control CS
    
    %% ======================Applying IMODE ============================
    if (current_eval<Par.Max_FES)
            
            %% =============================== Linear Reduction of PS1 ===================================================
            UpdPopSize = round((((Par.MinPopSize - InitPop) / Par.Max_FES) * current_eval) + InitPop);
            if PS1 > UpdPopSize
                reduction_ind_num = PS1 - UpdPopSize;
                if PS1 - reduction_ind_num <  Par.MinPopSize
                    reduction_ind_num = PS1 - Par.MinPopSize;
                end
                %% remove the worst ind.
                for r = 1 : reduction_ind_num
                    vv=PS1;
                    EA_1(vv,:)=[];
                    EA_1old(vv,:)=[];
                    EA_obj1(vv)=[];
                    PS1 = PS1 - 1;
                end
                archive.NP = round(arch_rate * PS1);
                if size(archive.pop, 1) > archive.NP
                    rndpos = randperm(size(archive.pop, 1));
                    rndpos = rndpos(1 : archive.NP);
                    archive.pop = archive.pop(rndpos, :);
                end
            end
            
            %% apply IMODE
            [EA_1, EA_1old, EA_obj1,probDE1,bestold,bestx,archive,hist_pos,memory_size, archive_f,archive_Cr,archive_T,archive_freq, current_eval,res_det,F,cr] = ...
                IMODE( f, EA_1,EA_1old, EA_obj1,probDE1,bestold,bestx,archive,hist_pos,memory_size, archive_f,archive_Cr,archive_T,....
                archive_freq, Par.xmin, Par.xmax,  Par.n,  PS1,  current_eval,res_det,Par.Printing,Par.Max_FES, Par.Gmax, iter,F,cr);
            
    end
    
     %% ============================ LS2 ====================================
    if current_eval>0.85*Par.Max_FES && current_eval<Par.Max_FES
        if rand<Par.prob_ls
            old_fit_eva=current_eval;
            [bestx,bestold,current_eval,succ] = LS2 (f,bestx,bestold,Par,current_eval,Par.Max_FES,Par.xmin,Par.xmax);
            if succ==1 %% if LS2 was successful
                EA_1(PS1,:)=bestx';
                EA_obj1(PS1)=bestold;
                [EA_obj1, sort_indx]=sort(EA_obj1);
                EA_1= EA_1(sort_indx,:);
                
%                 EA_2=repmat(EA_1(1,:), PS2, 1);
%                 [setting]= init_cma_par(setting,EA_2, Par.n, PS2);
%                 setting.sigma=1e-05;
%                 EA_obj2(1:PS2)= EA_obj1(1);
                Par.prob_ls=0.1;
            else
                Par.prob_ls=0.01; %% set p_LS to a small value it  LS was not successful
            end
            %% record best fitness -- set Par.Printing==0 if not
            if Par.Printing==1
                res_det= [res_det repmat(bestold,1,(current_eval-old_fit_eva))];
            end
            
        end
    end
    
    %% ====================== stopping criterion check ====================
    if (current_eval>=Par.Max_FES-4*UpdPopSize)
        stop_con=1;
        avgFE=current_eval;
    end
    
%     if ( (abs (Par.f_optimal - bestold)<= thrshold))
%         stop_con=1;
%         bestold=Par.f_optimal;
%         avgFE=current_eval;
%     end
    
    %% =============================== Print ==============================
    %          fprintf('current_eval\t %d fitness\t %d \n', current_eval, abs(Par.f_optimal-bestold));
    if stop_con
        %com_time= toc;%cputime-start_time;
        fprintf('solution\t %d  %d, fitness\t %d, avg.FFE\t %d\t\n', bestx, bestold,avgFE);
        %outcome= abs(Par.f_optimal-bestold);
%         if (min (bestx))< -100 || (max(bestx))>100 %% make sure  that the best solution is feasible
%             fprintf('in problem: %d, there is  a violation',I_fno);
%         end
        %SR= (outcome==0);
    end
end