import 'package:flutter/material.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/models/avatar_model.dart';

class TBTDataCollection {
  static List userCommentsList = [
    UserCommendsModel(
        color: Colors.amber,
        studentname: "Muhammed Hocaoğlu",
        avatar: Assets.imagesMhProfil,
        comment:
            "Tobeto'daki .NET ve React Fullstack eğitimi, yazılım dünyasında daha sağlam adım atmamı sağlayan önemli bir deneyim oldu. Bu eğitimde hem teknik bilgi hem de pratik uygulama becerileri kazandım. Ayrıca, softskill eğitimleri sayesinde iletişim ve problem çözme yeteneklerim de gelişti. Tobeto ekibi her zaman yardımcı oldu ve sorularımı cevaplamak için ellerinden geleni yaptı. Bu süreçte aldığım destek sayesinde, şimdi daha güvenli bir şekilde yazılım geliştirme yolculuğuma devam edebiliyorum. Tobeto'daki eğitim süreci, şimdi iş dünyasına hazır olduğumu hissettiriyor. Teşekkürler Tobeto!"),
    UserCommendsModel(
        color: Colors.greenAccent,
        studentname: "Ali Veli",
        avatar: Assets.imagesDefaultAvatar,
        comment:
            " İnsanın yeterince istediği ve emek verdiği her şeyi başarabileceğine inanan bir ekibin liderliğindeki muhteşem oluşum. Üstelik paydaşları ilgili alandaki en iyi isimler ve organizasyonlar."),
    UserCommendsModel(
        color: Colors.blueAccent,
        studentname: "Hasan Hüseyin",
        avatar: Assets.imagesDefaultAvatar,
        comment:
            "Tobeto ve İstanbul Kodluyor Projesi, kariyerimde kaybolmuş hissettiğim bir dönemde karşıma çıktı ve gerçek bir pusula gibi yol gösterdi. Artık hangi yöne ilerleyeceğim konusunda daha eminim. Tobeto ailesine minnettarım, benim için gerçek bir destek ve ilham kaynağı oldular. İyi ki varsınız, Tobeto ailesi.")
  ];

  static List<String> userTitlesList = [
    'Öğrenci',
    'Kurucu Direktör',
    'Eğitim ve Proje Koordinatörü',
    'Eğitim Teknolojileri ve Platform Sorumlusu',
    'Operasyon Uzman Yardımcısı',
    'Flutter Eğitmeni',
    '.NET Eğitmeni',
    'Java Eğitmeni',
    'Yazılım Kalite ve Test Eğitmeni',
    'İş Analisti Eğitmeni',
    'Sistem ve Network Eğitmeni',
    'Siber Güvenlik Eğitmeni',
    'Dijital Pazarlama Eğitmeni',
    'Veri Bilimi Eğitmeni',
    'Oyun Geliştiricisi Eğitmeni',
    'Dev Ops Eğitmeni',
  ];
}
