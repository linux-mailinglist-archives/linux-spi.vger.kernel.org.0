Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5271FA696
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 05:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFPDHY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 23:07:24 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51839 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgFPDHX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 23:07:23 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3CBFB806AC;
        Tue, 16 Jun 2020 15:07:20 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1592276840;
        bh=XrQwFMgzmQ++BTETHMRkARdW5JDjGNo8Hn0JI+Z6+v0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=Lisyu563s6DH0QCMPc7BAnEtj1lJUuqKBJ/rqRu+74BKqlMVsb3matB8fht/HoBZr
         Uv5aUIXKvCfxxL/dpdYMqjurJvxFW8XEVBy/nMmo15vYradSFTS/MTRIRAumMA4oNH
         kzFEpdNoZStZSmcH1K9XRdbZFClzAMqWsqa9CuJ/lD2pflvNf1PKTeNWYftWcSrMrz
         TuTspGtHdDBjxUxLK/HIgr5AahaBBEORMOIm+IdpjwMzQH4Vlml5/Mt77PlzFpK8It
         qgbHz2BZ859Qmo1L1IgPGyGrL/C+s8I3A+ug73cDFn3q9hLfoslpmXdcYEFSqyl/L2
         2kCR/axHn3Ygg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ee837660000>; Tue, 16 Jun 2020 15:07:18 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 16 Jun 2020 15:07:18 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Tue, 16 Jun 2020 15:07:18 +1200
From:   Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "kdasu.kdev@gmail.com" <kdasu.kdev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] spi: bcm-qspi: Make multiple data blocks
 interrupt-driven
Thread-Topic: [PATCH 4/5] spi: bcm-qspi: Make multiple data blocks
 interrupt-driven
Thread-Index: AQHWQspGicsrLKHS70ycxRR+nhJ226jY9N2AgADS34A=
Date:   Tue, 16 Jun 2020 03:07:17 +0000
Message-ID: <40bae0160c6e24c3d90d4935eb31cf3de64abc9e.camel@alliedtelesis.co.nz>
References: <20200615040557.2011-1-mark.tomlinson@alliedtelesis.co.nz>
         <20200615040557.2011-5-mark.tomlinson@alliedtelesis.co.nz>
         <20200615143233.GW4447@sirena.org.uk>
