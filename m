Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C091E1587
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 23:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgEYVOC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 17:14:02 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50379 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbgEYVOA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 May 2020 17:14:00 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3B6D8806AC;
        Tue, 26 May 2020 09:13:50 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1590441230;
        bh=1GZ+rBX7xqurTjIxUtllEu8f8mEOU1FUuJ0hbynCAVY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=x0g09B49nupucAeIZydEXbXYpZBAx1ac96op2Fb6IdmHdGkdYZ3HqiFcFIXwKOf3D
         9rUXhK/EHddvOCU7rdMttS+rLhTCSj+JDXsRVbNb6owI6NOZCz3zq2ADiTjSIqW3qG
         TYTM3OpXC9XmoyYhacaf9N0X7jZscyozjY0vgirNFTH9P1kqenHSkY6jkz7bbvhZOt
         XyYUdKNGf3gEg3ePy2NcXpRCFI/R+x0XF1a0qYYNO6E1OS7Kw3NvBAcSPBVBYBHD6z
         7Yj+cnJy4ZNx4R55J74vEtVLswKRPWtDjxGHgvdMdJ8j8THujfldkGq7elaMKuhLCl
         FkZ1+otnqfX0Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ecc350e0001>; Tue, 26 May 2020 09:13:50 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 26 May 2020 09:13:49 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Tue, 26 May 2020 09:13:49 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: mux: repair mux usage
Thread-Topic: [PATCH] spi: mux: repair mux usage
Thread-Index: AQHWMoFzOEHREl8s2kuQsEGWNhWTD6i4hJUA
Date:   Mon, 25 May 2020 21:13:49 +0000
Message-ID: <689e67d4-555a-a9a7-ee4d-a83f620a554a@alliedtelesis.co.nz>
References: <20200525104352.26807-1-peda@axentia.se>
In-Reply-To: <20200525104352.26807-1-peda@axentia.se>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <02BB1BD0A534F54E824D2F85043E7136@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQpPbiAyNS8wNS8yMCAxMDo0MyBwbSwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+IEl0IGlzIG5vdCB2
YWxpZCB0byBjYWNoZS9zaG9ydCBvdXQgc2VsZWN0aW9uIG9mIHRoZSBtdXguDQo+DQo+IG11eF9j
b250cm9sX3NlbGVjdCgpIG9ubHkgbG9ja3MgdGhlIG11eCB1bnRpbCBtdXhfY29udHJvbF9kZXNl
bGVjdCgpDQo+IGlzIGNhbGxlZC4gbXV4X2NvbnRyb2xfZGVzZWxlY3QoKSBtYXkgcHV0IHRoZSBt
dXggaW4gc29tZSBsb3cgcG93ZXINCj4gc3RhdGUgb3Igc29tZSBvdGhlciB1c2VyIG9mIHRoZSBt
dXggbWlnaHQgc2VsZWN0IGl0IGZvciBvdGhlciBwdXJwb3Nlcy4NCj4gVGhlc2UgdGhpbmdzIGFy
ZSBwcm9iYWJseSBub3QgaGFwcGVuaW5nIGluIHRoZSBvcmlnaW5hbCBzZXR0aW5nIHdoZXJlDQo+
IHRoaXMgZHJpdmVyIHdhcyBkZXZlbG9wZWQsIGJ1dCBpdCBpcyBzYWlkIHRvIGJlIGEgZ2VuZXJp
YyBTUEkgbXV4Lg0KPg0KPiBBbHNvLCB0aGUgbXV4IGZyYW1ld29yayB3aWxsIHNob3J0IG91dCB0
aGUgYWN0dWFsIGxvdyBsZXZlbCBtdXhpbmcNCj4gb3BlcmF0aW9uIHdoZW4vaWYgdGhhdCBpcyBw
b3NzaWJsZS4NCj4NCj4gRml4ZXM6IGU5ZTQwNTQzYWQ1YiAoInNwaTogQWRkIGdlbmVyaWMgU1BJ
IG11bHRpcGxleGVyIikNCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRp
YS5zZT4NCj4gLS0tDQo+ICAgZHJpdmVycy9zcGkvc3BpLW11eC5jIHwgOCArKysrLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktbXV4LmMgYi9kcml2ZXJzL3NwaS9zcGktbXV4LmMN
Cj4gaW5kZXggNGY5NGM5MTI3ZmMxLi5jYzllZjM3MWRiMTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvc3BpL3NwaS1tdXguYw0KPiArKysgYi9kcml2ZXJzL3NwaS9zcGktbXV4LmMNCj4gQEAgLTUx
LDYgKzUxLDEwIEBAIHN0YXRpYyBpbnQgc3BpX211eF9zZWxlY3Qoc3RydWN0IHNwaV9kZXZpY2Ug
KnNwaSkNCj4gICAJc3RydWN0IHNwaV9tdXhfcHJpdiAqcHJpdiA9IHNwaV9jb250cm9sbGVyX2dl
dF9kZXZkYXRhKHNwaS0+Y29udHJvbGxlcik7DQo+ICAgCWludCByZXQ7DQo+ICAgDQo+ICsJcmV0
ID0gbXV4X2NvbnRyb2xfc2VsZWN0KHByaXYtPm11eCwgc3BpLT5jaGlwX3NlbGVjdCk7DQo+ICsJ
aWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiAgIAlpZiAocHJpdi0+Y3VycmVudF9j
cyA9PSBzcGktPmNoaXBfc2VsZWN0KQ0KPiAgIAkJcmV0dXJuIDA7DQo+ICAgDQo+IEBAIC02Miwx
MCArNjYsNiBAQCBzdGF0aWMgaW50IHNwaV9tdXhfc2VsZWN0KHN0cnVjdCBzcGlfZGV2aWNlICpz
cGkpDQo+ICAgCXByaXYtPnNwaS0+bW9kZSA9IHNwaS0+bW9kZTsNCj4gICAJcHJpdi0+c3BpLT5i
aXRzX3Blcl93b3JkID0gc3BpLT5iaXRzX3Blcl93b3JkOw0KPiAgIA0KPiAtCXJldCA9IG11eF9j
b250cm9sX3NlbGVjdChwcml2LT5tdXgsIHNwaS0+Y2hpcF9zZWxlY3QpOw0KPiAtCWlmIChyZXQp
DQo+IC0JCXJldHVybiByZXQ7DQo+IC0NCj4gICAJcHJpdi0+Y3VycmVudF9jcyA9IHNwaS0+Y2hp
cF9zZWxlY3Q7DQo+ICAgDQo+ICAgCXJldHVybiAwOw0KDQoNCkkndmUgdGVzdGVkIHRoaXMgb24g
dGhlIDIgaGFyZHdhcmUgcGxhdGZvcm1zIEkgaGF2ZSB3aXRoIHRoZSBtdWx0aXBsZXhlZCANCkNT
IGFuZCBib3RoIHdvcmsgZmluZSB3aXRoIHRoaXMgY2hhbmdlIHNvDQoNClRlc3RlZC1ieTogQ2hy
aXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0K
