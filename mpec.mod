# MPEC Formulation
# note that presumer's variables are sell (zs >=0) and buy (zb>=0)
 

 
###############################################################################
# Sets used to define the problem                                             #
###############################################################################

set F;						# Firms

set I ordered;				# Nodes in the network
set Iz within I := 2..24;

set J ordered;
set K;						# within I cross I;
							# Arcs (interfaces) in the transmission network
set P;						# Plants
set H{F,I} within P;		# Set of Plants for firm F at node I
set M;						# set of technologies owned by presumer
set N{I} within M;			# set of technologies own by presumer in i


###############################################################################
# Parameters                                                                  #
###############################################################################
param p0{I};			# vertical intercept
param q0{I};			# horizontal intercept
param p2{I};			# vertical intercept of presumers
param q2{I};			# horizontal intercept  of presumers
param PTDF{K, I}; 		# PTDF matrix
param b0{P};			# constant term in supply curve
param b1{P};			# slope term in supply curve
param cap{P};			# gen cap
param Tcap{K};			# transmission cap
param cc;				# cap coverage index
param st{I};			# strategy index of presumer
param stf{F};			# strategy index of firms
param co2{I};
param tau{I};			# adjusting prosumer marginal benefit of consumption


###############################################################################
# prosumer parameters														  #
###############################################################################
param pcap{M};			# production capacity owned by prosumer
param pmc0{M};			# prosumer marginal production cost
param pmc1{M};			# prosumer marginal production cost

param R := 0.9;				# Prosumer risk tolerance
#param sigma{I};			# standard deviation

###############################################################################
# Variables in the problem                                                    #
###############################################################################
var x{f in F, i in I, h in H[f,i]} >= 0;	# Output of plant
#var w{I};									# Wheeling charge
#var aa{I};									# arbitrage quantity
#var s{f in F, i in I} >=0;					# sales
var y{I};									# injection/withdraw
#var ph;										# hub price
#var a{I};									# arbitrage 

###############################################################################
# prosumer variables:
###############################################################################
var zs{i in I,f in F} >=0;			# sale  of prosumer to wholesale market
var zb{i in I,f in F} >=0;			# buy of prosumer to wholesale market
var delta{I} >=0;		# dual for prosumer min load satisfaction at node i
var g{I} >=0;			# output by dispatchable plants owned by presumer
var l{I} >=0;			# consumption

###############################################################################
# Mutipliers for variational inequality constraints                           #
###############################################################################
#var theta{F};								# dual for mass balanced
var beta{f in F, i in I, h in H[f,i]} >= 0;	# dual for gen capacity constriant
var lambda_up{k in K} >= 0;					# upper transmission limit
var lambda_lo{k in K} >= 0;					# lower transmission limit
#var miu{i in I} >=0;						# dual of sell 
var kappa{i in I} >= 0;						# dual on dispatchable unit