In-Reply-To: <20200615143233.GW4447@sirena.org.uk>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:23:ed42:47d3:290f:32e3]
Content-Type: text/plain; charset="utf-8"
Content-ID: <40BFA6DC74A6F54791D9992BC84A293D@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTE1IGF0IDE1OjMyICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBNb24sIEp1biAxNSwgMjAyMCBhdCAwNDowNTo1NlBNICsxMjAwLCBNYXJrIFRvbWxpbnNvbiB3
cm90ZToNCj4gDQo+ID4gV2hlbiBuZWVkaW5nIHRvIHNlbmQvcmVjZWl2ZSBkYXRhIGluIHNtYWxs
IGNodW5rcywgbWFrZSB0aGlzIGludGVycnVwdA0KPiA+IGRyaXZlbiByYXRoZXIgdGhhbiB3YWl0
aW5nIGZvciBhIGNvbXBsZXRpb24gZXZlbnQgZm9yIGVhY2ggc21hbGwgc2VjdGlvbg0KPiA+IG9m
IGRhdGEuDQo+IA0KPiBBZ2FpbiB3YXMgdGhpcyBkb25lIGZvciBhIHJlYXNvbiBhbmQgaWYgc28g
ZG8gd2UgdW5kZXJzdGFuZCB3aHkgZG9pbmcNCj4gdGhpcyBmcm9tIGludGVycnVwdCBjb250ZXh0
IGlzIHNhZmUgLSBob3cgbG9uZyBjYW4gdGhlIGludGVycnVwdHMgYmUNCj4gd2hlbiBzdHVmZmlu
ZyB0aGUgRklGTyBmcm9tIGludGVycnVwdCBjb250ZXh0Pw0KDQpBcyBJJ20gcG9ydGluZyBhIEJy
b2FkY29tIHBhdGNoLCBJJ20gaG9waW5nIHNvbWVvbmUgZWxzZSBjYW4gYWRkDQpzb21ldGhpbmcg
dG8gdGhpcy4gRnJvbSB0aGUgaGlzdG9yeSBpdCBhcHBlYXJzIHRoZXJlIHdhcyBhIGhhcmQgbGlt
aXQNCihubyBzbWFsbCBjaHVua3MpLCBhbmQgdGhpcyB3YXMgY2hhbmdlZCB0byBkb2luZyBpdCBp
biBjaHVua3Mgd2l0aA0KcGF0Y2ggMzQ1MzA5ZmE3YzBjOTIsIGFwcGFyZW50bHkgdG8gaW1wcm92
ZSBwZXJmb3JtYW5jZS4gSSBiZWxpZXZlIHRoaXMNCmNoYW5nZSBmdXJ0aGVyIGltcHJvdmVzIHBl
cmZvcm1hbmNlLCBidXQgYXMgdGhlIHBhdGNoIGFycml2ZWQgd2l0aG91dA0KYW55IGRvY3VtZW50
YXRpb24sIEknbSBub3QgY2VydGFpbi4NCg0KDQo+ID4gQEAgLTczMSwxMiArNzMzLDE0IEBAIHN0
YXRpYyBpbmxpbmUgdTE2IHJlYWRfcnhyYW1fc2xvdF91MTYoc3RydWN0IGJjbV9xc3BpICpxc3Bp
LCBpbnQgc2xvdCkNCj4gPiAgCQkoKGJjbV9xc3BpX3JlYWQocXNwaSwgTVNQSSwgbXNiX29mZnNl
dCkgJiAweGZmKSA8PCA4KTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAtc3RhdGljIHZvaWQgcmVhZF9m
cm9tX2h3KHN0cnVjdCBiY21fcXNwaSAqcXNwaSwgaW50IHNsb3RzKQ0KPiA+ICtzdGF0aWMgdm9p
ZCByZWFkX2Zyb21faHcoc3RydWN0IGJjbV9xc3BpICpxc3BpKQ0KPiA+ICB7DQo+IA0KPiBUaGlu
Z3MgbWlnaHQgYmUgY2xlYXJlciBpZiB0aGlzIHJlZmFjdG9yaW5nIHdlcmUgc3BsaXQgb3V0IGlu
dG8gYQ0KPiBzZXBhcmF0ZSBwYXRjaC4NCg0KRG9uZS4NCg0KPiA+IEBAIC05NjAsMjQgKzk2Niwy
MSBAQCBzdGF0aWMgaW50IGJjbV9xc3BpX3RyYW5zZmVyX29uZShzdHJ1Y3Qgc3BpX21hc3RlciAq
bWFzdGVyLA0KPiA+ICAJCQkJIHN0cnVjdCBzcGlfdHJhbnNmZXIgKnRyYW5zKQ0KPiA+ICB7DQo+
ID4gIAlzdHJ1Y3QgYmNtX3FzcGkgKnFzcGkgPSBzcGlfbWFzdGVyX2dldF9kZXZkYXRhKG1hc3Rl
cik7DQo+ID4gLQlpbnQgc2xvdHM7DQo+ID4gLQl1bnNpZ25lZCBsb25nIHRpbWVvID0gbXNlY3Nf
dG9famlmZmllcygxMDApOw0KPiA+ICsJdW5zaWduZWQgbG9uZyB0aW1lbyA9IG1zZWNzX3RvX2pp
ZmZpZXMoMTAwMCk7DQo+IA0KPiBUaGF0J3MgYSByYW5kb21seSBjaG9zZW4gdmFsdWUgLSBpZiB3
ZSdyZSBub3cgZG9pbmcgdGhlIGVudGlyZSB0cmFuc2Zlcg0KPiB0aGVuIHdlIHNob3VsZCBiZSB0
cnlpbmcgdG8gZXN0aW1hdGUgdGhlIGxlbmd0aCBvZiB0aW1lIHRoZSB0cmFuc2Zlcg0KPiB3aWxs
IHRha2UsIGZvciBhIHZlcnkgbGFyZ2UgdHJhbnNmZXIgb24gYSBzbG93IGJ1cyBpdCdzIHBvc3Np
YmxlIHRoYXQNCj4gZXZlbiBhIHNlY29uZCB3b24ndCBiZSBlbm91Z2guDQo+IA0KQWdhaW4sIHRo
ZSB2YWx1ZSBjYW1lIGZyb20gQnJvYWRjb20uIFVzaW5nIHRoZSBkYXRhIGxlbmd0aCBhcyBhbg0K
ZXN0aW1hdGUgc291bmRzIGxpa2UgYSBnb29kIGlkZWEuDQoNCj4gPiAtCQljb21wbGV0ZSgmcXNw
aS0+bXNwaV9kb25lKTsNCj4gPiArDQo+ID4gKwkJcmVhZF9mcm9tX2h3KHFzcGkpOw0KPiA+ICsN
Cj4gPiArCQlpZiAocXNwaS0+dHJhbnNfcG9zLnRyYW5zKSB7DQo+ID4gKwkJCXdyaXRlX3RvX2h3
KHFzcGkpOw0KPiA+ICsJCX0gZWxzZSB7DQo+ID4gKwkJCWNvbXBsZXRlKCZxc3BpLT5tc3BpX2Rv
bmUpOw0KPiA+ICsJCQlzcGlfZmluYWxpemVfY3VycmVudF90cmFuc2Zlcihxc3BpLT5tYXN0ZXIp
Ow0KPiA+ICsJCX0NCj4gPiArDQo+IA0KPiBUaGlzIGlzIGFkZGluZyBhIHNwaV9maW5hbGl6ZV9j
dXJyZW50X3RyYW5zZmVyKCkgd2hpY2ggd2UgZGlkbid0IGhhdmUNCj4gYmVmb3JlLCBhbmQgc3Rp
bGwgbGVhdmluZyB1cyBkb2luZyBjbGVhbnVwIHdvcmsgaW4gdGhlIGRyaXZlciBpbiBhbm90aGVy
DQo+IHRocmVhZC4gIFRoaXMgaXMgY29uZnVzZWQsIHRoZSBkcml2ZXIgc2hvdWxkIG9ubHkgbmVl
ZCB0byBmaW5hbGl6ZSB0aGUNCj4gdHJhbnNmZXIgZXhwbGljaXRseSBpZiBpdCByZXR1cm5lZCBh
IHRpbWVvdXQgZnJvbSB0cmFuc2Zlcl9vbmUoKSBidXQNCj4gbm90aGluZydzIGNoYW5nZWQgdGhl
cmUuDQoNCkkgY2FuIHJlbW92ZSB0aGUgY2FsbCB0byBzcGlfZmluYWxpemVfY3VycmVudF90cmFu
c2ZlcigpIGZyb20gdGhpcw0KcGF0Y2guIEknbGwgdHJ5IHRvIGNoZWNrIHdoYXQgZG9lcyBoYXBw
ZW4gaW4gdGhlIHRpbWVvdXQgY2FzZS4NCg0KDQo=
