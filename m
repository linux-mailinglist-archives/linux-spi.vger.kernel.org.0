Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6152251041
	for <lists+linux-spi@lfdr.de>; Tue, 25 Aug 2020 05:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgHYDyw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Aug 2020 23:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgHYDyu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Aug 2020 23:54:50 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8450AC061574
        for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2020 20:54:49 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 315358066C;
        Tue, 25 Aug 2020 15:54:44 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1598327684;
        bh=hHq61X5njzw3KzTHFrbzLYnmhNEMViIircqEvxN8NfI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=whLr1H9y3oCGthWJtHSVl4tPCfKearLW4WiDvH5Embj6bxw8X+VwoR/mhmGGl03Dl
         n5hYA1ZqIRiL0rBwy5QjsqbaHlouiLWp33yXmOPXCB+gNfa+xYGYJsypCCfKZhxhOa
         3oiU2RPaV4jMbN9WXLAGoPKPGpZlcBbMDbT/yG4PtzuSiTcFTHFH4jIi3tovy0j+Zs
         oyuVJDQ6ltpX25N813IYRuolheWmm4sbmd84m0G7un6mu9C/OJGuWQxloDkLjQ/V4L
         upc22Gy0GUyiLOWdqeeQEAE641u7PgpmRECTupO4szsshF0y/4VYcXbSBUtSVVnS3F
         IQj/qW9aErz/Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f448b840001>; Tue, 25 Aug 2020 15:54:44 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 Aug 2020 15:54:43 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Tue, 25 Aug 2020 15:54:43 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fsl_espi errors on v5.7.15
Thread-Topic: fsl_espi errors on v5.7.15
Thread-Index: AQHWceVnik7XsBYbp0S+yHVGh1hdQak2WMaAgAQdSwCAAz9MAIAAfdcAgAD5u4CAB+sMAIAAYfwA
Date:   Tue, 25 Aug 2020 03:54:42 +0000
Message-ID: <4ed8a84b-0763-820e-df3e-1861d718f77d@alliedtelesis.co.nz>
References: <3f48e5fb-33c9-8046-0f80-236eed163c16@alliedtelesis.co.nz>
 <c43a23bd-33ec-4ef2-2ca5-730342248db3@gmail.com>
 <3c72eec1-41ba-7389-eceb-3de80065555a@alliedtelesis.co.nz>
 <1bbb3726-b0a4-6eb9-9076-706b06dfb90f@alliedtelesis.co.nz>
 <61bb9800-9f90-9cd4-3b17-c14a7f83d792@gmail.com>
 <0ff80ebb-e6ae-d8e1-9f0d-8759b2556141@alliedtelesis.co.nz>
 <c2dadf51-666f-72f6-7687-731f281ed7d6@alliedtelesis.co.nz>
