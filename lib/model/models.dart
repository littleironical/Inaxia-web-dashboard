class AllTshirtTypesModel {
  bool isSelected;
  final String tshirtType;
  final double tshirtPrice;
  final List tshirtSizesAvailable;
  final List tshirtColorsAvailable;

  AllTshirtTypesModel(
    this.isSelected,
    this.tshirtType,
    this.tshirtPrice,
    this.tshirtSizesAvailable,
    this.tshirtColorsAvailable,
  );
}
