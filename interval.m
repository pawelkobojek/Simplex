function [a1, a3] = interval(F, a0, d)
  a1 = a0;
  ax = a0 + d;

  cond3P = false;

  if F(a1) <= F(ax)
    a3 = ax;
    a2 = (a1 + a3) / 2;
    while !check3P(F, a1, a2, a3)
      a2 = (a1 + a2) / 2;
    end
  else
    a2 = ax;
    a3 = a2 + d;
    while !check3P(F, a1, a2, a3)
      d = 2*d;
      a3 = a2 + d;
    end
  end
end