In-Reply-To: <c2dadf51-666f-72f6-7687-731f281ed7d6@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DA87CAECE261C489414F0F0D1F6DFDF@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQpPbiAyNS8wOC8yMCAxMDowNCBhbSwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4NCj4gT24gMjAv
MDgvMjAgOTowOCBhbSwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+DQo+PiBPbiAxOS8wOC8yMCA2
OjE1IHBtLCBIZWluZXIgS2FsbHdlaXQgd3JvdGU6DQo+Pj4gT24gMTkuMDguMjAyMCAwMDo0NCwg
Q2hyaXMgUGFja2hhbSB3cm90ZToNCj4+Pj4gSGkgQWdhaW4sDQo+Pj4+DQo+Pj4+IE9uIDE3LzA4
LzIwIDk6MDkgYW0sIENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pj4+DQo+Pj4+PiBPbiAxNC8wOC8y
MCA2OjE5IHBtLCBIZWluZXIgS2FsbHdlaXQgd3JvdGU6DQo+Pj4+Pj4gT24gMTQuMDguMjAyMCAw
NDo0OCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+Pj4+Pj4gSGksDQo+Pj4+Pj4+DQo+Pj4+Pj4+
IEknbSBzZWVpbmcgYSBwcm9ibGVtIHdpdGggYWNjZXNzaW5nIHNwaS1ub3IgYWZ0ZXIgdXBncmFk
aW5nIGEgVDIwODENCj4+Pj4+Pj4gYmFzZWQgc3lzdGVtIHRvIGxpbnV4IHY1LjcuMTUNCj4+Pj4+
Pj4NCj4+Pj4+Pj4gRm9yIHRoaXMgYm9hcmQgdS1ib290IGFuZCB0aGUgdS1ib290IGVudmlyb25t
ZW50IGxpdmUgb24gc3BpLW5vci4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gV2hlbiBJIHVzZSBmd19zZXRl
bnYgZnJvbSB1c2Vyc3BhY2UgSSBnZXQgdGhlIGZvbGxvd2luZyBrZXJuZWwgbG9ncw0KPj4+Pj4+
Pg0KPj4+Pj4+PiAjIGZ3X3NldGVudiBmb289MQ0KPj4+Pj4+PiBmc2xfZXNwaSBmZmUxMTAwMDAu
c3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQo+Pj4+Pj4+IGZzbF9l
c3BpIGZmZTExMDAwMC5zcGk6IFRyYW5zZmVyIGRvbmUgYnV0IFNQSUVfRE9OIGlzbid0IHNldCEN
Cj4+Pj4+Pj4gZnNsX2VzcGkgZmZlMTEwMDAwLnNwaTogVHJhbnNmZXIgZG9uZSBidXQgU1BJRV9E
T04gaXNuJ3Qgc2V0IQ0KPj4+Pj4+PiBmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBk
b25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQo+Pj4+Pj4+IGZzbF9lc3BpIGZmZTExMDAwMC5z
cGk6IFRyYW5zZmVyIGRvbmUgYnV0IFNQSUVfRE9OIGlzbid0IHNldCENCj4+Pj4+Pj4gZnNsX2Vz
cGkgZmZlMTEwMDAwLnNwaTogVHJhbnNmZXIgZG9uZSBidXQgU1BJRV9ET04gaXNuJ3Qgc2V0IQ0K
Pj4+Pj4+PiBmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RP
TiBpc24ndCBzZXQhDQo+Pj4+Pj4+IGZzbF9lc3BpIGZmZTExMDAwMC5zcGk6IFRyYW5zZmVyIGRv
bmUgYnV0IFNQSUVfRE9OIGlzbid0IHNldCENCj4+Pj4+Pj4gZnNsX2VzcGkgZmZlMTEwMDAwLnNw
aTogVHJhbnNmZXIgZG9uZSBidXQgU1BJRV9ET04gaXNuJ3Qgc2V0IQ0KPj4+Pj4+PiBmc2xfZXNw
aSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQo+
Pj4+Pj4+IGZzbF9lc3BpIGZmZTExMDAwMC5zcGk6IFRyYW5zZmVyIGRvbmUgYnV0IFNQSUVfRE9O
IGlzbid0IHNldCENCj4+Pj4+Pj4gZnNsX2VzcGkgZmZlMTEwMDAwLnNwaTogVHJhbnNmZXIgZG9u
ZSBidXQgU1BJRV9ET04gaXNuJ3Qgc2V0IQ0KPj4+Pj4+PiBmc2xfZXNwaSBmZmUxMTAwMDAuc3Bp
OiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQo+Pj4+Pj4+IGZzbF9lc3Bp
IGZmZTExMDAwMC5zcGk6IFRyYW5zZmVyIGRvbmUgYnV0IFNQSUVfRE9OIGlzbid0IHNldCENCj4+
Pj4+Pj4gZnNsX2VzcGkgZmZlMTEwMDAwLnNwaTogVHJhbnNmZXIgZG9uZSBidXQgcngvdHggZmlm
bydzIGFyZW4ndCANCj4+Pj4+Pj4gZW1wdHkhDQo+Pj4+Pj4+IGZzbF9lc3BpIGZmZTExMDAwMC5z
cGk6IFNQSUVfUlhDTlQgPSAxLCBTUElFX1RYQ05UID0gMzINCj4+Pj4+Pj4gZnNsX2VzcGkgZmZl
MTEwMDAwLnNwaTogVHJhbnNmZXIgZG9uZSBidXQgcngvdHggZmlmbydzIGFyZW4ndCANCj4+Pj4+
Pj4gZW1wdHkhDQo+Pj4+Pj4+IGZzbF9lc3BpIGZmZTExMDAwMC5zcGk6IFNQSUVfUlhDTlQgPSAx
LCBTUElFX1RYQ05UID0gMzINCj4+Pj4+Pj4gZnNsX2VzcGkgZmZlMTEwMDAwLnNwaTogVHJhbnNm
ZXIgZG9uZSBidXQgcngvdHggZmlmbydzIGFyZW4ndCANCj4+Pj4+Pj4gZW1wdHkhDQo+Pj4+Pj4+
IGZzbF9lc3BpIGZmZTExMDAwMC5zcGk6IFNQSUVfUlhDTlQgPSAxLCBTUElFX1RYQ05UID0gMzIN
Cj4+Pj4+Pj4gLi4uDQo+Pj4+Pj4+DQo+Pj4+Pj4gVGhpcyBlcnJvciByZXBvcnRpbmcgZG9lc24n
dCBleGlzdCB5ZXQgaW4gNC40LiBTbyB5b3UgbWF5IGhhdmUgYW4gDQo+Pj4+Pj4gaXNzdWUNCj4+
Pj4+PiB1bmRlciA0LjQgdG9vLCBpdCdzIGp1c3Qgbm90IHJlcG9ydGVkLg0KPj4+Pj4+IERpZCB5
b3UgdmVyaWZ5IHRoYXQgdW5kZXIgNC40IGZ3X3NldGVudiBhY3R1YWxseSBoYXMgYW4gZWZmZWN0
Pw0KPj4+Pj4gSnVzdCBkb3VibGUgY2hlY2tlZCBhbmQgeWVzIHVuZGVyIDQuNCB0aGUgc2V0dGlu
ZyBkb2VzIGdldCBzYXZlZC4NCj4+Pj4+Pj4gSWYgSSBydW4gZndfcHJpbnRlbnYgKGJlZm9yZSBn
ZXR0aW5nIGl0IGludG8gYSBiYWQgc3RhdGUpIGl0IGlzIA0KPj4+Pj4+PiBhYmxlIHRvDQo+Pj4+
Pj4+IGRpc3BsYXkgdGhlIGNvbnRlbnQgb2YgdGhlIGJvYXJkcyB1LWJvb3QgZW52aXJvbm1lbnQu
DQo+Pj4+Pj4+DQo+Pj4+Pj4gVGhpcyBtaWdodCBpbmRpY2F0ZSBhbiBpc3N1ZSB3aXRoIHNwaSBi
ZWluZyBsb2NrZWQuIEkndmUgc2VlbiANCj4+Pj4+PiByZWxhdGVkDQo+Pj4+Pj4gcXVlc3Rpb25z
LCBqdXN0IHVzZSB0aGUgc2VhcmNoIGVuZ2luZSBvZiB5b3VyIGNob2ljZSBhbmQgY2hlY2sgZm9y
DQo+Pj4+Pj4gZndfc2V0ZW52IGFuZCBsb2NrZWQuDQo+Pj4+PiBJJ20gcnVubmluZyBhIHZlcnNp
b24gb2YgZndfc2V0ZW52IHdoaWNoIGluY2x1ZGVzDQo+Pj4+PiBodHRwczovL2dpdGxhYi5kZW54
LmRlL3UtYm9vdC91LWJvb3QvLS9jb21taXQvZGI4MjAxNTkgc28gaXQgDQo+Pj4+PiBzaG91bGRu
J3QNCj4+Pj4+IGJlIGxvY2tpbmcgdGhpbmdzIHVubmVjZXNzYXJpbHkuDQo+Pj4+Pj4+IElmIGJl
ZW4gdW5zdWNjZXNzZnVsIGluIHByb2R1Y2luZyBhIHNldHVwIGZvciBiaXNlY3RpbmcgdGhlIA0K
Pj4+Pj4+PiBpc3N1ZS4gSSBkbw0KPj4+Pj4+PiBrbm93IHRoZSBpc3N1ZSBkb2Vzbid0IG9jY3Vy
IG9uIHRoZSBvbGQgNC40LnggYmFzZWQga2VybmVsIGJ1dCANCj4+Pj4+Pj4gdGhhdCdzDQo+Pj4+
Pj4+IHByb2JhYmx5IG5vdCBtdWNoIGhlbHAuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IEFueSBwb2ludGVy
cyBvbiB3aGF0IHRoZSBpc3N1ZSAoYW5kL29yIHNvbHV0aW9uKSBtaWdodCBiZS4NCj4+Pj4gSSBm
aW5hbGx5IG1hbmFnZWQgdG8gZ2V0IG91ciBib2FyZCBydW5uaW5nIHdpdGggYSB2YW5pbGxhIGtl
cm5lbC4gV2l0aA0KPj4+PiBjb3JlbmV0NjRfc21wX2RlZmNvbmZpZyBJIG9jY2FzaW9uYWxseSBz
ZWUNCj4+Pj4NCj4+Pj4gwqAgwqAgZnNsX2VzcGkgZmZlMTEwMDAwLnNwaTogVHJhbnNmZXIgZG9u
ZSBidXQgU1BJRV9ET04gaXNuJ3Qgc2V0IQ0KPj4+Pg0KPj4+PiBvdGhlciB0aGFuIHRoZSBtZXNz
YWdlIHRoaW5ncyBzZWVtIHRvIGJlIHdvcmtpbmcuDQo+Pj4+DQo+Pj4+IFdpdGggYSBjdXN0b20g
ZGVmY29uZmlnIEkgc2VlDQo+Pj4+DQo+Pj4+IMKgIMKgIGZzbF9lc3BpIGZmZTExMDAwMC5zcGk6
IFRyYW5zZmVyIGRvbmUgYnV0IFNQSUVfRE9OIGlzbid0IHNldCENCj4+Pj4gwqAgwqAgZnNsX2Vz
cGkgZmZlMTEwMDAwLnNwaTogVHJhbnNmZXIgZG9uZSBidXQgcngvdHggZmlmbydzIGFyZW4ndCAN
Cj4+Pj4gZW1wdHkhDQo+Pj4+IMKgIMKgIGZzbF9lc3BpIGZmZTExMDAwMC5zcGk6IFNQSUVfUlhD
TlQgPSAxLCBTUElFX1RYQ05UID0gMzINCj4+Pj4gwqAgwqAgLi4uDQo+Pj4+DQo+Pj4+IGFuZCBh
Y2Nlc3MgdG8gdGhlIHNwaS1ub3IgZG9lcyBub3Qgd29yayB1bnRpbCB0aGUgYm9hcmQgaXMgcmVz
ZXQuDQo+Pj4+DQo+Pj4+IEknbGwgdHJ5IGFuZCBwaWNrIGFwYXJ0IHRoZSBkaWZmZXJlbmNlcyBi
ZXR3ZWVuIHRoZSB0d28gZGVmY29uZmlncy4NCj4+DQo+PiBJIG5vdyB0aGluayBteSBlYXJsaWVy
IHRlc3RpbmcgaXMgaW52YWxpZC4gSSBoYXZlIHNlZW4gdGhlIHByb2JsZW0gDQo+PiB3aXRoIGVp
dGhlciBkZWZjb25maWcgaWYgSSB0cnkgaGFyZCBlbm91Z2guIEkgaGFkIGNvbnZpbmNlZCBteXNl
bGYgDQo+PiB0aGF0IHRoZSBwcm9ibGVtIHdhcyBDT05GSUdfUFJFRU1QVCBidXQgdGhhdCB3YXMg
YmVmb3JlIEkgZm91bmQgDQo+PiBib290LXRvLWJvb3QgZGlmZmVyZW5jZXMgd2l0aCB0aGUgc2Ft
ZSBrZXJuZWwuDQo+Pg0KPj4gSXQncyBwb3NzaWJsZSB0aGF0IEknbSBjaGFzaW5nIG11bHRpcGxl
IGlzc3VlcyB3aXRoIHRoZSBzYW1lIHN5bXB0b20uDQo+Pg0KPj4gVGhlIGVycm9yIEknbSBtb3N0
IGNvbmNlcm5lZCB3aXRoIGlzIGluIHRoZSBzZXF1ZW5jZQ0KPj4gMS4gYm9vdCB3aXRoIG9sZCBp
bWFnZQ0KPj4gMi4gd3JpdGUgZW52aXJvbm1lbnQNCj4+IDMuIGJvb3Qgd2l0aCBuZXcgaW1hZ2UN
Cj4+IDQuIHdyaXRlIGVudmlyb25tZW50DQo+PiA1LiB3cml0ZSBmYWlscyBhbmQgZW52aXJvbm1l
bnQgaXMgY29ycnVwdGVkDQo+Pg0KPj4gQWZ0ZXIgSSByZWNvdmVyIHRoZSBzeXN0ZW0gdGhpbmdz
IHNvbWV0aW1lcyBzZWVtIGZpbmUuIFVudGlsIEkgcmVwZWF0IA0KPj4gdGhlIHNlcXVlbmNlIGFi
b3ZlLg0KPj4NCj4+PiBBbHNvIHJlbGV2YW50IG1heSBiZToNCj4+PiAtIFdoaWNoIGR0cyBhcmUg
eW91IHVzaW5nPw0KPj4gQ3VzdG9tIGJ1dCBiYXNlZCBoZWF2aWx5IG9uIHRoZSB0MjA4MHJkYi4N
Cj4+PiAtIFdoYXQncyB0aGUgc3BpLW5vciB0eXBlLCBhbmQgYXQgd2hpY2ggZnJlcXVlbmN5IGFy
ZSB5b3Ugb3BlcmF0aW5nIGl0Pw0KPj4gVGhlIGJvYXJkIGhhcyBzZXZlcmFsIGFsdGVybmF0ZSBw
YXJ0cyBmb3IgdGhlIHNwaS1ub3Igc28gdGhlIGR0cyBqdXN0IA0KPj4gc3BlY2lmaWVzIGNvbXBh
dGlibGUgPSAiamVkZWMsc3BpLW5vciIgdGhlIGFjdHVhbCBjaGlwIGRldGVjdGVkIG9uIA0KPj4g
dGhlIGJvYXJkIEkgaGF2ZSBpcyAibjI1cTAzMmEgKDQwOTYgS2J5dGVzKSIuIFRoZSBkdHMgc2V0
cyANCj4+IHNwaS1tYXgtZnJlcXVlbmN5ID0gPDEwMDAwMDAwPiBJIGhhdmVuJ3QgbWVhc3VyZWQg
dGhlIGFjdHVhbCANCj4+IGZyZXF1ZW5jeSBvbiB0aGUgYnVzLg0KPj4+IC0gRG9lcyB0aGUgaXNz
dWUgc3RpbGwgaGFwcGVuIGlmIHlvdSBsb3dlciB0aGUgZnJlcXVlbmN5Pw0KPj4gSSBkaWQgcGxh
eSBhcm91bmQgd2l0aCB0aGUgZnJlcXVlbmN5IGluaXRpYWxseSBidXQgSSBzaG91bGQgcHJvYmFi
bHkgDQo+PiBnaXZlIHRoYXQgYW5vdGhlciBnbyBub3cgdGhhdCBJIGhhdmUgYSBiZXR0ZXIgcmVw
cm9kdWN0aW9uIG1ldGhvZC4NCj4NCj4gUGxheWluZyBhcm91bmQgd2l0aCB0aGUgZnJlcXVlbmN5
IGRpZG4ndCBoZWxwLg0KPg0KPiBPbmUgdGhpbmcgdGhhdCBJJ3ZlIGZvdW5kIGlzIHRoYXQgdGhl
IHByb2JsZW0gYXBwZWFycyB0byBiZSB0aGF0IEkgZW5kIA0KPiB1cCB3aXRoIGV4dHJhIGJ5dGVz
IGluIHRoZSBSWCBGSUZPLiBJZiBJIGFkZCBjb2RlIHRvIGRyYWluIHRoZSBSWCBGSUZPIA0KPiB0
aGVuIHRoZSBzeXN0ZW0gaXMgYWJsZSB0byBrZWVwIGFjY2Vzc2luZyB0aGUgc3BpLW5vciAoYWxi
ZWl0IHdpdGggDQo+IHNvbWUgbm9pc3kgbG9ncykuDQoNCkkndmUgYmVlbiBzdGFyaW5nIGF0IHNw
aS1mc2wtZXNwaS5jIGZvciB3aGlsZSBub3cgYW5kIEkgdGhpbmsgSSd2ZSANCmlkZW50aWZpZWQg
YSBjb3VwbGUgb2YgZGVmaWNpZW5jaWVzIHRoYXQgbWF5IG9yIG1heSBub3QgYmUgcmVsYXRlZCB0
byBteSANCmlzc3VlLg0KDQpGaXJzdCBJIHRoaW5rIHRoZSAnVHJhbnNmZXIgZG9uZSBidXQgU1BJ
RV9ET04gaXNuJ3Qgc2V0JyBtZXNzYWdlIGNhbiBiZSANCmdlbmVyYXRlZCBzcHVyaW91c2x5LiBJ
biBmc2xfZXNwaV9pcnEoKSB3ZSByZWFkIHRoZSBFU1BJX1NQSUUgcmVnaXN0ZXIuIA0KV2UgYWxz
byB3cml0ZSBiYWNrIHRvIGl0IHRvIGNsZWFyIHRoZSBjdXJyZW50IGV2ZW50cy4gV2UgcmUtcmVh
ZCBpdCBpbiANCmZzbF9lc3BpX2NwdV9pcnEoKSBhbmQgY29tcGxhaW4gd2hlbiBTUElFX0RPTiBp
cyBub3Qgc2V0LiBCdXQgd2UgY2FuIA0KbmF0dXJhbGx5IGVuZCB1cCBpbiB0aGF0IHNpdHVhdGlv
biBpZiB3ZSdyZSBkb2luZyBhIGxhcmdlIHJlYWQuIENvbnNpZGVyIA0KdGhlIG1lc3NhZ2VzIGZv
ciByZWFkaW5nIGEgYmxvY2sgb2YgZGF0YSBmcm9tIGEgc3BpLW5vciBjaGlwDQoNCiDCoHR4ID0g
UkVBRF9PUCArIEFERFINCiDCoHJ4ID0gZGF0YQ0KDQpXZSBzZXR1cCB0aGUgdHJhbnNmZXIgYW5k
IHB1bXAgb3V0IHRoZSB0eF9idWYuIFRoZSBmaXJzdCBpbnRlcnJ1cHQgZ29lcyANCm9mZiBhbmQg
RVNQSV9TUElFIGhhcyBTUElNX0RPTiBhbmQgU1BJTV9SWFQgc2V0LiBXZSBlbXB0eSB0aGUgcngg
ZmlmbywgDQpjbGVhciBFU1BJX1NQSUUgYW5kIHdhaXQgZm9yIHRoZSBuZXh0IGludGVycnVwdC4g
VGhlIG5leHQgaW50ZXJydXB0IA0KZmlyZXMgYW5kIHRoaXMgdGltZSB3ZSBoYXZlIEVTUElfU1BJ
RSB3aXRoIGp1c3QgU1BJTV9SWFQgc2V0LiBUaGlzIA0KY29udGludWVzIHVudGlsIHdlJ3ZlIHJl
Y2VpdmVkIGFsbCB0aGUgZGF0YSBhbmQgd2UgZmluaXNoIHdpdGggRVNQSV9TUElFIA0KaGF2aW5n
IG9ubHkgU1BJTV9SWFQgc2V0LiBXaGVuIHdlIHJlLXJlYWQgaXQgd2UgY29tcGxhaW4gdGhhdCBT
UElFX0RPTiANCmlzbid0IHNldC4NCg0KVGhlIG90aGVyIGRlZmljaWVuY3kgaXMgdGhhdCB3ZSBv
bmx5IGdldCBhbiBpbnRlcnJ1cHQgd2hlbiB0aGUgYW1vdW50IG9mIA0KZGF0YSBpbiB0aGUgcngg
ZmlmbyBpcyBhYm92ZSBGU0xfRVNQSV9SWFRIUi4gSWYgdGhlcmUgYXJlIGZld2VyIHRoYW4gDQpG
U0xfRVNQSV9SWFRIUiBsZWZ0IHRvIGJlIHJlY2VpdmVkIHdlIHdpbGwgbmV2ZXIgcHVsbCB0aGVt
IG91dCBvZiB0aGUgZmlmby4NCg0KSSB0aGluayB0aGUgcmVhc29uIEknbSBzZWVpbmcgc29tZSB2
YXJpYWJpbGl0eSBpcyBiZWNhdXNlIG9mIGhvdyBmYXN0IA0KKG9yIHNsb3cpIHRoZSBpbnRlcnJ1
cHRzIGdldCBwcm9jZXNzZWQgYW5kIGhvdyBmYXN0IHRoZSBzcGktbm9yIGNoaXAgY2FuIA0KZmls
bCB0aGUgQ1BVcyByeCBmaWZvLg0K
