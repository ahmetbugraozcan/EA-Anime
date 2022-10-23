import 'package:flutter/material.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Widgets/Dialog/dialog_color.scheme.dart';

class DialogWithBackground extends StatelessWidget {
  String title;
  String contentText;
  VoidCallback? onConfirm;
  VoidCallback? onCancel;
  String? confirmText;

  DialogEnums dialogType;

  DialogWithBackground({
    super.key,
    this.confirmText,
    this.title = "",
    this.contentText = "",
    this.onCancel,
    this.dialogType = DialogEnums.INFORMATION,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    // Dialog tipine göre tema renklerini getiren fonksiyon
    DialogColorScheme colorScheme =
        DialogColorScheme.getDialogColorScheme(dialogType);

    return Dialog(
      backgroundColor: colorScheme.backgroundColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info,
                    color: Colors.grey.shade200.withOpacity(0.4),
                  ),
                  SizedBox(width: 8),
                  Text(
                    title,
                    style: context.textTheme.headline5?.copyWith(
                        color: Colors.grey.shade200,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                contentText,
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey.shade200),
              ),
              SizedBox(
                height: 24,
              ),
              Builder(
                builder: (context) {
                  switch (dialogType) {
                    case DialogEnums.INFORMATION:
                    case DialogEnums.ERROR:
                      return Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              elevation: 1,
                              backgroundColor: colorScheme.cancelButtonColor,
                            ),
                            onPressed: onConfirm,
                            child: Text(
                              "Tamam",
                              style: context.textTheme.caption?.copyWith(
                                  color: colorScheme.cancelButtonTextColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      );

                    case DialogEnums.INTERACTIVE:
                      return Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 1,
                                    padding: EdgeInsets.zero,
                                    backgroundColor:
                                        colorScheme.cancelButtonColor),
                                onPressed: onCancel ??
                                    () {
                                      Navigator.pop(context);
                                    },
                                child: Text(
                                  "Vazgeç",
                                  style: context.textTheme.caption?.copyWith(
                                      color: colorScheme.cancelButtonTextColor),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 4,
                            child: SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  elevation: 1,
                                  backgroundColor:
                                      colorScheme.approvalButtonColor,
                                ),
                                onPressed: onConfirm,
                                child: Text(
                                  confirmText ?? "Onayla",
                                  style: context.textTheme.caption?.copyWith(
                                      color:
                                          colorScheme.approvalButtonTextColor),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    default:
                      return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
