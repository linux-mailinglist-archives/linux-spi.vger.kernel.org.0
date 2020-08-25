Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF119250FDE
	for <lists+linux-spi@lfdr.de>; Tue, 25 Aug 2020 05:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgHYDSc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Aug 2020 23:18:32 -0400
Received: from gw-eagle1.siemens.com ([194.138.20.72]:10853 "EHLO
        gw-eagle1.siemens.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgHYDSb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Aug 2020 23:18:31 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Aug 2020 23:18:29 EDT
Received: from mail1.dc4ca.siemens.de (mail1.dc4ca.siemens.de [139.25.224.78])
        by gw-eagle1.siemens.com (Postfix) with ESMTPS id 1020E4F0070;
        Tue, 25 Aug 2020 05:12:24 +0200 (CEST)
Received: from DEMCHDC89YA.ad011.siemens.net (demchdc89ya.ad011.siemens.net [139.25.226.104])
        by mail1.dc4ca.siemens.de (Postfix) with ESMTPS id AA64C1622BD70;
        Tue, 25 Aug 2020 05:12:23 +0200 (CEST)
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 DEMCHDC89YA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Tue, 25 Aug 2020 05:12:22 +0200
Received: from CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) by
 CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) with mapi id
 15.01.2044.004; Tue, 25 Aug 2020 11:12:20 +0800
From:   "Jin, Le" <le.jin@siemens.com>
To:     "Kiszka, Jan" <jan.kiszka@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "simon.k.r.goldschmidt@gmail.com" <simon.k.r.goldschmidt@gmail.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "marex@denx.de" <marex@denx.de>
Subject: RE: [RESEND PATCH v3 5/8] mtd: spi-nor: cadence-quadspi: Handle probe
 deferral while requesting DMA channel
Thread-Topic: [RESEND PATCH v3 5/8] mtd: spi-nor: cadence-quadspi: Handle
 probe deferral while requesting DMA channel
Thread-Index: AQHWehUBoExbvQYBc0+HV1ub3Nt/GKlIJI9w
Date:   Tue, 25 Aug 2020 03:12:20 +0000
Message-ID: <84209e7d08e24362bdf7ccbab1c46e60@siemens.com>
References: <20200601070444.16923-1-vigneshr@ti.com>
 <20200601070444.16923-6-vigneshr@ti.com>
 <6c8d9bff-3a67-0e6c-d4d1-36b7ed5007b9@web.de>
 <8cebd31a-2366-4584-b1d1-faa30c18ed6a@ti.com>
 <dbba9f0c-4621-2d58-8fb8-4cbe788558f9@siemens.com>
