import 'package:flutter/material.dart';
import 'package:inaxia_official_dashboard_web/model/models.dart';
import 'package:inaxia_official_dashboard_web/resources/assets_manager.dart';
import 'package:inaxia_official_dashboard_web/resources/colors_manager.dart';
import 'package:inaxia_official_dashboard_web/resources/fonts_manager.dart';
import 'package:inaxia_official_dashboard_web/resources/strings_manager.dart';
import 'package:inaxia_official_dashboard_web/resources/styles_manager.dart';
import 'package:inaxia_official_dashboard_web/resources/values_manager.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // FINAL PRICING
  late double _tshirtPrice;
  late int _printingPrice;
  late double _totalCost;
  int _discountValue = 0;
  late double _finalDiscountedPrice;

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
          AssetsManager.poloTshirt2,
          AssetsManager.poloTshirt3,
          AssetsManager.poloTshirt4,
          AssetsManager.poloTshirt5,
          AssetsManager.poloTshirt1,
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
          const SizedBox(width: AppPaddingManager.p10),
          _productImageBanner(),
        ],
      ),
    );
  }

  // MEDIUM SCREEN
  _mediumScreenBody() {
    return Center(
      child: SizedBox(
        width: AppWidgetWidthManager.sw700,
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
        height: AppWidgetHeightManager.sh700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _productImageBanner(),
            const SizedBox(height: AppPaddingManager.p10),
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
        height: AppWidgetHeightManager.sh1700,
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
      height: AppWidgetHeightManager.sh560,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _productImageBanner(),
          const SizedBox(height: AppPaddingManager.p10),
          _productImageScrolls(),
        ],
      ),
    );
  }

  _productImageBanner() {
    return SizedBox(
      height: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppWidgetHeightManager.sh600
          : (_screenWidth >= AppBreakpointManager.b550)
              ? AppWidgetHeightManager.sh500
              : AppWidgetHeightManager.sh450,
      width: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppWidgetWidthManager.sw400
          : (_screenWidth >= AppBreakpointManager.b550)
              ? AppWidgetWidthManager.sw400
              : double.maxFinite,
      child: Container(
        color: _selectedTshirtColor,
        // color: ColorsManager.lightBlack,
        child: InkWell(
          onTap: _interactiveImageView,
          child: Image.network(
            _selectedTshirtImages[_selectedTshirtImagesIndex],
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Expanded(
                child: Container(
                  color: ColorsManager.lightBlack,
                ),
              );
            },
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  _interactiveImageView() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(StringsManager.imageInteractiveView),
        content: Container(
          color: _selectedTshirtColor,
          child: InteractiveViewer(
            child: Image.network(
              _selectedTshirtImages[_selectedTshirtImagesIndex],
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Expanded(
                  child: Container(
                    color: ColorsManager.lightBlack,
                  ),
                );
              },
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  _productImageScrolls() {
    return SizedBox(
      height: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppWidgetHeightManager.sh600
          : AppWidgetHeightManager.sh100,
      width: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppWidgetWidthManager.sw100
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
                ? AppWidgetHeightManager.sh10
                : AppWidgetHeightManager.sh0,
            width: (_screenWidth >= AppBreakpointManager.b1100)
                ? AppWidgetWidthManager.sw0
                : AppWidgetWidthManager.sw10,
          ),
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: (_screenWidth >= AppBreakpointManager.b1100)
                  ? AppPaddingManager.p10
                  : AppPaddingManager.p0,
            ),
            child: Container(
              height: (_screenWidth >= AppBreakpointManager.b550)
                  ? AppWidgetHeightManager.sh120
                  : AppWidgetHeightManager.sh80,
              width: (_screenWidth >= AppBreakpointManager.b550)
                  ? AppWidgetWidthManager.sw60
                  : AppWidgetWidthManager.sw80,
              color: _selectedTshirtColor,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTshirtImagesIndex = index;
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Image.network(
                    _selectedTshirtImages[index],
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Expanded(
                        child: Container(
                          color: ColorsManager.lightBlack,
                        ),
                      );
                    },
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

  // DYNAMIC OPTIONS
  _productOptions() {
    return Padding(
      padding: const EdgeInsets.all(AppPaddingManager.p20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // T-SHIRT TYPE
          _optionTitle(StringsManager.tshirtTypeTitle, true),
          _heightSpacing(AppPaddingManager.p10),
          _tshirtType(),
          _heightSpacing(AppPaddingManager.p20),

          // T-SHIRT SIZES AVAILABLE
          _optionTitle(StringsManager.tshirtSizesTitle, true),
          _heightSpacing(AppPaddingManager.p10),
          _tshirtSizes(),
          _heightSpacing(AppPaddingManager.p20),

          // T-SHIRT COLORS AVAILABLE
          _optionTitle(StringsManager.tshirtColorsTitle, true),
          _heightSpacing(AppPaddingManager.p10),
          _tshirtColors(),
          _heightSpacing(AppPaddingManager.p20),

          // PRINTING TECHNIQUES
          _optionTitle(StringsManager.printingTechniquesTitle, true),
          _heightSpacing(AppPaddingManager.p10),
          _printingTechniques(),
          _heightSpacing(AppPaddingManager.p20),

          // PRINTING AREA
          _optionTitle(StringsManager.printingAreasTitle, true),
          _heightSpacing(AppPaddingManager.p10),
          _printingAreas(),
          _heightSpacing(AppPaddingManager.p20),

          // T-SHIRT QUANTITY
          _optionTitle(StringsManager.tshirtQuantityTitle, true),
          _heightSpacing(AppPaddingManager.p10),
          _tshirtQuantity(),
          _heightSpacing(AppPaddingManager.p20),

          // FINAL PRICE
          _optionTitle(StringsManager.pricingTitle, false),
          _heightSpacing(AppPaddingManager.p10),
          _finalPricing(),
          _heightSpacing(AppPaddingManager.p20),

          // SEND DETAILS ON WHATSAPP
          _heightSpacing(AppPaddingManager.p10),
          _sendDetailsOnWhatsApp(),
          _heightSpacing(AppPaddingManager.p20),
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
                  width: AppWidgetWidthManager.sw30,
                  height: AppWidgetHeightManager.sh30,
                  decoration: BoxDecoration(
                    color: (_selectedTshirtColorsIndex == index)
                        ? ColorsManager.primary
                        : ColorsManager.transparent,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppRadiusManager.r4)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPaddingManager.p3),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _tshirtColorsAvailable[index],
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppRadiusManager.r30)),
                        border: (_tshirtColorsAvailable[index] ==
                                ColorsManager.whiteTshirt)
                            ? Border.all(
                                color: ColorsManager.black,
                                width: AppWidgetWidthManager.sw0_5,
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

  // FROM COLOR TO STRING
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
                _selectedPrintingArea = null;
                _selectedPrintingAreaIndex = null;
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
          : AppWidgetWidthManager.sw400,
      child: Column(
        children: [
          Container(
            height: AppWidgetHeightManager.sh30,
            padding:
                const EdgeInsets.symmetric(horizontal: AppPaddingManager.p10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                _tshirtQuantityList.length,
                (index) => SizedBox(
                  height: AppWidgetHeightManager.sh30,
                  width: AppWidgetWidthManager.sw27,
                  child: Column(
                    children: [
                      Text(_tshirtQuantityList[index]),
                      const SizedBox(height: AppWidgetHeightManager.sh4),
                      Container(
                        height: AppWidgetHeightManager.sh10,
                        width: AppWidgetWidthManager.sw1,
                        color: ColorsManager.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Slider(
            min: AppValueManager.v1.toDouble(),
            max: AppValueManager.v500.toDouble(),
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
    if (value == AppValueManager.v1) {
      _tshirtQuantityValue = AppValueManager.v1;
    } else if (value == AppValueManager.v84) {
      _tshirtQuantityValue = AppValueManager.v25;
    } else if (value == AppValueManager.v167) {
      _tshirtQuantityValue = AppValueManager.v50;
    } else if (value == AppValueManager.v250) {
      _tshirtQuantityValue = AppValueManager.v100;
    } else if (value == AppValueManager.v333) {
      _tshirtQuantityValue = AppValueManager.v200;
    } else if (value == AppValueManager.v416) {
      _tshirtQuantityValue = AppValueManager.v300;
    } else if (value == AppValueManager.v500) {
      _tshirtQuantityValue = AppValueManager.v500;
    }
  }

  // TOTAL PRICING CALCULATION
  _finalPricing() {
    int sizePrice = AppValueManager.v0;
    sizePrice = _setSizePrice();
    _printingPrice = _setPrintingPrice();

    _discountValue = _setDiscountValue();
    _totalCost = (_tshirtPrice + sizePrice + _printingPrice) *
        (_tshirtQuantityValue.toInt());
    _finalDiscountedPrice = _totalCost - (_totalCost * _discountValue / AppValueManager.v100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${StringsManager.pricingCurrency} $_finalDiscountedPrice',
              style: boldTextStyleManager(
                color: ColorsManager.black,
                fontSize: FontSizeManager.f22,
              ),
            ),
            const SizedBox(width: AppWidgetWidthManager.sw10),
            (_discountValue == AppValueManager.v0)
                ? const SizedBox()
                : Text(
                    '$_totalCost ',
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
        const SizedBox(height: AppWidgetHeightManager.sh10),
        Text(
            'T-shirt (${StringsManager.pricingCurrency}${_tshirtPrice + sizePrice}) + Printing (${StringsManager.pricingCurrency}$_printingPrice)  ->  Quantitiy (${_tshirtQuantityValue.toInt()})'),
      ],
    );
  }

  _setSizePrice() {
    if (_selectedTshirtSize == StringsManager.tshirtSizes2XL) {
      return AppValueManager.v20;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes3XL) {
      return AppValueManager.v40;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes4XL) {
      return AppValueManager.v60;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes5XL) {
      return AppValueManager.v80;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes6XL) {
      return AppValueManager.v100;
    } else if (_selectedTshirtSize == StringsManager.tshirtSizes7XL) {
      return AppValueManager.v120;
    } else {
      return AppValueManager.v0;
    }
  }

  _setPrintingPrice() {
    if (_selectedPrintingTechnique == StringsManager.printingTechniqueDTF) {
      if (_selectedPrintingArea == StringsManager.printingAreasA3) {
        return AppValueManager.v288;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA4) {
        return AppValueManager.v144;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA5) {
        return AppValueManager.v72;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA6) {
        return AppValueManager.v36;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA7) {
        return AppValueManager.v12;
      } else {
        return AppValueManager.v0;
      }
    } else {
      return AppValueManager.v0;
    }
  }

  _setDiscountValue() {
    if (_tshirtQuantityValue == 1) {
      return AppValueManager.v0;
    } else if (_tshirtQuantityValue == 25) {
      return AppValueManager.v0;
    } else if (_tshirtQuantityValue == 50) {
      return AppValueManager.v5;
    } else if (_tshirtQuantityValue == 100) {
      return AppValueManager.v7;
    } else if (_tshirtQuantityValue == 200) {
      return AppValueManager.v9;
    } else if (_tshirtQuantityValue == 300) {
      return AppValueManager.v11;
    } else if (_tshirtQuantityValue == 500) {
      return AppValueManager.v13;
    } else {
      return AppValueManager.v0;
    }
  }

  _sendDetailsOnWhatsApp() {
    return InkWell(
      onTap: _sendWhatsappMessage,
      child: Container(
        height: AppWidgetHeightManager.sh50,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: ColorsManager.whatsappGreen,
            borderRadius:
                BorderRadius.all(Radius.circular(AppRadiusManager.r10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppWidgetHeightManager.sh30,
              child: Image.asset(AssetsManager.whatsappLogo),
            ),
            const SizedBox(width: AppWidgetWidthManager.sw10),
            Text(
              StringsManager.whatsappButtonText,
              style: mediumTextStyleManager(
                color: ColorsManager.white,
                fontSize: FontSizeManager.f18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _sendWhatsappMessage() async {
    // const String whatsappNumber = '919540460273'; // NISHANT'S NUMBER
    const String whatsappNumber =
        '919319289478'; // INAXIA OFFICIAL WHATSAPP NUMBER
    String message =
        'Hi, I\'m looking for... \n• T-shirt Type: ${_allTshirtTypes[_selectedTshirtTypeIndex].tshirtType} \n• T-shirt Size: $_selectedTshirtSize \n• T-shirt Color: ${_getColorName(_selectedTshirtColor)} \n• Printing Technique: $_selectedPrintingTechnique \n• Printing Area (inch): $_selectedPrintingArea \n• T-shirt Price: ₹$_tshirtPrice \n• Printing Price: ₹$_printingPrice \n• T-shirt Quantity: $_tshirtQuantityValue \nTotal Cost: ₹$_totalCost \nDiscount: $_discountValue% \nFinal Price: ₹$_finalDiscountedPrice';
    final url = Uri.parse("https://wa.me/$whatsappNumber?text=$message");
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
