// Copyright 2018 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a 2-clause BSD License.
// The main directory contains that LICENSE file.
//
//          Created  11 Sep 2018
//

import 'package:flutter/material.dart'
    show
        AlignmentDirectional,
        BoxConstraints,
        BuildContext,
        Container,
        DefaultTextStyle,
        EdgeInsetsDirectional,
        IconTheme,
        MediaQuery,
        MergeSemantics,
        StatelessWidget,
        Text,
        TextButton,
        TextOverflow,
        TextSpan,
        TextStyle,
        Theme,
        VoidCallback,
        Widget,
        showAboutDialog;

import 'package:flutter/gestures.dart' show TapGestureRecognizer;

import 'package:url_launcher/url_launcher.dart' show launchUrl;

import 'package:flutter/foundation.dart' as p
    show defaultTargetPlatform, TargetPlatform;

// ignore: avoid_classes_with_only_static_members
/// Readily supply the app's settings in an about window.
class AppSettings {
  /// Return the 'default' [p.TargetPlatform] object.
  static p.TargetPlatform get defaultTargetPlatform => p.defaultTargetPlatform;

  /// A simple Widget of Text to 'tap' on.
  static StatelessWidget tapText(String text, VoidCallback onTap,
      {TextStyle? style}) {
    return _TapText(text, onTap, style: style);
  }

  /// A simple URL link Widget.
  static LinkTextSpan linkTextSpan(
      {TextStyle? style, String? url, String? text}) {
    return LinkTextSpan(
        style: style, url: url ?? 'http://www.google.com', text: text);
  }

  /// Show a simple 'About' Screen displaying information about the App.
  static void showAbout({
    required BuildContext context,
    String? applicationName,
    String? applicationVersion,
    Widget? applicationIcon,
    String? applicationLegalese,
    List<Widget>? children,
  }) {
    showAboutDialog(
      context: context,
      applicationName: applicationName,
      applicationVersion: applicationVersion,
      applicationIcon: applicationIcon,
      applicationLegalese: applicationLegalese,
      children: children,
    );
  }
}

class _TapText extends StatelessWidget {
  const _TapText(this.text, this.onTap, {this.style});

  final String text;
  final VoidCallback onTap;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return _OptionsItem(
      child: _FlatButton(
        onPressed: onTap,
        style: style,
        child: Text(text),
      ),
    );
  }
}

class _OptionsItem extends StatelessWidget {
  const _OptionsItem({this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Container(
        constraints: BoxConstraints(
            minHeight: 48.0 *
                MediaQuery.textScalerOf(context)
                    .scale(DefaultTextStyle.of(context).style.fontSize ?? 14)),
        padding: const EdgeInsetsDirectional.only(start: 56),
        alignment: AlignmentDirectional.centerStart,
        child: DefaultTextStyle(
          style: DefaultTextStyle.of(context).style,
          maxLines: 2,
          overflow: TextOverflow.fade,
          child: IconTheme(
            data: Theme.of(context).primaryIconTheme,
            child: child!,
          ),
        ),
      ),
    );
  }
}

class _FlatButton extends StatelessWidget {
  const _FlatButton({
    this.onPressed,
    this.child,
    this.style,
  });

  final VoidCallback? onPressed;
  final Widget? child;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final child = style == null
        ? this.child!
        : DefaultTextStyle(
            style: style!,
            child: this.child!,
          );
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

///
class LinkTextSpan extends TextSpan {
  // Beware!
  //
  // This class is only safe because the TapGestureRecognizer is not
  // given a deadline and therefore never allocates any resources.
  //
  // In any other situation -- setting a deadline, using any of the less trivial
  // recognizers, etc -- you would have to manage the gesture recognizer's
  // lifetime and call dispose() when the TextSpan was no longer being rendered.
  //
  // Since TextSpan itself is @immutable, this means that you would have to
  // manage the recognizer from outside the TextSpan, e.g. in the State of a
  // stateful widget that then hands the recognizer to the TextSpan.
  ///
  LinkTextSpan({super.style, required String url, String? text})
      : super(
            text: text ?? url,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrl(Uri.parse(url));
              });
}
