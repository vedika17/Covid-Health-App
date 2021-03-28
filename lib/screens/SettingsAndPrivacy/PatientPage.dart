import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/screens/PatientHome/PatientHome_Mobile.dart';
import 'package:covid_health_app/screens/SettingsAndPrivacy/ChangePassword.dart';
import 'package:covid_health_app/screens/SettingsAndPrivacy/EditPersonalInfo.dart';
import 'package:covid_health_app/widgets/Loading.dart';

import 'ViewProfile.dart';

class PatientProfilePage extends StatefulWidget {
  final String pE;

  PatientProfilePage(this.pE);

  _PatientProfilePageState createState() => _PatientProfilePageState(pE);
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  final String pE;
  final FirebaseStorage storage = FirebaseStorage(
    app: Firestore.instance.app,
    storageBucket: "gs://menonhealthtest.appspot.com/",
  );
  Uint8List imageBytes;
  String errorMsg;

  _PatientProfilePageState(this.pE) {
    print("inside profile" + pE + ".jpeg");
    storage
        .ref()
        .child("ProfileImages/")
        .child(pE + ".jpeg")
        .getData(10000000)
        .then((data) => setState(() {
              imageBytes = data;
            }))
        .catchError((e) => setState(() {
              errorMsg = e.error;
            }));
  }

