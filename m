Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E102279FAE
	for <lists+linux-spi@lfdr.de>; Sun, 27 Sep 2020 10:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgI0Iab (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 27 Sep 2020 04:30:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32913 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730450AbgI0Iab (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 27 Sep 2020 04:30:31 -0400
X-UUID: 44b997db2ba1471d8bc2dc62961eaed7-20200927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Lner+8cIRgrg0cDNcBnnCq0acUspa7hUGg30bAeP/UE=;
        b=pFD6Tgrfv5dopQXE62tIo5gn5ppuG6Rtmvj8zQD6GN2h25xzqH8nFvBMU6jwm4rffVhfJq4sWKt6yHmYEq3ZkGplUmLFNh/6rGVgB6GsYLNI2TQbIwy8nLXuqgMHAWLZdCSkirI35c2cQM6Tb2MnMoNoQLyamtDXPnTWvTtUigs=;
X-UUID: 44b997db2ba1471d8bc2dc62961eaed7-20200927
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1572921222; Sun, 27 Sep 2020 16:30:26 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 27 Sep 2020 16:30:24 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 27 Sep 2020 16:30:23 +0800
Message-ID: <1601195424.7766.4.camel@mtksdaap41>
Subject: Re: [PATCH v3 5/6] spi: spi-mtk-nor: support 36bit dma addressing
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Sun, 27 Sep 2020 16:30:24 +0800
In-Reply-To: <20200925145255.v3.5.Id1cb208392928afc7ceed4de06924243c7858cd0@changeid>
References: <20200925065418.1077472-1-ikjn@chromium.org>
         <20200925145255.v3.5.Id1cb208392928afc7ceed4de06924243c7858cd0@changeid>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTI1IGF0IDE0OjU0ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
VGhpcyBwYXRjaCBlbmFibGVzIDM2Yml0IGRtYSBhZGRyZXNzIHN1cHBvcnQgdG8gc3BpLW10ay1u
b3IuDQo+IEN1cnJlbnRseSB0aGlzIGlzIGVuYWJsZWQgb25seSBmb3IgbXQ4MTkyLW5vci4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IElram9vbiBKYW5nIDxpa2puQGNocm9taXVtLm9yZz4NCj4gLS0t
DQo+IA0KPiAobm8gY2hhbmdlcyBzaW5jZSB2MSkNCj4gDQo+ICBkcml2ZXJzL3NwaS9zcGktbXRr
LW5vci5jIHwgMTggKysrKysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3Bp
L3NwaS1tdGstbm9yLmMgYi9kcml2ZXJzL3NwaS9zcGktbXRrLW5vci5jDQo+IGluZGV4IDhkYmFm
ZWU3ZjQzMS4uMzUyMDU2MzVlZDQyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktbXRr
LW5vci5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1tdGstbm9yLmMNCj4gQEAgLTc4LDYgKzc4
LDggQEANCj4gICNkZWZpbmUgTVRLX05PUl9SRUdfRE1BX0ZBRFIJCTB4NzFjDQo+ICAjZGVmaW5l
IE1US19OT1JfUkVHX0RNQV9EQURSCQkweDcyMA0KPiAgI2RlZmluZSBNVEtfTk9SX1JFR19ETUFf
RU5EX0RBRFIJMHg3MjQNCj4gKyNkZWZpbmUgTVRLX05PUl9SRUdfRE1BX0RBRFJfSEIJCTB4NzM4
DQo+ICsjZGVmaW5lIE1US19OT1JfUkVHX0RNQV9FTkRfREFEUl9IQgkweDczYw0KPiAgDQo+ICAv
KiBtYXhpbXVtIGJ5dGVzIG9mIFRYIGluIFBSRyBtb2RlICovDQo+ICAjZGVmaW5lIE1US19OT1Jf
UFJHX01BWF9TSVpFCQk2DQo+IEBAIC0xMDYsNiArMTA4LDcgQEAgc3RydWN0IG10a19ub3Igew0K
PiAgCXVuc2lnbmVkIGludCBzcGlfZnJlcTsNCj4gIAlib29sIHdidWZfZW47DQo+ICAJYm9vbCBo
YXNfaXJxOw0KPiArCWJvb2wgaGlnaF9kbWE7DQo+ICAJc3RydWN0IGNvbXBsZXRpb24gb3BfZG9u
ZTsNCj4gIH07DQo+ICANCj4gQEAgLTMwNSw2ICszMDgsMTEgQEAgc3RhdGljIGludCBtdGtfbm9y
X2RtYV9leGVjKHN0cnVjdCBtdGtfbm9yICpzcCwgdTMyIGZyb20sIHVuc2lnbmVkIGludCBsZW5n
dGgsDQo+ICAJd3JpdGVsKGRtYV9hZGRyLCBzcC0+YmFzZSArIE1US19OT1JfUkVHX0RNQV9EQURS
KTsNCj4gIAl3cml0ZWwoZG1hX2FkZHIgKyBsZW5ndGgsIHNwLT5iYXNlICsgTVRLX05PUl9SRUdf
RE1BX0VORF9EQURSKTsNCj4gIA0KPiArCWlmIChzcC0+aGlnaF9kbWEpIHsNCj4gKwkJd3JpdGVs
KGRtYV9hZGRyID4+IDMyLCBzcC0+YmFzZSArIE1US19OT1JfUkVHX0RNQV9EQURSX0hCKTsNCj4g
KwkJd3JpdGVsKChkbWFfYWRkciArIGxlbmd0aCkgPj4gMzIsIHNwLT5iYXNlICsgTVRLX05PUl9S
RUdfRE1BX0VORF9EQURSX0hCKTsNCj4gKwl9DQo+ICsNCg0KTWF5YmUgdXNlIHVwcGVyXzMyX2Jp
dHMoKSA/DQoNCg0KPiAgCWlmIChzcC0+aGFzX2lycSkgew0KPiAgCQlyZWluaXRfY29tcGxldGlv
bigmc3AtPm9wX2RvbmUpOw0KPiAgCQltdGtfbm9yX3JtdyhzcCwgTVRLX05PUl9SRUdfSVJRX0VO
LCBNVEtfTk9SX0lSUV9ETUEsIDApOw0KPiBAQCAtNjM1LDcgKzY0Myw4IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXJfbWVtX29wcyBtdGtfbm9yX21lbV9vcHMgPSB7DQo+ICB9
Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfbm9yX21hdGNo
W10gPSB7DQo+IC0JeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtbm9yIiB9LA0KPiAr
CXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLW5vciIsIC5kYXRhID0gKHZvaWQgKikz
NiB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLW5vciIsIC5kYXRhID0g
KHZvaWQgKikzMiB9LA0KPiAgCXsgLyogc2VudGluZWwgKi8gfQ0KPiAgfTsNCj4gIE1PRFVMRV9E
RVZJQ0VfVEFCTEUob2YsIG10a19ub3JfbWF0Y2gpOw0KPiBAQCAtNjQ3LDYgKzY1Niw3IEBAIHN0
YXRpYyBpbnQgbXRrX25vcl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
CXZvaWQgX19pb21lbSAqYmFzZTsNCj4gIAlzdHJ1Y3QgY2xrICpzcGlfY2xrLCAqY3Rscl9jbGs7
DQo+ICAJaW50IHJldCwgaXJxOw0KPiArCXVuc2lnbmVkIGxvbmcgZG1hX2JpdHM7DQo+ICANCj4g
IAliYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiAgCWlm
IChJU19FUlIoYmFzZSkpDQo+IEBAIC02NjAsNiArNjcwLDEyIEBAIHN0YXRpYyBpbnQgbXRrX25v
cl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCWlmIChJU19FUlIoY3Rs
cl9jbGspKQ0KPiAgCQlyZXR1cm4gUFRSX0VSUihjdGxyX2Nsayk7DQo+ICANCj4gKwlkbWFfYml0
cyA9ICh1bnNpZ25lZCBsb25nKW9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsN
Cj4gKwlpZiAoZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgmcGRldi0+ZGV2LCBETUFfQklUX01B
U0soZG1hX2JpdHMpKSkgew0KPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gc2V0
IGRtYSBtYXNrKCVsdSlcbiIsIGRtYV9iaXRzKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJ
fQ0KPiArDQoNCkFzIHNhaWQgaW4gcHJldmlvdXMgdmVyc2lvbi4gSSBkb24ndCBzZWUgYW55IHBs
YWNlIGVuYWJsZSBoaWdoX2RtYSwgc28gSQ0KdGhpbmsgdGhpcyBwYXRjaCB3b24ndCBzZXQgPjMy
Yml0cyBmb3IgYW55Y2hpcC4gV2UgbmVlZCBzb21ldGhpbmcgbGlrZToNCg0KCXNwLT5oaWRoX2Rt
YSA9IGRtYV9iaXRzID4gMzI7DQoNCkFtIEkgbWlzc2luZyBhbnl0aGluZz8NCg0KSm9lLkMNCg0K

