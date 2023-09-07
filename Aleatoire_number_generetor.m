n = 500;
vect = zeros(1,n);
p = 0.5;
for i = 1:length(vect)
if rand() <= p
    vect(i) = 1;
else
    vect(i) = -1;

end
end
plot(1:n,cumsum(vect))
