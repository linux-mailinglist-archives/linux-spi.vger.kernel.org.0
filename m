Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9643547A530
	for <lists+linux-spi@lfdr.de>; Mon, 20 Dec 2021 07:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhLTG4e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Dec 2021 01:56:34 -0500
Received: from 113.196.136.146.ll.static.sparqnet.net ([113.196.136.146]:54602
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232310AbhLTG4e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Dec 2021 01:56:34 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(49491:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Mon, 20 Dec 2021 14:56:30 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 20 Dec 2021 14:56:24 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 20 Dec 2021 14:56:24 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v4 1/2] SPI: Add SPI driver for Sunplus SP7021
Thread-Topic: [PATCH v4 1/2] SPI: Add SPI driver for Sunplus SP7021
Thread-Index: AQHX7aQdqhfHTPMKakCCsqwpEyTHn6w2f9cAgARz93A=
Date:   Mon, 20 Dec 2021 06:56:24 +0000
Message-ID: <e3efae3bae8b4ea99367bb1a2efd81a0@sphcmbx02.sunplus.com.tw>
References: <cover.1639123362.git.lhjeff911@gmail.com>
 <65fb77debacc95ed3f54adac978ba24f2470f92e.1639123362.git.lhjeff911@gmail.com>
 <CAHp75VepLpcBR=Aqn2Zgvvq+dxiyrj9tYAYprx1Yjxhuv6JHKg@mail.gmail.com>
In-Reply-To: <CAHp75VepLpcBR=Aqn2Zgvvq+dxiyrj9tYAYprx1Yjxhuv6JHKg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.51]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgTXIgQW5keSBTaGV2Y2hlbmtvDQoNCj4gDQo+ID4gK2NvbmZpZyBTUElfU1VOUExVU19TUDcw
MjENCj4gPiArICAgICAgIHRyaXN0YXRlICJTdW5wbHVzIFNQNzAyMSBTUEkgY29udHJvbGxlciIN
Cj4gPiArICAgICAgIGRlcGVuZHMgb24gU09DX1NQNzAyMQ0KPiANCj4gTm8gQ09NUElMRV9URVNU
Pw0KPg0KDQpJIHdpbGwgYWRkIGl0IGluIG5leHQgbmV4dCBzdWJtaXNzaW9uDQoNCg0KDQoNCj4g
Li4uDQo+IAkNCj4gPiArY29uZmlnIFNQSV9TVU5QTFVTX1NQNzAyMQ0KPiA+ICsgICAgICAgdHJp
c3RhdGUgIlN1bnBsdXMgU1A3MDIxIFNQSSBjb250cm9sbGVyIg0KPiA+ICsgICAgICAgZGVwZW5k
cyBvbiBTT0NfU1A3MDIxDQo+IA0KPiBObyBDT01QSUxFX1RFU1Q/DQo+DQoNCj4gDQo+ID4gKyNk
ZWZpbmUgU1A3MDIxX0ZJRk9fREFUQV9CSVRTICAgICAoMTYgKiA4KQ0KPiANCj4gV2hhdCBkb2Vz
IHRoaXMgbXVsdGlwbGljYXRpb24gbWVhbj8NCj4gDQo+IC4uLg0KPg0KDQpJdCB3aWxsIGRlZmlu
ZSB0aGUgbGVuZ3RoIG9mIHRoZSBGSUZPDQpJIHdpbGwgZGVmaW5lIGl0IGNsZWFybHkgYXMgZm9s
bG93cw0KDQojZGVmaW5lIFNQNzAyMV9GSUZPX0RBVEFfTEVOICAgICAxNg0KDQo+ID4gKyAgICAg
ICB2b2lkIF9faW9tZW0gKm1hc19iYXNlOw0KPiA+ICsgICAgICAgdm9pZCBfX2lvbWVtICpzbGFf
YmFzZTsNCj4gDQo+IFRoZXNlIDMgbGV0dGVyIGFiYnJldmlhdGlvbnMgYXJlIG5vdCBzdGFuZGFy
ZCwgbWF5YmUgeW91IGNhbiBzaW1wbHkgc3dpdGNoIHRvIG9uZSBsZXR0ZXI/DQo+IA0KPiBtX2Jh
c2U7DQo+IHNfYmFzZTsNCj4gDQo+IGFuZCBzbyBvbiBiZWxvdz8NCj4NCg0KSSB3aWxsIGFkZCBp
dCBpbiBuZXh0IG5leHQgc3VibWlzc2lvbg0KDQo+ICtzdGF0aWMgaXJxcmV0dXJuX3Qgc3A3MDIx
X3NwaV9zbGFfaXJxKGludCBpcnEsIHZvaWQgKmRldikgew0KPiA+ICsgICAgICAgc3RydWN0IHNw
NzAyMV9zcGlfY3RsciAqcHNwaW0gPSBkZXY7DQo+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgZGF0
YV9zdGF0dXM7DQo+ID4gKw0KPiANCj4gPiArICAgICAgIGRhdGFfc3RhdHVzID0gcmVhZGwocHNw
aW0tPnNsYV9iYXNlICsgU1A3MDIxX0RBVEFfUkRZX1JFRyk7DQo+ID4gKyAgICAgICB3cml0ZWwo
ZGF0YV9zdGF0dXMgfCBTUDcwMjFfU0xBX0NMUl9JTlQsIHBzcGltLT5zbGFfYmFzZSArDQo+ID4g
KyBTUDcwMjFfREFUQV9SRFlfUkVHKTsNCj4gDQo+IENhbiB0aGlzIElPIGJlIHJ1biBpbiBwYXJh
bGxlbCB3aXRoIHNvbWUgb3RoZXIgZnVuY3Rpb25zPyBJZiBzbywgd2hlcmUgaXMgdGhlIHN5bmNo
cm9uaXphdGlvbj8NCj4NCg0KTm8gSXQgY2FuJ3QgcnVuIHdpdGggb3RoZXJmdW5jdGlvbnMuDQoN
Cg0KPiBVc2VsZXNzIGFzc2lnbm1lbnQuDQo+IA0KPiA+ICsgICAgICAgbXV0ZXhfbG9jaygmcHNw
aW0tPmJ1Zl9sb2NrKTsNCj4gPiArICAgICAgIHJlaW5pdF9jb21wbGV0aW9uKCZwc3BpbS0+c2xh
X2lzcik7DQo+IA0KPiA+ICsgICAgICAgcmVnX3RlbXAgPSBTUDcwMjFfU0xBX0RNQV9FTiB8IFNQ
NzAyMV9TTEFfRE1BX1JXIHwNCj4gPiArIEZJRUxEX1BSRVAoU1A3MDIxX1NMQV9ETUFfQ01ELCAz
KTsNCj4gDQo+IERvIHlvdSByZWFsbHkgbmVlZCB0byBoYXZlIHRoaXMgYXNzaWdubWVudCB1bmRl
ciB0aGUgbG9jaz8NCg0KTm8sIEFuZCBpIHdpbGwgcmVtb3ZlIHRoZSBsb2NrIGZvciB0aG9zZSBz
ZXR0aW5nLg0KDQo+IERpdHRvIGZvciB0aGUgcmVzdCBvZiB0aGUgc2ltaWxhciBjYXNlcy4NCj4g
DQoNCkkgd2lsbCBtb2RpZnkgdGhvc2UgZnVuY3Rpb24gYXMgYmVsb3cNCg0KaW50IHNwNzAyMV9z
cGlfc2xhX3R4KHN0cnVjdCBzcGlfZGV2aWNlICpzcGksIHN0cnVjdCBzcGlfdHJhbnNmZXIgKnhm
ZXIpDQp7DQoJc3RydWN0IHNwNzAyMV9zcGlfY3RsciAqcHNwaW0gPSBzcGlfY29udHJvbGxlcl9n
ZXRfZGV2ZGF0YShzcGktPmNvbnRyb2xsZXIpOw0KDQoJcmVpbml0X2NvbXBsZXRpb24oJnBzcGlt
LT5zbGFfaXNyKTsNCgl3cml0ZWwoU1A3MDIxX1NMQV9ETUFfRU4gfCBTUDcwMjFfU0xBX0RNQV9S
VyB8IEZJRUxEX1BSRVAoU1A3MDIxX1NMQV9ETUFfQ01ELCAzKSwNCgkgICAgICAgcHNwaW0tPnNf
YmFzZSArIFNQNzAyMV9TTFZfRE1BX0NUUkxfUkVHKTsNCgl3cml0ZWwoeGZlci0+bGVuLCBwc3Bp
bS0+c19iYXNlICsgU1A3MDIxX1NMVl9ETUFfTEVOR1RIX1JFRyk7DQoJd3JpdGVsKHhmZXItPnR4
X2RtYSwgcHNwaW0tPnNfYmFzZSArIFNQNzAyMV9TTFZfRE1BX0FERFJfUkVHKTsNCgl3cml0ZWwo
cmVhZGwocHNwaW0tPnNfYmFzZSArIFNQNzAyMV9EQVRBX1JEWV9SRUcpIHwgU1A3MDIxX1NMQV9E
QVRBX1JEWSwNCgkgICAgICAgcHNwaW0tPnNfYmFzZSArIFNQNzAyMV9EQVRBX1JEWV9SRUcpOw0K
CWlmICh3YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVycnVwdGlibGUoJnBzcGltLT5pc3JfZG9uZSkp
IHsNCgkJZGV2X2Vycigmc3BpLT5kZXYsICIlcygpIHdhaXRfZm9yX2NvbXBsZXRpb24gZXJyXG4i
LCBfX2Z1bmNfXyk7DQoJCXJldHVybiAtRUlOVFI7DQoJfQ0KCXJldHVybiAwOw0KfQ0KDQppbnQg
c3A3MDIxX3NwaV9zbGFfcngoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwgc3RydWN0IHNwaV90cmFu
c2ZlciAqeGZlcikNCnsNCglzdHJ1Y3Qgc3A3MDIxX3NwaV9jdGxyICpwc3BpbSA9IHNwaV9jb250
cm9sbGVyX2dldF9kZXZkYXRhKHNwaS0+Y29udHJvbGxlcik7DQoJaW50IHJldCA9IDA7DQoNCgly
ZWluaXRfY29tcGxldGlvbigmcHNwaW0tPmlzcl9kb25lKTsNCgl3cml0ZWwoU1A3MDIxX1NMQV9E
TUFfRU4gfCBGSUVMRF9QUkVQKFNQNzAyMV9TTEFfRE1BX0NNRCwgMyksDQoJICAgICAgIHBzcGlt
LT5zX2Jhc2UgKyBTUDcwMjFfU0xWX0RNQV9DVFJMX1JFRyk7DQoJd3JpdGVsKHhmZXItPmxlbiwg
cHNwaW0tPnNfYmFzZSArIFNQNzAyMV9TTFZfRE1BX0xFTkdUSF9SRUcpOw0KCXdyaXRlbCh4ZmVy
LT5yeF9kbWEsIHBzcGltLT5zX2Jhc2UgKyBTUDcwMjFfU0xWX0RNQV9BRERSX1JFRyk7DQoJaWYg
KHdhaXRfZm9yX2NvbXBsZXRpb25faW50ZXJydXB0aWJsZSgmcHNwaW0tPmlzcl9kb25lKSkgew0K
CQlkZXZfZXJyKCZzcGktPmRldiwgIiVzKCkgd2FpdF9mb3JfY29tcGxldGlvbiBlcnJcbiIsIF9f
ZnVuY19fKTsNCgkJcmV0dXJuIC1FSU5UUjsNCgl9DQoJd3JpdGVsKFNQNzAyMV9TTEFfU1dfUlNU
LCBwc3BpbS0+c19iYXNlICsgU1A3MDIxX1NMVl9ETUFfQ1RSTF9SRUcpOw0KCXJldHVybiByZXQ7
DQp9DQoNCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBT
aGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBTYXR1cmRheSwg
RGVjZW1iZXIgMTgsIDIwMjEgMjowNSBBTQ0KPiBUbzogTGktaGFvIEt1byA8bGhqZWZmOTExQGdt
YWlsLmNvbT4NCj4gQ2M6IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+OyBN
YXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBr
ZXJuZWwub3JnPjsgbGludXgtc3BpIDxsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnPjsgZGV2aWNl
dHJlZSA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBMaW51eCBLZXJuZWwgTWFpbGlu
ZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgV2VsbHMgTHUg5ZGC6Iqz6aiw
IDx3ZWxscy5sdUBzdW5wbHVzLmNvbT47IExoDQo+IEt1byDpg63lipvosaogPGxoLkt1b0BzdW5w
bHVzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzJdIFNQSTogQWRkIFNQSSBkcml2
ZXIgZm9yIFN1bnBsdXMgU1A3MDIxDQo+IA0KPiBPbiBGcmksIERlYyAxMCwgMjAyMSBhdCAxMTow
MiBBTSBMaS1oYW8gS3VvIDxsaGplZmY5MTFAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZy
b206ICJMaS1oYW8gS3VvIiA8bGhqZWZmOTExQGdtYWlsLmNvbT4NCj4gPg0KPiA+IEFkZCBTUEkg
ZHJpdmVyIGZvciBTdW5wbHVzIFNQNzAyMS4NCj4gDQo+IC4uLg0KPiANCj4gPiArY29uZmlnIFNQ
SV9TVU5QTFVTX1NQNzAyMQ0KPiA+ICsgICAgICAgdHJpc3RhdGUgIlN1bnBsdXMgU1A3MDIxIFNQ
SSBjb250cm9sbGVyIg0KPiA+ICsgICAgICAgZGVwZW5kcyBvbiBTT0NfU1A3MDIxDQo+IA0KPiBO
byBDT01QSUxFX1RFU1Q/DQo+IA0KPiA+ICsgICAgICAgaGVscA0KPiA+ICsgICAgICAgICBUaGlz
IGVuYWJsZXMgU3VucGx1cyBTUDcwMjEgU1BJIGNvbnRyb2xsZXIgZHJpdmVyIG9uIHRoZSBTUDcw
MjEgU29Dcy4NCj4gPiArICAgICAgICAgVGhpcyBkcml2ZXIgY2FuIGFsc28gYmUgYnVpbHQgYXMg
YSBtb2R1bGUuIElmIHNvLCB0aGUgbW9kdWxlIHdpbGwgYmUNCj4gPiArICAgICAgICAgY2FsbGVk
IGFzIHNwaS1zdW5wbHVzLXNwNzAyMS4NCj4gPiArDQo+ID4gKyAgICAgICAgIElmIHlvdSBoYXZl
IGEgU3VucGx1cyBTUDcwMjEgcGxhdGZvcm0gc2F5IFkgaGVyZS4NCj4gPiArICAgICAgICAgSWYg
dW5zdXJlLCBzYXkgTi4NCj4gDQo+IC4uLg0KPiANCj4gPiArI2RlZmluZSBTUDcwMjFfRklGT19E
QVRBX0JJVFMgICAgICgxNiAqIDgpDQo+IA0KPiBXaGF0IGRvZXMgdGhpcyBtdWx0aXBsaWNhdGlv
biBtZWFuPw0KPiANCj4gLi4uDQo+IA0KPiA+ICtzdHJ1Y3Qgc3A3MDIxX3NwaV9jdGxyIHsNCj4g
PiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiArICAgICAgIHN0cnVjdCBzcGlfY29u
dHJvbGxlciAqY3RscjsNCj4gDQo+ID4gKyAgICAgICB2b2lkIF9faW9tZW0gKm1hc19iYXNlOw0K
PiA+ICsgICAgICAgdm9pZCBfX2lvbWVtICpzbGFfYmFzZTsNCj4gDQo+IFRoZXNlIDMgbGV0dGVy
IGFiYnJldmlhdGlvbnMgYXJlIG5vdCBzdGFuZGFyZCwgbWF5YmUgeW91IGNhbiBzaW1wbHkgc3dp
dGNoIHRvIG9uZSBsZXR0ZXI/DQo+IA0KPiBtX2Jhc2U7DQo+IHNfYmFzZTsNCj4gDQo+IGFuZCBz
byBvbiBiZWxvdz8NCj4gDQo+IEFsc28gY29uc2lkZXIgdG8gdXNlIHRlcm1pbm9sb2d5IGNvbnRy
b2xsZXIgKGN0cmwpIGFuZCBwZXJpcGhlcmFsIChwZXIpLg0KPiANCj4gPiArICAgICAgIHUzMiB4
ZmVyX2NvbmY7DQo+ID4gKyAgICAgICBpbnQgbW9kZTsNCj4gPiArICAgICAgIGludCBtYXNfaXJx
Ow0KPiA+ICsgICAgICAgaW50IHNsYV9pcnE7DQo+ID4gKyAgICAgICBzdHJ1Y3QgY2xrICpzcGlf
Y2xrOw0KPiA+ICsgICAgICAgc3RydWN0IHJlc2V0X2NvbnRyb2wgKnJzdGM7DQo+ID4gKyAgICAg
ICAvLyBpcnEgc3BpbiBsb2NrDQo+ID4gKyAgICAgICBzcGlubG9ja190IGxvY2s7DQo+ID4gKyAg
ICAgICAvLyBkYXRhIHhmZXIgbG9jaw0KPiA+ICsgICAgICAgc3RydWN0IG11dGV4IGJ1Zl9sb2Nr
Ow0KPiA+ICsgICAgICAgc3RydWN0IGNvbXBsZXRpb24gaXNyX2RvbmU7DQo+ID4gKyAgICAgICBz
dHJ1Y3QgY29tcGxldGlvbiBzbGFfaXNyOw0KPiA+ICsgICAgICAgdW5zaWduZWQgaW50ICByeF9j
dXJfbGVuOw0KPiA+ICsgICAgICAgdW5zaWduZWQgaW50ICB0eF9jdXJfbGVuOw0KPiA+ICsgICAg
ICAgdW5zaWduZWQgaW50ICBkYXRhX3VuaXQ7DQo+ID4gKyAgICAgICBjb25zdCB1OCAqdHhfYnVm
Ow0KPiA+ICsgICAgICAgdTggKnJ4X2J1ZjsNCj4gPiArfTsNCj4gDQo+IC4uLg0KPiANCj4gPiAr
c3RhdGljIGlycXJldHVybl90IHNwNzAyMV9zcGlfc2xhX2lycShpbnQgaXJxLCB2b2lkICpkZXYp
IHsNCj4gPiArICAgICAgIHN0cnVjdCBzcDcwMjFfc3BpX2N0bHIgKnBzcGltID0gZGV2Ow0KPiA+
ICsgICAgICAgdW5zaWduZWQgaW50IGRhdGFfc3RhdHVzOw0KPiA+ICsNCj4gDQo+ID4gKyAgICAg
ICBkYXRhX3N0YXR1cyA9IHJlYWRsKHBzcGltLT5zbGFfYmFzZSArIFNQNzAyMV9EQVRBX1JEWV9S
RUcpOw0KPiA+ICsgICAgICAgd3JpdGVsKGRhdGFfc3RhdHVzIHwgU1A3MDIxX1NMQV9DTFJfSU5U
LCBwc3BpbS0+c2xhX2Jhc2UgKw0KPiA+ICsgU1A3MDIxX0RBVEFfUkRZX1JFRyk7DQo+IA0KPiBD
YW4gdGhpcyBJTyBiZSBydW4gaW4gcGFyYWxsZWwgd2l0aCBzb21lIG90aGVyIGZ1bmN0aW9ucz8g
SWYgc28sIHdoZXJlIGlzIHRoZSBzeW5jaHJvbml6YXRpb24/DQo+IA0KPiA+ICsgICAgICAgY29t
cGxldGUoJnBzcGltLT5zbGFfaXNyKTsNCj4gPiArICAgICAgIHJldHVybiBJUlFfTk9ORTsNCj4g
PiArfQ0KPiANCj4gLi4uDQo+IA0KPiA+ICtpbnQgc3A3MDIxX3NwaV9zbGFfdHgoc3RydWN0IHNw
aV9kZXZpY2UgKnNwaSwgc3RydWN0IHNwaV90cmFuc2Zlcg0KPiA+ICsqeGZlcikgew0KPiA+ICsg
ICAgICAgc3RydWN0IHNwNzAyMV9zcGlfY3RsciAqcHNwaW0gPQ0KPiA+ICtzcGlfY29udHJvbGxl
cl9nZXRfZGV2ZGF0YShzcGktPmNvbnRyb2xsZXIpOw0KPiANCj4gPiArICAgICAgIHUzMiByZWdf
dGVtcCA9IDA7DQo+IA0KPiBVc2VsZXNzIGFzc2lnbm1lbnQuDQo+IA0KPiA+ICsgICAgICAgbXV0
ZXhfbG9jaygmcHNwaW0tPmJ1Zl9sb2NrKTsNCj4gPiArICAgICAgIHJlaW5pdF9jb21wbGV0aW9u
KCZwc3BpbS0+c2xhX2lzcik7DQo+IA0KPiA+ICsgICAgICAgcmVnX3RlbXAgPSBTUDcwMjFfU0xB
X0RNQV9FTiB8IFNQNzAyMV9TTEFfRE1BX1JXIHwNCj4gPiArIEZJRUxEX1BSRVAoU1A3MDIxX1NM
QV9ETUFfQ01ELCAzKTsNCj4gDQo+IERvIHlvdSByZWFsbHkgbmVlZCB0byBoYXZlIHRoaXMgYXNz
aWdubWVudCB1bmRlciB0aGUgbG9jaz8NCj4gRGl0dG8gZm9yIHRoZSByZXN0IG9mIHRoZSBzaW1p
bGFyIGNhc2VzLg0KPiANCj4gPiArICAgICAgIHdyaXRlbF9yZWxheGVkKHJlZ190ZW1wLCBwc3Bp
bS0+c2xhX2Jhc2UgKyBTUDcwMjFfU0xWX0RNQV9DVFJMX1JFRyk7DQo+ID4gKyAgICAgICB3cml0
ZWxfcmVsYXhlZCh4ZmVyLT5sZW4sIHBzcGltLT5zbGFfYmFzZSArIFNQNzAyMV9TTFZfRE1BX0xF
TkdUSF9SRUcpOw0KPiA+ICsgICAgICAgd3JpdGVsX3JlbGF4ZWQoeGZlci0+dHhfZG1hLCBwc3Bp
bS0+c2xhX2Jhc2UgKyBTUDcwMjFfU0xWX0RNQV9BRERSX1JFRyk7DQo+ID4gKyAgICAgICB3cml0
ZWwocmVhZGwocHNwaW0tPnNsYV9iYXNlICsgU1A3MDIxX0RBVEFfUkRZX1JFRykgfCBTUDcwMjFf
U0xBX0RBVEFfUkRZLA0KPiA+ICsgICAgICAgICAgICAgIHBzcGltLT5zbGFfYmFzZSArIFNQNzAy
MV9EQVRBX1JEWV9SRUcpOw0KPiA+ICsgICAgICAgaWYgKHdhaXRfZm9yX2NvbXBsZXRpb25faW50
ZXJydXB0aWJsZSgmcHNwaW0tPmlzcl9kb25lKSkgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZf
ZXJyKCZzcGktPmRldiwgIiVzKCkgd2FpdF9mb3JfY29tcGxldGlvbiBlcnJcbiIsIF9fZnVuY19f
KTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5UUjsNCj4gPiArICAgICAgIH0NCj4g
PiArICAgICAgIG11dGV4X3VubG9jaygmcHNwaW0tPmJ1Zl9sb2NrKTsNCj4gPiArICAgICAgIHJl
dHVybiAwOw0KPiA+ICt9DQo+ID4gK3ZvaWQgc3A3MDIxX3NwaV9tYXNfcmIoc3RydWN0IHNwNzAy
MV9zcGlfY3RsciAqcHNwaW0sIHVuc2lnbmVkIGludA0KPiA+ICtsZW4pIHsNCj4gPiArICAgICAg
IGludCBpOw0KPiA+ICsNCj4gPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBsZW47IGkrKykgew0K
PiA+ICsgICAgICAgICAgICAgICBwc3BpbS0+cnhfYnVmW3BzcGltLT5yeF9jdXJfbGVuXSA9DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVhZGwocHNwaW0tPm1hc19iYXNlICsgU1A3MDIx
X0ZJRk9fUkVHKTsNCj4gPiArICAgICAgICAgICAgICAgcHNwaW0tPnJ4X2N1cl9sZW4rKzsNCj4g
PiArICAgICAgIH0NCj4gPiArfQ0KPiA+ICsNCj4gPiArdm9pZCBzcDcwMjFfc3BpX21hc193Yihz
dHJ1Y3Qgc3A3MDIxX3NwaV9jdGxyICpwc3BpbSwgdW5zaWduZWQgaW50DQo+ID4gK2xlbikgew0K
PiA+ICsgICAgICAgaW50IGk7DQo+ID4gKw0KPiA+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IGxl
bjsgaSsrKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHdyaXRlbChwc3BpbS0+dHhfYnVmW3BzcGlt
LT50eF9jdXJfbGVuXSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgIHBzcGltLT5tYXNfYmFz
ZSArIFNQNzAyMV9GSUZPX1JFRyk7DQo+ID4gKyAgICAgICAgICAgICAgIHBzcGltLT50eF9jdXJf
bGVuKys7DQo+ID4gKyAgICAgICB9DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpcnFyZXR1
cm5fdCBzcDcwMjFfc3BpX21hc19pcnEoaW50IGlycSwgdm9pZCAqZGV2KSB7DQo+ID4gKyAgICAg
ICBzdHJ1Y3Qgc3A3MDIxX3NwaV9jdGxyICpwc3BpbSA9IGRldjsNCj4gPiArICAgICAgIHVuc2ln
bmVkIGludCB0eF9jbnQsIHRvdGFsX2xlbjsNCj4gPiArICAgICAgIHVuc2lnbmVkIGludCB0eF9s
ZW4sIHJ4X2NudDsNCj4gPiArICAgICAgIHVuc2lnbmVkIGludCBmZF9zdGF0dXM7DQo+ID4gKyAg
ICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ICsgICAgICAgYm9vbCBpc3Jkb25lID0gZmFs
c2U7DQo+ID4gKw0KPiA+ICsgICAgICAgZmRfc3RhdHVzID0gcmVhZGwocHNwaW0tPm1hc19iYXNl
ICsgU1A3MDIxX1NQSV9TVEFUVVNfUkVHKTsNCj4gPiArICAgICAgIHR4X2NudCA9IEZJRUxEX0dF
VChTUDcwMjFfVFhfQ05UX01BU0ssIGZkX3N0YXR1cyk7DQo+ID4gKyAgICAgICB0eF9sZW4gPSBG
SUVMRF9HRVQoU1A3MDIxX1RYX0xFTl9NQVNLLCBmZF9zdGF0dXMpOw0KPiA+ICsgICAgICAgdG90
YWxfbGVuID0gRklFTERfR0VUKFNQNzAyMV9HRVRfTEVOX01BU0ssIGZkX3N0YXR1cyk7DQo+ID4g
Kw0KPiA+ICsgICAgICAgaWYgKChmZF9zdGF0dXMgJiBTUDcwMjFfVFhfRU1QX0ZMQUcpICYmIChm
ZF9zdGF0dXMgJiBTUDcwMjFfUlhfRU1QX0ZMQUcpICYmDQo+IHRvdGFsX2xlbiA9PSAwKQ0KPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gSVJRX05PTkU7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYg
KHR4X2xlbiA9PSAwICYmIHRvdGFsX2xlbiA9PSAwKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1
cm4gSVJRX05PTkU7DQo+ID4gKw0KPiA+ICsgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJnBzcGlt
LT5sb2NrLCBmbGFncyk7DQo+ID4gKw0KPiA+ICsgICAgICAgcnhfY250ID0gRklFTERfR0VUKFNQ
NzAyMV9SWF9DTlRfTUFTSywgZmRfc3RhdHVzKTsNCj4gPiArICAgICAgIGlmIChmZF9zdGF0dXMg
JiBTUDcwMjFfUlhfRlVMTF9GTEFHKQ0KPiA+ICsgICAgICAgICAgICAgICByeF9jbnQgPSBwc3Bp
bS0+ZGF0YV91bml0Ow0KPiA+ICsNCj4gPiArICAgICAgIHR4X2NudCA9IG1pbih0eF9sZW4gLSBw
c3BpbS0+dHhfY3VyX2xlbiwgcHNwaW0tPmRhdGFfdW5pdCAtIHR4X2NudCk7DQo+ID4gKyAgICAg
ICBkZXZfZGJnKHBzcGltLT5kZXYsICJmZF9zdD0weCV4IHJ4X2M6JWQgdHhfYzolZCB0eF9sOiVk
IiwNCj4gPiArICAgICAgICAgICAgICAgZmRfc3RhdHVzLCByeF9jbnQsIHR4X2NudCwgdHhfbGVu
KTsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAocnhfY250ID4gMCkNCj4gPiArICAgICAgICAgICAg
ICAgc3A3MDIxX3NwaV9tYXNfcmIocHNwaW0sIHJ4X2NudCk7DQo+ID4gKyAgICAgICBpZiAodHhf
Y250ID4gMCkNCj4gPiArICAgICAgICAgICAgICAgc3A3MDIxX3NwaV9tYXNfd2IocHNwaW0sIHR4
X2NudCk7DQo+ID4gKw0KPiA+ICsgICAgICAgZmRfc3RhdHVzID0gcmVhZGwocHNwaW0tPm1hc19i
YXNlICsgU1A3MDIxX1NQSV9TVEFUVVNfUkVHKTsNCj4gPiArICAgICAgIHR4X2xlbiA9IEZJRUxE
X0dFVChTUDcwMjFfVFhfTEVOX01BU0ssIGZkX3N0YXR1cyk7DQo+ID4gKyAgICAgICB0b3RhbF9s
ZW4gPSBGSUVMRF9HRVQoU1A3MDIxX0dFVF9MRU5fTUFTSywgZmRfc3RhdHVzKTsNCj4gPiArDQo+
ID4gKyAgICAgICBpZiAoZmRfc3RhdHVzICYgU1A3MDIxX0ZJTklTSF9GTEFHIHx8IHR4X2xlbiA9
PSBwc3BpbS0+dHhfY3VyX2xlbikgew0KPiA+ICsgICAgICAgICAgICAgICB3aGlsZSAodG90YWxf
bGVuICE9IHBzcGltLT5yeF9jdXJfbGVuKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ZmRfc3RhdHVzID0gcmVhZGwocHNwaW0tPm1hc19iYXNlICsgU1A3MDIxX1NQSV9TVEFUVVNfUkVH
KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB0b3RhbF9sZW4gPSBGSUVMRF9HRVQoU1A3
MDIxX0dFVF9MRU5fTUFTSywgZmRfc3RhdHVzKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoZmRfc3RhdHVzICYgU1A3MDIxX1JYX0ZVTExfRkxBRykNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJ4X2NudCA9IHBzcGltLT5kYXRhX3VuaXQ7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcnhfY250ID0gRklFTERfR0VUKFNQNzAyMV9SWF9DTlRfTUFTSywNCj4gPiArIGZkX3N0YXR1
cyk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChyeF9jbnQgPiAwKQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3A3MDIxX3NwaV9tYXNfcmIocHNw
aW0sIHJ4X2NudCk7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAg
d3JpdGVsKHJlYWRsKHBzcGltLT5tYXNfYmFzZSArIFNQNzAyMV9JTlRfQlVTWV9SRUcpDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgfCBTUDcwMjFfQ0xSX01BU19JTlQsIHBzcGltLT5tYXNf
YmFzZSArIFNQNzAyMV9JTlRfQlVTWV9SRUcpOw0KPiA+ICsgICAgICAgICAgICAgICB3cml0ZWwo
U1A3MDIxX0ZJTklTSF9GTEFHLCBwc3BpbS0+bWFzX2Jhc2UgKw0KPiA+ICsgU1A3MDIxX1NQSV9T
VEFUVVNfUkVHKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGlzcmRvbmUgPSB0cnVlOw0K
PiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGlmIChpc3Jkb25lKQ0KPiA+ICsgICAg
ICAgICAgICAgICBjb21wbGV0ZSgmcHNwaW0tPmlzcl9kb25lKTsNCj4gPiArICAgICAgIHNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJnBzcGltLT5sb2NrLCBmbGFncyk7DQo+ID4gKyAgICAgICByZXR1
cm4gSVJRX0hBTkRMRUQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHNwNzAyMV9w
cmVwX3RyYW5zZmVyKHN0cnVjdCBzcGlfY29udHJvbGxlciAqY3Rsciwgc3RydWN0DQo+ID4gK3Nw
aV9kZXZpY2UgKnNwaSkgew0KPiA+ICsgICAgICAgc3RydWN0IHNwNzAyMV9zcGlfY3RsciAqcHNw
aW0gPSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKGN0bHIpOw0KPiA+ICsNCj4gPiArICAgICAgIHBz
cGltLT50eF9jdXJfbGVuID0gMDsNCj4gPiArICAgICAgIHBzcGltLT5yeF9jdXJfbGVuID0gMDsN
Cj4gPiArICAgICAgIHBzcGltLT5kYXRhX3VuaXQgPSBTUDcwMjFfRklGT19EQVRBX0JJVFMgLyBz
cGktPmJpdHNfcGVyX3dvcmQ7DQo+ID4gK30NCj4gPiArDQo+ID4gKy8vIHByZWxpbWluYXJ5IHNl
dCBDUywgQ1BPTCwgQ1BIQSBhbmQgTFNCIHN0YXRpYyBpbnQNCj4gPiArc3A3MDIxX3NwaV9jb250
cm9sbGVyX3ByZXBhcmVfbWVzc2FnZShzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBz
cGlfbWVzc2FnZQ0KPiA+ICsqbXNnKSB7DQo+ID4gKyAgICAgICBzdHJ1Y3Qgc3A3MDIxX3NwaV9j
dGxyICpwc3BpbSA9IHNwaV9tYXN0ZXJfZ2V0X2RldmRhdGEoY3Rscik7DQo+ID4gKyAgICAgICBz
dHJ1Y3Qgc3BpX2RldmljZSAqcyA9IG1zZy0+c3BpOw0KPiA+ICsgICAgICAgdTMyIHJzID0gMDsN
Cj4gPiArDQo+ID4gKyAgICAgICB3cml0ZWwocmVhZGwocHNwaW0tPm1hc19iYXNlICsgU1A3MDIx
X1NQSV9TVEFUVVNfUkVHKSB8IFNQNzAyMV9GRF9TV19SU1QsDQo+ID4gKyAgICAgICAgICAgICAg
cHNwaW0tPm1hc19iYXNlICsgU1A3MDIxX1NQSV9TVEFUVVNfUkVHKTsNCj4gPiArICAgICAgIHJz
IHw9IFNQNzAyMV9GRF9TRUw7DQo+ID4gKyAgICAgICBpZiAocy0+bW9kZSAmIFNQSV9DUE9MKQ0K
PiA+ICsgICAgICAgICAgICAgICBycyB8PSBTUDcwMjFfQ1BPTF9GRDsNCj4gPiArDQo+ID4gKyAg
ICAgICBpZiAocy0+bW9kZSAmIFNQSV9MU0JfRklSU1QpDQo+ID4gKyAgICAgICAgICAgICAgIHJz
IHw9IFNQNzAyMV9MU0JfU0VMOw0KPiA+ICsNCj4gPiArICAgICAgIGlmIChzLT5tb2RlICYgU1BJ
X0NTX0hJR0gpDQo+ID4gKyAgICAgICAgICAgICAgIHJzIHw9IFNQNzAyMV9DU19QT1I7DQo+ID4g
Kw0KPiA+ICsgICAgICAgaWYgKHMtPm1vZGUgJiBTUElfQ1BIQSkNCj4gPiArICAgICAgICAgICAg
ICAgcnMgfD0gIFNQNzAyMV9DUEhBX1I7DQo+ID4gKyAgICAgICBlbHNlDQo+ID4gKyAgICAgICAg
ICAgICAgIHJzIHw9ICBTUDcwMjFfQ1BIQV9XOw0KPiA+ICsNCj4gPiArICAgICAgIHJzIHw9ICBG
SUVMRF9QUkVQKFNQNzAyMV9UWF9VTklULCAwKSB8IEZJRUxEX1BSRVAoU1A3MDIxX1JYX1VOSVQs
IDApOw0KPiA+ICsgICAgICAgcHNwaW0tPnhmZXJfY29uZiA9IHJzOw0KPiA+ICsgICAgICAgaWYg
KHBzcGltLT54ZmVyX2NvbmYgJiBTUDcwMjFfQ1BPTF9GRCkNCj4gPiArICAgICAgICAgICAgICAg
d3JpdGVsKHBzcGltLT54ZmVyX2NvbmYsIHBzcGltLT5tYXNfYmFzZSArDQo+ID4gKyBTUDcwMjFf
U1BJX0NPTkZJR19SRUcpOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBzcDcwMjFfc3BpX3NldHVwX2NsayhzdHJ1Y3Qgc3BpX2Nv
bnRyb2xsZXIgKmN0bHIsIHN0cnVjdA0KPiA+ICtzcGlfdHJhbnNmZXIgKnhmZXIpIHsNCj4gPiAr
ICAgICAgIHN0cnVjdCBzcDcwMjFfc3BpX2N0bHIgKnBzcGltID0gc3BpX21hc3Rlcl9nZXRfZGV2
ZGF0YShjdGxyKTsNCj4gPiArICAgICAgIHVuc2lnbmVkIGludCBjbGtfcmF0ZSwgY2xrX3NlbCwg
ZGl2Ow0KPiA+ICsNCj4gPiArICAgICAgIGNsa19yYXRlID0gY2xrX2dldF9yYXRlKHBzcGltLT5z
cGlfY2xrKTsNCj4gPiArICAgICAgIGRpdiA9IGNsa19yYXRlIC8geGZlci0+c3BlZWRfaHo7DQo+
ID4gKyAgICAgICBpZiAoZGl2IDwgMikNCj4gPiArICAgICAgICAgICAgICAgZGl2ID0gMjsNCj4g
PiArICAgICAgIGNsa19zZWwgPSAoZGl2IC8gMikgLSAxOw0KPiA+ICsgICAgICAgcHNwaW0tPnhm
ZXJfY29uZiB8PSAoKGNsa19zZWwgJiAweGZmZmYpIDw8IDE2KTsNCj4gPiArICAgICAgIHdyaXRl
bChwc3BpbS0+eGZlcl9jb25mLCBwc3BpbS0+bWFzX2Jhc2UgKw0KPiA+ICtTUDcwMjFfU1BJX0NP
TkZJR19SRUcpOyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHNwNzAyMV9zcGlfbWFzX3RyYW5z
ZmVyX29uZShzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIsIHN0cnVjdCBzcGlfZGV2aWNlICpz
cGksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNw
aV90cmFuc2ZlciAqeGZlcikgew0KPiA+ICsgICAgICAgc3RydWN0IHNwNzAyMV9zcGlfY3RsciAq
cHNwaW0gPSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKGN0bHIpOw0KPiA+ICsgICAgICAgdW5zaWdu
ZWQgbG9uZyB0aW1lb3V0ID0gbXNlY3NfdG9famlmZmllcygxMDAwKTsNCj4gPiArICAgICAgIHVu
c2lnbmVkIGludCB4ZmVyX2NudCwgeGZlcl9sZW4sIGxhc3RfbGVuOw0KPiA+ICsgICAgICAgdW5z
aWduZWQgaW50IGksIGxlbl90ZW1wOw0KPiA+ICsgICAgICAgdTMyIHJlZ190ZW1wOw0KPiA+ICsg
ICAgICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAgICAgICB4ZmVyX2NudCA9IHhmZXItPmxlbiAv
IFNQNzAyMV9TUElfREFUQV9TSVpFOw0KPiA+ICsgICAgICAgbGFzdF9sZW4gPSB4ZmVyLT5sZW4g
JSBTUDcwMjFfU1BJX0RBVEFfU0laRTsNCj4gPiArDQo+ID4gKyAgICAgICBmb3IgKGkgPSAwOyBp
IDw9IHhmZXJfY250OyBpKyspIHsNCj4gPiArICAgICAgICAgICAgICAgbXV0ZXhfbG9jaygmcHNw
aW0tPmJ1Zl9sb2NrKTsNCj4gPiArICAgICAgICAgICAgICAgc3A3MDIxX3ByZXBfdHJhbnNmZXIo
Y3Rsciwgc3BpKTsNCj4gPiArICAgICAgICAgICAgICAgc3A3MDIxX3NwaV9zZXR1cF9jbGsoY3Rs
ciwgeGZlcik7DQo+ID4gKyAgICAgICAgICAgICAgIHJlaW5pdF9jb21wbGV0aW9uKCZwc3BpbS0+
aXNyX2RvbmUpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgaWYgKGkgPT0geGZlcl9jbnQp
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgeGZlcl9sZW4gPSBsYXN0X2xlbjsNCj4gPiAr
ICAgICAgICAgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHhmZXJfbGVu
ID0gU1A3MDIxX1NQSV9EQVRBX1NJWkU7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBwc3Bp
bS0+dHhfYnVmID0geGZlci0+dHhfYnVmICsgaSAqIFNQNzAyMV9TUElfREFUQV9TSVpFOw0KPiA+
ICsgICAgICAgICAgICAgICBwc3BpbS0+cnhfYnVmID0geGZlci0+cnhfYnVmICsgaSAqDQo+ID4g
KyBTUDcwMjFfU1BJX0RBVEFfU0laRTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGlmIChw
c3BpbS0+dHhfY3VyX2xlbiA8IHhmZXJfbGVuKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgbGVuX3RlbXAgPSBtaW4ocHNwaW0tPmRhdGFfdW5pdCwgeGZlcl9sZW4pOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHNwNzAyMV9zcGlfbWFzX3diKHBzcGltLCBsZW5fdGVtcCk7DQo+
ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgcmVnX3RlbXAgPSByZWFk
bChwc3BpbS0+bWFzX2Jhc2UgKyBTUDcwMjFfU1BJX0NPTkZJR19SRUcpOw0KPiA+ICsgICAgICAg
ICAgICAgICByZWdfdGVtcCAmPSB+U1A3MDIxX0NMRUFOX1JXX0JZVEU7DQo+ID4gKyAgICAgICAg
ICAgICAgIHJlZ190ZW1wICY9IH5TUDcwMjFfQ0xFQU5fRkxVR19NQVNLOw0KPiA+ICsgICAgICAg
ICAgICAgICByZWdfdGVtcCB8PSBTUDcwMjFfRkRfU0VMIHwgU1A3MDIxX0ZJTklTSF9GTEFHX01B
U0sgfA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBTUDcwMjFfVFhfRU1QX0ZMQUdf
TUFTSyB8IFNQNzAyMV9SWF9GVUxMX0ZMQUdfTUFTSyB8DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEZJRUxEX1BSRVAoU1A3MDIxX1RYX1VOSVQsIDApIHwgRklFTERfUFJFUChTUDcw
MjFfUlhfVU5JVCwNCj4gMCk7DQo+ID4gKyAgICAgICAgICAgICAgIHdyaXRlbChyZWdfdGVtcCwg
cHNwaW0tPm1hc19iYXNlICsNCj4gPiArIFNQNzAyMV9TUElfQ09ORklHX1JFRyk7DQo+ID4gKw0K
PiA+ICsgICAgICAgICAgICAgICByZWdfdGVtcCA9IEZJRUxEX1BSRVAoU1A3MDIxX1NFVF9UWF9M
RU4sIHhmZXJfbGVuKSB8DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBGSUVMRF9QUkVQKFNQNzAyMV9TRVRfWEZFUl9MRU4sIHhmZXJfbGVuKSB8DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUDcwMjFfU1BJX1NUQVJUX0ZEOw0KPiA+
ICsgICAgICAgICAgICAgICB3cml0ZWwocmVnX3RlbXAsIHBzcGltLT5tYXNfYmFzZSArDQo+ID4g
KyBTUDcwMjFfU1BJX1NUQVRVU19SRUcpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgaWYg
KCF3YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVycnVwdGlibGVfdGltZW91dCgmcHNwaW0tPmlzcl9k
b25lLCB0aW1lb3V0KSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnNw
aS0+ZGV2LCAid2FpdF9mb3JfY29tcGxldGlvbiBlcnJcbiIpOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiAtRVRJTUVET1VUOw0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgICAgICAgICAgICByZWdfdGVtcCA9IHJlYWRsKHBzcGltLT5tYXNfYmFzZSAr
IFNQNzAyMV9TUElfU1RBVFVTX1JFRyk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChyZWdfdGVt
cCAmIFNQNzAyMV9GSU5JU0hfRkxBRykgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHdy
aXRlbChTUDcwMjFfRklOSVNIX0ZMQUcsIHBzcGltLT5tYXNfYmFzZSArDQo+IFNQNzAyMV9TUElf
U1RBVFVTX1JFRyk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgd3JpdGVsKHJlYWRsKHBz
cGltLT5tYXNfYmFzZSArIFNQNzAyMV9TUElfQ09ORklHX1JFRykgJg0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgU1A3MDIxX0NMRUFOX0ZMVUdfTUFTSywgcHNwaW0tPm1hc19i
YXNlICsNCj4gU1A3MDIxX1NQSV9DT05GSUdfUkVHKTsNCj4gPiArICAgICAgICAgICAgICAgfQ0K
PiA+ICsNCj4gPiArICAgICAgICAgICAgICAgcmV0ID0gMDsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICAgIGlmIChwc3BpbS0+eGZlcl9jb25mICYgU1A3MDIxX0NQT0xfRkQpDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgd3JpdGVsKHBzcGltLT54ZmVyX2NvbmYsIHBzcGltLT5tYXNfYmFz
ZSArDQo+ID4gKyBTUDcwMjFfU1BJX0NPTkZJR19SRUcpOw0KPiA+ICsNCj4gPiArICAgICAgICAg
ICAgICAgbXV0ZXhfdW5sb2NrKCZwc3BpbS0+YnVmX2xvY2spOw0KPiA+ICsgICAgICAgfQ0KPiA+
ICsgICAgICAgcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBzcDcw
MjFfc3BpX3NsYV90cmFuc2Zlcl9vbmUoc3RydWN0IHNwaV9jb250cm9sbGVyICpjdGxyLCBzdHJ1
Y3Qgc3BpX2RldmljZSAqc3BpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBzcGlfdHJhbnNmZXIgKnhmZXIpIHsNCj4gPiArICAgICAgIHN0cnVjdCBz
cDcwMjFfc3BpX2N0bHIgKnBzcGltID0gc3BpX21hc3Rlcl9nZXRfZGV2ZGF0YShjdGxyKTsNCj4g
PiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IHBzcGltLT5kZXY7DQo+ID4gKyAgICAgICBp
bnQgbW9kZSwgcmV0ID0gMDsNCj4gPiArDQo+ID4gKyAgICAgICBtb2RlID0gU1A3MDIxX1NQSV9J
RExFOw0KPiA+ICsgICAgICAgaWYgKHNwaV9jb250cm9sbGVyX2lzX3NsYXZlKGN0bHIpKSB7DQo+
ID4gKyAgICAgICAgICAgICAgIGlmICh4ZmVyLT50eF9idWYgJiYgeGZlci0+cnhfYnVmKSB7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2X2RiZygmY3Rsci0+ZGV2LCAiJXMoKSB3cm9u
ZyBjb21tYW5kXG4iLCBfX2Z1bmNfXyk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gLUVJTlZBTDsNCj4gPiArICAgICAgICAgICAgICAgfSBlbHNlIGlmICh4ZmVyLT50eF9idWYp
IHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB4ZmVyLT50eF9kbWEgPSBkbWFfbWFwX3Np
bmdsZShkZXYsICh2b2lkICopeGZlci0+dHhfYnVmLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHhmZXItPmxlbiwgRE1BX1RPX0RFVklD
RSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGRtYV9tYXBwaW5nX2Vycm9yKGRl
diwgeGZlci0+dHhfZG1hKSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAtRU5PTUVNOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIG1vZGUgPSBTUDcwMjFf
U0xBX1dSSVRFOw0KPiA+ICsgICAgICAgICAgICAgICB9IGVsc2UgaWYgKHhmZXItPnJ4X2J1Zikg
ew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHhmZXItPnJ4X2RtYSA9IGRtYV9tYXBfc2lu
Z2xlKGRldiwgeGZlci0+cnhfYnVmLCB4ZmVyLT5sZW4sDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRE1BX0ZST01fREVWSUNFKTsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoZG1hX21hcHBpbmdfZXJyb3IoZGV2LCB4ZmVy
LT5yeF9kbWEpKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
Tk9NRU07DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbW9kZSA9IFNQNzAyMV9TTEFfUkVB
RDsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgc3dp
dGNoIChtb2RlKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGNhc2UgU1A3MDIxX1NMQV9XUklURToN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzcDcwMjFfc3BpX3NsYV90eChzcGksIHhmZXIp
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgICAgICAg
ICBjYXNlIFNQNzAyMV9TTEFfUkVBRDoNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzcDcw
MjFfc3BpX3NsYV9yeChzcGksIHhmZXIpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJy
ZWFrOw0KPiA+ICsgICAgICAgICAgICAgICBkZWZhdWx0Og0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgICAgICBpZiAoeGZlci0+dHhfYnVmKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRt
YV91bm1hcF9zaW5nbGUoZGV2LCB4ZmVyLT50eF9kbWEsIHhmZXItPmxlbiwgRE1BX1RPX0RFVklD
RSk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmICh4ZmVyLT5yeF9idWYpDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgZG1hX3VubWFwX3NpbmdsZShkZXYsIHhmZXItPnJ4X2RtYSwgeGZlci0+
bGVuLCBETUFfRlJPTV9ERVZJQ0UpOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAg
IHNwaV9maW5hbGl6ZV9jdXJyZW50X3RyYW5zZmVyKGN0bHIpOw0KPiA+ICsgICAgICAgcmV0dXJu
IHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgc3A3MDIxX3NwaV9kaXNhYmxl
X3VucHJlcGFyZSh2b2lkICpkYXRhKSB7DQo+ID4gKyAgICAgICBjbGtfZGlzYWJsZV91bnByZXBh
cmUoZGF0YSk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHNwNzAyMV9zcGlfcmVz
ZXRfY29udHJvbF9hc3NlcnQodm9pZCAqZGF0YSkgew0KPiA+ICsgICAgICAgcmVzZXRfY29udHJv
bF9hc3NlcnQoZGF0YSk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgc3A3MDIxX3Nw
aV9jb250cm9sbGVyX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gK3sN
Cj4gPiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKyAgICAg
ICBzdHJ1Y3Qgc3A3MDIxX3NwaV9jdGxyICpwc3BpbTsNCj4gPiArICAgICAgIHN0cnVjdCBzcGlf
Y29udHJvbGxlciAqY3RscjsNCj4gPiArICAgICAgIGludCBtb2RlLCByZXQ7DQo+ID4gKw0KPiA+
ICsgICAgICAgbW9kZSA9IFNQNzAyMV9NQVNURVJfTU9ERTsNCj4gPiArICAgICAgIHBkZXYtPmlk
ID0gb2ZfYWxpYXNfZ2V0X2lkKHBkZXYtPmRldi5vZl9ub2RlLCAic3Bfc3BpIik7DQo+ID4gKw0K
PiA+ICsgICAgICAgaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChwZGV2LT5kZXYub2Zfbm9kZSwg
InNwaS1zbGF2ZSIpKQ0KPiA+ICsgICAgICAgICAgICAgICBtb2RlID0gU1A3MDIxX1NMQVZFX01P
REU7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKG1vZGUgPT0gU1A3MDIxX1NMQVZFX01PREUpDQo+
ID4gKyAgICAgICAgICAgICAgIGN0bHIgPSBkZXZtX3NwaV9hbGxvY19zbGF2ZShkZXYsIHNpemVv
ZigqcHNwaW0pKTsNCj4gPiArICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgY3RsciA9
IGRldm1fc3BpX2FsbG9jX21hc3RlcihkZXYsIHNpemVvZigqcHNwaW0pKTsNCj4gPiArICAgICAg
IGlmICghY3RscikNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gKyAg
ICAgICBkZXZpY2Vfc2V0X25vZGUoJmN0bHItPmRldiwgcGRldi0+ZGV2LmZ3bm9kZSk7DQo+ID4g
KyAgICAgICBjdGxyLT5idXNfbnVtID0gcGRldi0+aWQ7DQo+ID4gKyAgICAgICBjdGxyLT5tb2Rl
X2JpdHMgPSBTUElfQ1BPTCB8IFNQSV9DUEhBIHwgU1BJX0NTX0hJR0ggfCBTUElfTFNCX0ZJUlNU
Ow0KPiA+ICsgICAgICAgY3Rsci0+YXV0b19ydW50aW1lX3BtID0gdHJ1ZTsNCj4gPiArICAgICAg
IGN0bHItPnByZXBhcmVfbWVzc2FnZSA9IHNwNzAyMV9zcGlfY29udHJvbGxlcl9wcmVwYXJlX21l
c3NhZ2U7DQo+ID4gKyAgICAgICBpZiAobW9kZSA9PSBTUDcwMjFfU0xBVkVfTU9ERSkgew0KPiA+
ICsgICAgICAgICAgICAgICBjdGxyLT50cmFuc2Zlcl9vbmUgPSBzcDcwMjFfc3BpX3NsYV90cmFu
c2Zlcl9vbmU7DQo+ID4gKyAgICAgICAgICAgICAgIGN0bHItPnNsYXZlX2Fib3J0ID0gc3A3MDIx
X3NwaV9zbGFfYWJvcnQ7DQo+ID4gKyAgICAgICAgICAgICAgIGN0bHItPmZsYWdzID0gU1BJX0NP
TlRST0xMRVJfSEFMRl9EVVBMRVg7DQo+ID4gKyAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAg
ICAgICAgICBjdGxyLT5iaXRzX3Blcl93b3JkX21hc2sgPSBTUElfQlBXX01BU0soOCk7DQo+ID4g
KyAgICAgICAgICAgICAgIGN0bHItPm1pbl9zcGVlZF9oeiA9IDQwMDAwOw0KPiA+ICsgICAgICAg
ICAgICAgICBjdGxyLT5tYXhfc3BlZWRfaHogPSAyNTAwMDAwMDsNCj4gPiArICAgICAgICAgICAg
ICAgY3Rsci0+dXNlX2dwaW9fZGVzY3JpcHRvcnMgPSB0cnVlOw0KPiA+ICsgICAgICAgICAgICAg
ICBjdGxyLT5mbGFncyA9IFNQSV9DT05UUk9MTEVSX01VU1RfUlggfCBTUElfQ09OVFJPTExFUl9N
VVNUX1RYOw0KPiA+ICsgICAgICAgICAgICAgICBjdGxyLT50cmFuc2Zlcl9vbmUgPSBzcDcwMjFf
c3BpX21hc190cmFuc2Zlcl9vbmU7DQo+ID4gKyAgICAgICB9DQo+ID4gKyAgICAgICBwbGF0Zm9y
bV9zZXRfZHJ2ZGF0YShwZGV2LCBjdGxyKTsNCj4gPiArICAgICAgIHBzcGltID0gc3BpX2NvbnRy
b2xsZXJfZ2V0X2RldmRhdGEoY3Rscik7DQo+ID4gKyAgICAgICBwc3BpbS0+Y3RsciA9IGN0bHI7
DQo+ID4gKyAgICAgICBwc3BpbS0+ZGV2ID0gZGV2Ow0KPiA+ICsgICAgICAgc3Bpbl9sb2NrX2lu
aXQoJnBzcGltLT5sb2NrKTsNCj4gPiArICAgICAgIG11dGV4X2luaXQoJnBzcGltLT5idWZfbG9j
ayk7DQo+ID4gKyAgICAgICBpbml0X2NvbXBsZXRpb24oJnBzcGltLT5pc3JfZG9uZSk7DQo+ID4g
KyAgICAgICBpbml0X2NvbXBsZXRpb24oJnBzcGltLT5zbGFfaXNyKTsNCj4gPiArDQo+ID4gKyAg
ICAgICBwc3BpbS0+bWFzX2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnlu
YW1lKHBkZXYsICJtYXN0ZXIiKTsNCj4gPiArICAgICAgIGlmIChJU19FUlIocHNwaW0tPm1hc19i
YXNlKSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJf
RVJSKHBzcGltLT5tYXNfYmFzZSksDQo+ID4gKyAibWFzX2Jhc2UgZ2V0IGZhaWxcbiIpOw0KPiA+
ICsNCj4gPiArICAgICAgIHBzcGltLT5zbGFfYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9y
ZXNvdXJjZV9ieW5hbWUocGRldiwgInNsYXZlIik7DQo+ID4gKyAgICAgICBpZiAoSVNfRVJSKHBz
cGltLT5zbGFfYmFzZSkpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2Jl
KGRldiwgUFRSX0VSUihwc3BpbS0+c2xhX2Jhc2UpLA0KPiA+ICsgInNsYV9iYXNlIGdldCBmYWls
XG4iKTsNCj4gPiArDQo+ID4gKyAgICAgICBwc3BpbS0+bWFzX2lycSA9IHBsYXRmb3JtX2dldF9p
cnFfYnluYW1lKHBkZXYsICJtYXNfcmlzYyIpOw0KPiA+ICsgICAgICAgaWYgKHBzcGltLT5tYXNf
aXJxIDwgMCkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHBzcGltLT5tYXNfaXJxOw0KPiA+
ICsNCj4gPiArICAgICAgIHBzcGltLT5zbGFfaXJxID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUo
cGRldiwgInNsYXZlX3Jpc2MiKTsNCj4gPiArICAgICAgIGlmIChwc3BpbS0+c2xhX2lycSA8IDAp
DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBwc3BpbS0+c2xhX2lycTsNCj4gPiArDQo+ID4g
KyAgICAgICByZXQgPSBkZXZtX3JlcXVlc3RfaXJxKGRldiwgcHNwaW0tPm1hc19pcnEsIHNwNzAy
MV9zcGlfbWFzX2lycSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSVJRRl9U
UklHR0VSX1JJU0lORywgcGRldi0+bmFtZSwgcHNwaW0pOw0KPiA+ICsgICAgICAgaWYgKHJldCkN
Cj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKyAgICAgICByZXQg
PSBkZXZtX3JlcXVlc3RfaXJxKGRldiwgcHNwaW0tPnNsYV9pcnEsIHNwNzAyMV9zcGlfc2xhX2ly
cSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSVJRRl9UUklHR0VSX1JJU0lO
RywgcGRldi0+bmFtZSwgcHNwaW0pOw0KPiA+ICsgICAgICAgaWYgKHJldCkNCj4gPiArICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKyAgICAgICBwc3BpbS0+c3BpX2NsayA9
IGRldm1fY2xrX2dldChkZXYsIE5VTEwpOw0KPiA+ICsgICAgICAgaWYgKElTX0VSUihwc3BpbS0+
c3BpX2NsaykpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwg
UFRSX0VSUihwc3BpbS0+c3BpX2NsayksDQo+ID4gKyAiY2xrIGdldCBmYWlsXG4iKTsNCj4gPiAr
DQo+ID4gKyAgICAgICBwc3BpbS0+cnN0YyA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfZXhjbHVz
aXZlKGRldiwgTlVMTCk7DQo+ID4gKyAgICAgICBpZiAoSVNfRVJSKHBzcGltLT5yc3RjKSkNCj4g
PiArICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKHBzcGlt
LT5yc3RjKSwgInJzdA0KPiA+ICsgZ2V0IGZhaWxcbiIpOw0KPiA+ICsNCj4gPiArICAgICAgIHJl
dCA9IGNsa19wcmVwYXJlX2VuYWJsZShwc3BpbS0+c3BpX2Nsayk7DQo+ID4gKyAgICAgICBpZiAo
cmV0KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwg
ImZhaWxlZCB0byBlbmFibGUNCj4gPiArIGNsa1xuIik7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0
ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KGRldiwgc3A3MDIxX3NwaV9kaXNhYmxlX3VucHJl
cGFyZSwgcHNwaW0tPnNwaV9jbGspOw0KPiA+ICsgICAgICAgaWYgKHJldCkNCj4gPiArICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKyAgICAgICByZXQgPSByZXNldF9jb250
cm9sX2RlYXNzZXJ0KHBzcGltLT5yc3RjKTsNCj4gPiArICAgICAgIGlmIChyZXQpDQo+ID4gKyAg
ICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIGRl
YXNzZXJ0DQo+ID4gKyByZXNldFxuIik7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0ID0gZGV2bV9h
ZGRfYWN0aW9uX29yX3Jlc2V0KGRldiwgc3A3MDIxX3NwaV9yZXNldF9jb250cm9sX2Fzc2VydCwg
cHNwaW0tPnJzdGMpOw0KPiA+ICsgICAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKyAgICAgICBwbV9ydW50aW1lX2VuYWJsZShkZXYpOw0K
PiA+ICsgICAgICAgcmV0ID0gc3BpX3JlZ2lzdGVyX2NvbnRyb2xsZXIoY3Rscik7DQo+ID4gKyAg
ICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICAgIHBtX3J1bnRpbWVfZGlzYWJsZShk
ZXYpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwg
InNwaV9yZWdpc3Rlcl9tYXN0ZXIgZmFpbFxuIik7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+
ICsgICAgICAgcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBzcDcw
MjFfc3BpX2NvbnRyb2xsZXJfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBzcGlfY29udHJvbGxlciAqY3RsciA9IGRldl9nZXRf
ZHJ2ZGF0YSgmcGRldi0+ZGV2KTsNCj4gPiArDQo+ID4gKyAgICAgICBzcGlfdW5yZWdpc3Rlcl9j
b250cm9sbGVyKGN0bHIpOw0KPiA+ICsgICAgICAgcG1fcnVudGltZV9kaXNhYmxlKCZwZGV2LT5k
ZXYpOw0KPiA+ICsgICAgICAgcG1fcnVudGltZV9zZXRfc3VzcGVuZGVkKCZwZGV2LT5kZXYpOw0K
PiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMg
aW50IF9fbWF5YmVfdW51c2VkIHNwNzAyMV9zcGlfY29udHJvbGxlcl9zdXNwZW5kKHN0cnVjdCBk
ZXZpY2UNCj4gPiArKmRldikgew0KPiA+ICsgICAgICAgc3RydWN0IHNwaV9jb250cm9sbGVyICpj
dGxyID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKyAgICAgICBzdHJ1Y3Qgc3A3MDIxX3Nw
aV9jdGxyICpwc3BpbSA9IHNwaV9tYXN0ZXJfZ2V0X2RldmRhdGEoY3Rscik7DQo+ID4gKw0KPiA+
ICsgICAgICAgcmV0dXJuIHJlc2V0X2NvbnRyb2xfYXNzZXJ0KHBzcGltLT5yc3RjKTsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBfX21heWJlX3VudXNlZCBzcDcwMjFfc3BpX2NvbnRy
b2xsZXJfcmVzdW1lKHN0cnVjdCBkZXZpY2UNCj4gPiArKmRldikgew0KPiA+ICsgICAgICAgc3Ry
dWN0IHNwaV9jb250cm9sbGVyICpjdGxyID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKyAg
ICAgICBzdHJ1Y3Qgc3A3MDIxX3NwaV9jdGxyICpwc3BpbSA9IHNwaV9tYXN0ZXJfZ2V0X2RldmRh
dGEoY3Rscik7DQo+ID4gKw0KPiA+ICsgICAgICAgcmVzZXRfY29udHJvbF9kZWFzc2VydChwc3Bp
bS0+cnN0Yyk7DQo+ID4gKyAgICAgICByZXR1cm4gY2xrX3ByZXBhcmVfZW5hYmxlKHBzcGltLT5z
cGlfY2xrKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBzcDcwMjFfc3BpX3J1bnRp
bWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4gPiArICAgICAgIHN0cnVjdCBzcGlf
Y29udHJvbGxlciAqY3RsciA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsgICAgICAgc3Ry
dWN0IHNwNzAyMV9zcGlfY3RsciAqcHNwaW0gPSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKGN0bHIp
Ow0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiByZXNldF9jb250cm9sX2Fzc2VydChwc3BpbS0+
cnN0Yyk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgc3A3MDIxX3NwaV9ydW50aW1l
X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4gPiArICAgICAgIHN0cnVjdCBzcGlfY29u
dHJvbGxlciAqY3RsciA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsgICAgICAgc3RydWN0
IHNwNzAyMV9zcGlfY3RsciAqcHNwaW0gPSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKGN0bHIpOw0K
PiA+ICsNCj4gPiArICAgICAgIHJldHVybiByZXNldF9jb250cm9sX2RlYXNzZXJ0KHBzcGltLT5y
c3RjKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3Bz
IHNwNzAyMV9zcGlfcG1fb3BzID0gew0KPiA+ICsgICAgICAgU0VUX1JVTlRJTUVfUE1fT1BTKHNw
NzAyMV9zcGlfcnVudGltZV9zdXNwZW5kLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
IHNwNzAyMV9zcGlfcnVudGltZV9yZXN1bWUsIE5VTEwpDQo+ID4gKyAgICAgICBTRVRfU1lTVEVN
X1NMRUVQX1BNX09QUyhzcDcwMjFfc3BpX2NvbnRyb2xsZXJfc3VzcGVuZCwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNwNzAyMV9zcGlfY29udHJvbGxlcl9yZXN1bWUpIH07
DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBzcDcwMjFfc3Bp
X2NvbnRyb2xsZXJfaWRzW10gPSB7DQo+ID4gKyAgICAgICB7IC5jb21wYXRpYmxlID0gInN1bnBs
dXMsc3A3MDIxLXNwaSIgfSwNCj4gPiArICAgICAgIHt9DQo+ID4gK307DQo+ID4gK01PRFVMRV9E
RVZJQ0VfVEFCTEUob2YsIHNwNzAyMV9zcGlfY29udHJvbGxlcl9pZHMpOw0KPiA+ICsNCj4gPiAr
c3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgc3A3MDIxX3NwaV9jb250cm9sbGVyX2RyaXZl
ciA9IHsNCj4gPiArICAgICAgIC5wcm9iZSA9IHNwNzAyMV9zcGlfY29udHJvbGxlcl9wcm9iZSwN
Cj4gPiArICAgICAgIC5yZW1vdmUgPSBzcDcwMjFfc3BpX2NvbnRyb2xsZXJfcmVtb3ZlLA0KPiA+
ICsgICAgICAgLmRyaXZlciA9IHsNCj4gPiArICAgICAgICAgICAgICAgLm5hbWUgPSAic3VucGx1
cyxzcDcwMjEtc3BpLWNvbnRyb2xsZXIiLA0KPiA+ICsgICAgICAgICAgICAgICAub2ZfbWF0Y2hf
dGFibGUgPSBzcDcwMjFfc3BpX2NvbnRyb2xsZXJfaWRzLA0KPiA+ICsgICAgICAgICAgICAgICAu
cG0gICAgID0gJnNwNzAyMV9zcGlfcG1fb3BzLA0KPiA+ICsgICAgICAgfSwNCj4gPiArfTsNCj4g
PiArbW9kdWxlX3BsYXRmb3JtX2RyaXZlcihzcDcwMjFfc3BpX2NvbnRyb2xsZXJfZHJpdmVyKTsN
Cj4gPiArDQo+ID4gK01PRFVMRV9BVVRIT1IoIkxpLWhhbyBLdW8gPGxoamVmZjkxMUBnbWFpbC5j
b20+Iik7DQo+ID4gK01PRFVMRV9ERVNDUklQVElPTigiU3VucGx1cyBTUEkgY29udHJvbGxlciBk
cml2ZXIiKTsNCj4gPiArTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOw0KPiA+IC0tDQo+ID4gMi43
LjQNCj4gPg0KPiANCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZj
aGVua28NCg==
