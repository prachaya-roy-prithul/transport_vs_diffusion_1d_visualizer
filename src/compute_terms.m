function terms = compute_terms(d, out)
%COMPUTE_TERMS Compute discrete transport-equation term contributions.

Nmu = d.Nmu;
Nx = d.Nx;

streaming = zeros(Nmu, Nx);
removal = zeros(Nmu, Nx);
scatter_term = zeros(Nmu, Nx);
source_term = zeros(Nmu, Nx);
residual = zeros(Nmu, Nx);

for m = 1:Nmu
    mu_m = d.mu(m);

    for i = 1:Nx
        if mu_m > 0
            if i == 1
                psi_upwind = 0.0;
            else
                psi_upwind = out.psi(m, i-1);
            end
            dpsi_dx = (out.psi(m, i) - psi_upwind) / d.dx(i);

        elseif mu_m < 0
            if i == Nx
                psi_upwind = 0.0;
            else
                psi_upwind = out.psi(m, i+1);
            end
            dpsi_dx = (psi_upwind - out.psi(m, i)) / d.dx(i);

        else
            dpsi_dx = 0.0;
        end

        streaming(m, i) = mu_m * dpsi_dx;
        removal(m, i) = d.Sigma_t(i) * out.psi(m, i);
        scatter_term(m, i) = 0.5 * d.Sigma_s(i) * out.phi(i);
        source_term(m, i) = d.Q_ang(i);

        residual(m, i) = streaming(m, i) + removal(m, i) ...
            - scatter_term(m, i) - source_term(m, i);
    end
end

terms.streaming = streaming;
terms.removal = removal;
terms.scatter = scatter_term;
terms.source = source_term;
terms.residual = residual;
end