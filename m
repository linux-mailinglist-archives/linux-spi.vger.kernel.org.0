Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F7259EE4
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2019 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfF1Pai (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jun 2019 11:30:38 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:31576 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfF1Pai (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jun 2019 11:30:38 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="38750021"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2019 08:30:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Jun 2019 08:30:35 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 28 Jun 2019 08:30:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=itvHme4yM5ydo9CNjOZkdDcIVvoTx1qojlRiVjwZv9d7548aHnBSUIJktv/Dxr8ybTbH/QHO55t9/acSpha1sdvY3El39ZZUu2e0bi8ySgLNQsIL5HbAk2dyDfNXpz9WV24S5EEbBoi4VeKjSqj6Ur/oQQsM29DXHbAtCoCBTLY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6YLtt0Uu0akTgRx4a9atbJYgPk6spKklLVk9TmbylE=;
 b=aMtKeYQwP1yUfRe+p8p3aXCG5uL8IbAqFtTueWslr/zRfJaY+4O9+NQOTD6yy+Nvo0ZhXcLow8WYCMstiNi7mikFt5QZ3FABuV5YPmjskllZ1aakhZpjh7bCjrqCV5qj+x5PZ8uVAxd1s27bz1rI63PnAkpCGXXvq6t0PheVdBI=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6YLtt0Uu0akTgRx4a9atbJYgPk6spKklLVk9TmbylE=;
 b=XSNMONdcfA+Gg45bRYYQRwZkb3RLnIPwZFLsILBnliF7/o/hiIN/SgrWkLV0sveW6ZZhU5xDOqP5CEzv/J9z2BUSgv0yFd4CiWButP7G+F3hVKkmzNWjsVm4u+NvH+29qFigaBTQQ/fTUs0Lj2iVOk1dDZBrRrtOkiWjU1KekS4=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1729.namprd11.prod.outlook.com (10.175.98.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 15:30:34 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::ed4c:cf24:e5c0:43ab]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::ed4c:cf24:e5c0:43ab%2]) with mapi id 15.20.2032.019; Fri, 28 Jun 2019
 15:30:34 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <mdeneen@gmail.com>
