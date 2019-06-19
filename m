Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 160714BBD1
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 16:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfFSOie (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 10:38:34 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:13427 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSOie (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jun 2019 10:38:34 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="38031678"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jun 2019 07:38:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 19 Jun 2019 07:38:32 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 19 Jun 2019 07:38:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZXh86IpFZVS5y9m5VijsHA2ZTpWuRHLJMTWK54Sqiw=;
 b=Z2MYpX1DyLg6JGBqXVsVeWMIDadACh9IH9vEDMQlcXS9VZcULW08ZOBsXKXk0ZkjpwdojBF28nUozQTjpy/cTJ71GpSbJVQ/Ho92RxfsjdXbxF42gxUKg7ChuIYT6cSrdNLloXT2UsibQbiaQ0xKSqN/qoRJawX4yo4LY8KRqFw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1620.namprd11.prod.outlook.com (10.172.23.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Wed, 19 Jun 2019 14:38:28 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36%9]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 14:38:28 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <linus.walleij@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH] spi: fix ctrl->num_chipselect constraint
Thread-Topic: [PATCH] spi: fix ctrl->num_chipselect constraint
Thread-Index: AQHVJqyoJDQBj/rjE0m3OqBeVYcv8g==
Date:   Wed, 19 Jun 2019 14:38:28 +0000
Message-ID: <20190619143820.4045-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0048.eurprd04.prod.outlook.com
 (2603:10a6:802:2::19) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 224def5d-4c37-4779-605f-08d6f4c3cb20
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1620;
x-ms-traffictypediagnostic: BN6PR11MB1620:
x-microsoft-antispam-prvs: <BN6PR11MB162080B00A7F6882CB2DBD82F0E50@BN6PR11MB1620.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(189003)(199004)(6916009)(102836004)(2351001)(71190400001)(386003)(6506007)(71200400001)(256004)(14444005)(2501003)(1076003)(26005)(86362001)(186003)(2906002)(25786009)(5660300002)(5640700003)(53936002)(6436002)(6512007)(52116002)(99286004)(107886003)(6486002)(4326008)(54906003)(316002)(72206003)(478600001)(36756003)(66066001)(486006)(66446008)(14454004)(64756008)(66556008)(66476007)(3846002)(6116002)(73956011)(66946007)(50226002)(8936002)(305945005)(7736002)(8676002)(1730700003)(81156014)(81166006)(68736007)(2616005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1620;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ji9KpdGKWoi2eGeKUby4auqrxnUmQEo7kDARaq7ehUQvBzR/TU6zta2D+aiPX5MJgUDTcIY18vT5R7TRqlUp9pwvdOsU/dIWAzJhmThm0AXxJ2uhdhD5GnOhix/e4ysc1+Pq2+wRxixIAQSQJfpFnyk13bTcsw8HPuBiyejjt0zq5Xd8217YLsqc49YaNZ/spRmuQXNcyGq8vnqepWIF4ni6IPAm1R/CfqkdsVTG6Xs4d7/gXPzbXbLQ4LvhZlGJjBKhaJbAfBbWdWCPSMPOhfZBh8aOJUvR1EA7HbFTbvrJu+0iccMSqU/NnDxJ3exR+UTCyV85GdwVVmQndjj2Iv7my1Ytzc+kqck8MOAUGjijOe4NCGK+BdUaXkQsvkiDNiaDxMb7DnFdBup0c0hp8rgh/OxE10j+n3gBR5JJlXs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 224def5d-4c37-4779-605f-08d6f4c3cb20
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 14:38:28.7253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1620
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

RnJvbTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQphdDkx
c2FtOWcyNWVrIHNob3dlZCB0aGUgZm9sbG93aW5nIGVycm9yIGF0IHByb2JlOg0KYXRtZWxfc3Bp
IGYwMDAwMDAwLnNwaTogVXNpbmcgZG1hMGNoYW4yICh0eCkgYW5kIGRtYTBjaGFuMyAocngpDQpm
b3IgRE1BIHRyYW5zZmVycw0KYXRtZWxfc3BpOiBwcm9iZSBvZiBmMDAwMDAwMC5zcGkgZmFpbGVk
IHdpdGggZXJyb3IgLTIyDQoNCkNvbW1pdCAwYTkxOWFlNDkyMjMgKCJzcGk6IERvbid0IGNhbGwg
c3BpX2dldF9ncGlvX2Rlc2NzKCkgYmVmb3JlIGRldmljZSBuYW1lIGlzIHNldCIpDQptb3ZlZCB0
aGUgY2FsbGluZyBvZiBzcGlfZ2V0X2dwaW9fZGVzY3MoKSBhZnRlciBjdHJsLT5kZXYgaXMgc2V0
LA0KYnV0IGRpZG4ndCBtb3ZlIHRoZSAhY3RybC0+bnVtX2NoaXBzZWxlY3QgY2hlY2suIFdoZW4g
dGhlcmUgYXJlDQpjaGlwIHNlbGVjdHMgaW4gdGhlIGRldmljZSB0cmVlLCB0aGUgc3BpLWF0bWVs
IGRyaXZlciBsZXRzIHRoZQ0KU1BJIGNvcmUgZGlzY292ZXIgdGhlbSB3aGVuIHJlZ2lzdGVyaW5n
IHRoZSBTUEkgbWFzdGVyLg0KVGhlIGN0cmwtPm51bV9jaGlwc2VsZWN0IGlzIHRodXMgZXhwZWN0
ZWQgdG8gYmUgc2V0IGJ5DQpzcGlfZ2V0X2dwaW9fZGVzY3MoKS4NCg0KTW92ZSB0aGUgIWN0bHIt
Pm51bV9jaGlwc2VsZWN0IGFmdGVyIHNwaV9nZXRfZ3Bpb19kZXNjcygpIGFzIGl0IHdhcw0KYmVm
b3JlIHRoZSBhZm9yZW1lbnRpb25lZCBjb21taXQuIFdoaWxlIHRvdWNoaW5nIHRoaXMgYmxvY2ss
IGdldCByaWQNCm9mIHRoZSBleHBsaWNpdCBjb21wYXJpc29uIHdpdGggMCBhbmQgdXBkYXRlIHRo
ZSBjb21tZW50aW5nIHN0eWxlLg0KDQpGaXhlczogMGE5MTlhZTQ5MjIzICgic3BpOiBEb24ndCBj
YWxsIHNwaV9nZXRfZ3Bpb19kZXNjcygpIGJlZm9yZSBkZXZpY2UgbmFtZSBpcyBzZXQiKQ0KU2ln
bmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0K
LS0tDQogZHJpdmVycy9zcGkvc3BpLmMgfCAxMiArKysrKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zcGkvc3BpLmMgYi9kcml2ZXJzL3NwaS9zcGkuYw0KaW5kZXggZGI3ZDllODQ2NmM3Li41YzA4
MWY4Y2YwYjggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NwaS9zcGkuYw0KKysrIGIvZHJpdmVycy9z
cGkvc3BpLmMNCkBAIC0yMzk0LDExICsyMzk0LDYgQEAgaW50IHNwaV9yZWdpc3Rlcl9jb250cm9s
bGVyKHN0cnVjdCBzcGlfY29udHJvbGxlciAqY3RscikNCiAJaWYgKHN0YXR1cykNCiAJCXJldHVy
biBzdGF0dXM7DQogDQotCS8qIGV2ZW4gaWYgaXQncyBqdXN0IG9uZSBhbHdheXMtc2VsZWN0ZWQg
ZGV2aWNlLCB0aGVyZSBtdXN0DQotCSAqIGJlIGF0IGxlYXN0IG9uZSBjaGlwc2VsZWN0DQotCSAq
Lw0KLQlpZiAoY3Rsci0+bnVtX2NoaXBzZWxlY3QgPT0gMCkNCi0JCXJldHVybiAtRUlOVkFMOw0K
IAlpZiAoY3Rsci0+YnVzX251bSA+PSAwKSB7DQogCQkvKiBkZXZpY2VzIHdpdGggYSBmaXhlZCBi
dXMgbnVtIG11c3QgY2hlY2staW4gd2l0aCB0aGUgbnVtICovDQogCQltdXRleF9sb2NrKCZib2Fy
ZF9sb2NrKTsNCkBAIC0yNDY5LDYgKzI0NjQsMTMgQEAgaW50IHNwaV9yZWdpc3Rlcl9jb250cm9s
bGVyKHN0cnVjdCBzcGlfY29udHJvbGxlciAqY3RscikNCiAJCX0NCiAJfQ0KIA0KKwkvKg0KKwkg
KiBFdmVuIGlmIGl0J3MganVzdCBvbmUgYWx3YXlzLXNlbGVjdGVkIGRldmljZSwgdGhlcmUgbXVz
dA0KKwkgKiBiZSBhdCBsZWFzdCBvbmUgY2hpcHNlbGVjdC4NCisJICovDQorCWlmICghY3Rsci0+
bnVtX2NoaXBzZWxlY3QpDQorCQlyZXR1cm4gLUVJTlZBTDsNCisNCiAJc3RhdHVzID0gZGV2aWNl
X2FkZCgmY3Rsci0+ZGV2KTsNCiAJaWYgKHN0YXR1cyA8IDApIHsNCiAJCS8qIGZyZWUgYnVzIGlk
ICovDQotLSANCjIuOS41DQoNCg==
