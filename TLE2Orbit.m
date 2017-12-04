%ref : https://in.mathworks.com/matlabcentral/answers/47656-i-want-to-read-a-text-file-having-strings-and-numeric-data-is-there-any-better-function-than-textsc
% https://in.mathworks.com/help/matlab/ref/textscan.html
% 1	01–01	Line number	1
% 2	03–07	Satellite number	25544
% 3	08–08	Classification (U=Unclassified)	U
% 4	10–11	International Designator (Last two digits of launch year)	98
% 5	12–14	International Designator (Launch number of the year)	067
% 6	15–17	International Designator (piece of the launch)	A
% 7	19–20	Epoch Year (last two digits of year)	08
% 8	21–32	Epoch (day of the year and fractional portion of the day)	264.51782528
% 9	34–43	First Time Derivative of the Mean Motion divided by two [10]	?.00002182
% 10	45–52	Second Time Derivative of Mean Motion divided by six (decimal point assumed)	00000-0
% 11	54–61	BSTAR drag term (decimal point assumed) [10]	-11606-4
% 12	63–63	The number 0 (originally this should have been "Ephemeris type")	0
% 13	65–68	Element set number. Incremented when a new TLE is generated for this object.[10]	292
% 14	69–69	Checksum (modulo 10)	7
fid   = fopen('TLE.txt');
line = textscan(fid, '%s%s%s%s%s%s%s%s%s');
fclose(fid);

% 1 41783U 16059A   17335.74099121  .00000091  00000-0  27045-4 0  9998
% 2 41783  98.1467  35.1949 0033441 357.6842   2.4199 14.62883771 63091
% line{1}{1}
% line{2}{1}
% line{3}{1}
EpoachYear = (str2num(line{4}{1})- mod(str2num(line{4}{1}),1000))/1000
Epoach = mod(str2num(line{4}{1}),1000)
 SGPDrag1 =str2num(line{5}{1}) %% line 4 epoach first two out of 14 include decimal decimal after 5 
SGPDrag2 =  str2num(line{6}{1}(1:(end-3)))*10^(-str2num(line{6}{1}(end)))
BSTARDrag = str2num(line{7}{1}(1:(end-3)))*10^(-str2num(line{7}{1}(end)))
EphemerisType =line{8}{1}
ElementSetNo = (str2num(line{9}{1})- mod(str2num(line{9}{1}),10))/10
CheckSum1 = mod(str2num(line{9}{1}),10)
% 1	01–01	Line number	2
% 2	03–07	Satellite number	25544
% 3	09–16	Inclination (degrees)	51.6416
% 4	18–25	Right ascension of the ascending node (degrees)	247.4627
% 5	27–33	Eccentricity (decimal point assumed)	0006703
% 6	35–42	Argument of perigee (degrees)	130.5360
% 7	44–51	Mean Anomaly (degrees)	325.0288
% 8	53–63	Mean Motion (revolutions per day)	15.72125391
% 9	64–68	Revolution number at epoch (revolutions)	56353
% 10	69–69	Checksum (modulo 10)	7
% line{1}{2}
% line{2}{2}
Inclination = line{3}{2}
RAAN= line{4}{2}
Ecc =str2num(strcat('0.',char(line{5}{2})))
ArgPerigee =line{6}{2}
 MeanAnamoly= line{7}{2}
MeanMotion =line{8}{2}
RevNo = (str2num(line{9}{2})- mod(str2num(line{9}{2}),10))/10
CheckSum2 = mod(str2num(line{9}{2}),10)