  Widget _buildAboutTnC(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("1. Introduction\n",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            )),
        RichText(
          text: new TextSpan(
            text:
                "Welcome to Menon Health Tech Pvt Ltd (“Company”, “we”, “our”, “us”)!\n\nThese Terms of Service (“Terms”, “Terms of Service”) govern your use of our website located at menonhealthtech.in (together or individually “Service”) operated by Menon Health Tech Pvt Ltd.\n\nOur Privacy Policy also governs your use of our Service and explains how we collect, safeguard and disclose information that results from your use of our web pages.\n\nYour agreement with us includes these Terms and our Privacy Policy (“Agreements”). You acknowledge that you have read and understood Agreements, and agree to be bound of them.\n\nIf you do not agree with (or cannot comply with) Agreements, then you may not use the Service, but please let us know by emailing at healthtechmenon@gmail.com so we can try to find a solution. These Terms apply to all visitors, users and others who wish to access or use Service.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("2. Communications\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "By using our Service, you agree to subscribe to newsletters, marketing or promotional materials and other information we may send. However, you may opt out of receiving any, or all, of these communications from us by following the unsubscribe link or by emailing at healthtechmenon@gmail.com.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("3. Purchases\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "If you wish to purchase any product or service made available through Service (“Purchase”), you may be asked to supply certain information relevant to your Purchase including but not limited to, your credit or debit card number, the expiration date of your card, your billing address, and your shipping information.\n\nYou represent and warrant that: (i) you have the legal right to use any card(s) or other payment method(s) in connection with any Purchase; and that (ii) the information you supply to us is true, correct and complete.\n\nWe may employ the use of third party services for the purpose of facilitating payment and the completion of Purchases. By submitting your information, you grant us the right to provide the information to these third parties subject to our Privacy Policy.\n\nWe reserve the right to refuse or cancel your order at any time for reasons including but not limited to: product or service availability, errors in the description or price of the product or service, error in your order or other reasons.\n\nWe reserve the right to refuse or cancel your order if fraud or an unauthorized or illegal transaction is suspected.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("4. Contests, Sweepstakes and Promotions\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "Any contests, sweepstakes or other promotions (collectively, “Promotions”) made available through Service may be governed by rules that are separate from these Terms of Service. If you participate in any Promotions, please review the applicable rules as well as our Privacy Policy. If the rules for a Promotion conflict with these Terms of Service, Promotion rules will apply.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("5. Content\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "Our Service allows you to post, link, store, share and otherwise make available certain information, text, graphics, videos, or other material (“Content”). You are responsible for Content that you post on or through Service, including its legality, reliability, and appropriateness.\n\nBy posting Content on or through Service, You represent and warrant that: (i) Content is yours (you own it) and/or you have the right to use it and the right to grant us the rights and license as provided in these Terms, and (ii) that the posting of your Content on or through Service does not violate the privacy rights, publicity rights, copyrights, contract rights or any other rights of any person or entity. We reserve the right to terminate the account of anyone found to be infringing on a copyright.\n\nYou retain any and all of your rights to any Content you submit, post or display on or through Service and you are responsible for protecting those rights. We take no responsibility and assume no liability for Content you or any third party posts on or through Service. However, by posting Content using Service you grant us the right and license to use, modify, publicly perform, publicly display, reproduce, and distribute such Content on and through Service. You agree that this license includes the right for us to make your Content available to other users of Service, who may also use your Content subject to these Terms.\n\nMenon Health Tech Pvt Ltd has the right but not the obligation to monitor and edit all Content provided by users.\n\nIn addition, Content found on or through this Service are the property of Menon Health Tech Pvt Ltd or used with permission. You may not distribute, modify, transmit, reuse, download, repost, copy, or use said Content, whether in whole or in part, for commercial purposes or for personal gain, without express advance written permission from us.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("6. Prohibitted Uses\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "You may use Service only for lawful purposes and in accordance with Terms. You agree not to use Service:\n\n0.1. In any way that violates any applicable national or international law or regulation.\n\n0.2. For the purpose of exploiting, harming, or attempting to exploit or harm minors in any way by exposing them to inappropriate content or otherwise.\n\n0.3. To transmit, or procure the sending of, any advertising or promotional material, including any “junk mail”, “chain letter,” “spam,” or any other similar solicitation.\n\n0.4. To impersonate or attempt to impersonate Company, a Company employee, another user, or any other person or entity.\n\n0.5. In any way that infringes upon the rights of others, or in any way is illegal, threatening, fraudulent, or harmful, or in connection with any unlawful, illegal, fraudulent, or harmful purpose or activity.\n\n0.6. To engage in any other conduct that restricts or inhibits anyone’s use or enjoyment of Service, or which, as determined by us, may harm or offend Company or users of Service or expose them to liability.\n\nAdditionally, you agree not to:\n\n0.1. Use Service in any manner that could disable, overburden, damage, or impair Service or interfere with any other party’s use of Service, including their ability to engage in real time activities through Service.\n\n0.2. Use any robot, spider, or other automatic device, process, or means to access Service for any purpose, including monitoring or copying any of the material on Service.\n\n0.3. Use any manual process to monitor or copy any of the material on Service or for any other unauthorized purpose without our prior written consent.\n\n0.4. Use any device, software, or routine that interferes with the proper working of Service.\n\n0.5. Introduce any viruses, trojan horses, worms, logic bombs, or other material which is malicious or technologically harmful.\n\n0.6. Attempt to gain unauthorized access to, interfere with, damage, or disrupt any parts of Service, the server on which Service is stored, or any server, computer, or database connected to Service.\n\n0.7. Attack Service via a denial-of-service attack or a distributed denial-of-service attack.\n\n0.8. Take any action that may damage or falsify Company rating.\n\n0.9. Otherwise attempt to interfere with the proper working of Service.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("7. Analytics\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We may use third-party Service Providers to monitor and analyze the use of our Service.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("8. No Use By Minors\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "Service is intended only for access and use by individuals at least eighteen (18) years old. By accessing or using Service, you warrant and represent that you are at least eighteen (18) years of age and with the full authority, right, and capacity to enter into this agreement and abide by all of the terms and conditions of Terms. If you are not at least eighteen (18) years old, you are prohibited from both the access and usage of Service.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("9. Accounts\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "When you create an account with us, you guarantee that you are above the age of 18, and that the information you provide us is accurate, complete, and current at all times. Inaccurate, incomplete, or obsolete information may result in the immediate termination of your account on Service.\n\nYou are responsible for maintaining the confidentiality of your account and password, including but not limited to the restriction of access to your computer and/or account. You agree to accept responsibility for any and all activities or actions that occur under your account and/or password, whether your password is with our Service or a third-party service. You must notify us immediately upon becoming aware of any breach of security or unauthorized use of your account.\n\nYou may not use as a username the name of another person or entity or that is not lawfully available for use, a name or trademark that is subject to any rights of another person or entity other than you, without appropriate authorization. You may not use as a username any name that is offensive, vulgar or obscene.\n\nWe reserve the right to refuse service, terminate accounts, remove or edit content, or cancel orders in our sole discretion.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("10. Intellectual Property\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "Service and its original content (excluding Content provided by users), features and functionality are and will remain the exclusive property of Menon Health Tech Pvt Ltd and its licensors. Service is protected by copyright, trademark, and other laws of and foreign countries. Our trademarks may not be used in connection with any product or service without the prior written consent of Menon Health Tech Pvt Ltd.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("11. Copyright Policy\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We respect the intellectual property rights of others. It is our policy to respond to any claim that Content posted on Service infringes on the copyright or other intellectual property rights (“Infringement”) of any person or entity.\n\nIf you are a copyright owner, or authorized on behalf of one, and you believe that the copyrighted work has been copied in a way that constitutes copyright infringement, please submit your claim via email to healthtechmenon@gmail.com, with the subject line: “Copyright Infringement” and include in your claim a detailed description of the alleged Infringement as detailed below, under “DMCA Notice and Procedure for Copyright Infringement Claims”\n\nYou may be held accountable for damages (including costs and attorneys’ fees) for misrepresentation or bad-faith claims on the infringement of any Content found on and/or through Service on your copyright.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text(
            "12. DMCA Notice and Procedure for Copyright Infringement Claims\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "You may submit a notification pursuant to the Digital Millennium Copyright Act (DMCA) by providing our Copyright Agent with the following information in writing (see 17 U.S.C 512(c)(3) for further detail):\n\n0.1. an electronic or physical signature of the person authorized to act on behalf of the owner of the copyright’s interest;\n\n0.2. a description of the copyrighted work that you claim has been infringed, including the URL (i.e., web page address) of the location where the copyrighted work exists or a copy of the copyrighted work;\n\n0.3. identification of the URL or other specific location on Service where the material that you claim is infringing is located;\n\n0.4. your address, telephone number, and email address;\n\n0.5. a statement by you that you have a good faith belief that the disputed use is not authorized by the copyright owner, its agent, or the law;\n\n0.6. a statement by you, made under penalty of perjury, that the above information in your notice is accurate and that you are the copyright owner or authorized to act on the copyright owner’s behalf.\n\nYou can contact our Copyright Agent via email at healthtechmenon@gmail.com.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("13. Error Reporting and Feedback\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "You may provide us either directly at healthtechmenon@gmail.com or via third party sites and tools with information and feedback concerning errors, suggestions for improvements, ideas, problems, complaints, and other matters related to our Service (“Feedback”). You acknowledge and agree that: (i) you shall not retain, acquire or assert any intellectual property right or other right, title or interest in or to the Feedback; (ii) Company may have development ideas similar to the Feedback; (iii) Feedback does not contain confidential information or proprietary information from you or any third party; and (iv) Company is not under any obligation of confidentiality with respect to the Feedback. In the event the transfer of the ownership to the Feedback is not possible due to applicable mandatory laws, you grant. Company and its affiliates an exclusive, transferable, irrevocable, free-of-charge, sub-licensable, unlimited and perpetual right to use (including copy, modify, create derivative works, publish, distribute and commercialize) Feedback in any manner and for any purpose.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("14. Links to Other Web Sites\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "Our Service may contain links to third party web sites or services that are not owned or controlled by Menon Health Tech Pvt Ltd.\n\nMenon Health Tech Pvt Ltd has no control over, and assumes no responsibility for the content, privacy policies, or practices of any third party web sites or services. We do not warrant the offerings of any of these entities/individuals or their websites.\n\nYOU ACKNOWLEDGE AND AGREE THAT COMPANY SHALL NOT BE RESPONSIBLE OR LIABLE, DIRECTLY OR INDIRECTLY, FOR ANY DAMAGE OR LOSS CAUSED OR ALLEGED TO BE CAUSED BY OR IN CONNECTION WITH USE OF OR RELIANCE ON ANY SUCH CONTENT, GOODS OR SERVICES AVAILABLE ON OR THROUGH ANY SUCH THIRD PARTY WEB SITES OR SERVICES.\n\nWE STRONGLY ADVISE YOU TO READ THE TERMS OF SERVICE AND PRIVACY POLICIES OF ANY THIRD PARTY WEB SITES OR SERVICES THAT YOU VISIT.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("15. Disclaimer Of Warranty\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "THESE SERVICES ARE PROVIDED BY COMPANY ON AN “AS IS” AND “AS AVAILABLE” BASIS. COMPANY MAKES NO REPRESENTATIONS OR WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED, AS TO THE OPERATION OF THEIR SERVICES, OR THE INFORMATION, CONTENT OR MATERIALS INCLUDED THEREIN. YOU EXPRESSLY AGREE THAT YOUR USE OF THESE SERVICES, THEIR CONTENT, AND ANY SERVICES OR ITEMS OBTAINED FROM US IS AT YOUR SOLE RISK.\n\nNEITHER COMPANY NOR ANY PERSON ASSOCIATED WITH COMPANY MAKES ANY WARRANTY OR REPRESENTATION WITH RESPECT TO THE COMPLETENESS, SECURITY, RELIABILITY, QUALITY, ACCURACY, OR AVAILABILITY OF THE SERVICES. WITHOUT LIMITING THE FOREGOING, NEITHER COMPANY NOR ANYONE ASSOCIATED WITH COMPANY REPRESENTS OR WARRANTS THAT THE SERVICES, THEIR CONTENT, OR ANY SERVICES OR ITEMS OBTAINED THROUGH THE SERVICES WILL BE ACCURATE, RELIABLE, ERROR-FREE, OR UNINTERRUPTED, THAT DEFECTS WILL BE CORRECTED, THAT THE SERVICES OR THE SERVER THAT MAKES IT AVAILABLE ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS OR THAT THE SERVICES OR ANY SERVICES OR ITEMS OBTAINED THROUGH THE SERVICES WILL OTHERWISE MEET YOUR NEEDS OR EXPECTATIONS.\n\nCOMPANY HEREBY DISCLAIMS ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, STATUTORY, OR OTHERWISE, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, AND FITNESS FOR PARTICULAR PURPOSE.\n\nTHE FOREGOING DOES NOT AFFECT ANY WARRANTIES WHICH CANNOT BE EXCLUDED OR LIMITED UNDER APPLICABLE LAW.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("16. Limitation of Liability\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "EXCEPT AS PROHIBITED BY LAW, YOU WILL HOLD US AND OUR OFFICERS, DIRECTORS, EMPLOYEES, AND AGENTS HARMLESS FOR ANY INDIRECT, PUNITIVE, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGE, HOWEVER IT ARISES (INCLUDING ATTORNEYS’ FEES AND ALL RELATED COSTS AND EXPENSES OF LITIGATION AND ARBITRATION, OR AT TRIAL OR ON APPEAL, IF ANY, WHETHER OR NOT LITIGATION OR ARBITRATION IS INSTITUTED), WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE, OR OTHER TORTIOUS ACTION, OR ARISING OUT OF OR IN CONNECTION WITH THIS AGREEMENT, INCLUDING WITHOUT LIMITATION ANY CLAIM FOR PERSONAL INJURY OR PROPERTY DAMAGE, ARISING FROM THIS AGREEMENT AND ANY VIOLATION BY YOU OF ANY FEDERAL, STATE, OR LOCAL LAWS, STATUTES, RULES, OR REGULATIONS, EVEN IF COMPANY HAS BEEN PREVIOUSLY ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. EXCEPT AS PROHIBITED BY LAW, IF THERE IS LIABILITY FOUND ON THE PART OF COMPANY, IT WILL BE LIMITED TO THE AMOUNT PAID FOR THE PRODUCTS AND/OR SERVICES, AND UNDER NO CIRCUMSTANCES WILL THERE BE CONSEQUENTIAL OR PUNITIVE DAMAGES. SOME STATES DO NOT ALLOW THE EXCLUSION OR LIMITATION OF PUNITIVE, INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THE PRIOR LIMITATION OR EXCLUSION MAY NOT APPLY TO YOU.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("17. Termination\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We may terminate or suspend your account and bar access to Service immediately, without prior notice or liability, under our sole discretion, for any reason whatsoever and without limitation, including but not limited to a breach of Terms.\n\nIf you wish to terminate your account, you may simply discontinue using Service. All provisions of Terms which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("18. Governing Law\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "These Terms shall be governed and construed in accordance with the laws of India, which governing law applies to agreement without regard to its conflict of law provisions.\n\nOur failure to enforce any right or provision of these Terms will not be considered a waiver of those rights. If any provision of these Terms is held to be invalid or unenforceable by a court, the remaining provisions of these Terms will remain in effect. These Terms constitute the entire agreement between us regarding our Service and supersede and replace any prior agreements we might have had between us regarding Service.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("19. Changes To Service\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We reserve the right to withdraw or amend our Service, and any service or material we provide via Service, in our sole discretion without notice. We will not be liable if for any reason all or any part of Service is unavailable at any time or for any period. From time to time, we may restrict access to some parts of Service, or the entire Service, to users, including registered users.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("20. Amendments To Terms\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We may amend Terms at any time by posting the amended terms on this site. It is your responsibility to review these Terms periodically.\n\nYour continued use of the Platform following the posting of revised Terms means that you accept and agree to the changes. You are expected to check this page frequently so you are aware of any changes, as they are binding on you.\n\nBy continuing to access or use our Service after any revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, you are no longer authorized to use Service.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("21. Waiver And Severability\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "No waiver by Company of any term or condition set forth in Terms shall be deemed a further or continuing waiver of such term or condition or a waiver of any other term or condition, and any failure of Company to assert a right or provision under Terms shall not constitute a waiver of such right or provision.\n\nIf any provision of Terms is held by a court or other tribunal of competent jurisdiction to be invalid, illegal or unenforceable for any reason, such provision shall be eliminated or limited to the minimum extent such that the remaining provisions of Terms will continue in full force and effect.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("22. Acknowledgement\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "BY USING SERVICE OR OTHER SERVICES PROVIDED BY US, YOU ACKNOWLEDGE THAT YOU HAVE READ THESE TERMS OF SERVICE AND AGREE TO BE BOUND BY THEM.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("23. Contact Us\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "Please send your feedback, comments, requests for technical support by email: healthtechmenon@gmail.com.",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        "Terms and Conditions",
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildAboutTnC(context),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: new RaisedButton(
            color: primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Colors.white,
            child: const Text("Close"),
          ),
        )
      ],
    );
  }

  Widget _buildAboutPP(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("1. Introduction\n",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            )),
        RichText(
          text: new TextSpan(
            text:
                "Welcome to Menon Health Tech Pvt Ltd. Menon Health Tech Pvt Ltd (“us”, “we”, or “our”) operates menonhealthtech.in (hereinafter referred to as “Service”).\n\nOur Privacy Policy governs your visit to menonhealthtech.in, and explains how we collect, safeguard and disclose information that results from your use of our Service.\n\nWe use your data to provide and improve Service. By using Service, you agree to the collection and use of information in accordance with this policy. Unless otherwise defined in this Privacy Policy, the terms used in this Privacy Policy have the same meanings as in our Terms and Conditions.\n\nOur Terms and Conditions (“Terms”) govern all use of our Service and together with the Privacy Policy constitutes your agreement with us (“agreement”).\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("2. Definitions\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "SERVICE means the menonhealthtech.in website operated by Menon Health Tech Pvt Ltd.\n\nPERSONAL DATA means data about a living individual who can be identified from those data (or from those and other information either in our possession or likely to come into our possession).\n\nUSAGE DATA is data collected automatically either generated by the use of Service or from Service infrastructure itself (for example, the duration of a page visit).\n\nCOOKIES are small files stored on your device (computer or mobile device).\n\nDATA CONTROLLER means a natural or legal person who (either alone or jointly or in common with other persons) determines the purposes for which and the manner in which any personal data are, or are to be, processed. For the purpose of this Privacy Policy, we are a Data Controller of your data.\n\nDATA PROCESSORS (OR SERVICE PROVIDERS) means any natural or legal person who processes the data on behalf of the Data Controller. We may use the services of various Service Providers in order to process your data more effectively.\n\nDATA SUBJECT is any living individual who is the subject of Personal Data.\n\nTHE USER is the individual using our Service. The User corresponds to the Data Subject, who is the subject of Personal Data.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("3. Information Collection and Use\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We collect several different types of information for various purposes to provide and improve our Service to you.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("4. Types of Data Collected\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "Personal Data\nWhile using our Service, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you (“Personal Data”). Personally identifiable information may include, but is not limited to:\n\n0.1. Email address\n\n0.2. First name and last name\n\n0.3. Phone number\n\n0.4. Address, Country, State, Province, ZIP/Postal code, City\n\n0.5. Cookies and Usage Data\n\nWe may use your Personal Data to contact you with newsletters, marketing or promotional materials and other information that may be of interest to you. You may opt out of receiving any, or all, of these communications from us by following the unsubscribe link.\n\nUsage Data\nWe may also collect information that your browser sends whenever you visit our Service or when you access Service by or through any device (“Usage Data”).\n\nThis Usage Data may include information such as your computer’s Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that you visit, the time and date of your visit, the time spent on those pages, unique device identifiers and other diagnostic data.\n\nWhen you access Service with a device, this Usage Data may include information such as the type of device you use, your device unique ID, the IP address of your device, your device operating system, the type of Internet browser you use, unique device identifiers and other diagnostic data\n\nLocation Data\nWe may use and store information about your location if you give us permission to do so (“Location Data”). We use this data to provide features of our Service, to improve and customize our Service.\n\nYou can enable or disable location services when you use our Service at any time by way of your device settings.\n\nTracking Cookies Data\nWe use cookies and similar tracking technologies to track the activity on our Service and we hold certain information.\n\nCookies are files with a small amount of data which may include an anonymous unique identifier. Cookies are sent to your browser from a website and stored on your device. Other tracking technologies are also used such as beacons, tags and scripts to collect and track information and to improve and analyze our Service.\n\nYou can instruct your browser to refuse all cookies or to indicate when a cookie is being sent. However, if you do not accept cookies, you may not be able to use some portions of our Service.\n\nExamples of Cookies we use:\n\n0.1. Session Cookies: We use Session Cookies to operate our Service.\n\n0.2. Preference Cookies: We use Preference Cookies to remember your preferences and various settings.\n\n0.3. Security Cookies: We use Security Cookies for security purposes.\n\n0.4. Advertising Cookies: Advertising Cookies are used to serve you with advertisements that may be relevant to you and your interests.\n\nOther Data\nWhile using our Service, we may also collect the following information: sex, age, date of birth, place of birth, passport details, citizenship, registration at place of residence and actual address, telephone number (work, mobile), details of documents on education, qualification, professional training, employment agreements, NDA agreements, information on bonuses and compensation, information on marital status, family members, social security (or other taxpayer identification) number, office location and other data.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("5. Use Of Data\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "Menon Health Tech Pvt Ltd uses the collected data for various purposes:\n\n0.1. to provide and maintain our Service;\n\n0.2. to notify you about changes to our Service;\n\n0.3. to allow you to participate in interactive features of our Service when you choose to do so;\n\n0.4. to provide customer support;\n\n0.5. to gather analysis or valuable information so that we can improve our Service;\n\n0.6. to monitor the usage of our Service;\n\n0.7. to detect, prevent and address technical issues;\n\n0.8. to fulfil any other purpose for which you provide it;\n\n0.9. to carry out our obligations and enforce our rights arising from any contracts entered into between you and us, including for billing and collection;\n\n0.10. to provide you with notices about your account and/or subscription, including expiration and renewal notices, email-instructions, etc.;\n\n0.11. to provide you with news, special offers and general information about other goods,\n\nservices and events which we offer that are similar to those that you have already purchased\n\nor enquired about unless you have opted not to receive such information;\n\n0.12. in any other way we may describe when you provide the information;\n\n0.13. for any other purpose with your consent.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("6. Retention of Data\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We will retain your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.\n\nWe will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period, except when this data is used to strengthen the security or to improve the functionality of our Service, or we are legally obligated to retain this data for longer time periods.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("7. Transfer Of Data\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "Your information, including Personal Data, may be transferred to – and maintained on – computers located outside of your state, province, country or other governmental jurisdiction where the data protection laws may differ from those of your jurisdiction.\n\nIf you are located outside India and choose to provide information to us, please note that we transfer the data, including Personal Data, to India and process it there.\n\nYour consent to this Privacy Policy followed by your submission of such information represents your agreement to that transfer.\n\nMenon Health Tech Pvt Ltd will take all the steps reasonably necessary to ensure that your data is treated securely and in accordance with this Privacy Policy and no transfer of your Personal Data will take place to an organisation or a country unless there are adequate controls in place including the security of your data and other personal information.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("8. Disclosure Of Data\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We may disclose personal information that we collect, or you provide:\n\n0.1. Business Transaction.\n\nIf we or our subsidiaries are involved in a merger, acquisition or asset sale, your Personal Data may be transferred.\n\n0.2. Other cases. We may disclose your information also:\n\n0.2.1. to our subsidiaries and affiliates;\n\n0.2.2. to contractors, service providers, and other third parties we use to support our business;\n\n0.2.3. to fulfill the purpose for which you provide it;\n\n0.2.4. for the purpose of including your company’s logo on our website;\n\n0.2.5. for any other purpose disclosed by us when you provide the information;\n\n0.2.6. with your consent in any other cases;\n\n0.2.7. if we believe disclosure is necessary or appropriate to protect the rights, property, or safety of the Company, our customers, or others.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("9. Security Of Data\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "The security of your data is important to us but remember that no method of transmission over the Internet or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Data, we cannot guarantee its absolute security.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("10. Service Providers\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We may employ third party companies and individuals to facilitate our Service (“Service Providers”), provide Service on our behalf, perform Service-related services or assist us in analysing how our Service is used.\n\nThese third parties have access to your Personal Data only to perform these tasks on our behalf and are obligated not to disclose or use it for any other purpose.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("11. Analytics\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We may use third-party Service Providers to monitor and analyze the use of our Service.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("12. CI/CD tools\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We may use third-party Service Providers to automate the development process of our Service.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("13. Advertising\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We may use third-party Service Providers to show advertisements to you to help support and maintain our Service.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("14. Behavioral Remarketing\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We may use remarketing services to advertise on third party websites to you after you visited our Service. We and our third-party vendors use cookies to inform, optimise and serve ads based on your past visits to our Service.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("15. Payments\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We may provide paid products and/or services within Service. In that case, we use third-party services for payment processing (e.g. payment processors).\n\nWe will not store or collect your payment card details. That information is provided directly to our third-party payment processors whose use of your personal information is governed by their Privacy Policy. These payment processors adhere to the standards set by PCI-DSS as managed by the PCI Security Standards Council, which is a joint effort of brands like Visa, Mastercard. PCI-DSS requirements help ensure the secure handling of payment information.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("16. Links To Other Sites\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "Our Service may contain links to other sites that are not operated by us. If you click a third party link, you will be directed to that third party’s site. We strongly advise you to review the Privacy Policy of every site you visit.\n\nWe have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("17. Children’s Privacy\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "Our Services are not intended for use by children under the age of 18 (“Child” or “Children”).\n\nWe do not knowingly collect personally identifiable information from Children under 18. If you become aware that a Child has provided us with Personal Data, please contact us. If we become aware that we have collected Personal Data from Children without verification of parental consent, we take steps to remove that information from our servers.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("18. Changes to This Privacy Policy\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.\n\nWe will let you know via email and/or a prominent notice on our Service, prior to the change becoming effective and update “effective date” at the top of this Privacy Policy.\n\nYou are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.\n\n",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
        Text("19. Contact Us\n",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        RichText(
          text: new TextSpan(
            text:
                "Please send your feedback, comments, requests for technical support by email: healthtechmenon@gmail.com.",
            style: TextStyle(color: primaryColor, fontSize: 11),
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacyPolicy(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        "Privacy Policy",
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildAboutPP(context),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: new RaisedButton(
            color: primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Colors.white,
            child: const Text("Close"),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var profileImage = imageBytes != null
        ? Image.memory(
            imageBytes,
            fit: BoxFit.cover,
          )
        : Text(errorMsg != null ? errorMsg : "Loading...");
    print(profileImage);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Theme(
          data: ThemeData(iconTheme: IconThemeData(color: primaryColor)),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => PatientHome(widget.pE)));
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
                child: Image(
                    image: AssetImage('Images/appbar.png'),
                    height: 50,
                    width: 50)),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: FutureBuilder(
            future: DB().getSinglePatient(pE),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Loading();
              } else {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: primaryColor, width: 2),
                  ),
                  elevation: 10,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: CircleAvatar(
                                  //radius: 50,
                                  minRadius: 30,
                                  maxRadius: 50,
                                  child: profileImage,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data.firstName +
                                            " " +
                                            snapshot.data.lastName,
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        child: Text(
                                          "View Profile",
                                          style: TextStyle(
                                              color: primaryColor,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 14),
                                          textAlign: TextAlign.center,
                                        ),
                                        onTap: () {
                                          Navigator.push(context,
                                              new MaterialPageRoute(
                                                  builder: (context) {
                                            return ViewProfile(
                                                pE, snapshot.data);
                                          }));
                                        },
                                      )
                                    ],
                                  ))
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height / 10,
                            child: RaisedButton(
                              padding: EdgeInsets.all(10),
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ChangePassword(pE, snapshot.data)));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Privacy",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.privacy_tip,
                                      color: Colors.white, size: 20),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height / 10,
                            child: RaisedButton(
                              padding: EdgeInsets.all(10),
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            EditPersonalInfo(
                                                pE, snapshot.data)));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Update Personal Info",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.edit,
                                      color: Colors.white, size: 20),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height / 10,
                            child: RaisedButton(
                              padding: EdgeInsets.all(10),
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Text(
                                    "Notifications",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.notifications,
                                      color: Colors.white, size: 20),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Text(
                              "Legal Information:",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 10, 10),
                            child: InkWell(
                              child: Text("-Terms and Condition",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: primaryColor,
                                      fontSize: 16)),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildTermsAndConditions(context),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 10, 10),
                            child: InkWell(
                              child: Text(
                                "-Privacy Policy",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: primaryColor,
                                    fontSize: 16),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPrivacyPolicy(context),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
