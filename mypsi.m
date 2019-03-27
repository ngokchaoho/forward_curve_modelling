function result = mypsi(x1,x2)
    global sigma;
    global sigma_b;
    term_1 = 1;
    temp = zeros(1,2);
    if x1==1
        temp = sigma;
    else
        temp = sigma_b;
    end
    for i=1:2
        term_1 = term_1 * temp(i);
    end
    temp2 = zeros(1,2);
    if x2==1
        temp2 = sigma;
    else
        temp2 = sigma_b;
    end
    term_2 = 1;
    for i=1:2
        term_2 = term_2 * temp2(i);
    end
    term_3=0;
    for i=1:2
        for j=1:2
            term_3 = term_3 + temp(i)*temp2(j);
        end
    end
    result = term_1+term_2+term_3;
end