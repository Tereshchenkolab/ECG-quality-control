clc; close all; clear all

%This code computes threshold values for high voltage, low voltage and
%high mean frequency based outliers and lead reversal issues from any ECG
%data
% we implemented and validated this code on UK biobank and CRIC databases


fs=500; %sampling frequency

% mainfolder = 'H:\Postdoc data\Databases\UKB\main_uk_database'; %folder with .mat files
mainfolder = 'H:\Postdoc data\Databases\UKB\test'; %Input ECG data in .mat format
FileList = dir(fullfile(mainfolder, '*.mat')); 
addpath(genpath(pwd)); %this function will add folder and subfolder in matlab path
LeadOrder={'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};



for iFile = 1:numel(FileList);
  FileData     = load(FileList(iFile).name);  
        fa=fs;
     
        ecg_fir=FileData.ECG12Lead_bwr';
                   regname=FileList(iFile).name(1:end-4); %
                   regname1{iFile}=regname;
         
            for i=1:12 %run this loop for all the 12 leads to compute AmpDiff and meanFreq from all ECGs
            ECG12Lead=FileData.ECG12Lead_bwr(:,i);
            ECG12Leadabs=abs(FileData.ECG12Lead_bwr(:,i));
            
  
            ampDiff=max(ECG12Lead)-min(ECG12Lead); %compute Ampdiff from original ECG signal
            AmplitudeDiff{i}=ampDiff;

            ampDiffabs=max(ECG12Leadabs)-min(ECG12Leadabs); %compute Ampdiff from rectified ECG signal
            AmplitudeDiffabs{i}=ampDiffabs;

            meanfreqVal=meanfreq(ECG12Lead,fs); %compute meanFreq from original ECG signal
            meanfreqValue{i}=meanfreqVal;
            end
    AmplitudeDiff_orig{iFile}=cell2mat(AmplitudeDiff); 
    AmplitudeDiff_abs{iFile}=cell2mat(AmplitudeDiffabs); 
    meanfreqI{iFile}=cell2mat(meanfreqValue); 
 
end
AmplitudeDiff_all=cell2mat(AmplitudeDiff_orig');
AmplitudeDiff_all_abs=cell2mat(AmplitudeDiff_abs');
meanfreq_all=cell2mat(meanfreqI');

% %if you want to save all these results in excel sheet with ecg names then
% %you can run following command
%             regname=regname1';
%             xlswrite('Thresholds_UKB.xls',[regname],'RegName');
%             xlswrite('Thresholds_UKB.xls',[AmplitudeDiff_all],'AmplitudeDiff_sig');
%             xlswrite('Thresholds_UKB.xls',[AmplitudeDiff_all_abs],'AmplitudeDiff_abs');              
%             xlswrite('Thresholds_UKB.xls',[meanfreq_all],'meanfreqvalue');



%compute threshold for high voltage based outliers for 8 independent leads,
%if someone wants to compute it for 12 leads then you can add all the 12
%leads in following code

[bI,idxI,outliersI] = deleteoutliers_std((AmplitudeDiff_all(:,1)),0.05);     %lead I
[bII,idxII,outliersII] = deleteoutliers_std((AmplitudeDiff_all(:,2)),0.05);  %lead II
[bV1,idxV1,outliersV1] = deleteoutliers_std((AmplitudeDiff_all(:,7)),0.05);  %lead V1
[bV2,idxV2,outliersV2] = deleteoutliers_std((AmplitudeDiff_all(:,8)),0.05);  %lead V2
[bV3,idxV3,outliersV3] = deleteoutliers_std((AmplitudeDiff_all(:,9)),0.05);  %lead V3
[bV4,idxV4,outliersV4] = deleteoutliers_std((AmplitudeDiff_all(:,10)),0.05); %lead V4
[bV5,idxV5,outliersV5] = deleteoutliers_std((AmplitudeDiff_all(:,11)),0.05); %lead V5
[bV6,idxV6,outliersV6] = deleteoutliers_std((AmplitudeDiff_all(:,12)),0.05); %lead V6

Th_H=[max(bI),max(bII),max(bV1),max(bV2),max(bV3),max(bV4),max(bV5),max(bV6)];%threshold to identify high voltage based outliers if AmpDiff of any ECG is greater than Th_H


%compute threshold for high mean frequency based outliers
[bI,idxI,outliersI] = deleteoutliers_std((meanfreq_all(:,1)),0.05);
[bII,idxII,outliersII] = deleteoutliers_std((meanfreq_all(:,2)),0.05);
[bV1,idxV1,outliersV1] = deleteoutliers_std((meanfreq_all(:,7)),0.05);
[bV2,idxV2,outliersV2] = deleteoutliers_std((meanfreq_all(:,8)),0.05);
[bV3,idxV3,outliersV3] = deleteoutliers_std((meanfreq_all(:,9)),0.05);
[bV4,idxV4,outliersV4] = deleteoutliers_std((meanfreq_all(:,10)),0.05);
[bV5,idxV5,outliersV5] = deleteoutliers_std((meanfreq_all(:,11)),0.05);
[bV6,idxV6,outliersV6] = deleteoutliers_std((meanfreq_all(:,12)),0.05);

mFTh=[max(bI),max(bII),max(bV1),max(bV2),max(bV3),max(bV4),max(bV5),max(bV6)];

Th_MF=median(mFTh);%threshold to identify high frequency based outliers if meanFreq of any ECG is greater than Th_MF

%compute threshold for low voltage based outliers

ThLleadI=abs(prctile((AmplitudeDiff_all_abs(:,1)),10)-iqr((AmplitudeDiff_all_abs(:,1)))) %for lead I
ThLleadII=abs(prctile((AmplitudeDiff_all_abs(:,2)),10)-iqr((AmplitudeDiff_all_abs(:,2)))) %for lead I
ThLleadV1=abs(prctile((AmplitudeDiff_all_abs(:,7)),10)-iqr((AmplitudeDiff_all_abs(:,7)))) %for lead I
ThLleadV2=abs(prctile((AmplitudeDiff_all_abs(:,8)),10)-iqr((AmplitudeDiff_all_abs(:,8)))) %for lead I
ThLleadV3=abs(prctile((AmplitudeDiff_all_abs(:,9)),10)-iqr((AmplitudeDiff_all_abs(:,9)))) %for lead I
ThLleadV4=abs(prctile((AmplitudeDiff_all_abs(:,10)),10)-iqr((AmplitudeDiff_all_abs(:,10)))) %for lead I
ThLleadV5=abs(prctile((AmplitudeDiff_all_abs(:,11)),10)-iqr((AmplitudeDiff_all_abs(:,11)))) %for lead I
ThLleadV6=abs(prctile((AmplitudeDiff_all_abs(:,12)),10)-iqr((AmplitudeDiff_all_abs(:,12)))) %for lead I

Th_L=[ThLleadI,ThLleadII,ThLleadV1,ThLleadV2,ThLleadV3,ThLleadV4,ThLleadV5,ThLleadV6];%threshold to identify low amplitude outliers if ampDiff of any ECG is less than Th_L

% Now compute threshold for correlation coefficient based threshold
%Note: we suggested to first exclude above mentioned outliers and then
%compute thresholds based on correlation coefficients

for iFile = 1:numel(FileList);
% for iFile = 173:numel(FileList);
  FileData     = load(FileList(iFile).name);

   
        fa=fs;

         
        ecg_fir=FileData.ECG12Lead_bwr';
        ecg=FileData.ECG12Lead_bwr;
        
    %here we excluded all the ECGs, the one has above shown
    %outliers/artifacts and then compute correlation coefficient from
    %remaining ECGs

    if (max(abs(ecg(1:1000,1)))-min(abs(ecg(1:1000,1))))<Th_L(1) || (max(abs(ecg(1001:2000,1)))-min(abs(ecg(1001:2000,1))))<Th_L(1) || (max(abs(ecg(2001:3000,1)))-min(abs(ecg(2001:3000,1))))<Th_L(1) || (max(abs(ecg(3001:4000,1)))-min(abs(ecg(3001:4000,1))))<Th_L(1) || (max(abs(ecg(4001:end,1)))-min(abs(ecg(4001:end,1))))<Th_L(1) ||...
       (max(abs(ecg(1:1000,2)))-min(abs(ecg(1:1000,2))))<Th_L(2) || (max(abs(ecg(1001:2000,2)))-min(abs(ecg(1001:2000,2))))<Th_L(2) || (max(abs(ecg(2001:3000,2)))-min(abs(ecg(2001:3000,2))))<Th_L(2) || (max(abs(ecg(3001:4000,2)))-min(abs(ecg(3001:4000,2))))<Th_L(2) || (max(abs(ecg(4001:end,2)))-min(abs(ecg(4001:end,2))))<Th_L(2) ||...
       (max(abs(ecg(1:1000,7)))-min(abs(ecg(1:1000,7))))<Th_L(3) || (max(abs(ecg(1001:2000,7)))-min(abs(ecg(1001:2000,7))))<Th_L(3) || (max(abs(ecg(2001:3000,7)))-min(abs(ecg(2001:3000,7))))<Th_L(3) || (max(abs(ecg(3001:4000,7)))-min(abs(ecg(3001:4000,7))))<Th_L(3) || (max(abs(ecg(4001:end,7)))-min(abs(ecg(4001:end,7))))<Th_L(3) ||...
       (max(abs(ecg(1:1000,8)))-min(abs(ecg(1:1000,8))))<Th_L(4) || (max(abs(ecg(1001:2000,8)))-min(abs(ecg(1001:2000,8))))<Th_L(4) || (max(abs(ecg(2001:3000,8)))-min(abs(ecg(2001:3000,8))))<Th_L(4) || (max(abs(ecg(3001:4000,8)))-min(abs(ecg(3001:4000,8))))<Th_L(4) || (max(abs(ecg(4001:end,8)))-min(abs(ecg(4001:end,8))))<Th_L(4) ||...
       (max(abs(ecg(1:1000,9)))-min(abs(ecg(1:1000,9))))<Th_L(5) || (max(abs(ecg(1001:2000,9)))-min(abs(ecg(1001:2000,9))))<Th_L(5) || (max(abs(ecg(2001:3000,9)))-min(abs(ecg(2001:3000,9))))<Th_L(5) || (max(abs(ecg(3001:4000,9)))-min(abs(ecg(3001:4000,9))))<Th_L(5) || (max(abs(ecg(4001:end,9)))-min(abs(ecg(4001:end,9))))<Th_L(5) ||...
       (max(abs(ecg(1:1000,10)))-min(abs(ecg(1:1000,10))))<Th_L(6) || (max(abs(ecg(1001:2000,10)))-min(abs(ecg(1001:2000,10))))<Th_L(6) || (max(abs(ecg(2001:3000,10)))-min(abs(ecg(2001:3000,10))))<Th_L(6) || (max(abs(ecg(3001:4000,10)))-min(abs(ecg(3001:4000,10))))<Th_L(6) || (max(abs(ecg(4001:end,10)))-min(abs(ecg(4001:end,10))))<Th_L(6) ||...
       (max(abs(ecg(1:1000,11)))-min(abs(ecg(1:1000,11))))<Th_L(7) || (max(abs(ecg(1001:2000,11)))-min(abs(ecg(1001:2000,11))))<Th_L(7) || (max(abs(ecg(2001:3000,11)))-min(abs(ecg(2001:3000,11))))<Th_L(7) || (max(abs(ecg(3001:4000,11)))-min(abs(ecg(3001:4000,11))))<Th_L(7) || (max(abs(ecg(4001:end,11)))-min(abs(ecg(4001:end,11))))<Th_L(7) ||...
       (max(abs(ecg(1:1000,12)))-min(abs(ecg(1:1000,12))))<Th_L(8) || (max(abs(ecg(1001:2000,12)))-min(abs(ecg(1001:2000,12))))<Th_L(8) || (max(abs(ecg(2001:3000,12)))-min(abs(ecg(2001:3000,12))))<Th_L(8) || (max(abs(ecg(3001:4000,12)))-min(abs(ecg(3001:4000,12))))<Th_L(8) || (max(abs(ecg(4001:end,12)))-min(abs(ecg(4001:end,12))))<Th_L(8) ||...
       (meanfreq(ecg(:,1),fs))>Th_MF || (meanfreq(ecg(:,2),fs))>Th_MF || (meanfreq(ecg(:,7),fs))>Th_MF || (meanfreq(ecg(:,8),fs))>Th_MF || (meanfreq(ecg(:,9),fs))>Th_MF || (meanfreq(ecg(:,10),fs))>Th_MF || (meanfreq(ecg(:,11),fs))>Th_MF || (meanfreq(ecg(:,12),fs))>Th_MF ||...  %C5(mean freq, 2*STD but then mean of all Thresholds in 8 leads)
       (max((ecg(:,1)))-min((ecg(:,1))))>Th_H(1) || (max((ecg(:,2)))-min((ecg(:,2))))>Th_H(2) || (max((ecg(:,7)))-min((ecg(:,7))))>Th_H(3) || (max((ecg(:,8)))-min((ecg(:,8))))>Th_H(4) || (max((ecg(:,9)))-min((ecg(:,9))))>Th_H(5) || (max((ecg(:,10)))-min((ecg(:,10))))>Th_H(6) || (max((ecg(:,11)))-min((ecg(:,11))))>Th_H(7) || (max((ecg(:,12)))-min((ecg(:,12))))>Th_H(8) %C1, apha=0.05, multiply 2*STD in Grubbs formula, HV based amp Diff from orignal ECG
  
        D=[];
    else
                regname=FileList(iFile).name(1:end-4);
                regname1{iFile}=regname;
                x1=FileData.ECG12Lead_bwr(:,[1:2,7:12]); %just for 8 independent leads
  

%regression analysis to reconstruct ECG using modified version of Kors et al., 2001    
                for i=1:size(x1,2)  %length(x1)
                a=1; %order of polynomial
                x=[];
                z=[];
                y=[];
                %Leave one out approach to choose one at a time
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

                %compute correlation coefficient between original and
                %reconstructed ECG leads
                    rho= diag(corr( x1 , c ))';
                    rho_all{iFile}= rho;

    end
end

CC=cell2mat(rho_all');
CCabs=abs(cell2mat(rho_all'));

%compute thresholds from absolute rho based results
[bI,idxI,outliersI] = deleteoutliers_std((CCabs(:,1)),0.05);
[bII,idxII,outliersII] = deleteoutliers_std((CCabs(:,2)),0.05);
[bV1,idxV1,outliersV1] = deleteoutliers_std((CCabs(:,3)),0.05);
[bV2,idxV2,outliersV2] = deleteoutliers_std((CCabs(:,4)),0.05);
[bV3,idxV3,outliersV3] = deleteoutliers_std((CCabs(:,5)),0.05);
[bV4,idxV4,outliersV4] = deleteoutliers_std((CCabs(:,6)),0.05);
[bV5,idxV5,outliersV5] = deleteoutliers_std((CCabs(:,7)),0.05);
[bV6,idxV6,outliersV6] = deleteoutliers_std((CCabs(:,8)),0.05);

CCTh=[min(bI),min(bII),min(bV1),min(bV2),min(bV3),min(bV4),min(bV5),min(bV6)];
Th_CC=abs(CCTh-prctile(CCTh,95)); %threshold to identify lead reversal issues if abs(rho) of any ECG is less than Th_CC


%save HV, LV, meanFreq and CC-based thresholds in matfiles
save("Threshold_HV.mat","Th_H") % save high voltage based threshold
save("Threshold_MNF.mat","Th_MF") % save high meanFreq based threshold
save("Threshold_LV.mat","Th_L") % save low voltage based threshold
save("Threshold_CC.mat","Th_CC") % save correlation coefficient based threshold



            