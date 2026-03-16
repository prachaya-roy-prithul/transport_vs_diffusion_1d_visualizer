function bal = neutron_balance(d, out)
%NEUTRON_BALANCE Compute scalar source, absorption, and leakage estimates.

source_total = sum(d.Q_iso .* d.dx);
absorption_total = sum(d.Sigma_a .* out.phi .* d.dx);

left_leakage = 0.0;
right_leakage = 0.0;

for m = 1:d.Nmu
    if d.mu(m) < 0
        left_leakage = left_leakage + abs(d.mu(m)) * d.w(m) * out.psi(m, 1);
    elseif d.mu(m) > 0
        right_leakage = right_leakage + abs(d.mu(m)) * d.w(m) * out.psi(m, end);
    end
end

bal.source = source_total;
bal.absorption = absorption_total;
bal.left_leakage = left_leakage;
bal.right_leakage = right_leakage;
bal.total_loss = absorption_total + left_leakage + right_leakage;
bal.balance_error = source_total - bal.total_loss;
end