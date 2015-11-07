function condFulfilled = check3P(F, a1, a2, a3)
  condFulfilled = a1 < a2 && a2 < a3 && F(a1) > F(a2) && F(a2) < F(a3);
end