In-Reply-To: <dbba9f0c-4621-2d58-8fb8-4cbe788558f9@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcejAwM3YwdXBcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1jODExZWUyMy1lNjgwLTExZWEtYTdiYi00OGJhNGUyOWM1YzBcYW1lLXRlc3RcYzgxMWVlMjUtZTY4MC0xMWVhLWE3YmItNDhiYTRlMjljNWMwYm9keS50eHQiIHN6PSIzNjUwIiB0PSIxMzI0Mjc5ODczODU0NDc1MjQiIGg9ImJ4TUU3bGZuQjZVTnBmbkZwUmxOSFNFRWJ6QT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUhBQUFBQms5RzJLalhyV0FhU2FmQ3MzYnY3RnBKcDhLemR1L3NVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUJBQUFBQVFBQUFBQUFBQUFBQUFBQUFBQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: 
x-document-confidentiality: NotClassified
x-originating-ip: [139.24.108.114]
x-tm-snts-smtp: D8EF412AA5EA5D4009F7606EB488764A96583B18430D5CC3616F788D992CCDA82000:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGVsbG8gSmFuLA0KDQpUaGUgZmxhc2ggb24gb3VyIGJvYXJkIGlzIFdpbmJvbmQgVzI1UTEyOEpW
Lg0KDQpCZXN0IFJlZ2FyZHMsDQpMZSBKaW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IEtpc3prYSwgSmFuIChDVCBSREEgSU9UIFNFUy1ERSkgPGphbi5raXN6a2FAc2llbWVu
cy5jb20+IA0KU2VudDogTW9uZGF5LCBBdWd1c3QgMjQsIDIwMjAgODo0OSBQTQ0KVG86IFZpZ25l
c2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT47IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFt
YmFydXNAbWljcm9jaGlwLmNvbT47IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47IEpp
biwgTGUgKFJDLUNOIERJIEZBIFImRCBTVykgPGxlLmppbkBzaWVtZW5zLmNvbT4NCkNjOiBCb3Jp
cyBCcmV6aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz47IFJhbXV0aGV2YXIgVmFkaXZlbCBN
dXJ1Z2FuIDx2YWRpdmVsLm11cnVnYW54LnJhbXV0aGV2YXJAbGludXguaW50ZWwuY29tPjsgbGlu
dXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IHNpbW9uLmsuci5nb2xkc2NobWlkdEBnbWFpbC5j
b207IGRpbmd1eWVuQGtlcm5lbC5vcmc7IG1hcmV4QGRlbnguZGUNClN1YmplY3Q6IFJlOiBbUkVT
RU5EIFBBVENIIHYzIDUvOF0gbXRkOiBzcGktbm9yOiBjYWRlbmNlLXF1YWRzcGk6IEhhbmRsZSBw
cm9iZSBkZWZlcnJhbCB3aGlsZSByZXF1ZXN0aW5nIERNQSBjaGFubmVsDQoNCk9uIDI0LjA4LjIw
IDEzOjQ1LCBWaWduZXNoIFJhZ2hhdmVuZHJhIHdyb3RlOg0KPiANCj4gDQo+IE9uIDgvMjIvMjAg
MTE6MzUgUE0sIEphbiBLaXN6a2Egd3JvdGU6DQo+PiBPbiAwMS4wNi4yMCAwOTowNCwgVmlnbmVz
aCBSYWdoYXZlbmRyYSB3cm90ZToNCj4+PiBkbWFfcmVxdWVzdF9jaGFuX2J5X21hc2soKSBjYW4g
dGhyb3cgRVBST0JFX0RFRkVSIGlmIERNQSBwcm92aWRlciBpcyANCj4+PiBub3QgeWV0IHByb2Jl
ZC4gQ3VycmVudGx5IGRyaXZlciBqdXN0IGZhbGxzIGJhY2sgdG8gdXNpbmcgUElPIG1vZGUgDQo+
Pj4gKHdoaWNoIGlzIGxlc3MgZWZmaWNpZW50KSBpbiB0aGlzIGNhc2UuIEluc3RlYWQgcmV0dXJu
IHByb2JlIA0KPj4+IGRlZmVycmFsIGVycm9yIGFzIGlzIHNvIHRoYXQgZHJpdmVyIHdpbGwgYmUg
cmUgcHJvYmVkIG9uY2UgRE1BIA0KPj4+IHByb3ZpZGVyIGlzIGF2YWlsYWJsZS4NCj4+Pg0KPj4+
IFNpZ25lZC1vZmYtYnk6IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNvbT4NCj4+
PiBSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29t
Pg0KPj4+IC0tLQ0KPiBbLi4uXQ0KPj4+DQo+Pj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpX25v
cl9jb250cm9sbGVyX29wcyBjcXNwaV9jb250cm9sbGVyX29wcyA9IHsgDQo+Pj4gQEAgLTEyNjks
OCArMTI3NCwxMSBAQCBzdGF0aWMgaW50IGNxc3BpX3NldHVwX2ZsYXNoKHN0cnVjdCBjcXNwaV9z
dCAqY3FzcGksIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApDQo+Pj4gIAkJCWRldl9kYmcobm9yLT5k
ZXYsICJ1c2luZyBkaXJlY3QgbW9kZSBmb3IgJXNcbiIsDQo+Pj4gIAkJCQltdGQtPm5hbWUpOw0K
Pj4+DQo+Pj4gLQkJCWlmICghY3FzcGktPnJ4X2NoYW4pDQo+Pj4gLQkJCQljcXNwaV9yZXF1ZXN0
X21tYXBfZG1hKGNxc3BpKTsNCj4+PiArCQkJaWYgKCFjcXNwaS0+cnhfY2hhbikgew0KPj4+ICsJ
CQkJcmV0ID0gY3FzcGlfcmVxdWVzdF9tbWFwX2RtYShjcXNwaSk7DQo+Pj4gKwkJCQlpZiAocmV0
ID09IC1FUFJPQkVfREVGRVIpDQo+Pj4gKwkJCQkJZ290byBlcnI7DQo+Pj4gKwkJCX0NCj4+PiAg
CQl9DQo+Pj4gIAl9DQo+Pj4NCj4+Pg0KPj4NCj4+IFRoaXMgc2VlbSB0byBicmVhayByZWFkaW5n
IHRoZSBTUEkgZmxhc2ggb24gb3VyIElPVDIwNTAgWzFdIChkaWRuJ3QgDQo+PiB0ZXN0IHRoZSBl
dmFsIGJvYXJkIHlldCkuDQo+Pg0KPj4gV2l0aG91dCB0aGF0IGNvbW1pdCwgcmVhZCBoYXBwZW5z
IHZpYSBQSU8sIGFuZCB0aGF0IHdvcmtzLiBXaXRoIHRoZSANCj4+IGNvbW1pdCwgdGhlIHBhdHRl
cm4NCj4+DQo+PiB3aXRoIG9wZW4oIm91dC5iaW4iLCAid2IiKSBhcyBvdXQ6DQo+PiAgICAgcG9z
ID0gMA0KPj4gICAgIHdoaWxlIHBvcyA8IDI6DQo+PiAgICAgICAgIHdpdGggb3BlbigiL2Rldi9t
dGQwIiwgInJiIikgYXMgbXRkOg0KPj4gICAgICAgICAgICBtdGQuc2Vlayhwb3MgKiAweDEwMDAw
KQ0KPj4gICAgICAgICAgICBvdXQud3JpdGUobXRkLnJlYWQoMHgxMDAwMCkpDQo+PiAgICAgICAg
IHBvcyArPSAxDQo+Pg0KPj4gZ2l2ZXMgdGhlIHdyb25nIHJlc3VsdCBmb3IgdGhlIHNlY29uZCBi
bG9jayB3aGlsZQ0KPiANCj4gSW50ZXJlc3RpbmcuLi4gQ291bGQgeW91IHBsZWFzZSBleHBsYWlu
IHdyb25nIHJlc3VsdD8gSXMgdGhlIGRhdGEgbW92ZSANCj4gYXJvdW5kIG9yIGNvbXBsZXRlbHkg
Z2FyYmFnZT8NCg0KSXQgbG9va3MgbGlrZSBzb21lIHN0cmlwZXMgY29udGFpbiBkYXRhIGZyb20g
b3RoZXIgcGFydHMgb2YgdGhlIGZsYXNoIG9yIGtlcm5lbCBSQU0uIEl0J3Mgbm90IGp1c3QgZ2Fy
YmFnZSwgdGhlcmUgYXJlIHJlYWRhYmxlIHN0cmluZ3MgaW5jbHVkZWQuDQoNCj4gDQo+IERvZXMg
dGhpcyBmYWlsIGV2ZW4gb24gQU02NTQgRVZNPyBDb3VsZCB5b3Ugc2hhcmUgZnVsbCBzY3JpcHQg
Zm9yIG1lIA0KPiB0byB0ZXN0IGxvY2FsbHk/DQoNClRoZSBzY3JpcHRzIGFyZSBjb21wbGV0ZSAo
cHl0aG9uKS4gSnVzdCBiaW5hcnktZGlmZiB0aGUgb3V0cHV0cy4NCg0KSSdsbCB0cnkgb24gdGhl
IEVWTSBsYXRlci4NCg0KPiANCj4gV2hhdCBpcyB0aGUgZmxhc2ggb24gdGhlIGJvYXJkPw0KDQpM
ZSwgY291bGQgeW91IGFuc3dlciB0aGF0IG1vcmUgcHJlY2lzZWx5IHRoYW4gSSBjb3VsZD8NCg0K
VGhhbmtzLA0KSmFuDQoNCj4gDQo+Pg0KPj4gd2l0aCBvcGVuKCJvdXQyLmJpbiIsICJ3YiIpIGFz
IG91dDoNCj4+ICAgICB3aXRoIG9wZW4oIi9kZXYvbXRkMCIsICJyYiIpIGFzIG10ZDoNCj4+ICAg
ICAgICAgb3V0LndyaXRlKG10ZC5yZWFkKDB4MjAwMDApKQ0KPj4NCj4+IChvciAibXRkX2RlYnVn
IHJlYWQiKSBpcyBmaW5lLg0KPj4NCj4+IFdoYXQgY291bGQgYmUgdGhlIHJlYXNvbj8gT3VyIERU
QnMgYW5kIGszLWFtNjU0LWJhc2UtYm9hcmQuZHRiIGhhZCANCj4+IHNvbWUgZGV2aWF0aW9ucyAv
d3J0IHRoZSBvc3BpIG5vZGUsIGJ1dCBhbGlnbmluZyBvdXJzIHRvIHRoZSBiYXNlIA0KPj4gYm9h
cmQgbWFkZSBubyBkaWZmZXJlbmNlLg0KPj4NCj4+IEphbg0KPj4NCj4+IFsxXSBodHRwczovL2dp
dGh1Yi5jb20vc2llbWVucy9saW51eC9jb21taXRzL2phbi9pb3QyMDUwDQo+Pg0KDQotLQ0KU2ll
bWVucyBBRywgQ29ycG9yYXRlIFRlY2hub2xvZ3ksIENUIFJEQSBJT1QgU0VTLURFIENvcnBvcmF0
ZSBDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0K
