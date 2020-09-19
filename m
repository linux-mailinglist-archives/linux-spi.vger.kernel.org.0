Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8520270F06
	for <lists+linux-spi@lfdr.de>; Sat, 19 Sep 2020 17:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgISPcA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 19 Sep 2020 11:32:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50523 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726491AbgISPcA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 19 Sep 2020 11:32:00 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Sep 2020 11:31:58 EDT
X-UUID: cd6e87128bfa48b7ab029e7556ad1be4-20200919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=IrIcNVhFVMWRbTHiVNPXL4VIQ4/x908yIeAq6qk9Ekc=;
        b=AkC4jDUGvMpB3L53ZdH1ue0FGSgGFs0n4j/r6cPjzBdoxCITafuHL1+KZakmoORsWbVBlIBD+Z+jxGoFMGRMt3JL8uVKSby43kwv/ZBVGx9o7SRkI4MdleN8ZkXPUF3oVHclKUJDTfdCQial5DRmFTjC0CrOqxeEsQbfCpWVeAQ=;
X-UUID: cd6e87128bfa48b7ab029e7556ad1be4-20200919
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1990299331; Sat, 19 Sep 2020 23:26:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 19 Sep 2020 23:26:50 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 19 Sep 2020 23:26:42 +0800
Message-ID: <1600529204.7002.0.camel@mtksdaap41>
Subject: Re: [PATCH v2 4/5] spi: spi-mtk-nor: support 36bit dma addressing
 to mediatek
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Sat, 19 Sep 2020 23:26:44 +0800
In-Reply-To: <20200918162834.v2.4.Id1cb208392928afc7ceed4de06924243c7858cd0@changeid>
References: <20200918083124.3921207-1-ikjn@chromium.org>
         <20200918162834.v2.4.Id1cb208392928afc7ceed4de06924243c7858cd0@changeid>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 46E17E8B4D077AB8C9950FBED0B79A5B30E2719458EBEF71FDC429C6B020E84F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTE4IGF0IDE2OjMxICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
