# This is a helper function for the Bernoulli_notes.Rnw file
# It allows us to avoid repeating the same code over and over
priorpost <- function(y,a,b){
  N<-length(y)
  alpha=a
  beta=b
  dl = list('N'=N, 'alpha'=alpha, 'beta'=beta, 'y'=y)
  stanfit = stan("Bernoulli_flexible.stan",data=dl,iter=100000)         #call stan to fit the model
  pd=extract(stanfit)                      #extract the posterior draw values
  posterior = pd$theta
  prior = rbeta(length(posterior),alpha,beta)
  df=data.frame(posterior,prior) 
  data<- melt(df) 
  p=ggplot(data,aes(x=value, fill=variable)) + geom_density(alpha=0.25)
  print(p)
  return()
}