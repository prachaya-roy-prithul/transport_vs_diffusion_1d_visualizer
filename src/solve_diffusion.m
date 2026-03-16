function diff_out = solve_diffusion(d)
%SOLVE_DIFFUSION Assemble and solve the 1D diffusion finite-difference system.

Nx = d.Nx;
x = d.x_centers(:);
dx = d.dx(:);

D = 1 ./ (3.0 * d.Sigma_t(:));
Sa = d.Sigma_a(:);

A = zeros(Nx, Nx);
b = d.Q_iso(:);

for i = 1:Nx
    if i == 1
        dxL = dx(i);
        D_L = D(i);
        D_R = 0.5 * (D(i) + D(i+1));

        A(i, i) = D_L / dxL^2 + D_R / dxL^2 + Sa(i);
        A(i, i+1) = -D_R / dxL^2;

    elseif i == Nx
        dxR = dx(i);
        D_L = 0.5 * (D(i-1) + D(i));
        D_R = D(i);

        A(i, i-1) = -D_L / dxR^2;
        A(i, i) = D_L / dxR^2 + D_R / dxR^2 + Sa(i);

    else
        dx_i = dx(i);
        D_L = 0.5 * (D(i-1) + D(i));
        D_R = 0.5 * (D(i) + D(i+1));

        A(i, i-1) = -D_L / dx_i^2;
        A(i, i) = (D_L + D_R) / dx_i^2 + Sa(i);
        A(i, i+1) = -D_R / dx_i^2;
    end
end

phi_diff = A \ b;

diff_out.x = x;
diff_out.phi = phi_diff.';
diff_out.D = D.';
end