Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 052795BA8A
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2019 13:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfGALZH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jul 2019 07:25:07 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41076 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727239AbfGALZH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jul 2019 07:25:07 -0400
X-Greylist: delayed 14411 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jul 2019 07:25:06 EDT
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x617Mkf4003987;
        Mon, 1 Jul 2019 03:24:25 -0400
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2056.outbound.protection.outlook.com [104.47.42.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tf787gpvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 01 Jul 2019 03:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEAnQiBkc3w3vVxa72fx+WBUe+fAhwK+RAb5PH3JdVI=;
 b=5qdXG/cxaZVHxgUX/cPsIkaS9WKF0BTZ51e95v/7eYjcv5HY20aq5YLivuHK9nS4P7RzRYADeybYNbhitoNE2QtpSyKFtr9uzeyrKWCkF29Sgvv1hG6X+Z7O1y12CIUwJMzyHaYelSsyimc9DcaUbQcItd1Pu2i24DdDJlMggGE=
Received: from BL2PR03MB577.namprd03.prod.outlook.com (10.141.92.20) by
 BL2PR03MB547.namprd03.prod.outlook.com (10.141.90.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Mon, 1 Jul 2019 07:24:23 +0000
Received: from BL2PR03MB577.namprd03.prod.outlook.com
 ([fe80::d70:e601:2346:3616]) by BL2PR03MB577.namprd03.prod.outlook.com
 ([fe80::d70:e601:2346:3616%5]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 07:24:23 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "lukas@wunner.de" <lukas@wunner.de>,
        "wahrenst@gmx.net" <wahrenst@gmx.net>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kernel@martin.sperl.org" <kernel@martin.sperl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "eric@anholt.net" <eric@anholt.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] spi: spi-bcm2835.c: Fix 3-wire mode
Thread-Topic: [PATCH] spi: spi-bcm2835.c: Fix 3-wire mode
Thread-Index: AQHVLcWKil6b5DVA2k6/uFd6YOkY56axa+0AgAP0lwA=
Date:   Mon, 1 Jul 2019 07:24:23 +0000
Message-ID: <54323339606a36febc6a8633a8d3a7db84b975c4.camel@analog.com>
References: <20190628123023.4696-1-nuno.sa@analog.com>
         <1b932c61-982b-aae0-1fef-3c574e7d17eb@gmx.net>
         <20190628190022.vya4h2lihm6x2xpb@wunner.de>
In-Reply-To: <20190628190022.vya4h2lihm6x2xpb@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b4adba4-54d1-4a9c-2ba9-08d6fdf5240b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BL2PR03MB547;
x-ms-traffictypediagnostic: BL2PR03MB547:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BL2PR03MB54759EE412EFCA4F545BEA599F90@BL2PR03MB547.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(39860400002)(376002)(189003)(199004)(68736007)(102836004)(99286004)(71190400001)(66066001)(26005)(6506007)(486006)(476003)(11346002)(446003)(25786009)(6116002)(2616005)(4326008)(71200400001)(118296001)(3846002)(2906002)(64756008)(91956017)(73956011)(76116006)(54906003)(316002)(76176011)(478600001)(81156014)(66946007)(86362001)(110136005)(7416002)(66476007)(66446008)(66556008)(81166006)(305945005)(6486002)(6246003)(186003)(229853002)(6436002)(7736002)(6306002)(966005)(53936002)(72206003)(5660300002)(6512007)(2501003)(8936002)(8676002)(14454004)(256004)(14444005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB547;H:BL2PR03MB577.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FNNdUVnwmHEtDtq5c+AJtWxU+J1RsXElU49U3A2fKpxYs33aLx7ulkAQxdWXX5QMS2HgXatkdyao24Kf4g4XvHzAXj9tf+FxZngakHPf2TeOCtzrfoMEvUlRDZlS5dusc+xSwb0FI0HXbwolVXKH5E4nF+Mj9JPMKYyc5vC5NfOccp1XsuuWuHOKGEzacOeZ5av+vQxUoxRs5qEkwYiwQrmDlF8mz0ZlIWgvVY2kcUVJRaQf+vmPCZW+z9hKSsqHnlBwuvMaL0dnLtIkMxG/JqsnI9f2Rl9AiP7eEvgFomVI7WS0yehUqX529V9B7lgd+v/GoaGzjx+lIFVCJFBdFvg7dUn7GEkEBvSNHy1Z0Az9CNQ6tI9rmYgxvbO6QZxbIZ8+kTZowg9b6ZzEQ6IitfYh9mBZlv75kQAMZDjHmIE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <497AEA5E6E7D5B4A816686905C8A2FF6@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4adba4-54d1-4a9c-2ba9-08d6fdf5240b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 07:24:23.1669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nuno.Sa@analog.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB547
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010092
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgTHVrYXMgYW5kIFN0ZWZhbiwNCg0KT24gRnJpLCAyMDE5LTA2LTI4IGF0IDIxOjAwICswMjAw
LCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+IA0KPiBPbiBGcmksIEp1biAyOCwgMjAxOSBhdCAwNToy
Mzo1NFBNICswMjAwLCBTdGVmYW4gV2FocmVuIHdyb3RlOg0KPiA+IEFtIDI4LjA2LjE5IHVtIDE0
OjMwIHNjaHJpZWIgTnVubyBTw6E6DQo+ID4gPiBBcyBzdGF0ZWQgaW4NCj4gPiA+IGh0dHBzOi8v
d3d3LnJhc3BiZXJyeXBpLm9yZy9kb2N1bWVudGF0aW9uL2hhcmR3YXJlL3Jhc3BiZXJyeXBpL3Nw
aS9SRUFETUUubWQsDQo+ID4gPiBvbmUgb2Ygcnggb3IgdHggYnVmZmVyJ3MgbXVzdCBiZSBudWxs
LiBIb3dldmVyLCBpZiBETUEgaXMNCj4gPiA+IGVuYWJsZWQsIHRoZQ0KPiA+ID4gZHJpdmVyIHNl
dHMgdGhlIFNQSV9DT05UUk9MTEVSX01VU1RfUlggfCBTUElfQ09OVFJPTExFUl9NVVNUX1RYDQo+
ID4gPiBvbiB0aGUNCj4gPiA+IGNvbnRyb2xsZXIgZmxhZ3MuIEhlbmNlLCB0aGUgc3BpIGNvcmUg
d2lsbCBwcm92aWRlIGR1bW15IGJ1ZmZlcnMNCj4gPiA+IGV2ZW4gaWYNCj4gPiA+IG9uZSBvZiB0
aGUgYnVmZmVycyB3YXMgc2V0IHRvIG51bGwgYnkgdGhlIGRldmljZSBkcml2ZXIuIFRodXMsDQo+
ID4gPiB0aGUNCj4gPiA+IGNvbW11bmljYXRpb24gd2l0aCB0aGUgMy13aXJlIGRldmljZSBmYWls
cy4NCj4gPiA+IA0KPiA+ID4gVGhpcyBwYXRjaCB1c2VzIHRoZSBwcmVwYXJlX21lc3NhZ2UgY2Fs
bGJhY2sgdG8gbG9vayBmb3IgdGhlDQo+ID4gPiBkZXZpY2UgbW9kZQ0KPiA+ID4gYW5kIHNldHMv
Y2xlYXJzIHRoZSBTUElfQ09OVFJPTExFUl9NVVNUX1JYIHwNCj4gPiA+IFNQSV9DT05UUk9MTEVS
X01VU1RfVFggb24gYQ0KPiA+ID4gcGVyIHNwaSBtZXNzYWdlIGJhc2lzLiBJdCBhbHNvIGFzc3Vt
ZXMgdGhhdCBETUEgaXMgbm90IHN1cHBvcnRlZA0KPiA+ID4gb24NCj4gPiA+IGhhbGYtZHVwbGV4
IGRldmljZXMuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE51bm8gU8OhIDxudW5vLnNh
QGFuYWxvZy5jb20+DQo+ID4gDQo+ID4gaSBuZXZlciB0ZXN0ZWQgdGhlIDMtd2lyZSBtb2RlLiBD
b3VsZCB5b3UgcGxlYXNlIGRlc2NyaWJlIHlvdXIgdGVzdA0KPiA+IHNldHVwPw0KDQpJJ20gd29y
a2luZyBvbiBhIHJwaSBjYXBlIHdoaWNoIHVzZXMgdGhpcyBkZXZpY2UgDQpodHRwczovL2dpdGh1
Yi5jb20vYW5hbG9nZGV2aWNlc2luYy9saW51eC9ibG9iL21hc3Rlci9kcml2ZXJzL2lpby9mcmVx
dWVuY3kvYWRmNDM3MS5jDQp3aGljaCBpcyBjb25uZWN0ZWQgaW4gMy1XSVJFIG1vZGUuIEkgY291
bGQgY29uZmlybSB0aGF0IHNwaSB3YXMgbm90DQp3b3JraW5nLg0KDQo+IA0KPiBfX3NwaV92YWxp
ZGF0ZSgpIHJldHVybnMgLUVJTlZBTCBpZiAzLXdpcmUgbW9kZSBpcyB1c2VkIGFuZCBib3RoDQo+
IGJ1ZmZlcnMNCj4gYXJlIG5vbi1OVUxMLCBJIGd1ZXNzIHRoYXQncyB0aGUgcHJvYmxlbS4NCg0K
SW4gbXkgY2FzZSwgX19zcGlfdmFsaWRhdGUoKSB3YXMgb2sgYmVjYXVzZSBteSBkZXZpY2UgZHJp
dmVyIGlzIHBhc3NpbmcNCm9uZSBvZiByeCBvciB0eCBhcyBOVUxMLiBUaGUgcHJvYmxlbSBpcyBp
biBzcGlfbWFwX21zZygpIHdoaWNoDQphbGxvY2F0ZXMgZHVtbXkgYnVmZmVycyAoYmVjYXVzZSBv
ZiB0aGUgY3RybCBmbGFncykuIEFzIGEgcmVzdWx0LCBpbg0KYmNtMjgzNV9zcGlfdHJhbnNmZXJf
b25lKCkgd2Ugc2V0ICJjcyB8PSBCQ00yODM1X1NQSV9DU19SRU47IiB3aGVuIHdlDQp3YW50IHRv
IGRvIHR4IG9ubHkuIEkgYmVsaWV2ZSB0aGlzIHdhcyB0aGUgYWN0dWFsIHByb2JsZW0uLi4NCg0K
PiANCj4gDQo+ID4gQE1hcnRpbiwgQEx1a2FzIEFyZSB5b3UgZmluZSB3aXRoIHRoaXMgcGF0Y2g/
DQo+IA0KPiBJIGhhdmUgYSBwYXRjaCBzZXQgaW4gdGhlIHBpcGVsaW5lIHRvIGRyb3AgU1BJX0NP
TlRST0xMRVJfTVVTVF9SWA0KPiBhbmQgU1BJX0NPTlRST0xMRVJfTVVTVF9UWCBmcm9tIHNwaS1i
Y20yODM1LmMuDQo+IA0KPiBMYXRlc3Qgc25hcHNob3QgaXMgYXZhaWxhYmxlIGhlcmUgKHRvcC1t
b3N0IDEwIGNvbW1pdHMpOg0KPiBodHRwczovL2dpdGh1Yi5jb20vbDFrL2xpbnV4L2NvbW1pdHMv
cmV2cGlfc3RhZ2luZw0KPiANCj4gQE51bm8sIGNvdWxkIHlvdSBnaXZlIHRoaXMgYnJhbmNoIGEg
c3BpbiBhbmQgc2VlIGlmIGl0IGZpeGVzIHRoZQ0KPiBpc3N1ZSBmb3IgeW91PyAgSWYgc28sIHRo
aXMgbWlnaHQgYmUgYSBiZXR0ZXIgc29sdXRpb24uICBZb3VyIHBhdGNoDQo+IGlzIGZpbmUgaW4g
cHJpbmNpcGxlIHNpbmNlIGl0IHdvcmtzIGFyb3VuZCB0aGUgcHJvYmxlbSwgYnV0IHRoZQ0KPiBw
YXRjaCBzZXQgb24gdGhlIGFib3ZlLWxpbmtlZCBicmFuY2ggZml4ZXMgaXQgYXQgdGhlIHJvb3Qu
DQo+IEl0IGFsc28gcHJvdmlkZXMgYSBuaWNlIHdlbGNvbWUgc3BlZWR1cCBhbmQgcmVkdWNlcyBy
ZXNvdXJjZQ0KPiBjb25zdW1wdGlvbi4NCj4gDQo+IEkndmUgYmVlbiB3b3JraW5nIG9uIHRoaXMg
b24tYW5kLW9mZiBmb3IgYWJvdXQgaGFsZiBhIHllYXIsDQo+IEkgdGhpbmsgdGhlIHBhdGNoIHNl
dCBpcyBpbiBwcmV0dHkgZ29vZCBzaGFwZSBub3cgc28gSSB3YXMNCj4gcGxhbm5pbmcgdG8gc3Vi
bWl0IGl0IHByb2JhYmx5IGluIDIgd2Vla3Mgb3Igc28uDQo+IA0KDQpUaGlzIGxvb2tzIGdyZWF0
LiBJIHdpbGwgdHJ5IHRvIGdpdmUgdGhpcyBhIHRyeSBzdGlsbCB0b2RheS4NCg0KPiBUaGFua3Ms
DQo+IA0KPiBMdWthcw0KDQpSZWdhcmRzLA0KTnVubyBTw6ENCg==