VGhpcyBwYXRjaCBlbmFibGVzIDM2Yml0IGRtYSBhZGRyZXNzIHN1cHBvcnQgdG8gc3BpLW10ay1u
b3IuDQo+IEN1cnJlbnRseSAzNmJpdCBkbWEgYWRkcmVzc2luZyBpcyBlbmFibGVkIG9ubHkgZm9y
IG10ODE5Mi1ub3IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBJa2pvb24gSmFuZyA8aWtqbkBjaHJv
bWl1bS5vcmc+DQo+IC0tLQ0KPiANCj4gKG5vIGNoYW5nZXMgc2luY2UgdjEpDQo+IA0KPiAgZHJp
dmVycy9zcGkvc3BpLW10ay1ub3IuYyB8IDE5ICsrKysrKysrKysrKysrKysrKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zcGkvc3BpLW10ay1ub3IuYyBiL2RyaXZlcnMvc3BpL3NwaS1tdGstbm9y
LmMNCj4gaW5kZXggZTE0Nzk4YTZlN2QwLi45OWRkNWRjYTc0NGUgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvc3BpL3NwaS1tdGstbm9yLmMNCj4gKysrIGIvZHJpdmVycy9zcGkvc3BpLW10ay1ub3Iu
Yw0KPiBAQCAtNzgsNiArNzgsOCBAQA0KPiAgI2RlZmluZSBNVEtfTk9SX1JFR19ETUFfRkFEUgkJ
MHg3MWMNCj4gICNkZWZpbmUgTVRLX05PUl9SRUdfRE1BX0RBRFIJCTB4NzIwDQo+ICAjZGVmaW5l
IE1US19OT1JfUkVHX0RNQV9FTkRfREFEUgkweDcyNA0KPiArI2RlZmluZSBNVEtfTk9SX1JFR19E
TUFfREFEUl9IQgkJMHg3MzgNCj4gKyNkZWZpbmUgTVRLX05PUl9SRUdfRE1BX0VORF9EQURSX0hC
CTB4NzNjDQo+ICANCj4gICNkZWZpbmUgTVRLX05PUl9QUkdfTUFYX1NJWkUJCTYNCj4gIC8vIFJl
YWRpbmcgRE1BIHNyYy9kc3QgYWRkcmVzc2VzIGhhdmUgdG8gYmUgMTYtYnl0ZSBhbGlnbmVkDQo+
IEBAIC0xMDIsNiArMTA0LDcgQEAgc3RydWN0IG10a19ub3Igew0KPiAgCXVuc2lnbmVkIGludCBz
cGlfZnJlcTsNCj4gIAlib29sIHdidWZfZW47DQo+ICAJYm9vbCBoYXNfaXJxOw0KPiArCWJvb2wg
aGlnaF9kbWE7DQo+ICAJc3RydWN0IGNvbXBsZXRpb24gb3BfZG9uZTsNCj4gIH07DQo+ICANCj4g
QEAgLTI5MSw2ICsyOTQsMTEgQEAgc3RhdGljIGludCByZWFkX2RtYShzdHJ1Y3QgbXRrX25vciAq
c3AsIHUzMiBmcm9tLCB1bnNpZ25lZCBpbnQgbGVuZ3RoLA0KPiAgCXdyaXRlbChkbWFfYWRkciwg
c3AtPmJhc2UgKyBNVEtfTk9SX1JFR19ETUFfREFEUik7DQo+ICAJd3JpdGVsKGRtYV9hZGRyICsg
bGVuZ3RoLCBzcC0+YmFzZSArIE1US19OT1JfUkVHX0RNQV9FTkRfREFEUik7DQo+ICANCj4gKwlp
ZiAoc3AtPmhpZ2hfZG1hKSB7DQo+ICsJCXdyaXRlbChkbWFfYWRkciA+PiAzMiwgc3AtPmJhc2Ug
KyBNVEtfTk9SX1JFR19ETUFfREFEUl9IQik7DQo+ICsJCXdyaXRlbCgoZG1hX2FkZHIgKyBsZW5n
dGgpID4+IDMyLCBzcC0+YmFzZSArIE1US19OT1JfUkVHX0RNQV9FTkRfREFEUl9IQik7DQo+ICsJ
fQ0KPiArDQo+ICAJaWYgKHNwLT5oYXNfaXJxKSB7DQo+ICAJCXJlaW5pdF9jb21wbGV0aW9uKCZz
cC0+b3BfZG9uZSk7DQo+ICAJCW10a19ub3Jfcm13KHNwLCBNVEtfTk9SX1JFR19JUlFfRU4sIE1U
S19OT1JfSVJRX0RNQSwgMCk7DQo+IEBAIC01OTQsNyArNjAyLDggQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBzcGlfY29udHJvbGxlcl9tZW1fb3BzIG10a19ub3JfbWVtX29wcyA9IHsNCj4gIH07DQo+
ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19ub3JfbWF0Y2hbXSA9
IHsNCj4gLQl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1ub3IiIH0sDQo+ICsJeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItbm9yIiwgLmRhdGEgPSAodm9pZCAqKTM2IH0s
DQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtbm9yIiwgLmRhdGEgPSAodm9p
ZCAqKTMyIH0sDQo+ICAJeyAvKiBzZW50aW5lbCAqLyB9DQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklD
RV9UQUJMRShvZiwgbXRrX25vcl9tYXRjaCk7DQo+IEBAIC02MDcsNiArNjE2LDcgQEAgc3RhdGlj
IGludCBtdGtfbm9yX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJdTgg
KmJ1ZmZlcjsNCj4gIAlzdHJ1Y3QgY2xrICpzcGlfY2xrLCAqY3Rscl9jbGs7DQo+ICAJaW50IHJl
dCwgaXJxOw0KPiArCXVuc2lnbmVkIGxvbmcgZG1hX2JpdHM7DQo+ICANCj4gIAliYXNlID0gZGV2
bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiAgCWlmIChJU19FUlIoYmFz
ZSkpDQo+IEBAIC02MjMsNiArNjMzLDEzIEBAIHN0YXRpYyBpbnQgbXRrX25vcl9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCWJ1ZmZlciA9IGRldm1fa21hbGxvYygmcGRl
di0+ZGV2LA0KPiAgCQkJICAgICAgTVRLX05PUl9CT1VOQ0VfQlVGX1NJWkUgKyBNVEtfTk9SX0RN
QV9BTElHTiwNCj4gIAkJCSAgICAgIEdGUF9LRVJORUwpOw0KPiArDQo+ICsJZG1hX2JpdHMgPSAo
dW5zaWduZWQgbG9uZylvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7DQo+ICsJ
aWYgKGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoJnBkZXYtPmRldiwgRE1BX0JJVF9NQVNLKGRt
YV9iaXRzKSkpIHsNCj4gKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIHNldCBkbWEg
bWFzayglbHUpXG4iLCBkbWFfYml0cyk7DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCX0NCj4g
Kw0KDQpEbyB3ZSBuZWVkIHRvIHNldCBzcC0+aGlnaF9kbWEgd2hlbiB3ZSBoYXZlID4zMmJpdHMg
RE1BPw0KDQpKb2UuQw0K

