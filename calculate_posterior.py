#!/usr/bin/python

import math
import numpy as np
import operator
import scipy.stats as stats 
from matplotlib import pyplot as plt
import sys

infile = open("LWJ_293T_BE3_bulk_" + sys.argv[1] + ".nobed.pileup")
# infile = open("LWJ_seriesTF_new1_" + sys.argv[1] + ".nobed.pileup")
out = open("LWJ_293T_BE3_bulk_" + sys.argv[1] + ".markers.re.txt", "w")
# out = open("LWJ_seriesTF_new1_" + sys.argv[1] + ".markers.re.txt", "w")

# notation from SNVMix2 
# gamma distribution a, b to estimate prior prob of RR, RA, AA, to calculate u = (x,x,x) <- EM algorithm
# prior mean value a/(a+b) u is prior mean ex..0.8 for genotype RR...skewed toward a value
# p(q) = 0.8 if matches to reference base at position i ~ > 0.8 performs well
# Ai = number of reads that matches reference base (10 depth, a=8, 10C8*(u)8*(1-u)2 

# starting value for prior mean u
prior_mean_RR = 900.0/ (1000+1)
prior_mean_RA = 500.0/ (500+500)
prior_mean_AA = 1.0/ (1+1000)

dirchlet_priors = np.random.dirichlet([500,100,100])

def nCr(n,r):
    f = math.factorial
    return f(n) / f(r) / f(n-r)
	
def Indicator_genotype(post_prob):
	if post_prob > 0.5:
		return 1
	else:
		return 0
		
def pileup_count(read_string) :
	tmp = {"A":0, "T":0, "C":0, "G":0}
	ref_ct = 0
	
	x = 0
	read_start_chk = False
	indel_chk = False
	indel_length = 0
	while x < len(read_string) :
		letter = read_string[x]
		
		if read_start_chk :
			## skip mapping quality letters
			read_start_chk = False
			
		elif letter == "+" or letter == "-" :
			## skip indel - recognition
			indel_chk = True
			# tmp["indel"] += 1
			
		elif indel_chk :
			## skip indel - check length of indel
			indel_length += int(letter) + 10*indel_length
			if not read_string[x+1].isdigit() :
				indel_chk = False
		
		elif indel_length :
			## skip indel
			indel_length -= 1
		
		elif letter == "^" :
			## read start - recognition
			read_start_chk = True
			
		elif letter == "$" :
			## read end
			pass
		
		elif letter == "*" :
			## indel
			pass
		
		elif letter == "." or letter == "," :
			## reference match
			ref_ct +=1
			# tmp['ref'] += 1
			pass
		
		else :
			# pass
			## mismatch
			# tmp["sub"] += 1
			if letter == "a" or letter == "A"	:
				tmp["A"] += 1
			if letter == "t" or letter == "T":
				# CtoT += 1
				tmp["T"] += 1
			elif letter == "c" or letter == "C"	:
				tmp["C"] += 1
			elif letter == "g" or letter == "G"	:
				tmp["G"] += 1
		
		x += 1
	return ref_ct, tmp	
		
