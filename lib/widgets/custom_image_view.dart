// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageView extends StatelessWidget {
  ///[imagePath] is required parameter for showing image
  String? imagePath;

  double? height;
  double? width;
  Color? color;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;

  ///a [CustomImageView] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  CustomImageView({
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = 'assets/images/image_not_found.png',
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        // Add this
        color: Colors.transparent, // Add this
        child: InkWell(
          onTap: onTap,
          child: _buildCircleImage(),
        ),
      ),
    );
  }

  ///build the image with border radius
  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (imagePath != null) {
      Widget image;
      switch (imagePath!.imageType) {
        case ImageType.svg:
          image = SvgPicture.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            color: color,
          );
          break;
        case ImageType.file:
          image = Image.file(
            File(imagePath!),
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
          break;
        case ImageType.network:
          image = CachedNetworkImage(
            height: height,
            width: width,
            fit: fit,
            imageUrl: imagePath!,
            color: color,
            placeholder: (context, url) => Container(
              height: 30,
              width: 30,
              child: LinearProgressIndicator(
                color: Colors.grey.shade200,
                backgroundColor: Colors.grey.shade100,
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              placeHolder,
              height: height,
              width: width,
              fit: fit ?? BoxFit.cover,
            ),
          );
          break;
        case ImageType.png:
        default:
          image = Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
      }
      return Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: image, // replace with your image
          ),
          const Positioned(
            top: 10,
            right: 20,
            child: Icon(Icons.visibility,
                size: 40, color: Color.fromARGB(255, 66, 66, 66)),
          ),
        ],
      );
    }
    return const SizedBox();
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (this.startsWith('http') || this.startsWith('https')) {
      return ImageType.network;
    } else if (this.endsWith('.svg')) {
      return ImageType.svg;
    } else if (this.startsWith('file://')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }
