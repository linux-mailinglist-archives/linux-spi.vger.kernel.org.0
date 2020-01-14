Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5877913ACCB
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 15:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgANO60 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 09:58:26 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:25192 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANO60 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 09:58:26 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: +4kfcO9oC7v5//xZeoPyzvDMthpLXL+UuT3qGkyYW7uU4QdKrkbSMmeF1oeArLRE6EMYroRBTb
 K2Egt52gPU5Uac04RWTmu10kIZQHb5cI9Hc193weMDLQjOFCR0CI4YWTJgV2gwRXYulE+shig9
 Wj/ZPENQgSt5Atr8ZhGiUeCGnn2fmJWRj5k5ZfElxK693fwOM/MWi1i/HntX6FqW/0GIfhczk9
 +MPwhvkkaLFb3OwZxBJubAhFWS8nq1soxX7cwKUQv4gIQz2uXZ4aUIgirczI+yrZ7k/1FlZW2J
 Coc=
X-IronPort-AV: E=Sophos;i="5.69,433,1571727600"; 
   d="scan'208";a="62573383"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jan 2020 07:58:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 07:58:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 14 Jan 2020 07:58:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geizsOP3SKgCwExC4ZLHrzvPMnkB2fy0rMg5+azzA071L9cA9BDpuQXxvBZoaC0DaR/WUsoMnU9DQnnP8L2mhmOon6AEsgp8gFyhUC4VE6o3hbaOWwQexGEh67y3wVGfNmKokpI6ksOtX8OUOOjdVQPHMp0xbO0Kqz0SL/LEZuVNpDA7TOGHyHoijxYXujEQ8DyAVZGFruinrb8TKapanNntwWXDWeWg0K81JL2W/+vh4w0LWcZKXj3+cg++Ct0JIT829zbUE+nUG3IDxGiuU+obcwtRRUEqsxPob+oG4dElE7/azQdRUjrDOFbeeKuq5BKes0f4igUAP2Uxp9W6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwPDBA/JXrHpHd10XJ1yOZszLgTAO4rKFP8Z67jaYWo=;
 b=Ua7d1gs610VIiZVkDa49EyN6cH5flWx0/MOBDKS5Aw+LumfqKNnZPlnCSoNaV9tAz9XIqA6YQWuaul4t8fxwUGwyNaZ++1Whu3lRDKkdnoLSKqVx0dAKo0TJWkKlCC/cAYhyD0xU6Hpo8V6K0w9HJmDmCWOcM+VZm4auBNl60k37TfzmfRuPR/HQw7Tikn04UTfs06GkNnJqiGUjcrvrJBVfAi625RruWoHM3xWnPQT3UxqeJPa5N1wPAmO24nY1sKySDdLla33qHQDzvBEr+NxFClf42hfRV0WbMpWyNqzg8NRIFewuQ1aTZVuSaH0F6IW+90i9voH/ttl9QyN5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwPDBA/JXrHpHd10XJ1yOZszLgTAO4rKFP8Z67jaYWo=;
 b=YjiMCMzPFRSfj79C2ME9cAe01pTckqiclmk8MGkaB3YEIR07R6KS1OQYwfMF5f/ThLvOzgmCvP0fRP0/VMW+HvIL6Pizpkjzl1d/TEHvyw0MFzzSsUXsQcQWvnmTyX+d9pKkZaCRQVbmqTmtUQtHztWhfDMmNCyKrUzSt2pVV+E=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3228.namprd11.prod.outlook.com (20.176.120.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 14:58:23 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::106f:424f:ac54:1dbb]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::106f:424f:ac54:1dbb%7]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 14:58:23 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <Ludovic.Desroches@microchip.com>, <radu_nicolae.pirea@upb.ro>,
        <richard.genoud@gmail.com>, <a.zummo@towertech.it>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] dt-bindings: atmel-usart: remove wildcard
Thread-Topic: [PATCH v3 4/7] dt-bindings: atmel-usart: remove wildcard
Thread-Index: AQHVyssxad36L/lyDU2/n1XqgFNXSA==
Date:   Tue, 14 Jan 2020 14:58:23 +0000
Message-ID: <a7f9f8c6-7636-6c1d-ecd8-39e5a956b85a@microchip.com>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
 <1578997397-23165-5-git-send-email-claudiu.beznea@microchip.com>
 <20200114104237.GM3137@piout.net>
 <f3c4d460-cff6-2e14-428a-a732a6bffe38@microchip.com>
 <20200114111704.GN3137@piout.net>
