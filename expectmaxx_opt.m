function [meu1,sigma1,wt]=expectmaxx(data,k)
%Perform GMM based expectation maximization algorithm  
    %initialization
        temp=randperm(length(data));
        wt(1:k,1)=(1/k)*ones(k,1);
        meu1(1:k,1)=data(temp(1:k));
        sigma1(1:k,1)=var(data);

       %E Step
        log_likelihood_old=0;
    for i = 1:200
        p_dummy=zeros(1,length(data));
        probb=gauss_dist_opt(data,meu1,sigma1);
        p_dummy=(wt'*probb);
        log_likelihood(i)=sum(log(p_dummy));
        %M Step
        posterior=bsxfun(@rdivide,bsxfun(@times,wt,probb),p_dummy);
        meu1=(posterior*data')./((sum(posterior'))');
%         meu_dummy=padarray(meu1(:,i),[0 length(data)-1],'symmetric','post');
        sigma1=(sum((posterior.*(bsxfun(@minus,data,meu1).^2))')....
                            ./sum(posterior'))';
        wt=(sum(posterior')./length(data))';   
            
        if abs(log_likelihood_old-log_likelihood(i))<10^-5
            break;
        end    
    
    end
      figure
      plot(log_likelihood)
      xlabel('Iteration');
      ylabel('Observed Data Log-likelihood');
end