var eps{f in F, i in I, h in H[f,i]} >= 0;	# dual associated with non-negativity of x
var xi{i in I} >= 0;						# dual assoc. w/ non-negativity of d[i]
var eta{i in I};							# dual as price
var theta;									# dual of sum_i y_i = 0
###############################################################################
# Defined variables                                                           #
###############################################################################
var d{i in I};# = sum{f in F} s[f,i]+a[i];#-sum{f in F} zb[i,f];
var p{i in I} = p0[i]- ((p0[i]/q0[i]*d[i])); # price at node i
var mc {f in F, i in I, h in H[f,i]} = b0[h] + 2*b1[h]* (x[f,i,h]);			# Marginal cost 
var mc1{i in I} = pmc0[2] + pmc1[2]*g[i];
var flow {k in K} = sum {i in I} (PTDF[k,i]*y[i]);	 						# Flow definition
var w{i in I} = p[i] - p[13];
var s{f in F, i in I} = sum {h in H[f,i]} x[f,i,h];
var ps{f in F} = (1/1000)*(sum{i in I} (p[i]-w[i])*s[f,i]-sum{i in I, h in H[f,i]} ((b0[h]-w[i])*x[f,i,h]+b1[h]*x[f,i,h]**2));
var psQP{f in F} = (1/1000)*(sum{i in I} (p[i])*s[f,i]-sum{i in I, h in H[f,i]} ((b0[h])*x[f,i,h]+b1[h]*x[f,i,h]**2));
#var ps{f in F} = (sum{i in I} (p[i]-w[i])*s[f,i]-sum{i in I, h in H[f,i]} (x[f,i,h]*b0[h] + (x[f,i,h]^2)*b1[h]))/1000;
#var wps{f in F} = (sum{i in I} (p[i]-w[i])*s[f,i]-sum{i in I, h in H[f,i]} ((mc[f,i,h]-w[i])*x[f,i,h]))/1000;
#var wheelTPS = sum{f in F, i in I, h in H[f,i]}( (p[i] - w[i])*x[f,i,h]) - sum{i in I, f in F, h in H[f,i]} (b0[h]*x[f,i,h] + b1[h]*(x[f,i,h]^2) - w[i]*x[f,i,h]);
#var tps = (1/1000)*(sum{i in I, f in F, h in H[f,i]} (p[i])*x[f,i,h] - sum{i in I, f in F, h in H[f,i]} (b0[h]*x[f,i,h] + b1[h]*(x[f,i,h]^2)));
var cs =  sum{i in I} (p0[i]*d[i] - 0.5*p0[i]/q0[i]*d[i]**2 - p[i]*d[i])/1000;	# consumer surplus
var iso = sum{i in I} w[i]*y[i]/1000;											# iso revenu
#var arb =sum{i in I} a[i]*(p[i]-w[i])/1000;
#var tps = sum{f in F} ps[f]; 
#var producer = sum{f in F, i in I, h in H[f,i]}( eta[i]*x[f,i,h]) - sum{i in I, f in F, h in H[f,i]} b1[h]*x[f,i,h];
var producer = sum{f in F, i in I, h in H[f,i]}( p[i]*x[f,i,h]) - sum{i in I, f in F, h in H[f,i]} (b0[h]*x[f,i,h] + b1[h]*(x[f,i,h]^2));
var sw = cs + iso + sum{f in F} ps[f];# + iso + arb;	
var swqp = cs + sum{f in F}psQP[f];										# social surplus
var ts{i in I}=sum{f in F, h in H[f,i]} x[f,i,h];										# total sales
var totd =sum{i in I} d[i];
var avgp =sum{i in I} (p[i]*d[i])/totd;
#var mb{i in I} = tau[i]*p2[i]-p2[i]/q2[i]*(pcap[1]+g[i]);
var tx{i in I} = sum{f in F, h in H[f,i]} (x[f,i,h]); 
var tzs{i in I} = sum{f in F} zs[i,f];
var tzb{i in I} = sum{f in F} zb[i,f];
var tz{i in I} = tzs[i]- tzb[i];
var sw1 = (sum{i in I} (p0[i]*d[i]-0.5*p0[i]/q0[i]*d[i]**2)-sum{f in F, i in I, h in H[f,i]} (b0[h]*x[f,i,h] + b1[h]*(x[f,i,h]^2)) -tz[1]*p[1])/1000;
#var pres = (sum{i in I} p[i]*(tz[i]) - sum{i in I} (p2[i]*(pcap[1]-l[i])-0.5*p2[i]/q2[i]*(pcap[1]**2-l[i]**2))-pmc0[1]*pcap[1]-sum{i in I}(pmc0[2]*g[i]+0.5*pmc1[2]*g[i]**2))/1000; 		#presumers profit
var pres = (sum{i in I} p[i]*(tz[i]) + sum{i in I} (tau[i]*p2[i]*l[i] - 0.5*(p2[i]/q2[i])*(l[i]^2)) -sum{i in I}(pmc0[2]*g[i]+0.5*pmc1[2]*g[i]**2))/1000; 		#presumers profit
var txt = sum{i in I} tx[i];
var consumer =  sum{i in I} (p0[i]*d[i] - 0.5*p0[i]/q0[i]*d[i]**2 - p[i]*d[i]);	# consumer surplus
var primal =  sum{i in I} ( eta[i]*(tz[i]) + p2[1]*l[i] - (0.5)*(p2[i]/q2[i])*(l[i]^2) - (pmc0[2]*g[i]+0.5*pmc1[2]*g[i]**2));
var swp = primal/1000 + sw;