In-Reply-To: <20200114111704.GN3137@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4d740b6-67a8-472e-5080-08d7990233ea
x-ms-traffictypediagnostic: DM6PR11MB3228:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3228F3B9868F7DBA8D17887587340@DM6PR11MB3228.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(376002)(39860400002)(199004)(189003)(66946007)(76116006)(31686004)(66446008)(6506007)(53546011)(26005)(186003)(64756008)(66556008)(86362001)(91956017)(54906003)(66476007)(71200400001)(316002)(6512007)(4326008)(6916009)(2616005)(2906002)(6486002)(36756003)(81156014)(7416002)(966005)(31696002)(5660300002)(478600001)(8676002)(81166006)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3228;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Pd87UK+T6wnlaiwJ/HnFQT+JfV6ynzpebDEllz7/8QtBGuipRl3UyWG1voWvRtBXxVK2VRDim8XJh4nqJfRrdt/5T4SmJMvuuW7rbFGUokiPSaGWu7lcOVnye7lemhgpAFbu/hp/vMRQ5Lrrz50M8JesS7yENrENNRRqKEa0Whl3VaOsbsoO3qAALGvUOrnT/QpgKo0veRSCWcaf1ngQOnzkOQZ6rBPlwQ7TfE6OZqgNZaS9m3Ab1tiKajV2IDNfZI9y8lpV/2VXi7ZsCUxpsIIJzUqEaetB7xzxscEPtml+CMSXhohN+kMuMZSVJszn6UicnYkE5PYQDt8aXVWOj3Ig8u8I0+fJPsRUiR6E6oFuyVolLNzub7IewBMtDLc2r9mriqdYZEtawqONebTCMy8HsXTvEp3rAUM3elcqmBOvEPu7xaeYQo7z9IN838UZVrIJQtzBWeVJp+rAQpcEno7IK8k8F/Ovz14RE4XVfAftMCHEP+uQR/Eh6AQD3k6+lKiruos+/Jihp0RKNTN9A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD33279CEB73A84684BB56835DC9D6F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d740b6-67a8-472e-5080-08d7990233ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 14:58:23.2235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Egllc5yUKitD0Pe697cx4bgy3xmrLoP9lwUdrdQ4j3VUsh3hdMnj23vdasFWechuQqc5lUjS4ME5lrsuCHxth0I4U3Umh+puTTrfv0/rwxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3228
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQoNCk9uIDE0LjAxLjIwMjAgMTM6MTcsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDE0LzAxLzIwMjAgMTE6MTA6
MTQrMDAwMCwgQ2xhdWRpdS5CZXpuZWFAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+DQo+Pg0KPj4g
T24gMTQuMDEuMjAyMCAxMjo0MiwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+Pj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBPbiAxNC8wMS8yMDIwIDEyOjIz
OjE0KzAyMDAsIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPj4+PiBSZW1vdmUgY2hpcCB3aGlsZGNh
cmQgYW5kIGludHJvZHVjZSB0aGUgbGlzdCBvZiBjb21wYXRpYmxlcyBpbnN0ZWFkLg0KPj4+Pg0K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9j
aGlwLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWZkL2F0bWVsLXVzYXJ0LnR4dCB8IDcgKysrLS0tLQ0KPj4+PiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwtdXNhcnQudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC11c2FydC50eHQNCj4+
Pj4gaW5kZXggNjk5ZmQzYzlhY2U4Li43NzhlODMxMDYwNmEgMTAwNjQ0DQo+Pj4+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwtdXNhcnQudHh0DQo+Pj4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwtdXNhcnQu
dHh0DQo+Pj4+IEBAIC0xLDEwICsxLDkgQEANCj4+Pj4gICogQXRtZWwgVW5pdmVyc2FsIFN5bmNo
cm9ub3VzIEFzeW5jaHJvbm91cyBSZWNlaXZlci9UcmFuc21pdHRlciAoVVNBUlQpDQo+Pj4+DQo+
Pj4+ICBSZXF1aXJlZCBwcm9wZXJ0aWVzIGZvciBVU0FSVDoNCj4+Pj4gLS0gY29tcGF0aWJsZTog
U2hvdWxkIGJlICJhdG1lbCw8Y2hpcD4tdXNhcnQiIG9yICJhdG1lbCw8Y2hpcD4tZGJndSINCj4+
Pj4gLSAgVGhlIGNvbXBhdGlibGUgPGNoaXA+IGluZGljYXRlZCB3aWxsIGJlIHRoZSBmaXJzdCBT
b0MgdG8gc3VwcG9ydCBhbg0KPj4+PiAtICBhZGRpdGlvbmFsIG1vZGUgb3IgYW4gVVNBUlQgbmV3
IGZlYXR1cmUuDQo+Pj4+IC0gIEZvciB0aGUgZGJndSBVQVJULCB1c2UgImF0bWVsLDxjaGlwPi1k
Ymd1IiwgImF0bWVsLDxjaGlwPi11c2FydCINCj4+Pj4gKy0gY29tcGF0aWJsZTogU2hvdWxkIGJl
IG9uZSBvZiB0aGUgZm9sbG93aW5nOg0KPj4+PiArICAgICAtICJhdG1lbCxhdDkxcm05MjAwLWRi
Z3UiLCAiYXRtZWwsYXQ5MXJtOTIwMC11c2FydCINCj4+Pj4gKyAgICAgLSAiYXRtZWwsYXQ5MXNh
bTkyNjAtZGJndSIsICJhdG1lbCxhdDkxc2FtOTI2MC11c2FydCINCj4+Pg0KPj4+IEFsbCB0aGUg
dWFydHMgYXJlIG5vdCBkYmd1cywgc28gdGhpcyBuZWVkIHRvIGJlOg0KPj4+DQo+Pj4gIC0gImF0
bWVsLGF0OTFybTkyMDAtdXNhcnQiDQo+Pj4gIC0gImF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0Ig0K
Pj4+ICAtICJhdG1lbCxhdDkxcm05MjAwLWRiZ3UiLCAiYXRtZWwsYXQ5MXJtOTIwMC11c2FydCIN
Cj4+PiAgLSAiYXRtZWwsYXQ5MXNhbTkyNjAtZGJndSIsICJhdG1lbCxhdDkxc2FtOTI2MC11c2Fy
dCINCj4+DQo+PiBPayENCj4+DQo+Pj4NCj4+PiBBbHNvLCB5b3UgbmVlZCB0byB1cGRhdGUgZHJp
dmVycy9zb2MvYXRtZWwvc29jLmMNCj4+DQo+PiBPSy4gRGlkIHlvdSByZWZlciB0byBDSURSLCBF
WElEIHJlZ2lzdGVycz8gVGhleSBhcmUgYXQgdGhlIHNhbWUgb2Zmc2V0cyBhcw0KPj4gZm9yIHRo
ZSBvbGQgcHJvZHVjdHMuIFNvIHdlIGNhbiByZWx5IG9uIG9sZCBjb21wYXRpYmxlIGZvciB0aGVt
LiBJcyB0aGlzIE9LPw0KPj4NCj4gDQo+IFRoZW4sIHdoYXQgaXMgdGhlIHBvaW50IG9mIGFkZGlu
ZyBtaWNyb2NoaXAsc2FtOXg2MC1kYmd1ID8NCg0KRGlmZmVyZW50IG1lYW5pbmcgZm9yIENJRFIg
cmVnaXN0ZXIgYml0cy4gVmVyc2lvbiBpcyBrZXB0IG9uIGJpdHMgNCB0byAwDQpidXQgbm90IGRv
Y3VtZW50ZWQgaW4gcHVibGljIGRhdGFzaGVldCwgc28gdmVyc2lvbiBkaXNwbGF5ZWQgYnkNCmRy
aXZlcnMvc29jL2F0bWVsL3NvYy5jIHNob3VsZCB3b3JrLg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1
IEJlem5lYQ0KDQo+IA0KPiANCj4gLS0NCj4gQWxleGFuZHJlIEJlbGxvbmksIEJvb3RsaW4NCj4g
RW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZw0KPiBodHRwczovL2Jvb3RsaW4u
Y29tDQo+IA==
