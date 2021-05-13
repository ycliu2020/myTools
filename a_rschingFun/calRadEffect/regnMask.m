%%---------------------------------------------------------
% Author       : LYC
% Date         : 2021-05-10 16:22:41
% LastEditors  : Please set LastEditors
% Description  :
% FilePath     : /code/home/liuyc/lib/tools/matlab/myTools/a_rschingFun/calRadEffect/regmMask.m
%
%%---------------------------------------------------------

% mask CHN US EUR
areaStr = {'world', 'china east', 'USA east', 'EUR west'};
latRange = 90;
% world
[dR_cloudMask.world, ~, ~] = maskArea(dR_cloud_sfc, lat_f, latRange, -latRange, 'world');
[dR_residualMask.world, ~, ~] = maskArea(dR_residual_cld_sfc, lat_f, latRange, -latRange, 'world');
[dR_albMask.world, ~, ~] = maskArea(albEffect, lat_f, latRange, -latRange, 'world');
[dR_husMask.world, ~, ~] = maskArea(husEffect, lat_f, latRange, -latRange, 'world');
[dR_taMask.world, ~, ~] = maskArea(taEffect, lat_f, latRange, -latRange, 'world');
[dR_tsMask.world, ~, ~] = maskArea(tsEffect, lat_f, latRange, -latRange, 'world');
[dhfssMask.world, ~, ~] = maskArea(dhfss, lat_f, latRange, -latRange, 'world');
[dhflsMask.world, ~, ~] = maskArea(dhfls, lat_f, latRange, -latRange, 'world');

[drhsMask.world, ~, ~] = maskArea(drhs, lat_f, latRange, -latRange, 'world');
[drhsKernMask.world, ~, ~] = maskArea(drhsKern, lat_f, latRange, -latRange, 'world');
[dlwUPRawDataMask.world, ~, ~] = maskArea(dlwUPRawData, lat_f, latRange, -latRange, 'world');
[dlwUPKernMask.world, ~, ~] = maskArea(dlwUPKern, lat_f, latRange, -latRange, 'world');

% china east
[dR_cloudMask.CHNeast, ~, ~] = maskArea(dR_cloud_sfc, lat_f, latRange, -latRange, 'china east');
[dR_residualMask.CHNeast, ~, ~] = maskArea(dR_residual_cld_sfc, lat_f, latRange, -latRange, 'china east');
[dR_albMask.CHNeast, ~, ~] = maskArea(albEffect, lat_f, latRange, -latRange, 'china east');
[dR_husMask.CHNeast, ~, ~] = maskArea(husEffect, lat_f, latRange, -latRange, 'china east');
[dR_taMask.CHNeast, ~, ~] = maskArea(taEffect, lat_f, latRange, -latRange, 'china east');
[dR_tsMask.CHNeast, ~, ~] = maskArea(tsEffect, lat_f, latRange, -latRange, 'china east');
[dhfssMask.CHNeast, ~, ~] = maskArea(dhfss, lat_f, latRange, -latRange, 'china east');
[dhflsMask.CHNeast, ~, ~] = maskArea(dhfls, lat_f, latRange, -latRange, 'china east');

[drhsMask.CHNeast, ~, ~] = maskArea(drhs, lat_f, latRange, -latRange, 'china east');
[drhsKernMask.CHNeast, ~, ~] = maskArea(drhsKern, lat_f, latRange, -latRange, 'china east');
[dlwUPRawDataMask.CHNeast, ~, ~] = maskArea(dlwUPRawData, lat_f, latRange, -latRange, 'china east');
[dlwUPKernMask.CHNeast, ~, ~] = maskArea(dlwUPKern, lat_f, latRange, -latRange, 'china east');

% US east
[dR_cloudMask.USeast, ~, ~] = maskArea(dR_cloud_sfc, lat_f, latRange, -latRange, 'USA east');
[dR_residualMask.USeast, ~, ~] = maskArea(dR_residual_cld_sfc, lat_f, latRange, -latRange, 'USA east');
[dR_albMask.USeast, ~, ~] = maskArea(albEffect, lat_f, latRange, -latRange, 'USA east');
[dR_husMask.USeast, ~, ~] = maskArea(husEffect, lat_f, latRange, -latRange, 'USA east');
[dR_taMask.USeast, ~, ~] = maskArea(taEffect, lat_f, latRange, -latRange, 'USA east');
[dR_tsMask.USeast, ~, ~] = maskArea(tsEffect, lat_f, latRange, -latRange, 'USA east');
[dhfssMask.USeast, ~, ~] = maskArea(dhfss, lat_f, latRange, -latRange, 'USA east');
[dhflsMask.USeast, ~, ~] = maskArea(dhfls, lat_f, latRange, -latRange, 'USA east');

[drhsMask.USeast, ~, ~] = maskArea(drhs, lat_f, latRange, -latRange, 'USA east');
[drhsKernMask.USeast, ~, ~] = maskArea(drhsKern, lat_f, latRange, -latRange, 'USA east');
[dlwUPRawDataMask.USeast, ~, ~] = maskArea(dlwUPRawData, lat_f, latRange, -latRange, 'USA east');
[dlwUPKernMask.USeast, ~, ~] = maskArea(dlwUPKern, lat_f, latRange, -latRange, 'USA east');

% EUR west
[dR_cloudMask.EURwest, ~, ~] = maskArea(dR_cloud_sfc, lat_f, latRange, -latRange, 'EUR west');
[dR_residualMask.EURwest, ~, ~] = maskArea(dR_residual_cld_sfc, lat_f, latRange, -latRange, 'EUR west');
[dR_albMask.EURwest, ~, ~] = maskArea(albEffect, lat_f, latRange, -latRange, 'EUR west');
[dR_husMask.EURwest, ~, ~] = maskArea(husEffect, lat_f, latRange, -latRange, 'EUR west');
[dR_taMask.EURwest, ~, ~] = maskArea(taEffect, lat_f, latRange, -latRange, 'EUR west');
[dR_tsMask.EURwest, ~, ~] = maskArea(tsEffect, lat_f, latRange, -latRange, 'EUR west');
[dhfssMask.EURwest, ~, ~] = maskArea(dhfss, lat_f, latRange, -latRange, 'EUR west');
[dhflsMask.EURwest, ~, ~] = maskArea(dhfls, lat_f, latRange, -latRange, 'EUR west');

[drhsMask.EURwest, ~, ~] = maskArea(drhs, lat_f, latRange, -latRange, 'EUR west');
[drhsKernMask.EURwest, ~, ~] = maskArea(drhsKern, lat_f, latRange, -latRange, 'EUR west');
[dlwUPRawDataMask.EURwest, ~, ~] = maskArea(dlwUPRawData, lat_f, latRange, -latRange, 'EUR west');
[dlwUPKernMask.EURwest, ~, ~] = maskArea(dlwUPKern, lat_f, latRange, -latRange, 'EUR west');
