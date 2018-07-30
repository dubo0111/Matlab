const=0; 
x=-5:0.05:5;y=-5:0.05:5;z=-5:0.05:5; 
[x,y,z]=meshgrid(x,y,z); 
f=(x.^2 + (9/4)*y.^2 + z.^2 - 1).^3 - x.^2.*z.^3 - (9/80)*y.^2.*z.^3-const; 
p=patch(isosurface(x,y,z,f,0)); 
set(p, 'FaceColor', 'red', 'EdgeColor', 'none');
daspect([1 1 1]) 
view(3) 
camlight; 
lighting phong