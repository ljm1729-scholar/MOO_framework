function timestone = RecordTime(SimName,timestone)
    try
        timestone{2,1}=[timestone{2,1},toc]; timestone{1,1}=[timestone{1,1},SimName];
    catch
        timestone{2,1}=0;timestone{1,1}="Start"; tic;
    end
    toc
    pause(eps)