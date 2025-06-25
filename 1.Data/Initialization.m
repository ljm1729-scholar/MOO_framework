%% 
% Time delay from the starting point of importation to the first confirmed case
DelayTimeToConfirm = 14;
% The social distancing policy changed every 2 weeks
PolicyChangingTerm = 14;

%% Data load
CountryName = "Republic of Korea";
%-- Set population
Pop = 51207874;
% Load raw data (Table)
data = readtable('cumulative-confirmed-covid-19-cases.csv','NumHeaderLines',1);
% Translate the Table to Array
Data = data(data.Var1==CountryName,:).Var3;
clear data
% Find when the first confirmed cases occur
FirstConfirmTiming = find(Data,1,'first');
% Trim the data from the first confirmed case
DataCase = Data(FirstConfirmTiming:end);
% Set the initial time for the data
DataInitialTime = datenum(2020,01,04)+FirstConfirmTiming-1; % The data aggregated from January 5, 2020

%% Estimation
% The length of data for the data fitting process
FittingLength = 14*13;
%-- Trim the data to the length of what we want
DataCase = DataCase(1:FittingLength+1);
% Set the end time for the data
DataEndTime = DataInitialTime +FittingLength;
%-- The corresponding time to the data
DataTime = DataInitialTime:DataEndTime;
%-- Time point to change the social distancing policy changing point during the estimation (changing point of mu value)
FittingDividingPoint = [DataInitialTime-DelayTimeToConfirm,DataInitialTime:PolicyChangingTerm:DataEndTime,DataEndTime];
FittingDividingPoint = unique(FittingDividingPoint);
%-- The corresponding time to the fitting
FittingTime = FittingDividingPoint(1):FittingDividingPoint(end);
%-- NumberOfMu
FittingNumberOfMu = length(FittingDividingPoint);

%% Simulation
% Simulation length
SimulLength = 14*13;
% Set the end time for the simulation
SimulEndTime = DataInitialTime +SimulLength;
%-- Time point to change the social distancing policy changing point during the simulation (changing point of mu value)
SimulDividingPoint = [DataInitialTime-DelayTimeToConfirm,DataInitialTime:PolicyChangingTerm:SimulEndTime,SimulEndTime];
SimulDividingPoint = unique(SimulDividingPoint);
%-- The corresponding time to the simulation
SimulTime = SimulDividingPoint(1):SimulDividingPoint(end);
%-- NumberOfMu
SimulNumberOfMu = length(SimulDividingPoint);

%% Disease information
beta = 0.6;
Re0 = 2.87;
kappa = 1/4;
alpha = 1/10;
gamma = 1/14;
f = 0.01729;
X0 = [Pop,0,0,0,0,0];

%% Color Setting
FigInfo.DataMarkerSize = 5;
FigInfo.DataSimulLineWidth = 1.5;

Red = [230  25  75]/255;
Gre = [ 60 180  75]/255;
Yel = [255 225  25]/255;
Blu = [  0 130 200]/255;
Ora = [245 130  48]/255;
Pur = [145  30 180]/255;
Cya = [ 70 240 240]/255;
Mag = [240  50 230]/255;
Lim = [210 245  60]/255;
Pin = [250 190 212]/255;
Tea = [  0 128 128]/255;
Lav = [220 190 255]/255;
Bro = [170 110  40]/255;
Bei = [255 250 200]/255;
Mar = [128   0   0]/255;
Min = [170 255 195]/255;
Oli = [128 128   0]/255;
Apr = [255 215 180]/255;
Nav = [  0   0 128]/255;
Gre = [128 128 128]/255;
FigInfo.MCMCchainColor = [Mar;  Red;... % 1, 2
                          Bro;  Ora;... % 3, 4
                          Oli;  Yel;... % 5, 6
                          Lim;  Gre;... % 7, 8
                          Tea;  Cya;... % 9, 10
                          Nav;  Blu;... % 11, 12
                          Pur;  Mag;... % 13, 14
                          ];
FigInfo.MultiObjColor = [Blu;Tea;Nav;Gre;Cya;Mar;Pur;Bro];

FigInfo.CostOptimalColor = [Ora;Mag;Red;Lav;Oli];
%% recording time
% Time record 1: Data preprocessing
timestone = RecordTime("Preprocessing",timestone);

