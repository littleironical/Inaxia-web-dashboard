import 'package:flutter/material.dart';
import 'package:inaxia_official_dashboard_web/model/models.dart';
import 'package:inaxia_official_dashboard_web/resources/assets_manager.dart';
import 'package:inaxia_official_dashboard_web/resources/colors_manager.dart';
import 'package:inaxia_official_dashboard_web/resources/fonts_manager.dart';
import 'package:inaxia_official_dashboard_web/resources/strings_manager.dart';
import 'package:inaxia_official_dashboard_web/resources/styles_manager.dart';
import 'package:inaxia_official_dashboard_web/resources/values_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<AllTshirtTypesModel> _allTshirtTypes = [];
  final List _productImage = [
    AssetsManager.poloTshirt,
    AssetsManager.regularTshirt,
    AssetsManager.oversizedTshirt,
  ];

  int _selectedTshirtTypeIndex = 0;
  late double _tshirtPrice;
  late List _selectedTshirtSizesAvaialble;
  late List _selectedTshirtColorsAvailable;
  String? _selectedTshirtSize;
  int? _selectedTshirtSizeIndex;

  @override
  void initState() {
    _initializeAllTshirtTypes();
    _initializeTshirt();
    super.initState();
  }

  _initializeAllTshirtTypes() {
    _allTshirtTypes.add(
      AllTshirtTypesModel(
        true,
        'Polo',
        270,
        [
          StringsManager.tshirtSizesS,
          StringsManager.tshirtSizesM,
          StringsManager.tshirtSizesL,
          StringsManager.tshirtSizesXL,
          StringsManager.tshirtSizes2XL,
          StringsManager.tshirtSizes3XL,
        ],
        [
          ColorsManager.beigeTshirt,
          ColorsManager.whiteTshirt,
          ColorsManager.blackTshirt,
          ColorsManager.lavenderTshirt,
          ColorsManager.pinkTshirt,
          ColorsManager.greyTshirt,
          ColorsManager.navyTshirt,
          ColorsManager.greenTshirt,
        ],
      ),
    );
    _allTshirtTypes.add(
      AllTshirtTypesModel(
        false,
        'Regular',
        160,
        [
          StringsManager.tshirtSizesS,
          StringsManager.tshirtSizesM,
          StringsManager.tshirtSizesL,
          StringsManager.tshirtSizesXL,
          StringsManager.tshirtSizes2XL,
          StringsManager.tshirtSizes3XL,
          StringsManager.tshirtSizes4XL,
          StringsManager.tshirtSizes5XL,
          StringsManager.tshirtSizes6XL,
          StringsManager.tshirtSizes7XL,
        ],
        [
          ColorsManager.beigeTshirt,
          ColorsManager.whiteTshirt,
          ColorsManager.blackTshirt,
          ColorsManager.lavenderTshirt,
          ColorsManager.pinkTshirt,
          ColorsManager.greyTshirt,
          ColorsManager.navyTshirt,
          ColorsManager.greenTshirt,
          ColorsManager.redTshirt,
          ColorsManager.orangeTshirt,
          ColorsManager.skyBlueTshirt,
        ],
      ),
    );
    _allTshirtTypes.add(
      AllTshirtTypesModel(
        false,
        'Oversized',
        190,
        [
          StringsManager.tshirtSizesXS,
          StringsManager.tshirtSizesS,
          StringsManager.tshirtSizesM,
          StringsManager.tshirtSizesL,
          StringsManager.tshirtSizesXL,
          StringsManager.tshirtSizes2XL,
        ],
        [
          ColorsManager.beigeTshirt,
          ColorsManager.whiteTshirt,
          ColorsManager.blackTshirt,
          ColorsManager.lavenderTshirt,
          ColorsManager.pinkTshirt,
          ColorsManager.greyTshirt,
          ColorsManager.navyTshirt,
        ],
      ),
    );
  }

  _initializeTshirt() {
    for (var element in _allTshirtTypes) {
      if (element.isSelected == true) {
        _tshirtPrice = element.tshirtPrice;
        _selectedTshirtSizesAvaialble = element.tshirtSizesAvailable;
        _selectedTshirtColorsAvailable = element.tshirtColorsAvailable;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text(StringsManager.appTitle),
    );
  }

  _body() {
    return Center(
      child: SizedBox(
        width: AppSizeManager.s1265,
        // padding: const EdgeInsets.symmetric(horizontal: AppPaddingManager.p400),
        child: Row(
          children: [
            Expanded(
              flex: AppValueManager.v1,
              child: Padding(
                padding: const EdgeInsets.all(AppPaddingManager.p20),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(AppSizeManager.s20)),
                  child: Image.asset(_productImage[_selectedTshirtTypeIndex]),
                ),
              ),
            ),
            Expanded(
              flex: AppValueManager.v1,
              child: Padding(
                padding: const EdgeInsets.all(AppPaddingManager.p20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // T-SHIRT TYPE
                    _optionTitle(StringsManager.tshirtTypeTitle),
                    _heightSpacing(AppSizeManager.s20),
                    _tshirtType(),
                    _heightSpacing(AppSizeManager.s40),
    
                    // T-SHIRT SIZES AVAILABLE
                    _optionTitle(StringsManager.tshirtSizesTitle),
                    _heightSpacing(AppSizeManager.s20),
                    _tshirtSizesAvailable(),
                    _heightSpacing(AppSizeManager.s40),
    
                    // T-SHIRT COLORS AVAILABLE
                    _optionTitle(StringsManager.tshirtColorsTitle),
                    _heightSpacing(AppSizeManager.s20),
                    _tshirtColorsAvailable(),
                    _heightSpacing(AppSizeManager.s40),
    
                    // FINAL PRICE
                    _optionTitle(StringsManager.pricingTitle),
                    _heightSpacing(AppSizeManager.s10),
                    _finalPricing(),
                    _heightSpacing(AppSizeManager.s20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _optionTitle(String title) {
    return Text(title);
  }

  _heightSpacing(double size) {
    return SizedBox(height: size);
  }

  _tshirtType() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p20,
      children: List.generate(
        _allTshirtTypes.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: ElevatedButton(
            onPressed: () {
              for (var element in _allTshirtTypes) {
                element.isSelected = false;
              }
              _allTshirtTypes[index].isSelected = true;

              setState(() {
                _selectedTshirtTypeIndex = index;
                _tshirtPrice = _allTshirtTypes[index].tshirtPrice;
                _selectedTshirtSizesAvaialble =
                    _allTshirtTypes[index].tshirtSizesAvailable;
                _selectedTshirtColorsAvailable =
                    _allTshirtTypes[index].tshirtColorsAvailable;
                _selectedTshirtSize = null;
                _selectedTshirtSizeIndex = null;
              });

              // print(MediaQuery.of(context).size.width);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (_allTshirtTypes[index].isSelected == true)
                  ? ColorsManager.primary
                  : ColorsManager.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPaddingManager.p10),
              child: Text(_allTshirtTypes[index].tshirtType),
            ),
          ),
        ),
      ),
    );
  }

  _tshirtSizesAvailable() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p20,
      children: List.generate(
        _selectedTshirtSizesAvaialble.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedTshirtSize = _selectedTshirtSizesAvaialble[index];
                _selectedTshirtSizeIndex = index;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (_selectedTshirtSizeIndex == index)
                  ? ColorsManager.primary
                  : ColorsManager.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPaddingManager.p5,
                vertical: AppPaddingManager.p10,
              ),
              child: Text(_selectedTshirtSizesAvaialble[index]),
            ),
          ),
        ),
      ),
    );
  }

  _tshirtColorsAvailable() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p20,
      children: List.generate(
        _selectedTshirtColorsAvailable.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: Tooltip(
            message: _getColorName(_selectedTshirtColorsAvailable[index]),
            child: Container(
              width: AppSizeManager.s40,
              height: AppSizeManager.s40,
              decoration: BoxDecoration(
                color: _selectedTshirtColorsAvailable[index],
                shape: BoxShape.rectangle,
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppSizeManager.s4)),
                border: (_selectedTshirtColorsAvailable[index] ==
                        ColorsManager.whiteTshirt)
                    ? Border.all(
                        color: ColorsManager.black,
                        width: AppSizeManager.s0_5,
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getColorName(Color color) {
    if (color == ColorsManager.beigeTshirt) {
      return StringsManager.beigeColor;
    } else if (color == ColorsManager.whiteTshirt) {
      return StringsManager.whiteColor;
    } else if (color == ColorsManager.blackTshirt) {
      return StringsManager.blackColor;
    } else if (color == ColorsManager.lavenderTshirt) {
      return StringsManager.lavenderColor;
    } else if (color == ColorsManager.pinkTshirt) {
      return StringsManager.pinkColor;
    } else if (color == ColorsManager.greyTshirt) {
      return StringsManager.greyColor;
    } else if (color == ColorsManager.navyTshirt) {
      return StringsManager.navyColor;
    } else if (color == ColorsManager.greenTshirt) {
      return StringsManager.greenColor;
    } else if (color == ColorsManager.redTshirt) {
      return StringsManager.redColor;
    } else if (color == ColorsManager.orangeTshirt) {
      return StringsManager.orangeColor;
    } else if (color == ColorsManager.skyBlueTshirt) {
      return StringsManager.skyBlueColor;
    }
  }

  _finalPricing() {
    double finalTshirtPrice = _tshirtPrice;
    double sizePrice = 0;

    if (_selectedTshirtSize == StringsManager.tshirtSizes2XL) {
      sizePrice = 20;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes3XL) {
      sizePrice = 40;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes4XL) {
      sizePrice = 60;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes5XL) {
      sizePrice = 80;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes6XL) {
      sizePrice = 100;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes7XL) {
      sizePrice = 120;
    }

    finalTshirtPrice = _tshirtPrice + sizePrice;

    return Text(
      '${StringsManager.pricingCurrency} $finalTshirtPrice',
      style: boldTextStyleManager(
        color: ColorsManager.black,
        fontSize: FontSizeManager.f22,
      ),
    );
  }
}