CC:     <Claudiu.Beznea@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 2/2] spi: atmel-quadspi: fix resume call
Thread-Topic: [PATCH 2/2] spi: atmel-quadspi: fix resume call
Thread-Index: AQHVLcZtwFeJQVFybkSJWy1t1PvRtw==
Date:   Fri, 28 Jun 2019 15:30:34 +0000
Message-ID: <20190628153009.7571-3-tudor.ambarus@microchip.com>
References: <20190628153009.7571-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190628153009.7571-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0601CA0042.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::52) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa72afd5-fc24-4c88-dd1e-08d6fbdd8ff8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1729;
x-ms-traffictypediagnostic: BN6PR11MB1729:
x-microsoft-antispam-prvs: <BN6PR11MB172936D64680269E2754A75EF0FC0@BN6PR11MB1729.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(39860400002)(396003)(376002)(199004)(189003)(256004)(86362001)(14454004)(81156014)(6486002)(6512007)(25786009)(8936002)(6436002)(5660300002)(66066001)(107886003)(4326008)(478600001)(14444005)(54906003)(1076003)(71200400001)(305945005)(7736002)(81166006)(72206003)(71190400001)(6506007)(2616005)(11346002)(386003)(486006)(316002)(76176011)(8676002)(110136005)(2501003)(476003)(6116002)(26005)(186003)(2906002)(446003)(53936002)(68736007)(36756003)(66556008)(73956011)(66446008)(66476007)(64756008)(66946007)(3846002)(50226002)(99286004)(52116002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1729;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W5qlCSviEiMJYRlDGK3IH5Cwe/7/1XXRfKgphKiBSbdLyJ3yv9BwTAlpCi9i+ZvwDOnNpu4ytxOL+t52GFm9FGzzSh6C2A3Tnq/lc9U9P3AmSAcfD9s6YWUnLVepLuG5meVf+vGOiFVaIpvt32bWDXcMJwzsMUfYMHUFZijJGpFAFZSmCDSo4FG0m4sCM2Y0pkg+31doiDu6TMEG7N6HFY5HX/bpbPUNOHtZEm7TTtcP7RP3xYn9S5s4DZC3miSciKlQ37258lhw3h/jg6CGDW7UyBHKOxvLcMIg3hHPLi6XtgM+ko3djTNta8aMYs37bX2mtpNXpt2stq0p3/pxYFrl0kWBFVd86FcNY97o6U78yQvKadvyuNKWiqH/a6/iOQvHRorQHnwA9GUsOiAGmUZxTEwyTL/JTKLZdQgITks=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aa72afd5-fc24-4c88-dd1e-08d6fbdd8ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 15:30:34.3871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1729
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

RnJvbTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQpXaGVu
IHdha2luZyB1cCBmcm9tIHRoZSBTdXNwZW5kLXRvLVJBTSBzdGF0ZSwgdGhlIGZvbGxvd2luZyBl
cnJvcg0Kd2FzIHNlZW46DQoNCm0yNXA4MCBzcGkyLjA6IGZsYXNoIG9wZXJhdGlvbiB0aW1lZCBv
dXQNCg0KVGhlIGZsYXNoIHJlbWFpbmVkIGluIGFuIHVuZGVmaW5lZCBzdGF0ZSwgcmV0dXJuaW5n
IDB4RkZzLg0KRml4IGl0IGJ5IHNldHRpbmcgdGhlIFNlcmlhbCBDbG9jayBCYXVkIFJhdGUsIGFz
IGl0IHdhcyBzZXQNCmJlZm9yZSB0aGUgY29udmVyc2lvbiB0byBTUElNRU0uDQoNClRlc3RlZCB3
aXRoIHNhbWE1ZDJfeHBsYWluZWQgYW5kIG14MjVsMjU2NzNnIHNwaS1ub3IgaW4NCkJhY2t1cCAr
IFNlbGYtUmVmcmVzaCBhbmQgU3VzcGVuZCBtb2Rlcy4NCg0KRml4ZXM6IDBlNmFhZTA4ZTlhZSAo
InNwaTogQWRkIFF1YWRTUEkgZHJpdmVyIGZvciBBdG1lbCBTQU1BNUQyIikNClJlcG9ydGVkLWJ5
OiBNYXJrIERlbmVlbiA8bWRlbmVlbkBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBUdWRvciBB
bWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQotLS0NCiBkcml2ZXJzL3NwaS9h
dG1lbC1xdWFkc3BpLmMgfCAxMCArKysrKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL2F0bWVs
LXF1YWRzcGkuYyBiL2RyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYw0KaW5kZXggMzJlYjc0NDdj
MzFhLi42YTdkN2I1NTNkOTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3Bp
LmMNCisrKyBiL2RyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYw0KQEAgLTE1MSw2ICsxNTEsNyBA
QCBzdHJ1Y3QgYXRtZWxfcXNwaSB7DQogCWNvbnN0IHN0cnVjdCBhdG1lbF9xc3BpX2NhcHMgKmNh
cHM7DQogCXUzMgkJCXBlbmRpbmc7DQogCXUzMgkJCW1yOw0KKwl1MzIJCQlzY3I7DQogCXN0cnVj
dCBjb21wbGV0aW9uCWNtZF9jb21wbGV0aW9uOw0KIH07DQogDQpAQCAtMzgyLDcgKzM4Myw3IEBA
IHN0YXRpYyBpbnQgYXRtZWxfcXNwaV9zZXR1cChzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KIAlz
dHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0cmwgPSBzcGktPm1hc3RlcjsNCiAJc3RydWN0IGF0bWVs
X3FzcGkgKmFxID0gc3BpX2NvbnRyb2xsZXJfZ2V0X2RldmRhdGEoY3RybCk7DQogCXVuc2lnbmVk
IGxvbmcgc3JjX3JhdGU7DQotCXUzMiBzY3IsIHNjYnI7DQorCXUzMiBzY2JyOw0KIA0KIAlpZiAo
Y3RybC0+YnVzeSkNCiAJCXJldHVybiAtRUJVU1k7DQpAQCAtMzk5LDggKzQwMCw4IEBAIHN0YXRp
YyBpbnQgYXRtZWxfcXNwaV9zZXR1cChzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KIAlpZiAoc2Ni
ciA+IDApDQogCQlzY2JyLS07DQogDQotCXNjciA9IFFTUElfU0NSX1NDQlIoc2Nicik7DQotCXdy
aXRlbF9yZWxheGVkKHNjciwgYXEtPnJlZ3MgKyBRU1BJX1NDUik7DQorCWFxLT5zY3IgPSBRU1BJ
X1NDUl9TQ0JSKHNjYnIpOw0KKwl3cml0ZWxfcmVsYXhlZChhcS0+c2NyLCBhcS0+cmVncyArIFFT
UElfU0NSKTsNCiANCiAJcmV0dXJuIDA7DQogfQ0KQEAgLTU4NCw2ICs1ODUsOSBAQCBzdGF0aWMg
aW50IF9fbWF5YmVfdW51c2VkIGF0bWVsX3FzcGlfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikN
CiAJY2xrX3ByZXBhcmVfZW5hYmxlKGFxLT5xc3BpY2spOw0KIA0KIAlhdG1lbF9xc3BpX2luaXQo
YXEpOw0KKw0KKwl3cml0ZWxfcmVsYXhlZChhcS0+c2NyLCBhcS0+cmVncyArIFFTUElfU0NSKTsN
CisNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLS0gDQoyLjkuNQ0KDQo=
