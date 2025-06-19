import 'package:url_launcher/url_launcher.dart';

Future<void> launchWhatsApp({required String phone, String? message}) async {
  final String encodedMessage = Uri.encodeComponent(message ?? '');
  final String url =
      'https://wa.me/$phone${message != null ? '?text=$encodedMessage' : ''}';

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch WhatsApp';
  }
}
