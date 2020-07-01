Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDD32103EF
	for <lists+linux-spi@lfdr.de>; Wed,  1 Jul 2020 08:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGAG0b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Jul 2020 02:26:31 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45520 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726746AbgGAG0b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Jul 2020 02:26:31 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0616H0lw021669;
        Wed, 1 Jul 2020 02:26:26 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00128a01.pphosted.com with ESMTP id 31x315kmnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 02:26:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxYrMLsqUsearSMTgkyxHTVV8FHYYpfoLA/jfHk+OrKDw+IGmoY9+PC0rWsXrvtOtivvuBHh0ZP8bhuGZ/98EcxHvNQiYyXJJXTuEn67HZhcEG3TdddDsBXgo6FOnU9tcFjVCp9BmIq5ToRtBMIlvjFmHlCpuqyKDtSy5hsm+gaAGcKBwEt0Is8Fy9pxe1hgpnzZt6fSINIraliiwh8UwD/GleB6dqyEX7lFH0FcxAMSVQaon/xhfcOucP2Amfa2RMu8n2XOv5KF+6GBzk1YQN9RvTW2EZJnbyZV+kqqzIvRrtkKLZE4h1QQagkuK8hJgRw1KnjGC+ZnX3q8ipdpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Gh0bzUkB8YWiD1/dZide7Rt8i7U1vrMd8brH99I/k4=;
 b=hDQBGsRTBrIPTjmjEgvwBgilZt86hOhvABHQruqGvMJDJXVk0AQ7rgZoIW7oV3U9n0/mDCTIxLiKkSl3uCB37dFtVOPAQAwArqgtgdCShD5BOrLVjhe88tM4Fprl/RCXD9Jkfbv0lort7JdaDUuY2lkXouq9BQqAzHa3jX864/HIELML2KBuk+id+BBShGY3XtgQ0jMB1z1mfRXGB1S85dyKEkvtDpEnkc7zmCvDnf147NPP5cXMbf7fbzGO7b76lWtxVVRsY+3RBOcMlJEzIv7qJEdHXpANXTjggPPGk99ektp1nAPYHPj8SisczuHE0d59ZMZEmGN1c6P4OvqZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Gh0bzUkB8YWiD1/dZide7Rt8i7U1vrMd8brH99I/k4=;
 b=E3lrrUOq0GkiDMZAkXH/9r8AR9GoTJPwDuUknnRDrkE46NTzAmpbMKAaty2r2n3gJ6XaEdaQkgGXOSMt8z0jzhjFnMkbkKu+KMEkzdn+g0RjEfXNyoBgIIhRguZZ1Bst/2A+09TnE5Noll1HMtdk+cCMvuKt7uwlC0g/Z7sg8mY=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3851.namprd03.prod.outlook.com (2603:10b6:5:46::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Wed, 1 Jul
 2020 06:26:24 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 06:26:24 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "dianders@chromium.org" <dianders@chromium.org>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: Re: [PATCH] spi: Avoid setting the chip select if we don't need to
Thread-Topic: [PATCH] spi: Avoid setting the chip select if we don't need to
Thread-Index: AQHWTm8Wd+QNJOrWKE+ouXjZn5VwUqjyRDUA
Date:   Wed, 1 Jul 2020 06:26:24 +0000
Message-ID: <522b1d9297604a1cfa93fdc54a3cd0773cf7580a.camel@analog.com>
References: <20200629164103.1.Ied8e8ad8bbb2df7f947e3bc5ea1c315e041785a2@changeid>
In-Reply-To: <20200629164103.1.Ied8e8ad8bbb2df7f947e3bc5ea1c315e041785a2@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.128.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83bc389c-127f-4a95-6619-08d81d87ad99
x-ms-traffictypediagnostic: DM6PR03MB3851:
x-microsoft-antispam-prvs: <DM6PR03MB385112E709C57104CFB48ED1F96C0@DM6PR03MB3851.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h2L0pUrnplK39il8WrKFO5ZLlTtQFDwkIHByg0oqaZFyqW6xdfx5AbL3i2eCvgXYEUWz+j2Zmb3k+bMlLUDoLhWjEPsBf4TliXXCVJaDu2U4pfJO6qH+FtORjvozmUjpII2IyYZP7Nw88A839wO5be6qN6zWP3TU1cnuvFEF2FFDgrX+qJqrmDzD97WmSJJM1FMlZOLKUnQZ741bsVVG6JFS8tMthCdDDB7HV7YZCYQLUSGz0excflCB+eChg+wENa3WncI2VUhNnKnLv/5HJnO9BxUgpp7AT0SIao9sjhkRfD/7QydxLoX5ELUR+PtA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(366004)(39860400002)(376002)(346002)(2906002)(6512007)(8936002)(4326008)(5660300002)(66556008)(26005)(66946007)(2616005)(91956017)(478600001)(76116006)(66446008)(66476007)(64756008)(186003)(6506007)(36756003)(6486002)(71200400001)(86362001)(316002)(83380400001)(54906003)(110136005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: w06RPpwOfFII1OrEYOqDQjJVX1ITCSdkoJx/N/EHCKaQImSewcrXwsayy78tBh8F1qAlgNddQJePDpkNXKdJuvbJqRqlYT3l+nt6zTTuICJ1+uLNF186yAgQzFraZg8emTCyM4t6QhYxeLnrjY7n2Z0Zwn++aHT5ofM1l9hRYWdr96QNA3zOp8x/Wgnw/5Uwh7eOaNpmK7bhmucbYHY2kbNGaIsfcJs+5+SjzqTR1UoCpJ5gapEZXksENc0v/ZvdHrB/l6+A6Xv3TP6MJKgzbwN72ZEhXKjE+JNuvf5+4nmb5nPAM0/t/t8qaTjUz/leygIdc1dHe+T8pl4+2VbaiF/eNF/aAk0uvnRjKoscIX58cNmmgGY9Qzb+GzmcT792l1RhCpkDkMXEifou7sMWRmx+ZkUVvzCrViWGvwpv2dQV2oWIz0XPGE7YCRLhyv5+TOBi5MvaVV31eDI9L8549R3aNVMFPg+TKKAPIr/MuKM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <188B8C4A3D6B0E4BA7B9C32F7FFFD88B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bc389c-127f-4a95-6619-08d81d87ad99
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 06:26:24.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJ1YpIzksbfEexRyb11ZmFM0kA8CAeszajoSVRlo0ZLPdKtr1UVvf+50bq8fHeTELfBg1iYT7+Ekcs87y+k9uikT7CGmrRX6QGg8EtXykIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3851
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_03:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1011 suspectscore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007010045
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTI5IGF0IDE2OjQxIC0wNzAwLCBEb3VnbGFzIEFuZGVyc29uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBzb21lIFNQSSBjb250cm9sbGVycyAobGlrZSBzcGkt
Z2VuaS1xY29tKSBzZXR0aW5nIHRoZSBjaGlwIHNlbGVjdA0KPiBpcyBhIGhlYXZ5IG9wZXJhdGlv
bi4gIEZvciBpbnN0YW5jZSBvbiBzcGktZ2VuaS1xY29tLCB3aXRoIHRoZSBjdXJyZW50DQo+IGNv
ZGUsIGlzIHdhcyBtZWFzdXJlZCBhcyB0YWtpbmcgdXB3YXJkcyBvZiAyMCB1cy4gIEV2ZW4gb24g
U1BJDQo+IGNvbnRyb2xsZXJzIHRoYXQgYXJlbid0IGFzIGhlYXZ5LCBzZXR0aW5nIHRoZSBjaGlw
IHNlbGVjdCBpcyBhdCBsZWFzdA0KPiBzb21ldGhpbmcgbGlrZSBhIE1NSU8gb3BlcmF0aW9uIG92
ZXIgc29tZSBwZXJpcGhlcmFsIGJ1cyB3aGljaCBpc24ndA0KPiBhcyBmYXN0IGFzIGEgUkFNIGFj
Y2Vzcy4NCj4gDQo+IFdoaWxlIGl0IHdvdWxkIGJlIGdvb2QgdG8gZmluZCB3YXlzIHRvIG1pdGln
YXRlIHByb2JsZW1zIGxpa2UgdGhpcyBpbg0KPiB0aGUgZHJpdmVycyBmb3IgdGhvc2UgU1BJIGNv
bnRyb2xsZXJzLCBpdCBjYW4gYWxzbyBiZSBub3RlZCB0aGF0IHRoZQ0KPiBTUEkgZnJhbWV3b3Jr
IGNvdWxkIGFsc28gaGVscCBvdXQuICBTcGVjaWZpY2FsbHksIGluIHNvbWUgc2l0dWF0aW9ucywN
Cj4gd2UgY2FuIHNlZSB0aGUgU1BJIGZyYW1ld29yayBjYWxsaW5nIHRoZSBkcml2ZXIncyBzZXRf
Y3MoKSB3aXRoIHRoZQ0KPiBzYW1lIHBhcmFtZXRlciBzZXZlcmFsIHRpbWVzIGluIGEgcm93LiAg
VGhpcyBpcyBzcGVjaWZpY2FsbHkgb2JzZXJ2ZWQNCj4gd2hlbiBsb29raW5nIGF0IHRoZSB3YXkg
dGhlIENocm9tZSBPUyBFQyBTUEkgZHJpdmVyIChjcm9zX2VjX3NwaSkNCj4gd29ya3MgYnV0IG90
aGVyIGRyaXZlcnMgbGlrZWx5IHRyaXAgaXQgdG8gc29tZSBleHRlbnQuDQo+IA0KPiBMZXQncyBz
b2x2ZSB0aGlzIGJ5IGNhY2hpbmcgdGhlIGNoaXAgc2VsZWN0IHN0YXRlIGluIHRoZSBjb3JlIGFu
ZCBvbmx5DQo+IGNhbGxpbmcgaW50byB0aGUgY29udHJvbGxlciBpZiB0aGVyZSB3YXMgYSBjaGFu
Z2UuICBXZSBjaGVjayBub3Qgb25seQ0KPiB0aGUgImVuYWJsZSIgc3RhdGUgYnV0IGFsc28gdGhl
IGNoaXAgc2VsZWN0IG1vZGUgKGFjdGl2ZSBoaWdoIG9yDQo+IGFjdGl2ZSBsb3cpIHNpbmNlIGNv
bnRyb2xsZXJzIG1heSBjYXJlIGFib3V0IGJvdGggdGhlIG1vZGUgYW5kIHRoZQ0KPiBlbmFibGUg
ZmxhZyBpbiB0aGVpciBjYWxsYmFjay4NCg0KSSB0aGluayBjaGVja3BhdGNoIHN1Z2dlc3RlZCBJ
IGJlIGFkZGVkIGhlcmUsIHNpbmNlIEkgdG91Y2hlZCBzb21lIHBhcnRzIG9mDQp0aGUgZGVsYXkv
dGltaW5ncyBjb2RlLg0KDQo+IFNpZ25lZC1vZmYtYnk6IERvdWdsYXMgQW5kZXJzb24gPGRpYW5k
ZXJzQGNocm9taXVtLm9yZz4NCj4gLS0tDQo+IA0KPiAgZHJpdmVycy9zcGkvc3BpLmMgICAgICAg
fCAxMSArKysrKysrKysrKw0KPiAgaW5jbHVkZS9saW51eC9zcGkvc3BpLmggfCAgNCArKysrDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3NwaS9zcGkuYyBiL2RyaXZlcnMvc3BpL3NwaS5jDQo+IGluZGV4IDZmYTU2NTkwYmJh
Mi4uZDRiYTcyM2EzMGRhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGkuYw0KPiArKysg
Yi9kcml2ZXJzL3NwaS9zcGkuYw0KPiBAQCAtNzc4LDYgKzc3OCwxNyBAQCBzdGF0aWMgdm9pZCBz
cGlfc2V0X2NzKHN0cnVjdCBzcGlfZGV2aWNlICpzcGksIGJvb2wNCj4gZW5hYmxlKQ0KPiAgew0K
PiAgCWJvb2wgZW5hYmxlMSA9IGVuYWJsZTsNCj4gIA0KPiArCS8qDQo+ICsJICogQXZvaWQgY2Fs
bGluZyBpbnRvIHRoZSBkcml2ZXIgKG9yIGRvaW5nIGRlbGF5cykgaWYgdGhlIGNoaXANCj4gc2Vs
ZWN0DQo+ICsJICogaXNuJ3QgYWN0dWFsbHkgY2hhbmdpbmcgZnJvbSB0aGUgbGFzdCB0aW1lIHRo
aXMgd2FzIGNhbGxlZC4NCj4gKwkgKi8NCj4gKwlpZiAoKHNwaS0+Y29udHJvbGxlci0+bGFzdF9j
c19lbmFibGUgPT0gZW5hYmxlKSAmJg0KPiArCSAgICAoc3BpLT5jb250cm9sbGVyLT5sYXN0X2Nz
X21vZGVfaGlnaCA9PSAoc3BpLT5tb2RlICYNCj4gU1BJX0NTX0hJR0gpKSkNCj4gKwkJcmV0dXJu
Ow0KPiArDQo+ICsJc3BpLT5jb250cm9sbGVyLT5sYXN0X2NzX2VuYWJsZSA9IGVuYWJsZTsNCj4g
KwlzcGktPmNvbnRyb2xsZXItPmxhc3RfY3NfbW9kZV9oaWdoID0gc3BpLT5tb2RlICYgU1BJX0NT
X0hJR0g7DQo+ICsNCg0KSSBkb24ndCBmZWVsIGxpa2UgdGhpcyBpcyB0aGUgYmVzdCBhcHByb2Fj
aCBmb3IgdGhlIFNQSSBDUyBoYW5kbGluZywNCmJlY2F1c2UgaXQncyBwcmV0dHkgZGlmZmljdWx0
IHRvIGd1ZXNzIHRoZSBsYXN0IENTIHN0YXRlLCBhbmQgd2hldGhlciB0aGlzDQpyZXR1cm4gd291
bGQgY2F1c2Ugb3RoZXIgd2VpcmRlciBpc3N1ZXMgW2xpa2Ugbm90IHRvZ2dsaW5nIENTIHdoZW4g
aXQNCnNob3VsZF0uDQoNCk1heWJlIGEgcXVlc3Rpb24gaXM6IHdoZW4gc2hvdWxkIHRoaXMgQ1Mg
YmUgdG9nZ2xlZCBbb3Igbm90XT8NCklzIGl0IGJldHdlZW4gMiBjYWxscyBvZiBzcGlfdHJhbnNm
ZXJfb25lX21lc3NhZ2UoKSBvciBiZXR3ZWVuIDINCnNwaV90cmFuc2ZlcnM/DQpPciwgaXMgInhm
ZXItPmNzX2NoYW5nZSA9PSAxIiB3aGVyZSBpdCBzaG91bGRuJ3QgYmU/DQoNCkkgdGhpbmssIHRo
ZXJlIGFyZSBzb21lIHdheXMgdG8gbm90IHRvZ2dsZSBDUyBiZXR3ZWVuIHNvbWUgb2YgdGhlc2Us
IG9yIGlmDQp0aGVyZSBhcmVuJ3QsIHNvbWUgY29udHJvbHMgY291bGQgYmUgYWRkZWQvcHJvcG9z
ZWQgdG8gYXZvaWQgdG9nZ2xpbmcgQ1MsDQp2cyBkb2luZyBjYWNoaW5nLg0KDQo+ICAJaWYgKCFz
cGktPmNvbnRyb2xsZXItPnNldF9jc190aW1pbmcpIHsNCj4gIAkJaWYgKGVuYWJsZTEpDQo+ICAJ
CQlzcGlfZGVsYXlfZXhlYygmc3BpLT5jb250cm9sbGVyLT5jc19zZXR1cCwgTlVMTCk7DQo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NwaS9zcGkuaCBiL2luY2x1ZGUvbGludXgvc3BpL3Nw
aS5oDQo+IGluZGV4IGI0OTE3ZGY3OTYzNy4uMGU2N2E5YTNhMWQzIDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L3NwaS9zcGkuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3NwaS9zcGkuaA0K
PiBAQCAtMzY4LDYgKzM2OCw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBzcGlfdW5yZWdpc3Rlcl9k
cml2ZXIoc3RydWN0DQo+IHNwaV9kcml2ZXIgKnNkcnYpDQo+ICAgKiBAY3VyX21zZ19wcmVwYXJl
ZDogc3BpX3ByZXBhcmVfbWVzc2FnZSB3YXMgY2FsbGVkIGZvciB0aGUgY3VycmVudGx5DQo+ICAg
KiAgICAgICAgICAgICAgICAgICAgaW4tZmxpZ2h0IG1lc3NhZ2UNCj4gICAqIEBjdXJfbXNnX21h
cHBlZDogbWVzc2FnZSBoYXMgYmVlbiBtYXBwZWQgZm9yIERNQQ0KPiArICogQGxhc3RfY3NfZW5h
YmxlOiB3YXMgZW5hYmxlIHRydWUgb24gdGhlIGxhc3QgY2FsbCB0byBzZXRfY3MuDQo+ICsgKiBA
bGFzdF9jc19tb2RlX2hpZ2g6IHdhcyAobW9kZSAmIFNQSV9DU19ISUdIKSB0cnVlIG9uIHRoZSBs
YXN0IGNhbGwgdG8NCj4gc2V0X2NzLg0KPiAgICogQHhmZXJfY29tcGxldGlvbjogdXNlZCBieSBj
b3JlIHRyYW5zZmVyX29uZV9tZXNzYWdlKCkNCj4gICAqIEBidXN5OiBtZXNzYWdlIHB1bXAgaXMg
YnVzeQ0KPiAgICogQHJ1bm5pbmc6IG1lc3NhZ2UgcHVtcCBpcyBydW5uaW5nDQo+IEBAIC02MDQs
NiArNjA2LDggQEAgc3RydWN0IHNwaV9jb250cm9sbGVyIHsNCj4gIAlib29sCQkJCWF1dG9fcnVu
dGltZV9wbTsNCj4gIAlib29sICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN1cl9tc2dfcHJl
cGFyZWQ7DQo+ICAJYm9vbAkJCQljdXJfbXNnX21hcHBlZDsNCj4gKwlib29sCQkJCWxhc3RfY3Nf
ZW5hYmxlOw0KPiArCWJvb2wJCQkJbGFzdF9jc19tb2RlX2hpZ2g7DQo+ICAJYm9vbCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBmYWxsYmFjazsNCj4gIAlzdHJ1Y3QgY29tcGxldGlvbiAgICAg
ICAgICAgICAgIHhmZXJfY29tcGxldGlvbjsNCj4gIAlzaXplX3QJCQkJbWF4X2RtYV9sZW47DQo=
