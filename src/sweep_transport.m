function psi = sweep_transport(d, scatter_source)
%SWEEP_TRANSPORT Perform a first-order upwind transport sweep for all directions.
%
% psi(m,i) is the cell-centered angular flux for direction m and cell i.

Nmu = d.Nmu;
Nx = d.Nx;

psi = zeros(Nmu, Nx);

for m = 1:Nmu
    mu_m = d.mu(m);

    if mu_m > 0
        psi_in = 0.0;
        for i = 1:Nx
            dx_i = d.dx(i);
            St_i = d.Sigma_t(i);
            rhs_i = scatter_source(i) + d.Q_ang(i);

            denom = mu_m / dx_i + St_i;
            numer = rhs_i + (mu_m / dx_i) * psi_in;

            psi(m, i) = numer / denom;
            psi_in = psi(m, i);
        end

    elseif mu_m < 0
        psi_in = 0.0;
        for i = Nx:-1:1
            dx_i = d.dx(i);
            St_i = d.Sigma_t(i);
            rhs_i = scatter_source(i) + d.Q_ang(i);

            mu_abs = abs(mu_m);
            denom = mu_abs / dx_i + St_i;
            numer = rhs_i + (mu_abs / dx_i) * psi_in;

            psi(m, i) = numer / denom;
            psi_in = psi(m, i);
        end
    end
end
end