for line in infile:
	tmp = line.rstrip().split("\t")
	chrom = tmp[0]
	pos = tmp[1]
	ref_base = tmp[2]
	total = int(tmp[3])
	try:
		pileup_bases = tmp[4]
	except:
		continue
	ref_base_ct = pileup_count(pileup_bases)[0]
	ct_table = pileup_count(pileup_bases)[1]
	max_alt_base = max(ct_table)

	if ref_base == 'C' and max_alt_base == 'T' and ct_table['T'] >= 2:	
		
		
		dirchlet_prior_RR = dirchlet_priors[0]
		dirchlet_prior_RA = dirchlet_priors[1]
		dirchlet_prior_AA = dirchlet_priors[2]
		
		# try:
			# nCr(total, ref_base_ct)
		# except:
			# print total, ref_base_ct
			# print chrom, pos
			# exit(1)
			
		# print dirchlet_prior_RR, dirchlet_prior_RA, dirchlet_prior_AA
		if total >= 5 and ref_base_ct >= 2:
			# scaling sampling depth..
			# if total >= 100 :
				# total = total / 10
				# ref_base_ct = ref_base_ct / 10
				
			if total >= 1000 :
				total = total / 100
				ref_base_ct = ref_base_ct / 100
					
			# try:
				# nCr(total, ref_base_ct)
			# except:
				# print total, ref_base_ct
				# print chrom, pos
				# exit(1)	
				
			for i in xrange(0,100):
			
				nominator_RR = nCr(total, ref_base_ct) * prior_mean_RR**(ref_base_ct) * (1-prior_mean_RR)**(total-ref_base_ct) 
				nominator_RA = nCr(total, ref_base_ct) * prior_mean_RA**(ref_base_ct) * (1-prior_mean_RA)**(total-ref_base_ct) 
				nominator_AA = nCr(total, ref_base_ct) * prior_mean_AA**(ref_base_ct) * (1-prior_mean_AA)**(total-ref_base_ct) 
			
					
				denominator = dirchlet_prior_RR * nominator_RR + dirchlet_prior_RA * nominator_RA + dirchlet_prior_AA * nominator_AA
				# print denominator 
				
				try:
					posterior_RR = dirchlet_prior_RR*nominator_RR / denominator
					posterior_RA = dirchlet_prior_RA*nominator_RA / denominator
					posterior_AA = dirchlet_prior_AA*nominator_AA / denominator
				except ZeroDivisionError:
					print denominator
					exit(1)
				
				posterior_list= [[posterior_RR, posterior_RA, posterior_AA]]
				# print posterior_list
				# exit(1)
				
				if i >= 1 :
					posterior_list.append([posterior_RR, posterior_RA, posterior_AA])
					try:
						threshold = [i - j for i, j in zip(posterior_list[i], posterior_list[i-1])]
					except:
						print i, posterior_list, total, ref_base_ct
						exit(1)
					# print threshold
					# exit(1)
					if min(threshold) <= 0.00001:
						break
					elif i == 99:
						break
					else:
						continue
				
				# loop to identify phi, prior_mean value using EM algorithm
				else:
					# print Indicator_genotype(posterior_RR), Indicator_genotype(posterior_RA), Indicator_genotype(posterior_AA)
					# exit(1)
					EM_nominator_dirchlet_prior_RR = Indicator_genotype(posterior_RR) + dirchlet_prior_RR
					EM_nominator_dirchlet_prior_RA = Indicator_genotype(posterior_RA) + dirchlet_prior_RA
					EM_nominator_dirchlet_prior_AA = Indicator_genotype(posterior_AA) + dirchlet_prior_AA
					EM_denom_dirchlet_prior = EM_nominator_dirchlet_prior_RR + EM_nominator_dirchlet_prior_RA + EM_nominator_dirchlet_prior_AA
					
					dirchlet_prior_RR = EM_nominator_dirchlet_prior_RR / EM_denom_dirchlet_prior
					dirchlet_prior_RA = EM_nominator_dirchlet_prior_RA / EM_denom_dirchlet_prior
					dirchlet_prior_AA = EM_nominator_dirchlet_prior_AA / EM_denom_dirchlet_prior
					
					# print dirchlet_prior_RR,dirchlet_prior_RA, dirchlet_prior_AA
					# exit(1)
					
					EM_nominator_prior_mean_RR = ref_base_ct ** (Indicator_genotype(posterior_RR)) + 1000 -1
					EM_nominator_prior_mean_RA = ref_base_ct ** (Indicator_genotype(posterior_RA)) + 500 -1
					EM_nominator_prior_mean_AA = ref_base_ct ** (Indicator_genotype(posterior_AA)) + 1 -1
					
					EM_denom_prior_mean_RR = total ** (Indicator_genotype(posterior_RR)) + total ** (Indicator_genotype(posterior_RA)) + total ** (Indicator_genotype(posterior_AA)) + 1000 + 1 - 2
					EM_denom_prior_mean_RA = total ** (Indicator_genotype(posterior_RR)) + total ** (Indicator_genotype(posterior_RA)) + total ** (Indicator_genotype(posterior_AA)) + 500 + 500 - 2
					EM_denom_prior_mean_AA = total ** (Indicator_genotype(posterior_RR)) + total ** (Indicator_genotype(posterior_RA)) + total ** (Indicator_genotype(posterior_AA)) + 1 + 1000 - 2
					
					prior_mean_RR = 1.0 * EM_nominator_prior_mean_RR / EM_denom_prior_mean_RR
					prior_mean_RA = 1.0 * EM_nominator_prior_mean_RA / EM_denom_prior_mean_RA
					prior_mean_AA = 1.0 * EM_nominator_prior_mean_AA / EM_denom_prior_mean_AA
					
					# print prior_mean_RR, prior_mean_RA, prior_mean_AA
					# exit(1)
					continue
				
			max_index, max_value = max(enumerate([posterior_list[-1][0], posterior_list[-1][1], posterior_list[-1][2]]), key=operator.itemgetter(1))
				
			if max_index == 0:
				genotype = 'RR'
			elif max_index == 1:
				genotype = 'RA'
			else:
				genotype = 'AA'
		
		# print max_value
		# exit(1)
		# log_posterior = -10.0 * math.log(1-max_value, 10)		
		
			if genotype != 'RR':
				out.write(chrom + "\t" + pos + "\t" + str(genotype) + "\n")
				# out.write(chrom + "\t" + pos + "\n")
		# print genotype
		# exit(1)
		# print posterior_RR, posterior_RA, posterior_AA
		# exit(1)		