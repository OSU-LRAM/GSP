function loc_conn = LegCube_SO3_loc_conn(in1,in2)
%LEGCUBE_SO3_LOC_CONN
%    LOC_CONN = LEGCUBE_SO3_LOC_CONN(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 6.1.
%    05-Dec-2015 17:44:42

leg1_th_y = in2(1,:);
leg2_th_y = in2(2,:);
t2 = sin(leg1_th_y);
t3 = cos(leg1_th_y);
t4 = sin(leg2_th_y);
t5 = cos(leg2_th_y);
t6 = t2.^2;
t7 = t4.^2;
t8 = t6.^2;
t9 = t3.^2;
t10 = t5.^2;
t11 = t9.^2;
t12 = t10.^2;
t13 = t7.^2;
t14 = t9.*6.909612e6;
t15 = t10.*6.909612e6;
t16 = t11.*2.2815e5;
t17 = t12.*2.2815e5;
t18 = t9.*t11.*7.02e2;
t19 = t10.*t12.*7.02e2;
t20 = t6.*7.599714e6;
t21 = t7.*7.599714e6;
t22 = t8.*2.29959e5;
t23 = t13.*2.29959e5;
t24 = t6.*t8.*7.29e2;
t25 = t7.*t13.*7.29e2;
t26 = t3.*t5.*t10.*2.646e3;
t27 = t3.*t5.*t9.*2.646e3;
t28 = t2.*t4.*t7.*6.48e2;
t29 = t2.*t4.*t6.*6.48e2;
t30 = t9.*t10.*4.63086e5;
t31 = t9.*t12.*2.457e3;
t32 = t10.*t11.*2.457e3;
t33 = t6.*t9.*4.58109e5;
t34 = t7.*t9.*4.93227e5;
t35 = t6.*t10.*4.93227e5;
t36 = t8.*t9.*2.16e3;
t37 = t7.*t10.*4.58109e5;
t38 = t6.*t11.*2.133e3;
t39 = t9.*t13.*2.511e3;
t40 = t8.*t10.*2.511e3;
t41 = t7.*t11.*2.592e3;
t42 = t6.*t12.*2.592e3;
t43 = t10.*t13.*2.16e3;
t44 = t7.*t12.*2.133e3;
t45 = t6.*t7.*4.66488e5;
t46 = t6.*t13.*2.43e3;
t47 = t7.*t8.*2.43e3;
t48 = t3.*t5.*4.1508e4;
t49 = t6.*t7.*t9.*5.022e3;
t50 = t6.*t7.*t10.*5.022e3;
t51 = t3.*t5.*t6.*3.078e3;
t52 = t3.*t5.*t7.*3.078e3;
t53 = t2.*t4.*t9.*2.16e2;
t54 = t2.*t3.*t4.*t7.*2.16e2;
t55 = t2.*t4.*t10.*2.16e2;
t56 = t2.*t4.*t5.*t6.*2.16e2;
t57 = t2.*t3.*t4.*2.8008e4;
t58 = t2.*t4.*t5.*2.8008e4;
t59 = t6.*t9.*t10.*4.968e3;
t60 = t7.*t9.*t10.*4.968e3;
t61 = t2.*t3.*t4.*t10.*1.08e3;
t62 = t2.*t4.*t5.*t9.*1.08e3;
t65 = t3.*1.7736e6;
t66 = t5.*1.7736e6;
t67 = t2.*t4.*6.696e3;
t68 = t3.*t9.*1.63656e5;
t69 = t5.*t10.*1.63656e5;
t70 = t3.*t11.*3.024e3;
t71 = t5.*t12.*3.024e3;
t72 = t3.*t10.*1.7658e5;
t73 = t5.*t9.*1.7658e5;
t74 = t3.*t12.*3.726e3;
t75 = t5.*t11.*3.726e3;
t76 = t3.*t6.*1.74564e5;
t77 = t3.*t7.*2.1528e5;
t78 = t5.*t6.*2.1528e5;
t79 = t3.*t8.*3.024e3;
t80 = t5.*t7.*1.74564e5;
t81 = t3.*t13.*3.726e3;
t82 = t5.*t8.*3.726e3;
t83 = t5.*t13.*3.024e3;
t84 = t5.*t9.*t10.*6.858e3;
t85 = t3.*t9.*t10.*6.858e3;
t86 = t3.*t6.*t9.*6.048e3;
t87 = t3.*t7.*t9.*7.506e3;
t88 = t5.*t6.*t10.*7.506e3;
t89 = t5.*t7.*t10.*6.048e3;
t90 = t3.*t6.*t10.*7.29e3;
t91 = t5.*t6.*t9.*7.452e3;
t92 = t3.*t7.*t10.*7.452e3;
t93 = t5.*t7.*t9.*7.29e3;
t94 = t3.*t6.*t7.*7.074e3;
t95 = t5.*t6.*t7.*7.074e3;
t96 = t2.*t3.*t4.*t5.*t7.*2.16e2;
t97 = t2.*t3.*t4.*t5.*t6.*2.16e2;
t98 = t2.*t3.*t4.*t5.*t10.*2.16e2;
t99 = t2.*t3.*t4.*t5.*t9.*2.16e2;
t100 = t2.*t3.*t4.*t5.*5.688e4;
t63 = t14+t15+t16+t17+t18+t19+t20+t21+t22+t23+t24+t25+t26+t27+t28+t29+t30+t31+t32+t33+t34+t35+t36+t37+t38+t39+t40+t41+t42+t43+t44+t45+t46+t47+t48+t49+t50+t51+t52+t53+t54+t55+t56+t57+t58+t59+t60+t61+t62-t65-t66-t67-t68-t69-t70-t71-t72-t73-t74-t75-t76-t77-t78-t79-t80-t81-t82-t83-t84-t85-t86-t87-t88-t89-t90-t91-t92-t93-t94-t95-t96-t97-t98-t99-t100+5.45032e7;
t64 = 1.0./t63;
t101 = t2.*t4.*9.84e2;
t102 = t9.*t10.*6.381e3;
t103 = t6.*t7.*6.21e3;
t104 = t3.*t5.*4.518e3;
t105 = t2.*t4.*t9.*3.6e1;
t106 = t2.*t4.*t5.*t6.*1.8e1;
t107 = t2.*t3.*t4.*t7.*1.8e1;
t108 = t2.*t4.*t10.*3.6e1;
loc_conn = reshape([t64.*(t2.*7.36e4+t4.*3.6e3-t2.*t3.*1.704e3-t2.*t5.*1.254e3-t3.*t4.*1.704e3+t2.*t6.*7.449e3+t2.*t7.*7.503e3-t4.*t5.*5.4e1+t2.*t8.*2.7e1+t4.*t6.*3.24e2+t2.*t9.*7.458e3+t4.*t7.*3.78e2+t2.*t10.*5.286e3+t2.*t11.*1.8e1+t4.*t9.*2.16e2+t2.*t12.*1.8e1+t4.*t10.*3.78e2+t2.*t13.*2.7e1+t2.*t3.*t5.*1.44e2-t2.*t3.*t7.*1.26e2+t3.*t4.*t5.*2.244e3-t2.*t5.*t6.*1.26e2-t3.*t4.*t6.*5.4e1-t2.*t5.*t7.*1.08e2-t3.*t4.*t7.*7.2e1-t2.*t3.*t10.*1.08e2+t2.*t6.*t7.*6.3e1+t4.*t5.*t6.*5.4e1-t2.*t5.*t9.*1.44e2-t3.*t4.*t9.*3.6e1-t4.*t5.*t7.*5.4e1-t2.*t5.*t10.*7.2e1+t2.*t6.*t9.*4.5e1-t3.*t4.*t10.*1.08e2+t2.*t6.*t10.*5.4e1+t2.*t7.*t9.*7.2e1+t4.*t5.*t9.*3.6e1+t2.*t7.*t10.*4.5e1-t4.*t5.*t10.*5.4e1+t2.*t9.*t10.*6.3e1+t3.*t4.*t5.*t7.*1.8e1+t3.*t4.*t5.*t10.*1.8e1).*6.0,t64.*(t3.*-1.556e5-t5.*1.44e4+t6.*1.13694e5+t7.*1.14894e5+t8.*3.033e3+t9.*1.04268e5+t10.*1.03986e5+t11.*3.186e3+t12.*3.159e3+t13.*3.159e3+t101+t102+t103+t104+t105+t106-t3.*t6.*1.9026e4-t3.*t7.*2.163e4-t3.*t8.*4.68e2-t5.*t6.*1.422e3-t3.*t9.*1.7208e4-t5.*t7.*9.72e2-t3.*t10.*1.9398e4-t3.*t11.*4.68e2-t5.*t9.*9.72e2-t3.*t12.*5.85e2-t5.*t10.*9.72e2+t6.*t9.*6.219e3-t3.*t13.*5.67e2+t6.*t10.*6.678e3+t7.*t9.*6.921e3+t7.*t10.*6.318e3+t2.*t3.*t4.*4.86e2+t2.*t4.*t5.*4.14e2+t2.*t4.*t6.*1.08e2+t2.*t4.*t7.*1.26e2+t3.*t5.*t6.*3.33e2+t3.*t5.*t7.*2.97e2+t2.*t4.*t10.*1.26e2-t3.*t6.*t7.*1.071e3+t3.*t5.*t9.*2.61e2+t3.*t5.*t10.*2.97e2-t3.*t6.*t9.*9.36e2-t3.*t6.*t10.*1.125e3-t3.*t7.*t9.*1.143e3-t3.*t7.*t10.*1.152e3-t3.*t9.*t10.*1.053e3-t2.*t3.*t4.*t5.*1.008e3-t2.*t4.*t5.*t7.*1.8e1+t2.*t4.*t5.*t9.*1.62e2-t2.*t4.*t5.*t10.*1.8e1+8.472e5).*3.0,t64.*(t3.*2.59808e5+t5.*1.2708e4+t6.*4.146e3-t7.*6.462e3+t8.*2.25e2-t9.*1.8e2-t10.*6.57e3+t11.*2.34e2-t12.*3.51e2-t13.*2.43e2-t105+t106-t2.*t4.*2.316e3-t3.*t5.*1.0986e4+t3.*t6.*1.4262e4+t3.*t7.*1.2162e4+t3.*t8.*1.8e1+t5.*t6.*3.96e2+t3.*t9.*1.428e4+t5.*t7.*8.1e2+t3.*t10.*1.6686e4+t5.*t9.*7.38e2+t3.*t12.*1.17e2+t5.*t10.*8.1e2+t6.*t9.*4.59e2+t3.*t13.*8.1e1+t6.*t10.*1.08e2-t7.*t9.*2.25e2-t7.*t10.*5.94e2-t9.*t10.*1.53e2+t2.*t3.*t4.*2.7e2+t2.*t4.*t5.*4.47e3-t2.*t4.*t7.*1.8e1-t3.*t5.*t6.*3.15e2-t3.*t5.*t7.*3.15e2-t2.*t4.*t10.*9.0e1+t3.*t6.*t7.*9.9e1-t3.*t5.*t9.*3.51e2-t3.*t5.*t10.*3.87e2+t3.*t6.*t9.*1.8e1+t3.*t6.*t10.*9.9e1+t3.*t7.*t9.*1.17e2+t3.*t7.*t10.*1.98e2+t3.*t9.*t10.*1.17e2-t2.*t3.*t4.*t5.*3.6e1+t2.*t4.*t5.*t7.*1.8e1+t2.*t4.*t5.*t9.*1.8e1+t2.*t4.*t5.*t10.*1.8e1).*3.0,t64.*(t2.*3.6e3+t4.*7.36e4-t2.*t3.*5.4e1-t2.*t5.*1.704e3-t3.*t4.*1.254e3+t2.*t6.*3.78e2+t2.*t7.*3.24e2-t4.*t5.*1.704e3+t4.*t6.*7.503e3+t2.*t9.*3.78e2+t4.*t7.*7.449e3+t2.*t10.*2.16e2+t4.*t8.*2.7e1+t4.*t9.*5.286e3+t4.*t10.*7.458e3+t4.*t11.*1.8e1+t4.*t12.*1.8e1+t4.*t13.*2.7e1+t2.*t3.*t5.*2.244e3-t2.*t3.*t6.*5.4e1+t2.*t3.*t7.*5.4e1+t3.*t4.*t5.*1.44e2-t2.*t5.*t6.*7.2e1-t3.*t4.*t6.*1.08e2-t2.*t3.*t9.*5.4e1-t2.*t5.*t7.*5.4e1-t3.*t4.*t7.*1.26e2+t2.*t3.*t10.*3.6e1-t4.*t5.*t6.*1.26e2-t2.*t5.*t9.*1.08e2-t3.*t4.*t9.*7.2e1-t2.*t5.*t10.*3.6e1-t3.*t4.*t10.*1.44e2+t4.*t6.*t7.*6.3e1-t4.*t5.*t9.*1.08e2+t4.*t6.*t9.*4.5e1+t4.*t6.*t10.*7.2e1+t4.*t7.*t9.*5.4e1+t4.*t7.*t10.*4.5e1+t4.*t9.*t10.*6.3e1+t2.*t3.*t5.*t6.*1.8e1+t2.*t3.*t5.*t9.*1.8e1).*-6.0,t64.*(t3.*-1.44e4-t5.*1.556e5+t6.*1.14894e5+t7.*1.13694e5+t8.*3.159e3+t9.*1.03986e5+t10.*1.04268e5+t11.*3.159e3+t12.*3.186e3+t13.*3.033e3+t101+t102+t103+t104+t107+t108-t3.*t6.*9.72e2-t3.*t7.*1.422e3-t5.*t6.*2.163e4-t3.*t9.*9.72e2-t5.*t7.*1.9026e4-t3.*t10.*9.72e2-t5.*t8.*5.67e2-t5.*t9.*1.9398e4-t5.*t10.*1.7208e4+t6.*t9.*6.318e3-t5.*t11.*5.85e2+t6.*t10.*6.921e3+t7.*t9.*6.678e3-t5.*t12.*4.68e2+t7.*t10.*6.219e3-t5.*t13.*4.68e2+t2.*t3.*t4.*4.14e2+t2.*t4.*t5.*4.86e2+t2.*t4.*t6.*1.26e2+t2.*t4.*t7.*1.08e2+t3.*t5.*t6.*2.97e2+t2.*t4.*t9.*1.26e2+t3.*t5.*t7.*3.33e2+t3.*t5.*t9.*2.97e2+t3.*t5.*t10.*2.61e2-t5.*t6.*t7.*1.071e3-t5.*t6.*t9.*1.152e3-t5.*t6.*t10.*1.143e3-t5.*t7.*t9.*1.125e3-t5.*t7.*t10.*9.36e2-t5.*t9.*t10.*1.053e3-t2.*t3.*t4.*t5.*1.008e3-t2.*t3.*t4.*t6.*1.8e1-t2.*t3.*t4.*t9.*1.8e1+t2.*t3.*t4.*t10.*1.62e2+8.472e5).*3.0,t64.*(t3.*1.2708e4+t5.*2.59808e5-t6.*6.462e3+t7.*4.146e3-t8.*2.43e2-t9.*6.57e3-t10.*1.8e2-t11.*3.51e2+t12.*2.34e2+t13.*2.25e2+t107-t108-t2.*t4.*2.316e3-t3.*t5.*1.0986e4+t3.*t6.*8.1e2+t3.*t7.*3.96e2+t5.*t6.*1.2162e4+t3.*t9.*8.1e2+t5.*t7.*1.4262e4+t3.*t10.*7.38e2+t5.*t8.*8.1e1+t5.*t9.*1.6686e4+t5.*t10.*1.428e4-t6.*t9.*5.94e2+t5.*t11.*1.17e2-t6.*t10.*2.25e2+t7.*t9.*1.08e2+t7.*t10.*4.59e2+t5.*t13.*1.8e1-t9.*t10.*1.53e2+t2.*t3.*t4.*4.47e3+t2.*t4.*t5.*2.7e2-t2.*t4.*t6.*1.8e1-t3.*t5.*t6.*3.15e2-t2.*t4.*t9.*9.0e1-t3.*t5.*t7.*3.15e2-t3.*t5.*t9.*3.87e2-t3.*t5.*t10.*3.51e2+t5.*t6.*t7.*9.9e1+t5.*t6.*t9.*1.98e2+t5.*t6.*t10.*1.17e2+t5.*t7.*t9.*9.9e1+t5.*t7.*t10.*1.8e1+t5.*t9.*t10.*1.17e2-t2.*t3.*t4.*t5.*3.6e1+t2.*t3.*t4.*t6.*1.8e1+t2.*t3.*t4.*t9.*1.8e1+t2.*t3.*t4.*t10.*1.8e1).*-3.0],[3, 2]);
