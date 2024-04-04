clc; close all; clear all

% After computing threshold values using
% "Threshold_computation_UKB_issues.m": Following code plots
% non-physiological ECG artifacts (high voltage, low voltage, high mean
% frequency based outliers) and then ECGs with lead reversal by using
% threshold values computed in "Threshold_computation_UKB_issues.m" file

fs=500;
%addpath(genpath([rootP '\stable\tools\filtering\ver2']))

mainfolder = 'H:\Postdoc data\Databases\UKB\test'; %Input ECG data in .mat format
 FileList = dir(fullfile(mainfolder, '*.mat')); 
addpath(genpath(pwd)); %this function will add folder and subfolder in matlab path
LeadOrder={'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'}; %For Torso



for iFile = 1:numel(FileList);
    FileData     = load(FileList(iFile).name);
    fa=500; %sampling frequency
    regname=FileList(iFile).name(1:end-4);
    ecg=FileData.ECG12Lead_bwr;
    ecg_fir=FileData.ECG12Lead_bwr';
    
   %load thresholds based .mat files (the ones computed from
   %"Threshold_computation_UKB_issues.m" file)
   addpath('H:\Postdoc data\Databases\UKB\') % path of folder where you saved threshold values in .mat format
   load("Threshold_HV.mat"); %Th_H -->threshold for high voltage artifacts from 8 independent leads
   load("Threshold_MNF.mat"); %Th_MF -->threshold for high mean Frequency artifacts from 8 independent leads
   load("Threshold_LV.mat"); %Th_L -->threshold for low voltage artifacts from 8 independent leads
   load("Threshold_CC.mat"); %Th_CC -->threshold for correlation coefficient to identify lead reversal from 8 independent leads



%Following if statement based condition will plot figures for ECGs with
%high voltage or low voltage or high mean frequency based artifacts

%Following else statement based condition will plot figures for ECGs with
%lead reversal

    if (max(abs(ecg(1:1000,1)))-min(abs(ecg(1:1000,1))))<Th_L(1) || (max(abs(ecg(1001:2000,1)))-min(abs(ecg(1001:2000,1))))<Th_L(1) || (max(abs(ecg(2001:3000,1)))-min(abs(ecg(2001:3000,1))))<Th_L(1) || (max(abs(ecg(3001:4000,1)))-min(abs(ecg(3001:4000,1))))<Th_L(1) || (max(abs(ecg(4001:end,1)))-min(abs(ecg(4001:end,1))))<Th_L(1) ||...
       (max(abs(ecg(1:1000,2)))-min(abs(ecg(1:1000,2))))<Th_L(2) || (max(abs(ecg(1001:2000,2)))-min(abs(ecg(1001:2000,2))))<Th_L(2) || (max(abs(ecg(2001:3000,2)))-min(abs(ecg(2001:3000,2))))<Th_L(2) || (max(abs(ecg(3001:4000,2)))-min(abs(ecg(3001:4000,2))))<Th_L(2) || (max(abs(ecg(4001:end,2)))-min(abs(ecg(4001:end,2))))<Th_L(2) ||...
       (max(abs(ecg(1:1000,7)))-min(abs(ecg(1:1000,7))))<Th_L(3) || (max(abs(ecg(1001:2000,7)))-min(abs(ecg(1001:2000,7))))<Th_L(3) || (max(abs(ecg(2001:3000,7)))-min(abs(ecg(2001:3000,7))))<Th_L(3) || (max(abs(ecg(3001:4000,7)))-min(abs(ecg(3001:4000,7))))<Th_L(3) || (max(abs(ecg(4001:end,7)))-min(abs(ecg(4001:end,7))))<Th_L(3) ||...
       (max(abs(ecg(1:1000,8)))-min(abs(ecg(1:1000,8))))<Th_L(4) || (max(abs(ecg(1001:2000,8)))-min(abs(ecg(1001:2000,8))))<Th_L(4) || (max(abs(ecg(2001:3000,8)))-min(abs(ecg(2001:3000,8))))<Th_L(4) || (max(abs(ecg(3001:4000,8)))-min(abs(ecg(3001:4000,8))))<Th_L(4) || (max(abs(ecg(4001:end,8)))-min(abs(ecg(4001:end,8))))<Th_L(4) ||...
       (max(abs(ecg(1:1000,9)))-min(abs(ecg(1:1000,9))))<Th_L(5) || (max(abs(ecg(1001:2000,9)))-min(abs(ecg(1001:2000,9))))<Th_L(5) || (max(abs(ecg(2001:3000,9)))-min(abs(ecg(2001:3000,9))))<Th_L(5) || (max(abs(ecg(3001:4000,9)))-min(abs(ecg(3001:4000,9))))<Th_L(5) || (max(abs(ecg(4001:end,9)))-min(abs(ecg(4001:end,9))))<Th_L(5) ||...
       (max(abs(ecg(1:1000,10)))-min(abs(ecg(1:1000,10))))<Th_L(6) || (max(abs(ecg(1001:2000,10)))-min(abs(ecg(1001:2000,10))))<Th_L(6) || (max(abs(ecg(2001:3000,10)))-min(abs(ecg(2001:3000,10))))<Th_L(6) || (max(abs(ecg(3001:4000,10)))-min(abs(ecg(3001:4000,10))))<Th_L(6) || (max(abs(ecg(4001:end,10)))-min(abs(ecg(4001:end,10))))<Th_L(6) ||...
       (max(abs(ecg(1:1000,11)))-min(abs(ecg(1:1000,11))))<Th_L(7) || (max(abs(ecg(1001:2000,11)))-min(abs(ecg(1001:2000,11))))<Th_L(7) || (max(abs(ecg(2001:3000,11)))-min(abs(ecg(2001:3000,11))))<Th_L(7) || (max(abs(ecg(3001:4000,11)))-min(abs(ecg(3001:4000,11))))<Th_L(7) || (max(abs(ecg(4001:end,11)))-min(abs(ecg(4001:end,11))))<Th_L(7) ||...
       (max(abs(ecg(1:1000,12)))-min(abs(ecg(1:1000,12))))<Th_L(8) || (max(abs(ecg(1001:2000,12)))-min(abs(ecg(1001:2000,12))))<Th_L(8) || (max(abs(ecg(2001:3000,12)))-min(abs(ecg(2001:3000,12))))<Th_L(8) || (max(abs(ecg(3001:4000,12)))-min(abs(ecg(3001:4000,12))))<Th_L(8) || (max(abs(ecg(4001:end,12)))-min(abs(ecg(4001:end,12))))<Th_L(8) ||...
       (meanfreq(ecg(:,1),fs))>Th_MF(1) || (meanfreq(ecg(:,2),fs))>Th_MF(2) || (meanfreq(ecg(:,7),fs))>Th_MF(3) || (meanfreq(ecg(:,8),fs))>Th_MF(4) || (meanfreq(ecg(:,9),fs))>Th_MF(5) || (meanfreq(ecg(:,10),fs))>Th_MF(6) || (meanfreq(ecg(:,11),fs))>Th_MF(7) || (meanfreq(ecg(:,12),fs))>Th_MF(8) ||...  %C5(mean freq, 2*STD but then mean of all Thresholds in 8 leads)
       (max((ecg(:,1)))-min((ecg(:,1))))>Th_H(1) || (max((ecg(:,2)))-min((ecg(:,2))))>Th_H(2) || (max((ecg(:,7)))-min((ecg(:,7))))>Th_H(3) || (max((ecg(:,8)))-min((ecg(:,8))))>Th_H(4) || (max((ecg(:,9)))-min((ecg(:,9))))>Th_H(5) || (max((ecg(:,10)))-min((ecg(:,10))))>Th_H(6) || (max((ecg(:,11)))-min((ecg(:,11))))>Th_H(7) || (max((ecg(:,12)))-min((ecg(:,12))))>Th_H(8) %C1, apha=0.05, multiply 2*STD in Grubbs formula, HV based amp Diff from orignal ECG



                    hFig=figure;
   
                    subplot(421)
                    plot((1:length(ecg_fir(1,:)))/(fa*2),ecg_fir(1,:))
                    title('ECG(I)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('A(samp)','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');

                    subplot(422)
                    plot((1:length(ecg_fir(2,:)))/(fa*2),ecg_fir(2,:))
                    title('ECG(II)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('A(samp)','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    
                    subplot(423)
                    plot((1:length(ecg_fir(7,:)))/(fa*2),ecg_fir(7,:))
                    title('ECG(V1)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('A(samp)','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');

                    subplot(424)
                    plot((1:length(ecg_fir(8,:)))/(fa*2),ecg_fir(8,:))
                    title('ECG(V2)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('A(samp)','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');

                    subplot(425)
                    plot((1:length(ecg_fir(9,:)))/(fa*2),ecg_fir(9,:))
                    title('ECG(V3)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('A(samp)','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    
                    subplot(426)
                    plot((1:length(ecg_fir(10,:)))/(fa*2),ecg_fir(10,:))
                    title('ECG(V4)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('A(samp)','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    
                    subplot(427)
                    plot((1:length(ecg_fir(11,:)))/(fa*2),ecg_fir(11,:))
                    title('ECG(V5)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('A(samp)','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    
                    subplot(428)
                    plot((1:length(ecg_fir(12,:)))/(fa*2),ecg_fir(12,:))
                    title('ECG(V6)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('A(samp)','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                
                   
                    set(gca, 'FontName', 'Times New Roman', 'FontSize',8);
                 
                    SaveFigfigure=(['H:\Postdoc data\Databases\UKB\test\figureC1\']); %folder to save figures for HV, LV and MF based outliers
                    fullFileName = fullfile(SaveFigfigure,regname);
                    saveas(hFig,fullFileName,'png');
                    close(hFig)



    else
                regname=FileList(iFile).name(1:end-4);
                regname1{iFile}=regname;
                x1=FileData.ECG12Lead_bwr(:,[1:2,7:12]);
                for i=1:size(x1,2)  %length(x1)
                    a=1; %order of polynomial
                    x=[];
                    z=[];
                    y=[];
                        for ij=1:size(x1,2)%length(x1)
                            if(ij~=i)
                               x=[x x1(:,ij)];
                            end
                        end
               
                    X = [ones(length(x),1) x];
                     y=x1(:,i)';
                     [beta,Sigma,E,CovB,logL] = mvregress(X,y');
                    
                    coeff=beta';
                    c(:,i)=coeff(1)+coeff(2)*(X(:,2))+coeff(3)*(X(:,3))+coeff(4)*(X(:,4))+coeff(5)*(X(:,5))+coeff(6)*(X(:,6))+coeff(7)*(X(:,7))+coeff(8)*(X(:,8)); %for univariate
                end

                    rho= diag(corr( x1 , c ))';
                    rho_all{iFile}= rho;

               if   abs(rho(1))<Th_CC(1) || abs(rho(2))<Th_CC(2) || abs(rho(3))<Th_CC(3) || abs(rho(4))<Th_CC(4) || abs(rho(5))<Th_CC(5) || abs(rho(6))<Th_CC(6) || abs(rho(7))<Th_CC(7) || abs(rho(8))<Th_CC(8) % abs(CCth-95%percentileCCth) i.e. abs(CCth-prctle(CCth,95)
                    hFig=figure;
        
                    subplot(431)
                    plot((1:length(ecg_fir(1,:)))/(fa*2),ecg_fir(1,:))
                    title('ECG(I)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('Amp','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');

                    subplot(432)
                    plot((1:length(ecg_fir(2,:)))/(fa*2),ecg_fir(2,:))
                    title('ECG(II)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('Amp','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    

                    subplot(433)
                    plot((1:length(ecg_fir(3,:)))/(fa*2),ecg_fir(3,:))
                    title('ECG(III)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('Amp','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    

                    subplot(434)
                    plot((1:length(ecg_fir(4,:)))/(fa*2),ecg_fir(4,:))
                    title('ECG(aVR)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('Amp','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    

                    subplot(435)
                    plot((1:length(ecg_fir(5,:)))/(fa*2),ecg_fir(5,:))
                    title('ECG(aVL)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('Amp','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    

                    subplot(436)
                    plot((1:length(ecg_fir(6,:)))/(fa*2),ecg_fir(6,:))
                    title('ECG(aVF)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('Amp','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    

                    subplot(437)
                    plot((1:length(ecg_fir(7,:)))/(fa*2),ecg_fir(7,:))
                    title('ECG(V1)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('Amp','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');

                    subplot(438)
                    plot((1:length(ecg_fir(8,:)))/(fa*2),ecg_fir(8,:))
                    title('ECG(V2)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('Amp','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');

                    subplot(439)
                    plot((1:length(ecg_fir(9,:)))/(fa*2),ecg_fir(9,:))
                    title('ECG(V3)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('Amp','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    
                    subplot(4,3,10)
                    plot((1:length(ecg_fir(10,:)))/(fa*2),ecg_fir(10,:))
                    title('ECG(V4)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('Amp','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    
                    subplot(4,3,11)
                    plot((1:length(ecg_fir(11,:)))/(fa*2),ecg_fir(11,:))
                    title('ECG(V5)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('Amp','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    
                    subplot(4,3,12)
                    plot((1:length(ecg_fir(12,:)))/(fa*2),ecg_fir(12,:))
                    title('ECG(V6)','FontSize',8, 'FontName', 'Times New Roman')
                    ylabel('Amp','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                    xlabel('t','FontSize',8, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
                
                   

                    set(gca, 'FontName', 'Times New Roman', 'FontSize',8);
            
                    SaveFigfigure=(['H:\Postdoc data\Databases\UKB\test\figureC2\']); %folder to save lead reversal based 12 lead ECGs
                    fullFileName = fullfile(SaveFigfigure,regname);
                    saveas(hFig,fullFileName,'png');
                    close(hFig)
              else
                  E=[]; %No figure will be plotted if there is not any lead reversal issue
              end
    end

                  

end

%To save all these results in excel sheet with ecg names of all ECGs, then ECGs with artifacts and ECGs with lead reversal 
            ECG_id_all=regname_all';
            ECG_id_artifacts=regnameC1';
            ECG_id_leadreversal=regnameC2';


            xlRange = 'A2';
            x2Range = 'B2';
            x3Range = 'C2';
            sheet = 2;
            xlswrite('Results.xls',['All';ECG_id_all],sheet,xlRange);
            xlswrite('Results.xls',['Artifacts';ECG_id_artifacts],sheet,x2Range);
            xlswrite('Results.xls',['Leadreversal';ECG_id_leadreversal],sheet,x3Range);


