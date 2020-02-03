Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE86A1511A4
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2020 22:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBCVMD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Feb 2020 16:12:03 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53039 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgBCVMB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Feb 2020 16:12:01 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BE1BE886BF;
        Tue,  4 Feb 2020 10:11:56 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580764316;
        bh=+ExEBuVbffqKLBT+cZT+EIZ7Ph7ax/kOn9pnMgaSNRM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=zXgg0Xmww2hJpiNE0ECeuAxB2K/m0Mz4WM2O6+BSNS8L7OTyhUrkVy1JWAvLr0lA2
         p/c6D/1CaxxkzknPQoou1LEtzcjkZilXCdkpO6yEqPHCIkQYlftu7J2WdHxiFIVk+V
         9bnGsjP7wzuEtJ5csFp9HkTbDgyH9wq7GKt0GdCuMODgsCzXsN7XIBkU5vCifuCamd
         qsCBDvKIclW6ZNFit7JdwJjAPomx/l3O5ceDfgHDA7TcQKry8z5SDEX+XF2638ON5+
         31Jf8szwZGHQrucq+3lzBV90zSCY1kKb0N4WvEs0rP7Ihqjcn3RKB4iYzt2BTvKPgy
         ZMGVabQp0vbLw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e388c9d0000>; Tue, 04 Feb 2020 10:11:57 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb 2020 10:11:56 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Tue, 4 Feb 2020 10:11:56 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] spi: Add generic SPI multiplexer
Thread-Topic: [PATCH v4 2/2] spi: Add generic SPI multiplexer
Thread-Index: AQHV1979Bf4h06uI5E63bjUMirMKN6gIZR8AgAC+VIA=
Date:   Mon, 3 Feb 2020 21:11:56 +0000
Message-ID: <86509a5e6656c4f560ee6f6514ab00a232994957.camel@alliedtelesis.co.nz>
References: <20200131023433.12133-1-chris.packham@alliedtelesis.co.nz>
         <20200131023433.12133-3-chris.packham@alliedtelesis.co.nz>
         <CAHp75VfT=KNM6J1bP5cPsLw7Z776opcB9Kf6qhNCZukY-7g=pQ@mail.gmail.com>
In-Reply-To: <CAHp75VfT=KNM6J1bP5cPsLw7Z776opcB9Kf6qhNCZukY-7g=pQ@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:4cc:2ac4:9aa5:522d]
Content-Type: text/plain; charset="utf-8"
Content-ID: <05AFCD9D1BA3554699885BAC2DCCA5A2@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgQW5keSwNCg0KT24gTW9uLCAyMDIwLTAyLTAzIGF0IDExOjUwICswMjAwLCBBbmR5IFNoZXZj
aGVua28gd3JvdGU6DQoNCk90aGVyIGNvbW1lbnRzIGFsbCBhY2NlcHRlZCBhbmQgd2lsbCBiZSBh
ZGRyZXNzZWQgaW4gdjUuDQoNCj4gDQo+IC4uLg0KPiANCj4gDQo+ID4gKyAgICAgICBwcml2LT5t
dXggPSBkZXZtX211eF9jb250cm9sX2dldCgmc3BpLT5kZXYsIE5VTEwpOw0KPiA+ICsgICAgICAg
cmV0ID0gUFRSX0VSUl9PUl9aRVJPKHByaXYtPm11eCk7DQo+IA0KPiBUaGlzIGlzIGEgYml0IGNv
bXBsaWNhdGVkLg0KPiANCj4gPiArICAgICAgIGlmIChyZXQpIHsNCj4gDQo+IFdoeSBub3Qgc2lt
cGxlIGRvDQo+IA0KPiAgIGlmIChJU19FUlIocHJpdi0+bXV4KSkgew0KPiAgICAgcmV0ID0gUFRS
X0VSUiguLi4pOw0KPiAgICAgLi4uDQo+ICAgfQ0KPiANCj4gPw0KDQpJJ3ZlIGhhZCBvdGhlciBt
YWludGFpbmVycy9yZXZpZXdlcnMgc3VnZ2VzdCB0aGUgb3Bwb3NpdGUgZm9yIHBhdGNoZXMNCkkn
dmUgc3VibWl0dGVkIHRvIG90aGVyIHN1YnN5c3RlbXMgd2hpY2ggaXMgd2h5IEkgd2VudCB3aXRo
DQpQVFJfRVJSX09SX1pFUk8uIEl0IGFsc28gd29ya3Mgd2VsbCB3aXRoIHRoZSBnb3RvIGVycl9w
dXRfY3Rscjsgd2hpY2gNCm5lZWRzIHJldCB0byBiZSBzZXQuIEl0J3Mgbm90IGV4YWN0bHkgYSBj
b21tb24gcGF0dGVybiBpbiB0aGUgc3BpIGNvZGUNCnNvIEknZCBiZSBoYXBweSB0byBnbyB0aGUg
b3RoZXIgd2F5IGlmIHRoYXQncyB0aGUgZGVzaXJlZCBjb252ZW50aW9uDQpmb3Igc3BpLg0KDQo+
IA0KPiA+ICsgICAgICAgICAgICAgICBpZiAocmV0ICE9IC1FUFJPQkVfREVGRVIpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgZGV2X2Vycigmc3BpLT5kZXYsICJmYWlsZWQgdG8gZ2V0IGNv
bnRyb2wtbXV4XG4iKTsNCj4gPiArICAgICAgICAgICAgICAgZ290byBlcnJfcHV0X2N0bHI7DQo+
ID4gKyAgICAgICB9DQo+ID4gKyAgICAgICBjdGxyLT5kZXYub2Zfbm9kZSA9IHNwaS0+ZGV2Lm9m
X25vZGU7DQo+IA0KPiBJJ20gd29uZGVyaW5nIHdoeSBTUEkgY29yZSBjYW4ndCBoYW5kbGUgdGhp
cyBieSBkZWZhdWx0IChsaWtlIEdQSU8NCj4gc3Vic3lzdGVtIGRvZXMpLg0KPiANCg0KV2UgZG8g
aGF2ZSBpdCBmb3Igc3BpIGRldmljZXMgaW4gb2ZfcmVnaXN0ZXJfc3BpX2RldmljZSgpLiBJJ20g
bm90DQphd2FyZSBvZiBhbnkgcmVhc29uIHNwaV9yZWdpc3Rlcl9jb250cm9sbGVyKCkgY291bGRu
J3QgZG8gdGhlIHNhbWUgZm9yDQpjb250cm9sbGVycy4gSXQgd291bGQgYWZmZWN0IGEgbGFyZ2Ug
bnVtYmVyIG9mIGRyaXZlcnMgc28gc2hvdWxkDQpwcm9iYWJseSBiZSBzZXBhcmF0ZSB0byB0aGlz
IHNlcmllcy4gSXQncyBwcm9iYWJseSByZWFzb25hYmx5DQphdXRvbWF0YWJsZSB3aXRoIGNvY2Np
bmVsbGUuDQoNCg==
