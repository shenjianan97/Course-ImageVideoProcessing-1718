% Commands for exercises 1-6

%%%%% 1b
LENA_YUV = BUPT_format_converter(LENA_RGB);
LENA_RGB2 = BUPT_format_converter(LENA_YUV, 'inverse');
% pgmwrite(LENA_YUV(:,:,1), l, 1, '1b_LENA');
% ppmwrite(LENA_RGB2, l, 0, '1b_LENA_recovered');

BABOON_YUV = BUPT_format_converter(BABOON_RGB);
BABOON_RGB2 = BUPT_format_converter(BABOON_YUV, 'inverse');
% pgmwrite(BABOON_YUV(:,:,1), l, 0, '1b_BABOON');


%%%%% 1c
LENA_grey_sub1 = BUPT_subsample(LENA_grey, 2, 1);
LENA_grey_sub2 = BUPT_subsample(LENA_grey, 1, 2);
LENA_grey_sub3 = BUPT_subsample(LENA_grey, 8, 2);
LENA_grey_sub4 = BUPT_subsample(LENA_grey, 4, 4);
% pgmwrite(LENA_grey_sub1, l, 0, '1c_LENA_subsample2by1');
% pgmwrite(LENA_grey_sub2, l, 0, '1c_LENA_subsample1by2');
% pgmwrite(LENA_grey_sub3, l, 0, '1c_LENA_subsample8by2');
% pgmwrite(LENA_grey_sub4, l, 0, '1c_LENA_subsample4by4');



