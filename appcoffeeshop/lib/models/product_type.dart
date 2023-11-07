enum ProductType {
  ALL(name: 'Tất cả'),
  CAPHE(name: 'Cà phê'),
  CAPHEMAY(name: 'Cà phê máy'),
  COLDBRREW(name: 'Cold brew'),
  TRATRAICAY(name: 'Trà trái cây'),
  TRASUAMACCHIATO(name: 'Trà sữa macchiato'),
  HITEATRA(name: 'Hi-tea trà'),
  BANHMAN(name: 'Bánh mặn'),
  BANHNGOT(name: 'Bánh ngọt'),
  CAPHETAINHA(name: 'Cà phê tại nhà');

  const ProductType({required this.name});

  final String name;
}
