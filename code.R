T<-5 #Do not assume this is will be 5 in the assessment
dt<-1 #Do not assume this is will be 1 in the assessment
N<-T/dt #Do not assume this is will be 5 in the assessment

S_0<-130. #Do not assume this is will be the same in the assessment
K<-140 #Do not assume this is will be the same in the assessment

u<-1.04426 #Do not assume this is will be the same in the assessment
d<-1/u 
r<-1.0025 #Do not assume this is will be the same in the assessment

S <- matrix(data=NA, nrow=N+1, ncol=N+1) #Matrix of asset prices
f_tilde <- matrix(data=NA, nrow=N+1, ncol=N+1) #Matrix of discounted American put prices

# Your code here (you can call the function you wrote for Ch 6 if you like). # You need to
#(i) Populate the S matrix.
S[1,1] = 1    #initial value
S[1,2] = u    #up factor
S[2,2] = d    #down factor

#loop for an N-period re-combining tree
for(j in 1:(N+1)){
  for(i in 1:(N+1)){
    if(j >= 3){
      if(is.na(S[i,j-1])){
        S[i,j] = S[i-1,j-1] * d     #multiply with down factor
      }else {
        S[i,j] = S[i,j-1] * u       #multiply with up factor
      }
    }
  }
}

Snew = S * S_0    #asset prices

#(ii) Calculate discounted asset prices
discount = matrix(data=NA, nrow=N+1, ncol=N+1)    #declare empty matrix for discounted asset prices

#loop for discounted asset prices
for(j in 1:(N+1)){
  for(i in 1:(N+1)){
    discount[i,j] = S[i,j]/(r^(j-1))    #discount based on period of time
  }
}

#risk-neutral probability of up-state
q_u = (discount[1,1]-discount[2,2])/(discount[1,2]-discount[2,2])

#(iii) Calculate the derivative prices, taking into account early exercise
#loop for no-arbitrage American put price
for(j in N:1){
  for(i in 1:N){
    f_tilde[,N+1] = (pmax((K-Snew[,N+1]),0))*(r^-N)   #values for when put option reaches maturity
    
    if(q_u<1 && q_u>0){
      #value at any other nodes before option reaches maturity
      f_tilde[i,j] = (max((q_u*(f_tilde[i,j+1]) + (1-q_u)*(f_tilde[i+1,j+1]))*(r^(j-1)),(max(K-Snew[i,j],0))))*(r^-(j-1))
    }else{
      f_tilde[i,j] = NA     #NA for all values if there is an arbitrage opportunity
    }
  }
}

f_tilde     #matrix of discounted derivative price

#(iv) The time zero derivative price should be given by f_tilde[1,1]
f_tilde[1,1]    #no-arbitrage American put price
