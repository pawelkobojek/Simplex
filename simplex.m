function [x_opt, f_opt, exitflag] = simplex(f, A, b)
  %
  % [x_opt, f_opt, exitflag] = simplex(f, A, b)
  %
  % Solves max(f' * x) with subject to Ax <= b and x >= 0 problem with
  % simplex method.
  %
  % Returns found point (x_opt), function value for this point (f_opt) and
  % exitflag indicating whether problem has finite solution (1) or not (0).

  [n, m] = size(A);

  indices = (1:size(f, 1))';
  base = (size(f, 1)+1:size(f, 1) + n)';

  % add slack variables
  A = [A, eye(n)];
  f = [f; zeros(n, 1)];

  c = f';
  cb = zeros(n, 1);

  % compute initial 'z' and 'z-c'
  z = cb' * A;
  z_c = z - c;

  fprintf('-----------------------------------------------\n');

  cb
  base
  Ab = [A b]
  z
  z_c

  fprintf('-----------------------------------------------\n');
  %pause

  while min(z_c >= 0) == 0
    fprintf('-----------------------------------------------\n');

    % find index of minimal element of 'z-c'
    [_, to_base] = min(z_c);

    % find index of variable which should be chosen to base result
    divider = max(0, A(:, to_base));
    if all(divider <= 0)
      exitflag = 0;
      x_opt = f_opt = [];
      return;
    end
    [_, from_base] = min(b ./ divider);

    temp_A_b = [A b];
    temp_A_b(from_base, :) = temp_A_b(from_base, :) / temp_A_b(from_base, to_base);

    for i=1:n
      if i ~= from_base && temp_A_b(from_base, to_base) ~= 0
        divider = temp_A_b(i, to_base) / temp_A_b(from_base, to_base);
        temp_A_b(i, :) = temp_A_b(i, :) - temp_A_b(from_base, :) * divider;
      end
    end
    A = temp_A_b(:, 1:end-1);
    b = temp_A_b(:, end);

    cb(from_base) = c(to_base);
    base(from_base) = to_base;

    z = cb' * A;
    z_c = z - c;

    cb
    base
    Ab = [A b]
    z
    z_c

    fprintf('-----------------------------------------------\n');

    % uncomment following line if you wish to perform step by step analysis
    % of iterations
    %pause
  end

  x_opt = zeros(1, length(b));
  for i=1:length(b)
    x_opt(base(i)) = b(i);
  end

  x_opt = x_opt(indices);
  f_opt = sum(f(indices) * x_opt);
  exitflag = 1;

end
