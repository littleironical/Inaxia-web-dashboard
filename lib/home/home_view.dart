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
  late double _screenWidth;
  final List<AllTshirtTypesModel> _allTshirtTypes = [];

  // FOR T-SHIRT TYPE & PRICE
  int _selectedTshirtTypeIndex = 0;
  late double _tshirtPrice;

  // FOR T-SHIRT IMAGES
  late List _selectedTshirtImages;
  int _selectedTshirtImagesIndex = 0;

  // FOR T-SHIRT SIZED
  late List _tshirtSizesAvaialble;
  String? _selectedTshirtSize;
  int? _selectedTshirtSizeIndex;

  // FOR T-SHIRT COLORS
  late List _tshirtColorsAvailable;
  late Color _selectedTshirtColor;
  int _selectedTshirtColorsIndex = 0;

  // PRINITNG TECHNIQUES
  final List _printingTechniquesAvailable = [
    StringsManager.printingTechniqueDTF,
  ];
  String? _selectedPrintingTechnique;
  int? _selectedPrintingTechniquesIndex;

  // PRINTING AREA
  final List _printingAreaAvailable = [
    StringsManager.printingAreasA3,
    StringsManager.printingAreasA4,
    StringsManager.printingAreasA5,
    StringsManager.printingAreasA6,
    StringsManager.printingAreasA7,
  ];
  String? _selectedPrintingArea;
  int? _selectedPrintingAreaIndex;

  // T-SHIRT QUANTITY
  final List _tshirtQuantityList = [
    StringsManager.tshirtQuantity1,
    StringsManager.tshirtQuantity25,
    StringsManager.tshirtQuantity50,
    StringsManager.tshirtQuantity100,
    StringsManager.tshirtQuantity200,
    StringsManager.tshirtQuantity300,
    StringsManager.tshirtQuantity500,
  ];
  int _tshirtQuantityValue = AppValueManager.v1;
  int _tshirtQuantitySliderValue = AppValueManager.v1;

  // DISCOUNT
  int _discountValue = 0;

  // INITIALIZING ALL DATA
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
          ColorsManager.whiteTshirt,
          ColorsManager.beigeTshirt,
          ColorsManager.blackTshirt,
          ColorsManager.lavenderTshirt,
          ColorsManager.pinkTshirt,
          ColorsManager.greyTshirt,
          ColorsManager.navyTshirt,
          ColorsManager.greenTshirt,
        ],
        [
          // AssetsManager.poloTshirt,
          AssetsManager.poloTshirt1,
          AssetsManager.poloTshirt2,
          AssetsManager.poloTshirt3,
          AssetsManager.poloTshirt4,
          AssetsManager.poloTshirt5,
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
        ],
        [
          ColorsManager.whiteTshirt,
          ColorsManager.beigeTshirt,
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
        [
          // AssetsManager.regularTshirt,
          AssetsManager.regularTshirt1,
          AssetsManager.regularTshirt2,
          AssetsManager.regularTshirt3,
          AssetsManager.regularTshirt4,
          AssetsManager.regularTshirt5,
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
          ColorsManager.whiteTshirt,
          ColorsManager.beigeTshirt,
          ColorsManager.blackTshirt,
          ColorsManager.lavenderTshirt,
          ColorsManager.pinkTshirt,
          ColorsManager.greyTshirt,
          ColorsManager.navyTshirt,
        ],
        [
          // AssetsManager.oversizedTshirt,
          AssetsManager.oversizedTshirt1,
          AssetsManager.oversizedTshirt2,
          AssetsManager.oversizedTshirt3,
          AssetsManager.oversizedTshirt4,
          AssetsManager.oversizedTshirt5,
        ],
      ),
    );
  }

  _initializeTshirt() {
    for (var element in _allTshirtTypes) {
      if (element.isSelected == true) {
        _tshirtPrice = element.tshirtPrice;
        _tshirtSizesAvaialble = element.tshirtSizesAvailable;
        _tshirtColorsAvailable = element.tshirtColorsAvailable;
        _selectedTshirtColor =
            _tshirtColorsAvailable[_selectedTshirtColorsIndex];
        _selectedTshirtImages = element.tshirtImages;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (_screenWidth >= AppBreakpointManager.b1100)
            ? _largeScreenBody()
            : (_screenWidth >= AppBreakpointManager.b550)
                ? _mediumScreenBody()
                : _smallScreenBody(),
        //* MORE SECTIONS TO BE ADDED
      ],
    );
  }

  // LARGE SCREEN
  _largeScreenBody() {
    return Center(
      child: SizedBox(
        width: AppBreakpointManager.b1265,
        child: Row(
          children: [
            Expanded(
              flex: AppValueManager.v1,
              child: _largeScreenProductsImages(),
            ),
            Expanded(
              flex: AppValueManager.v1,
              child: _productOptions(),
            ),
          ],
        ),
      ),
    );
  }

  // CONTROLLING ALL IMAGES [IMAGE BANNER + SCROLL IMAGES]
  _largeScreenProductsImages() {
    return Padding(
      padding: const EdgeInsets.all(AppPaddingManager.p20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _productImageScrolls(),
          const SizedBox(width: AppSizeManager.s10),
          _productImageBanner(),
        ],
      ),
    );
  }

  // MEDIUM SCREEN
  _mediumScreenBody() {
    return Center(
      child: SizedBox(
        width: AppSizeManager.s700,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: AppValueManager.v1,
              child: _mediumScreenProductsImages(),
            ),
            Expanded(
              flex: AppValueManager.v1,
              child: _productOptions(),
            ),
          ],
        ),
      ),
    );
  }

  // CONTROLLING ALL IMAGES [IMAGE BANNER + SCROLL IMAGES]
  _mediumScreenProductsImages() {
    return Padding(
      padding: const EdgeInsets.all(AppPaddingManager.p20),
      child: SizedBox(
        height: AppSizeManager.s700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _productImageBanner(),
            const SizedBox(height: AppSizeManager.s10),
            _productImageScrolls(),
          ],
        ),
      ),
    );
  }

  // SMALL SCREEN
  _smallScreenBody() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: AppSizeManager.s1500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _smallScreenProductsImages(),
            _productOptions(),
          ],
        ),
      ),
    );
  }

  // CONTROLLING ALL IMAGES [IMAGE BANNER + SCROLL IMAGES]
  _smallScreenProductsImages() {
    return SizedBox(
      height: AppSizeManager.s560,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _productImageBanner(),
          const SizedBox(height: AppSizeManager.s10),
          _productImageScrolls(),
        ],
      ),
    );
  }

  _productImageBanner() {
    return SizedBox(
      height: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppSizeManager.s600
          : (_screenWidth >= AppBreakpointManager.b550) ? AppSizeManager.s500 : AppSizeManager.s450,
      width: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppSizeManager.s400
          : (_screenWidth >= AppBreakpointManager.b550) ? AppSizeManager.s400 : double.maxFinite,
      child: Container(
        color: _selectedTshirtColor,
        child: Image.asset(
          _selectedTshirtImages[_selectedTshirtImagesIndex],
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _productImageScrolls() {
    return SizedBox(
      height: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppSizeManager.s600
          : AppSizeManager.s100,
      width: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppSizeManager.s100
          : double.maxFinite,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: (_screenWidth >= AppBreakpointManager.b1100)
              ? Axis.vertical
              : Axis.horizontal,
          shrinkWrap: true,
          itemCount: _selectedTshirtImages.length,
          separatorBuilder: (context, index) => SizedBox(
            height: (_screenWidth >= AppBreakpointManager.b1100)
                ? AppSizeManager.s10
                : AppSizeManager.s0,
            width: (_screenWidth >= AppBreakpointManager.b1100)
                ? AppSizeManager.s0
                : AppSizeManager.s10,
          ),
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: (_screenWidth >= AppBreakpointManager.b1100)
                  ? AppPaddingManager.p10
                  : AppPaddingManager.p0,
            ),
            child: Container(
              height: (_screenWidth >= AppBreakpointManager.b550) ? AppSizeManager.s120 : AppSizeManager.s80,
              width: (_screenWidth >= AppBreakpointManager.b550) ? AppSizeManager.s60 : AppSizeManager.s80,
              color: _selectedTshirtColor,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTshirtImagesIndex = index;
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Image.asset(
                    _selectedTshirtImages[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _productOptions() {
    return Padding(
      padding: const EdgeInsets.all(AppPaddingManager.p20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // T-SHIRT TYPE
          _optionTitle(StringsManager.tshirtTypeTitle, true),
          _heightSpacing(AppSizeManager.s10),
          _tshirtType(),
          _heightSpacing(AppSizeManager.s20),

          // T-SHIRT SIZES AVAILABLE
          _optionTitle(StringsManager.tshirtSizesTitle, true),
          _heightSpacing(AppSizeManager.s10),
          _tshirtSizes(),
          _heightSpacing(AppSizeManager.s20),

          // T-SHIRT COLORS AVAILABLE
          _optionTitle(StringsManager.tshirtColorsTitle, true),
          _heightSpacing(AppSizeManager.s10),
          _tshirtColors(),
          _heightSpacing(AppSizeManager.s20),

          // PRINTING TECHNIQUES
          _optionTitle(StringsManager.printingTechniquesTitle, true),
          _heightSpacing(AppSizeManager.s10),
          _printingTechniques(),
          _heightSpacing(AppSizeManager.s20),

          // PRINTING AREA
          _optionTitle(StringsManager.printingAreasTitle, true),
          _heightSpacing(AppSizeManager.s10),
          _printingAreas(),
          _heightSpacing(AppSizeManager.s20),

          // T-SHIRT QUANTITY
          _optionTitle(StringsManager.tshirtQuantityTitle, true),
          _heightSpacing(AppSizeManager.s10),
          _tshirtQuantity(),
          _heightSpacing(AppSizeManager.s20),

          // FINAL PRICE
          _optionTitle(StringsManager.pricingTitle, false),
          _heightSpacing(AppSizeManager.s10),
          _finalPricing(),
          _heightSpacing(AppSizeManager.s20),

          // TODO SEND QUERY ON WHATSAPP
          // _optionTitle(StringsManager.pricingTitle, false),
          // _heightSpacing(AppSizeManager.s10),
          // _finalPricing(),
          // _heightSpacing(AppSizeManager.s20),
        ],
      ),
    );
  }

  _optionTitle(String title, bool isBold) {
    return Text(
      title,
      style: (isBold) ? const TextStyle(fontWeight: FontWeight.bold) : null,
    );
  }

  _heightSpacing(double size) {
    return SizedBox(height: size);
  }

  _tshirtType() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _allTshirtTypes.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: ElevatedButton(
            onPressed: () {
              if (_selectedTshirtTypeIndex != index) {
                for (var element in _allTshirtTypes) {
                  element.isSelected = false;
                }
                _allTshirtTypes[index].isSelected = true;

                setState(() {
                  // T-SHIRT TYPES
                  _selectedTshirtTypeIndex = index;
                  _tshirtPrice = _allTshirtTypes[index].tshirtPrice;

                  // T-SHIRT IMAGES
                  _selectedTshirtImages = _allTshirtTypes[index].tshirtImages;
                  _selectedTshirtImagesIndex = 0;

                  // T-SHIRT SIZES
                  _tshirtSizesAvaialble =
                      _allTshirtTypes[index].tshirtSizesAvailable;
                  _selectedTshirtSize = null;
                  _selectedTshirtSizeIndex = null;

                  // T-SHIRT COLORS
                  _tshirtColorsAvailable =
                      _allTshirtTypes[index].tshirtColorsAvailable;
                  _selectedTshirtColorsIndex = 0;
                  _selectedTshirtColor =
                      _tshirtColorsAvailable[_selectedTshirtColorsIndex];

                  // PRINTING TECHNIQUES
                  _selectedPrintingTechnique = null;
                  _selectedPrintingTechniquesIndex = null;

                  // PRINTING TECHNIQUES
                  _selectedPrintingArea = null;
                  _selectedPrintingAreaIndex = null;
                });

                // print(MediaQuery.of(context).size.width);
              }
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

  _tshirtSizes() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _tshirtSizesAvaialble.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedTshirtSize = _tshirtSizesAvaialble[index];
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
              child: Text(_tshirtSizesAvaialble[index]),
            ),
          ),
        ),
      ),
    );
  }

  _tshirtColors() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _tshirtColorsAvailable.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTshirtColorsIndex = index;
                  _selectedTshirtColor = _tshirtColorsAvailable[index];
                });
              },
              child: Tooltip(
                message: _getColorName(_tshirtColorsAvailable[index]),
                child: Container(
                  width: AppSizeManager.s30,
                  height: AppSizeManager.s30,
                  decoration: BoxDecoration(
                    color: (_selectedTshirtColorsIndex == index)
                        ? ColorsManager.primary
                        : ColorsManager.transparent,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppSizeManager.s4)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPaddingManager.p3),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _tshirtColorsAvailable[index],
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppSizeManager.s30)),
                        border: (_tshirtColorsAvailable[index] ==
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

  _printingTechniques() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _printingTechniquesAvailable.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedPrintingTechnique =
                    _printingTechniquesAvailable[index];
                _selectedPrintingTechniquesIndex = index;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: (_selectedPrintingTechniquesIndex == index)
                  ? ColorsManager.primary
                  : ColorsManager.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPaddingManager.p5,
                vertical: AppPaddingManager.p10,
              ),
              child: Text(_printingTechniquesAvailable[index]),
            ),
          ),
        ),
      ),
    );
  }

  _printingAreas() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _printingAreaAvailable.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p20),
          child: Tooltip(
            message: (_selectedPrintingTechniquesIndex == null)
                ? StringsManager.selectPrintingTechnique
                : StringsManager.emptyString,
            child: ElevatedButton(
              onPressed: (_selectedPrintingTechniquesIndex == null)
                  ? null
                  : () {
                      setState(() {
                        _selectedPrintingArea = _printingAreaAvailable[index];
                        _selectedPrintingAreaIndex = index;
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: (_selectedPrintingAreaIndex == index)
                    ? ColorsManager.primary
                    : ColorsManager.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPaddingManager.p5,
                  vertical: AppPaddingManager.p10,
                ),
                child: Text(_printingAreaAvailable[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _tshirtQuantity() {
    return SizedBox(
      width: (_screenWidth >= AppBreakpointManager.b1100)
          ? double.maxFinite
          : AppSizeManager.s400,
      child: Column(
        children: [
          Container(
            height: AppSizeManager.s30,
            padding:
                const EdgeInsets.symmetric(horizontal: AppPaddingManager.p10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                _tshirtQuantityList.length,
                (index) => SizedBox(
                  height: AppSizeManager.s30,
                  width: AppSizeManager.s24,
                  child: Column(
                    children: [
                      Text(_tshirtQuantityList[index]),
                      const SizedBox(height: AppSizeManager.s4),
                      Container(
                        height: AppSizeManager.s10,
                        width: AppSizeManager.s1,
                        color: ColorsManager.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Slider(
            min: AppSizeManager.s1,
            max: AppSizeManager.s500,
            value: _tshirtQuantitySliderValue.toDouble(),
            divisions: _tshirtQuantityList.length - 1,
            onChanged: (value) {
              setState(() {
                _tshirtQuantitySliderValue = value.toInt();
                _setTshirtQuantity(value.toInt());
              });
            },
          ),
        ],
      ),
    );
  }

  _setTshirtQuantity(int value) {
    if (value == 1) {
      _tshirtQuantityValue = 1;
    } else if (value == 84) {
      _tshirtQuantityValue = 25;
    } else if (value == 167) {
      _tshirtQuantityValue = 50;
    } else if (value == 250) {
      _tshirtQuantityValue = 100;
    } else if (value == 333) {
      _tshirtQuantityValue = 200;
    } else if (value == 416) {
      _tshirtQuantityValue = 300;
    } else if (value == 500) {
      _tshirtQuantityValue = 500;
    }
  }

  _finalPricing() {
    double finalTshirtPrice = _tshirtPrice;
    double discountedPrice;
    int sizePrice = 0;
    sizePrice = _setSizePrice();
    int printingPrice = 0;
    printingPrice = _setPrintingPrice();

    _discountValue = _setDiscountValue();
    finalTshirtPrice = (_tshirtPrice + sizePrice + printingPrice) *
        (_tshirtQuantityValue.toInt());
    discountedPrice =
        finalTshirtPrice - (finalTshirtPrice * _discountValue / 100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${StringsManager.pricingCurrency} $discountedPrice',
              style: boldTextStyleManager(
                color: ColorsManager.black,
                fontSize: FontSizeManager.f22,
              ),
            ),
            const SizedBox(width: AppSizeManager.s10),
            (_discountValue == 0)
                ? const SizedBox()
                : Text(
                    '$finalTshirtPrice ',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: ColorsManager.black,
                      fontSize: FontSizeManager.f20,
                    ),
                  ),
            Text(
              '(-$_discountValue%)',
              style: mediumTextStyleManager(
                color: ColorsManager.black,
                fontSize: FontSizeManager.f20,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizeManager.s10),
        Text(
            'T-shirt (${StringsManager.pricingCurrency}${_tshirtPrice + sizePrice}) + Printing (${StringsManager.pricingCurrency}$printingPrice)  ->  Quantitiy (${_tshirtQuantityValue.toInt()})'),
      ],
    );
  }

  _setSizePrice() {
    if (_selectedTshirtSize == StringsManager.tshirtSizes2XL) {
      return 20;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes3XL) {
      return 40;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes4XL) {
      return 60;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes5XL) {
      return 80;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes6XL) {
      return 100;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes7XL) {
      return 120;
    } else {
      return 0;
    }
  }

  _setPrintingPrice() {
    if (_selectedPrintingTechnique == StringsManager.printingTechniqueDTF) {
      if (_selectedPrintingArea == StringsManager.printingAreasA3) {
        return 288;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA4) {
        return 144;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA5) {
        return 72;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA6) {
        return 36;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA7) {
        return 12;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  _setDiscountValue() {
    if (_tshirtQuantityValue == 1) {
      return 0;
    } else if (_tshirtQuantityValue == 25) {
      return 0;
    } else if (_tshirtQuantityValue == 50) {
      return 5;
    } else if (_tshirtQuantityValue == 100) {
      return 7;
    } else if (_tshirtQuantityValue == 200) {
      return 9;
    } else if (_tshirtQuantityValue == 300) {
      return 11;
    } else if (_tshirtQuantityValue == 500) {
      return 13;
    } else {
      return 0;
    }
  }
}