###############################################################################
# MPEC parameters                                                    		  #
###############################################################################
param M1;
param M2;
param M3;
param M4;
param M5;

###############################################################################
# MPEC parameters                                                    		  #
###############################################################################
#var r1{f in F,i in I} binary;
#var r2{f in F,i in I, h in H[f,i]} binary;
#var r3{f in F,i in I, h in H[f,i]} binary;
#var r4{k in K} binary;
#var r5{k in K} binary;


###############################################################################
# MPEC Model                                                    		  	  #
###############################################################################

maximize rev:
	- sum{i in I, f in F, h in H[f,i]} (mc[f,i,h]*x[f,i,h] + beta[f,i,h]*cap[h]) -
	sum{k in K} (lambda_up[k] + lambda_lo[k])*Tcap[k] + sum{i in I} ( p0[i]*d[i] - (p0[i]/q0[i])*(d[i]^2))
	+ p2[1]*l[1] - (0.5)*(p2[1]/q2[1])*(l[1]^2) - (pmc0[2]*g[1]+0.5*pmc1[2]*g[1]**2);
	
			
	subject to net_energy:
		0.2*pcap[1]*sqrt((1-R)/R) + tz[1] + l[1] - pcap[1] - g[1] <= 0;		# 0.2*pcap ~ sigma
	
	#subject to iz{i in Iz}:
	#	tz[i] = 0;
		
	subject to izs{i in Iz,f in F}:
		zs[i,f]=0;
		
	subject to izb{i in Iz, f in F}:
		zb[i,f]=0;
	
	subject to ramp_cap:
		g[1] <= pcap[2];

	subject to xgrad{f in F, i in I, h in H[f,i]}:
		-mc[f,i,h] - beta[f,i,h] + eps[f,i,h] + eta[i] = 0;
	
	subject to dgrad{i in I}:
		p0[i] - (p0[i]/q0[i])*(d[i]) - eta[i] + xi[i] = 0;
	
	subject to ygrad{i in I}:
		sum{k in K}PTDF[k,i]*(lambda_lo[k] - lambda_up[k]) + eta[i] - theta = 0;	
		
	
	subject to con_Gen_cap{f in F, i in I, h in H[f,i]}:
		0 <= beta[f,i,h] complements x[f,i,h] - cap[h] <= 0;
		
	subject to grid_up{k in K}:
		0 <= lambda_up[k] complements flow[k] - Tcap[k] <= 0;
	
	subject to grid_lo{k in K}:
		0 <= lambda_lo[k] complements - flow[k] - Tcap[k] <= 0;
	
	subject to balance{i in I}:
		y[i] = d[i] - tz[i] - sum{f in F, h in H[f,i]} x[f,i,h];
		
#	subject to floww {i in I}:
#		y[i] - sum{f in F, h in H[f,i]} x[f,i,h] + d[i] = 0;
	
	subject to x_non_negativity{f in F, i in I, h in H[f,i]}:
		0 <= eps[f,i,h] complements -x[f,i,h] <= 0;
		
	subject to d_non_negativity{i in I}:
		0 <= xi[i] complements -d[i] <= 0;
		
	subject to flowbal:
		sum{i in I} y[i] = 0;
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	