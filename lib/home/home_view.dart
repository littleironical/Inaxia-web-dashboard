import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inaxia_catalogue/model/models.dart';
import 'package:inaxia_catalogue/resources/assets_manager.dart';
import 'package:inaxia_catalogue/resources/colors_manager.dart';
import 'package:inaxia_catalogue/resources/fonts_manager.dart';
import 'package:inaxia_catalogue/resources/icons_manager.dart';
import 'package:inaxia_catalogue/resources/strings_manager.dart';
import 'package:inaxia_catalogue/resources/styles_manager.dart';
import 'package:inaxia_catalogue/resources/values_manager.dart';
import 'package:shimmer/shimmer.dart';
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
  int _printingAreaHeight = 0;
  int _printingAreaWidth = 0;
  bool _isCustomPrintingArea = false;

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
  bool _isCustomTshirtQuantity = false;
  String _customTshirtErrorMessage = StringsManager.emptyString;

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
        StringsManager.tshirtTypePolo,
        270,
        [
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
          ColorsManager.greenTshirt,
        ],
        [
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
        StringsManager.tshirtTypeRegular,
        160,
        [
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
        StringsManager.tshirtTypeOversized,
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

    return RefreshIndicator(
      color: ColorsManager.primary,
      onRefresh: () {
        setState(() {
          // SETTINGS VALUES TO INITIAL VALUES
          // T-SHIRT TYPE
          _selectedTshirtTypeIndex = AppValueManager.v0;

          for (var element in _allTshirtTypes) {
            element.isSelected = false;
          }
          _allTshirtTypes[_selectedTshirtTypeIndex].isSelected = true;

          _tshirtPrice = _allTshirtTypes[_selectedTshirtTypeIndex].tshirtPrice;

          // T-SHIRT IMAGES
          _selectedTshirtImagesIndex = AppValueManager.v0;
          _selectedTshirtImages =
              _allTshirtTypes[_selectedTshirtTypeIndex].tshirtImages;

          // T-SHIRT SIZES
          _selectedTshirtSize = null;
          _selectedTshirtSizeIndex = null;
          _tshirtSizesAvaialble =
              _allTshirtTypes[_selectedTshirtTypeIndex].tshirtSizesAvailable;

          // T-SHIRT COLORS
          _tshirtColorsAvailable =
              _allTshirtTypes[_selectedTshirtTypeIndex].tshirtColorsAvailable;
          _selectedTshirtColorsIndex = 0;
          _selectedTshirtColor =
              _tshirtColorsAvailable[_selectedTshirtColorsIndex];

          // PRINTING TECHNIQUES
          _selectedPrintingTechnique = null;
          _selectedPrintingTechniquesIndex = null;

          // PRINTING AREAS
          _selectedPrintingArea = null;
          _selectedPrintingAreaIndex = null;

          // QUANTITY
          _tshirtQuantityValue = AppValueManager.v1;
          _tshirtQuantitySliderValue = AppValueManager.v1;
        });
        return Future<void>.delayed(
            const Duration(seconds: AppValueManager.v1));
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
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
        ),
      ),
    );
  }

  // LARGE SCREEN
  _largeScreenBody() {
    return Center(
      child: SizedBox(
        width: AppBreakpointManager.b1265,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
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
        height: AppWidgetHeightManager.sh1800,
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
    );
  }

  _productImageBanner() {
    String? swipeDirection;

    return SizedBox(
      height: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppWidgetHeightManager.sh600
          : (_screenWidth >= AppBreakpointManager.b550)
              ? AppWidgetHeightManager.sh500
              : AppWidgetHeightManager.sh590,
      width: (_screenWidth >= AppBreakpointManager.b1100)
          ? AppWidgetWidthManager.sw400
          : (_screenWidth >= AppBreakpointManager.b550)
              ? AppWidgetWidthManager.sw400
              : double.maxFinite,
      child: Container(
        color: _selectedTshirtColor,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _interactiveImageView,
            onPanUpdate: (details) {
              swipeDirection = details.delta.dx < 0 ? 'left' : 'right';
            },
            onPanEnd: (details) {
              if (swipeDirection == null) {
                return;
              }

              // SWIPED LEFT - NEXT IMAGE TO BE SEEN
              if (swipeDirection == 'left') {
                if (_selectedTshirtImagesIndex ==
                    (_allTshirtTypes[_selectedTshirtTypeIndex]
                            .tshirtImages
                            .length -
                        1)) {
                  return;
                } else {
                  setState(() {
                    _selectedTshirtImagesIndex++;
                  });
                }
              }

              // SWIPED RIGHT - PREVIUOS IMAGE TO BE SEEN
              else if (swipeDirection == 'right') {
                if (_selectedTshirtImagesIndex == 0) {
                  return;
                } else {
                  setState(() {
                    _selectedTshirtImagesIndex--;
                  });
                }
              }
            },
            child: Image.network(
              _selectedTshirtImages[_selectedTshirtImagesIndex],
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Shimmer.fromColors(
                  baseColor: ColorsManager.lightBlack,
                  highlightColor: ColorsManager.darkLightBlack,
                  child: Container(
                    color: ColorsManager.white,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: ColorsManager.lightBlack,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(IconsManager.error),
                      SizedBox(height: AppWidgetHeightManager.sh10),
                      Text(StringsManager.networkError),
                    ],
                  ),
                );
              },
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
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
                return Shimmer.fromColors(
                  baseColor: ColorsManager.lightBlack,
                  highlightColor: ColorsManager.darkLightBlack,
                  child: Container(
                    color: ColorsManager.white,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: ColorsManager.lightBlack,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(IconsManager.error),
                      SizedBox(height: AppWidgetHeightManager.sh10),
                      Text(StringsManager.networkError),
                    ],
                  ),
                );
              },
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
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
                  child: Container(
                    decoration: BoxDecoration(
                      border: (_selectedTshirtImagesIndex == index)
                          ? Border.all(
                              color: ColorsManager.primary,
                              width: AppWidgetWidthManager.sw2,
                            )
                          : null,
                    ),
                    child: Image.network(
                      _selectedTshirtImages[index],
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Shimmer.fromColors(
                          baseColor: ColorsManager.lightBlack,
                          highlightColor: ColorsManager.darkLightBlack,
                          child: Container(
                            color: ColorsManager.white,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: ColorsManager.lightBlack,
                          child: const Icon(IconsManager.error),
                        );
                      },
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
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
          _tshirtColorsTitle(),
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
          _customPrintingAreasSwitch(),
          _heightSpacing(AppPaddingManager.p10),
          (_isCustomPrintingArea) ? _customPrintingAreas() : _printingAreas(),
          _heightSpacing(AppPaddingManager.p20),

          // T-SHIRT QUANTITY
          _optionTitle(StringsManager.tshirtQuantityTitle, true),
          _customTshirtQuantitySwitch(),
          _heightSpacing(AppPaddingManager.p10),
          (_isCustomTshirtQuantity)
              ? _customTshirtQuantity()
              : _tshirtQuantity(),
          _heightSpacing(AppPaddingManager.p20),

          // FINAL PRICE
          _optionTitle(StringsManager.pricingTitle, false),
          _heightSpacing(AppPaddingManager.p10),
          _finalPricing(),
          _heightSpacing(AppPaddingManager.p20),

          // ORDER A SAMPLE BUTTON
          _heightSpacing(AppPaddingManager.p10),
          _orderASample(),
          // _heightSpacing(AppPaddingManager.p10),

          // SHARE ON WHATSAPP BUTTON
          _heightSpacing(AppPaddingManager.p10),
          _shareOnWhatsApp(),
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
                  _tshirtPrice =
                      _allTshirtTypes[_selectedTshirtTypeIndex].tshirtPrice;

                  // T-SHIRT IMAGES
                  _selectedTshirtImages =
                      _allTshirtTypes[_selectedTshirtTypeIndex].tshirtImages;
                  _selectedTshirtImagesIndex = 0;

                  // T-SHIRT SIZES
                  _tshirtSizesAvaialble =
                      _allTshirtTypes[_selectedTshirtTypeIndex]
                          .tshirtSizesAvailable;
                  _selectedTshirtSize = null;
                  _selectedTshirtSizeIndex = null;

                  // T-SHIRT COLORS
                  _tshirtColorsAvailable =
                      _allTshirtTypes[_selectedTshirtTypeIndex]
                          .tshirtColorsAvailable;
                  _selectedTshirtColorsIndex = 0;
                  _selectedTshirtColor =
                      _tshirtColorsAvailable[_selectedTshirtColorsIndex];

                  // PRINTING TECHNIQUES
                  _selectedPrintingTechnique = null;
                  _selectedPrintingTechniquesIndex = null;

                  // PRINTING AREAS
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
              padding:
                  const EdgeInsets.symmetric(vertical: AppPaddingManager.p15),
              child: Text(
                _allTshirtTypes[index].tshirtType,
                style: (_allTshirtTypes[index].isSelected == true)
                    ? regularTextStyleManager(color: ColorsManager.white)
                    : null,
              ),
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
              padding:
                  const EdgeInsets.symmetric(vertical: AppPaddingManager.p15),
              child: Text(
                _tshirtSizesAvaialble[index],
                style: (_selectedTshirtSizeIndex == index)
                    ? regularTextStyleManager(color: ColorsManager.white)
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _tshirtColorsTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _optionTitle(StringsManager.tshirtColorsTitle, true),
        const SizedBox(width: AppWidgetWidthManager.sw1),
        Text(
            '(${_getColorName(_tshirtColorsAvailable[_selectedTshirtColorsIndex])})'),
      ],
    );
  }

  _tshirtColors() {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: AppPaddingManager.p10,
      children: List.generate(
        _tshirtColorsAvailable.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: AppPaddingManager.p10),
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
                  width: AppWidgetWidthManager.sw40,
                  height: AppWidgetHeightManager.sh40,
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
                                color: ColorsManager.primary,
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
              padding:
                  const EdgeInsets.symmetric(vertical: AppPaddingManager.p15),
              child: Text(
                _printingTechniquesAvailable[index],
                style: (_selectedPrintingTechniquesIndex == index)
                    ? regularTextStyleManager(color: ColorsManager.white)
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _customPrintingAreasSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _optionTitle(StringsManager.customPrintitngArea, false),
        const SizedBox(width: AppWidgetWidthManager.sw1),
        Switch(
          value: _isCustomPrintingArea,
          onChanged: (value) {
            setState(() {
              _isCustomPrintingArea = !_isCustomPrintingArea;
              _selectedPrintingArea = null;
              _selectedPrintingAreaIndex = null;
              _printingAreaHeight = 0;
              _printingAreaWidth = 0;
            });
          },
        ),
      ],
    );
  }

  _customPrintingAreas() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(StringsManager.customPrintingHeight),
            const SizedBox(width: AppWidgetWidthManager.sw10),
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: (_selectedPrintingTechniquesIndex == null)
                  ? StringsManager.selectPrintingTechnique
                  : StringsManager.emptyString,
              child: DropdownButton(
                value: _printingAreaHeight,
                menuMaxHeight: AppWidgetHeightManager.sh400,
                elevation: AppValueManager.v10,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPaddingManager.p10),
                borderRadius: const BorderRadius.all(
                    Radius.circular(AppRadiusManager.r10)),
                icon: const Icon(IconsManager.arrowDown),
                items: List.generate(
                  AppValueManager.v23,
                  (index) => DropdownMenuItem(
                    value: index,
                    child: Text(
                      (index).toString(),
                    ),
                  ),
                ),
                onChanged: (_selectedPrintingTechniquesIndex == null)
                    ? null
                    : (value) {
                        setState(() {
                          _printingAreaHeight = int.parse(value.toString());
                        });
                      },
              ),
            ),
          ],
        ),
        const SizedBox(width: AppWidgetWidthManager.sw10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(StringsManager.customPrintingWidth),
            const SizedBox(width: AppWidgetWidthManager.sw10),
            Tooltip(
              triggerMode: TooltipTriggerMode.tap,
              message: (_selectedPrintingTechniquesIndex == null)
                  ? StringsManager.selectPrintingTechnique
                  : StringsManager.emptyString,
              child: DropdownButton(
                value: _printingAreaWidth,
                menuMaxHeight: AppWidgetHeightManager.sh400,
                elevation: AppValueManager.v10,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPaddingManager.p10),
                borderRadius: const BorderRadius.all(
                    Radius.circular(AppRadiusManager.r10)),
                icon: const Icon(IconsManager.arrowDown),
                items: List.generate(
                  AppValueManager.v23,
                  (index) => DropdownMenuItem(
                    value: index,
                    child: Text(
                      (index).toString(),
                    ),
                  ),
                ),
                onChanged: (_selectedPrintingTechniquesIndex == null)
                    ? null
                    : (value) {
                        setState(() {
                          _printingAreaWidth = int.parse(value.toString());
                        });
                      },
              ),
            ),
          ],
        ),
      ],
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
            triggerMode: TooltipTriggerMode.tap,
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
                padding:
                    const EdgeInsets.symmetric(vertical: AppPaddingManager.p15),
                child: Text(
                  _printingAreaAvailable[index],
                  style: (_selectedPrintingAreaIndex == index)
                      ? regularTextStyleManager(color: ColorsManager.white)
                      : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _customTshirtQuantitySwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _optionTitle(StringsManager.customTshirtQuality, false),
        const SizedBox(width: AppWidgetWidthManager.sw1),
        Switch(
          value: _isCustomTshirtQuantity,
          onChanged: (value) {
            setState(() {
              _isCustomTshirtQuantity = !_isCustomTshirtQuantity;
              _customTshirtErrorMessage = StringsManager.emptyString;
              _tshirtQuantityValue = AppValueManager.v1;
              _tshirtQuantitySliderValue = AppValueManager.v1;
            });
          },
        ),
      ],
    );
  }

  _customTshirtQuantity() {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        initialValue: _tshirtQuantityValue.toString(),
        cursorColor: ColorsManager.primary,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.done,
        maxLines: AppValueManager.v1,
        maxLength: AppValueManager.v3,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          labelText: StringsManager.customTshirtsNumber,
          errorText: (_customTshirtErrorMessage == StringsManager.emptyString)
              ? null
              : _customTshirtErrorMessage,
        ),
        onChanged: (value) {
          if (value == StringsManager.emptyString || value.isEmpty) {
            setState(() {
              _customTshirtErrorMessage =
                  StringsManager.customTshirtsErrorNumberEmpty;
            });
          } else if (int.parse(value) < 1) {
            setState(() {
              _customTshirtErrorMessage =
                  StringsManager.customTshirtsErrorNumberBetween1To999;
            });
          } else {
            setState(() {
              _customTshirtErrorMessage = StringsManager.emptyString;
              _tshirtQuantityValue = int.parse(value);
            });
          }
        },
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
            height: AppWidgetHeightManager.sh35,
            padding:
                const EdgeInsets.symmetric(horizontal: AppPaddingManager.p10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                _tshirtQuantityList.length,
                (index) => SizedBox(
                  height: AppWidgetHeightManager.sh35,
                  width: AppWidgetWidthManager.sw27,
                  child: Column(
                    children: [
                      Text(_tshirtQuantityList[index]),
                      const SizedBox(height: AppWidgetHeightManager.sh4),
                      Container(
                        height: AppWidgetHeightManager.sh10,
                        width: AppWidgetWidthManager.sw1,
                        color: ColorsManager.primary,
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
    _setPrintingPrice();
    _printingPrice = _printingAreaHeight * _printingAreaWidth;

    _discountValue = _setDiscountValue();
    _totalCost = (_tshirtPrice + sizePrice + _printingPrice) *
        (_tshirtQuantityValue.toInt());
    _finalDiscountedPrice =
        _totalCost - (_totalCost * _discountValue / AppValueManager.v100);

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
                fontSize: FontSizeManager.f24,
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
        _printingAreaHeight = AppValueManager.v16;
        _printingAreaWidth = AppValueManager.v12;
        // return AppValueManager.v288;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA4) {
        _printingAreaHeight = AppValueManager.v12;
        _printingAreaWidth = AppValueManager.v8;
        // return AppValueManager.v144;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA5) {
        _printingAreaHeight = AppValueManager.v8;
        _printingAreaWidth = AppValueManager.v6;
        // return AppValueManager.v72;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA6) {
        _printingAreaHeight = AppValueManager.v6;
        _printingAreaWidth = AppValueManager.v4;
        // return AppValueManager.v36;
      } else if (_selectedPrintingArea == StringsManager.printingAreasA7) {
        _printingAreaHeight = AppValueManager.v4;
        _printingAreaWidth = AppValueManager.v2;
        // return AppValueManager.v12;
      } else {
        // return AppValueManager.v0;
      }
    } else {
      // return AppValueManager.v0;
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

  _orderASample() {
    return InkWell(
      onTap: () => _sendWhatsappMessage(
          'Hi, I wanted to order a sample of \n• T-shirt Type: ${_allTshirtTypes[_selectedTshirtTypeIndex].tshirtType} \n• T-shirt Size: $_selectedTshirtSize \n• T-shirt Color: ${_getColorName(_selectedTshirtColor)} \n• Printing Technique: $_selectedPrintingTechnique \n• Printing Area (inch): $_printingAreaHeight x $_printingAreaWidth \n• T-shirt Price: ₹$_tshirtPrice \n• Printing Price: ₹$_printingPrice \n• T-shirt Quantity: $_tshirtQuantityValue \nTotal Cost: ₹$_totalCost \nDiscount: $_discountValue% \nFinal Price: ₹$_finalDiscountedPrice'),
      child: Container(
        height: AppWidgetHeightManager.sh50,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: ColorsManager.primary,
            borderRadius:
                BorderRadius.all(Radius.circular(AppRadiusManager.r10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: AppWidgetHeightManager.sh30,
              child: Icon(
                IconsManager.orderASampleIcon,
                size: AppWidgetHeightManager.sh30,
                color: ColorsManager.white,
              ),
            ),
            const SizedBox(width: AppWidgetWidthManager.sw10),
            Text(
              StringsManager.orderASampleButtonText,
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

  _shareOnWhatsApp() {
    return InkWell(
      onTap: () => _sendWhatsappMessage(
          'Hi, I\'m looking for... \n• T-shirt Type: ${_allTshirtTypes[_selectedTshirtTypeIndex].tshirtType} \n• T-shirt Size: $_selectedTshirtSize \n• T-shirt Color: ${_getColorName(_selectedTshirtColor)} \n• Printing Technique: $_selectedPrintingTechnique \n• Printing Area (inch): $_printingAreaHeight x $_printingAreaWidth \n• T-shirt Price: ₹$_tshirtPrice \n• Printing Price: ₹$_printingPrice \n• T-shirt Quantity: $_tshirtQuantityValue \nTotal Cost: ₹$_totalCost \nDiscount: $_discountValue% \nFinal Price: ₹$_finalDiscountedPrice'),
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

  Future _sendWhatsappMessage(String whatsAppMessage) async {
    // const String whatsappNumber = '919540460273'; // NISHANT'S NUMBER
    const String whatsappNumber =
        '919319289478'; // INAXIA OFFICIAL WHATSAPP NUMBER
    String message = whatsAppMessage;
    // 'Hi, I\'m looking for... \n• T-shirt Type: ${_allTshirtTypes[_selectedTshirtTypeIndex].tshirtType} \n• T-shirt Size: $_selectedTshirtSize \n• T-shirt Color: ${_getColorName(_selectedTshirtColor)} \n• Printing Technique: $_selectedPrintingTechnique \n• Printing Area (inch): $_printingAreaHeight x $_printingAreaWidth \n• T-shirt Price: ₹$_tshirtPrice \n• Printing Price: ₹$_printingPrice \n• T-shirt Quantity: $_tshirtQuantityValue \nTotal Cost: ₹$_totalCost \nDiscount: $_discountValue% \nFinal Price: ₹$_finalDiscountedPrice';
    final url = Uri.parse("https://wa.me/$whatsappNumber?text=$message");
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
