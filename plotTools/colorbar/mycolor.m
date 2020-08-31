function [y] = mycolor(x)
%Detailed explanation goes here
%     �÷���colormap(mycols(x))
%           colormap mycols(x)
%     ------------------------------------------------------
%      1��ͷ˫ɫ
%    x=12  �ȽϺÿ�������ɫ/19
%    x=13  �ȽϺÿ�������ɫ(�ް�ɫ��/18
%    x=14  ��ʦ�������õ�ɫ�� /12
%    x=15  ai�ָ�ʪ���ع� /12
%    x=16  л�Ժ���ɫ�� /64
%    x=17  ����ʦѧ�������Ա�/12*2
%    x=18  �Զ���1/5*2
%    x=19  ����ʦ�����ɫ��
%    x=100 soden����ɫ��/ 11(5*2+1)

%    2��ͷ��ɫ���
%    x=21  3����
%    x=22  3�к�
%    x=31  3��(���˹��׵�ɫ��)

%     x=0 define_colors(grads��define_colors49-41 21-29 )   /18
%     1-11��ʾncl������ɫ��        ncolors
%     x=1 BlueDarkRed18           /18
%     x=2 precip_diff_12lev       /12
%     x=3 temp_19lev              /20 ɫ�ʽϺ�
%     x=4 nrl_sirkes              /21
%     x=5 BrownBlue12             /12
%     x=6 rh_19lev                /20
%     x=7 amwg_blueyellowred      /16
%     x=8 GHRSST_anomaly          /42
%     x=9 percent_11lev           /12
%     x=10 radar                  /15
%     x=11 radar_1                /24
%     ------------------------------------------------------
if x==0
    y=[20 100 210;30 110 235;40 130 240;60 150 245;80 165 245;120 185 250;
        150 210 250;180 240 250;225 255 255;255 250 170;255 232 120;255 192 60;
        255 160 0;255 96 0;255 50 0;225 20 0;192 0 0;165 0 0]/255;
elseif x==1
    y=[   36       0     216
        24      28     247
        40      87     255
        61     135     255
        86     176     255
        117     211     255
        153     234     255
        188     249     255
        234     255     255
        255     255     234
        255     241     188
        255     214     153
        255     172     117
        255     120      86
        255      61      61
        247      39      53
        216      21      47
        165       0      33]/255;
elseif x==2
    y=[205 133 63;225 165 100;246 205 132;246 224 158;255 246 186;255 255 255;
        205 255 205;153 240 178;83 189 159;110 170 200;5 112 176;2 56 88]/255;
elseif x==3
    y=[6 30 70; 6 47 107;7 82 156; 33 113 181;66 146 199;90 160 205;120 191 214;
        170 220 230; 219 246 255; 240 252 255;255 240 246;255 224 224;252 187 170;
        252 146 114;251 106 74;240 60 43;204 24 30;166 15 19;120 9 15;95 0 0]/255;
elseif x==4
    y=[0 97 128;0 128 161;0 161 191;0 191 224;0 224 255;0 255 255;51 252 252;102 252 252;
        153 252 252;204 252 252;255 255 255;252 252 0;252 224 0;255 194 1;252 161 0;252 128 0;
        252 97 0;252 64 0;245 18 0;191 0 0;128 0 0]/255;
elseif x==5
    y=[51 25 0;102 47 0;153 96 53;204 155 122;216 175 151;242 218 205;204 253 255;
        153 249 255;101 239 255;50 227 255;0 169 204;0 122 153]/255;
elseif x==6
    y=[254 254 254;254 254 160;254 254 99;244 244 110;255 210 35;255 163 25;255 89 25;230 122 101;
        237 145 124;239 178 146;248 199 178;255 230 230;215 225 255;150 210 255;30 189 255;19 159 255;
        9 108 240;11 116 255;9 104 200;0 89 159]/255;
elseif x==7
    y=[130 31 240;0 0 150;0 0 205;65 105 225;30 144 255;0 191 255;160 210 255;210 246 255;
        255 255 200;255 225 50;255 170 0;255 110 0;255 0 0;200 0 0;160 35 35;255 105 180]/255;
elseif x==8
    y=[ 107           0         219
        122           0         213
        138           0         208
        156           0         201
        131          24         209
        85          60         225
        39          97         241
        0         133         255
        0         169         255
        0         211         255
        0         247         255
        29         255         226
        65         255         190
        102         255         154
        133         255         131
        154         255         141
        173         255         150
        191         255         159
        192         238         168
        191         220         177
        191         202         186
        202         202         183
        220         220         168
        238         238         154
        255         254         137
        255         236          97
        255         218          58
        255         197          11
        255         179           0
        255         161           0
        255         142           0
        255         120           0
        255          84           0
        255          41           0
        255           5           0
        246           0          37
        236           0          79
        227           0         122
        211           0         135
        180           0          85
        154           0          43
        128           0           0 ]/255;
elseif x==9
    y=[100   0 150
        39  48 215
        89 141 252
        139 239 217
        96 207 145
        26 152  80
        145 207  96
        217 239 139
        254 224 139
        252 141  89
        215  48  39
        150   0 100 ]/255;
elseif x==10
    y=[    0  255  255
        0  157  255
        0    0  255
        9  130  175
        0  255    0
        8  175   20
        255  214    0
        255  152    0
        255    0    0
        221    0   27
        188    0   54
        121    0  109
        121   51  160
        195  163  212
        255  255  255  ]/255;
elseif x==11
    y=[ 178 248 255
        178 184 255
        125  37 205
        84  26 139
        237 230 133
        205 198 115
        150 150 150
        255 255 255
        170 255 255
        85 160 255
        29   0 255
        126 229  91
        78 204  67
        46 178  57
        30 153  61
        255 255 102
        255 204 102
        255 136  76
        255  25  25
        204  61  61
        165  49  49
        237   0 237
        137 103 205
        250 240 230 ]/255;
elseif x==12
    y=[0.0627450980392157,0.164705882352941,0.294117647058824;0.0705882352941177,0.274509803921569,0.513725490196078;0.0274509803921569,0.333333333333333,0.576470588235294;0.0705882352941177,0.407843137254902,0.658823529411765;0.0666666666666667,0.419607843137255,0.670588235294118;0.176470588235294,0.501960784313726,0.729411764705882;0.290196078431373,0.564705882352941,0.752941176470588;0.458823529411765,0.682352941176471,0.819607843137255;0.635294117647059,0.745098039215686,0.850980392156863;1,1,1;0.968627450980392,0.949019607843137,0.615686274509804;0.949019607843137,0.705882352941177,0.423529411764706;0.933333333333333,0.600000000000000,0.349019607843137;0.898039215686275,0.513725490196078,0.317647058823529;0.870588235294118,0.352941176470588,0.196078431372549;0.835294117647059,0.243137254901961,0.156862745098039;0.776470588235294,0.129411764705882,0.156862745098039;0.662745098039216,0.117647058823529,0.137254901960784;0.309803921568627,0.0941176470588235,0.109803921568627];
elseif x==13
    y=[0.0627450980392157,0.164705882352941,0.294117647058824;0.0705882352941177,0.274509803921569,0.513725490196078;0.0274509803921569,0.333333333333333,0.576470588235294;0.0705882352941177,0.407843137254902,0.658823529411765;0.0666666666666667,0.419607843137255,0.670588235294118;0.176470588235294,0.501960784313726,0.729411764705882;0.290196078431373,0.564705882352941,0.752941176470588;0.458823529411765,0.682352941176471,0.819607843137255;0.635294117647059,0.745098039215686,0.850980392156863;0.968627450980392,0.949019607843137,0.615686274509804;0.949019607843137,0.705882352941177,0.423529411764706;0.933333333333333,0.600000000000000,0.349019607843137;0.898039215686275,0.513725490196078,0.317647058823529;0.870588235294118,0.352941176470588,0.196078431372549;0.835294117647059,0.243137254901961,0.156862745098039;0.776470588235294,0.129411764705882,0.156862745098039;0.662745098039216,0.117647058823529,0.137254901960784;0.309803921568627,0.0941176470588235,0.109803921568627];
elseif x==14
    y=[0.992156862745098,0.156862745098039,0.164705882352941;0.996078431372549,0.298039215686275,0.301960784313725;0.976470588235294,0.447058823529412,0.419607843137255;0.984313725490196,0.647058823529412,0.647058823529412;0.996078431372549,0.898039215686275,0.898039215686275;0.878431372549020,0.901960784313726,1;0.737254901960784,0.733333333333333,1;0.600000000000000,0.607843137254902,0.992156862745098;0.450980392156863,0.450980392156863,1;0.0117647058823529,0,0.992156862745098];
elseif x==141
    y=[9.6862745e-01   0.0000000e+00   0.0000000e+00
        1.0000000e+00   2.9411765e-01   2.9411765e-01
        9.8823529e-01   4.1960784e-01   4.5882353e-01
        9.8823529e-01   6.0000000e-01   6.1960784e-01
        9.8039216e-01   7.3725490e-01   7.4509804e-01
        9.9607843e-01   9.0588235e-01   9.0196078e-01
        8.8627451e-01   9.0196078e-01   9.9607843e-01
        7.6470588e-01   7.5294118e-01   1.0000000e+00
        6.0784314e-01   5.9607843e-01   1.0000000e+00
        4.5490196e-01   4.5882353e-01   1.0000000e+00
        3.0196078e-01   2.9411765e-01   1.0000000e+00
        1.1764706e-02   0.0000000e+00   9.9215686e-01];
elseif x==142%ֻ�к�ɫ
    y=[9.6862745e-01   0.0000000e+00   0.0000000e+00
        1.0000000e+00   2.9411765e-01   2.9411765e-01
        9.8823529e-01   4.1960784e-01   4.5882353e-01
        9.8823529e-01   6.0000000e-01   6.1960784e-01
        9.8039216e-01   7.3725490e-01   7.4509804e-01
        9.9607843e-01   9.0588235e-01   9.0196078e-01];
elseif x==143%ֻ����ɫ
    y=[
        8.8627451e-01   9.0196078e-01   9.9607843e-01
        7.6470588e-01   7.5294118e-01   1.0000000e+00
        6.0784314e-01   5.9607843e-01   1.0000000e+00
        4.5490196e-01   4.5882353e-01   1.0000000e+00
        3.0196078e-01   2.9411765e-01   1.0000000e+00
        1.1764706e-02   0.0000000e+00   9.9215686e-01];
elseif x==21
    y=[6 30 70; 6 47 107;7 82 156; 33 113 181;66 146 199;90 160 205;120 191 214;
        170 220 230; 219 246 255; 240 252 255]/255;
elseif x==22
    y=[255 240 246;255 224 224;252 187 170;
        252 146 114;251 106 74;240 60 43;204 24 30;166 15 19;120 9 15;95 0 0]/255;
elseif x==31
    y=[90 160 205;120 191 214;
        170 220 230; 219 246 255; 240 252 255;255 240 246;255 224 224;252 187 170;
        252 146 114;251 106 74;240 60 43;204 24 30;166 15 19;120 9 15;95 0 0]/255;
elseif x==33
    y=[ 7 82 156;33 113 181;120 191 214;
        170 220 230; 219 246 255; 255 224 224;
        252 146 114;251 106 74;240 60 43;204 24 30]/255;
    %         y=[6 30 70; 6 47 107;7 82 156; 33 113 181;66 146 199;90 160 205;120 191 214;
    %         170 220 230; 219 246 255; 240 252 255;255 240 246;255 224 224;252 187 170;
    %         252 146 114;251 106 74;240 60 43;204 24 30;166 15 19;120 9 15;95 0 0]/255;
    %ǰ������ɫ�������Ǻ�ɫ
elseif x==32
    y=[6 30 70; 6 47 107;7 82 156; 33 113 181;66 146 199;90 160 205;120 191 214;
        170 220 230; 219 246 255; 240 252 255;255 240 246;255 224 224;252 187 170;
        252 146 114;251 106 74;240 60 43;204 24 30;166 15 19;120 9 15]/255;
elseif x==15
    y=[120 191 214;
        219 246 255;255 224 224;
        240 60 43;]/255;
    
    % elseif x==16
    %     y=[120 191 214;
    %         255 224 224;
    %         240 60 43;]/255;
elseif x==16
    y=[0.242200002074242,0.150399997830391,0.660300016403198;0.270000010728836,0.180000007152557,0.670000016689301;0.289999991655350,0.209999993443489,0.680000007152557;0.314482748508453,0.237241372466087,0.691034495830536;0.338965505361557,0.264482766389847,0.702068984508514;0.363448262214661,0.291724145412445,0.713103473186493;0.387931019067764,0.318965524435043,0.724137961864471;0.412413775920868,0.346206903457642,0.735172450542450;0.436896532773972,0.373448282480240,0.746206879615784;0.461379289627075,0.400689661502838,0.757241368293762;0.485862076282501,0.427931040525436,0.768275856971741;0.510344803333283,0.455172419548035,0.779310345649719;0.534827589988709,0.482413798570633,0.790344834327698;0.559310317039490,0.509655177593231,0.801379323005676;0.583793103694916,0.536896526813507,0.812413811683655;0.608275830745697,0.564137935638428,0.823448300361633;0.632758617401123,0.591379284858704,0.834482789039612;0.657241344451904,0.618620693683624,0.845517277717590;0.681724131107330,0.645862042903900,0.856551706790924;0.706206917762756,0.673103451728821,0.867586195468903;0.730689644813538,0.700344800949097,0.878620684146881;0.755172431468964,0.727586209774017,0.889655172824860;0.779655158519745,0.754827558994293,0.900689661502838;0.804137945175171,0.782068967819214,0.911724150180817;0.828620672225952,0.809310317039490,0.922758638858795;0.853103458881378,0.836551725864410,0.933793127536774;0.877586185932159,0.863793075084686,0.944827616214752;0.902068972587585,0.891034483909607,0.955862045288086;0.926551699638367,0.918275833129883,0.966896533966065;0.951034486293793,0.945517241954804,0.977931022644043;0.975517213344574,0.972758591175079,0.988965511322022;1,1,1;
        0.995312511920929,0.979062497615814,0.971875011920929;0.990625023841858,0.958124995231628,0.943750023841858;0.985937476158142,0.937187492847443,0.915624976158142;0.981249988079071,0.916249990463257,0.887499988079071;0.976562500000000,0.895312488079071,0.859375000000000;0.971875011920929,0.874374985694885,0.831250011920929;0.967187523841858,0.853437483310700,0.803125023841858;0.962499976158142,0.832499980926514,0.774999976158142;0.957812488079071,0.811562478542328,0.746874988079071;0.953125000000000,0.790624976158142,0.718750000000000;0.948437511920929,0.769687533378601,0.690625011920929;0.943750023841858,0.748750030994415,0.662500023841858;0.939062535762787,0.727812528610230,0.634374976158142;0.934374988079071,0.706875026226044,0.606249988079071;0.929687500000000,0.685937523841858,0.578125000000000;0.925000011920929,0.665000021457672,0.550000011920929;0.920312523841858,0.644062519073486,0.521875023841858;0.915625035762787,0.623125016689301,0.493750005960465;0.910937488079071,0.602187514305115,0.465624988079071;0.906250000000000,0.581250011920929,0.437500000000000;0.901562511920929,0.560312509536743,0.409375011920929;0.896875023841858,0.539375007152557,0.381249994039536;0.892187535762787,0.518437504768372,0.353125005960465;0.887500047683716,0.497500002384186,0.324999988079071;0.882812500000000,0.476562500000000,0.296875000000000;0.878125011920929,0.455624997615814,0.268750011920929;0.873437523841858,0.434687525033951,0.240624994039536;0.868750035762787,0.413750022649765,0.212500005960464;0.864062547683716,0.392812520265579,0.184375002980232;0.859375000000000,0.371875017881393,0.156250000000000;0.854687511920929,0.350937515497208,0.128124997019768;0.850000023841858,0.330000013113022,0.100000001490116];
    
elseif x==17
    y=[72,60,200; 128,112,235; 192,180,255; 60,150,245; 120,185,250; 180,240,250;
    180,250,170; 120,245,115; 55,210,60; 255,250,170; 255,192,60; 255,96,0]/255;
elseif x==18
    y=[72,60,200; 128,112,235; 60,150,245; 120,185,250; 180,240,250;
     255,250,170; 235,230,43; 255,163,10; 255,96,0; 198,33,40] /255;
elseif x==100
    y=[119,26,151; 100,17,158; 70,54,151; 112,152,208; 139,208,205; 180,240,250; 255,250,170;
    180,214,43; 229,224,61; 221,133,52; 202,76,64; 197,27,131] /255;
    
else
    y=[1 1 1];
end
end
