Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91CC186C1C
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 14:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbgCPNcE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 09:32:04 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:56302 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbgCPNcE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 09:32:04 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 09:32:02 EDT
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 02D3B67A8D3;
        Mon, 16 Mar 2020 14:23:12 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 16 Mar
 2020 14:23:11 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Mon, 16 Mar 2020 14:23:11 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Anson Huang" <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
CC:     Peng Fan <peng.fan@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] clk: imx8mm: Switch to platform driver
Thread-Topic: [PATCH v2] clk: imx8mm: Switch to platform driver
Thread-Index: AQHV3Nj/eAC8KOmHpke/9mSCMhEqHagN6HgAgD15JoA=
Date:   Mon, 16 Mar 2020 13:23:11 +0000
Message-ID: <9dae8bb7-b1da-28b5-a6e9-42102a5c3be3@kontron.de>
References: <1562682003-20951-1-git-send-email-abel.vesa@nxp.com>
 <2df024c3-ab46-4e33-f961-5ef994aea145@kontron.de>
 <c2a9d048-6a33-f357-ac88-4eb81002fe93@kontron.de>
In-Reply-To: <c2a9d048-6a33-f357-ac88-4eb81002fe93@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <B43B291D1F5AB54E807AB891783DA5B5@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 02D3B67A8D3.AA458
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: abel.vesa@nxp.com, anson.huang@nxp.com,
        fabio.estevam@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, mturquette@baylibre.com, peng.fan@nxp.com,
        ping.bai@nxp.com, sboyd@kernel.org, shawnguo@kernel.org
X-Spam-Status: No
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMDYuMDIuMjAgMTE6MzcsIEZyaWVkZXIgU2NocmVtcGYgd3JvdGU6DQo+IE9uIDA2LjAyLjIw
IDExOjM0LCBTY2hyZW1wZiBGcmllZGVyIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gT24gMDkuMDcu
MTkgMTY6MjAsIEFiZWwgVmVzYSB3cm90ZToNCj4+PiBUaGVyZSBpcyBubyBzdHJvbmcgcmVhc29u
IGZvciB0aGlzIHRvIHVzZSBDTEtfT0ZfREVDTEFSRSBpbnN0ZWFkDQo+Pj4gb2YgYmVpbmcgYSBw
bGF0Zm9ybSBkcml2ZXIuIFBsdXMsIHRoaXMgd2lsbCBub3cgYmUgYWxpZ25lZCB3aXRoIHRoZQ0K
Pj4+IG90aGVyIGkuTVg4TSBjbG9jayBkcml2ZXJzIHdoaWNoIGFyZSBwbGF0Zm9ybSBkcml2ZXJz
Lg0KPj4+DQo+Pj4gSW4gb3JkZXIgdG8gbWFrZSB0aGUgY2xvY2sgcHJvdmlkZXIgYSBwbGF0Zm9y
bSBkcml2ZXINCj4+PiBhbGwgdGhlIGRhdGEgYW5kIGNvZGUgbmVlZHMgdG8gYmUgb3V0c2lkZSBv
ZiAuaW5pdCBzZWN0aW9uLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQWJlbCBWZXNhIDxhYmVs
LnZlc2FAbnhwLmNvbT4NCj4+PiBBY2tlZC1ieTogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwu
b3JnPg0KPj4NCj4+IFRoaXMgaGFzIGJlZW4gdXBzdHJlYW0gZm9yIHF1aXRlIHNvbWUgdGltZSBu
b3csIGJ1dCBzb21laG93IEkgaGF2ZSBhbg0KPj4gaXNzdWUgd2l0aCBTUEkgb24gdGhlIGkuTVg4
TU0gdGhhdCBnZXRzIHJlc29sdmVkIHdoZW4gSSByZXZlcnQgdGhpcyANCj4+IHBhdGNoLg0KPj4N
Cj4+IFdoZW4gSSB0cnkgdG8gcHJvYmUgYW4gU1BJIE5PUiBmbGFzaCB3aXRoIGxhdGVzdCA1LjQg
b3IgZXZlbiA1LjU6DQo+Pg0KPj4gwqDCoMKgwqBzcGlfaW14IDMwODIwMDAwLnNwaTogZG1hIHNl
dHVwIGVycm9yIC0xOSwgdXNlIHBpbw0KPj4gwqDCoMKgwqBzcGktbm9yIHNwaTAuMDogdW5yZWNv
Z25pemVkIEpFREVDIGlkIGJ5dGVzOiAwMCAwMCAwMCAwMCAwMCAwMA0KPj4gwqDCoMKgwqBzcGlf
aW14IDMwODIwMDAwLnNwaTogcHJvYmVkDQo+Pg0KPj4gV2hlbiBJIHJldmVydCB0aGlzIHBhdGNo
Og0KPj4NCj4+IMKgwqDCoMKgc3BpX2lteCAzMDgyMDAwMC5zcGk6IGRtYSBzZXR1cCBlcnJvciAt
MTksIHVzZSBwaW8NCj4+IMKgwqDCoMKgc3BpLW5vciBzcGkwLjA6IG14MjVyMTYzNWYgKDIwNDgg
S2J5dGVzKQ0KPj4gwqDCoMKgwqBzcGlfaW14IDMwODIwMDAwLnNwaTogcHJvYmVkDQo+Pg0KPj4g
UGxlYXNlIG5vdGUsIHRoYXQgaW4gYm90aCBjYXNlcyBJIGhhdmUgZGlzYWJsZWQgRE1BLCBhcyB0
aGlzIGNhdXNlcyBldmVuDQo+PiBtb3JlIHRyb3VibGUgKHNlZSBbMV0pLiBCdXQgZXZlbiB3aXRo
IERNQSBlbmFibGVkIGFuZCBpZ25vcmluZyB0aGUgRE1BDQo+PiBlcnJvcnMsIHRoZSBpc3N1ZSBk
ZXNjcmliZWQgYWJvdmUgb2NjdXJzLg0KPj4NCj4+IERvZXMgc29tZW9uZSBoYXZlIGFuIGlkZWEg
d2hhdCdzIHdyb25nPw0KPj4gQW0gSSB0aGUgb25seSB1c2VyIG9mIFNQSSBvbiBpLk1YOE1NIGFz
IHRoaXMgaXNzdWUgc2VlbXMgdG8gZXhpc3QNCj4+IHVwc3RyZWFtIHNpbmNlIHY1LjQtcmMxPw0K
DQpUaGlzIGlzc3VlIHN0aWxsIHBlcnNpc3RzIGluIHY1LjYtcmM2LiBDYW4gc29tZW9uZSBwbGVh
c2UgaGF2ZSBhIGxvb2s/DQoNClRoYW5rcywNCkZyaWVkZXINCg0KPiANCj4gU29ycnkgZm9yZ290
IHRoZSBsaW5rOg0KPiANCj4gWzFdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsv
cGF0Y2gvMTA4NjQ1OS8NCj4gDQo+Pg0KPj4+IC0tLQ0KPj4+DQo+Pj4gQ2hhbmdlcyBzaW5jZSB2
MToNCj4+PiDCoMKgICogU3dpdGNoZWQgdG8gcGxhdGZvcm0gZHJpdmVyIG1lbW9yeSBtYXBwaW5n
IEFQSQ0KPj4+IMKgwqAgKiBSZW1vdmVkIGV4dHJhIG5ld2xpbmUNCj4+PiDCoMKgICogQWRkZWQg
YW4gZXhwbGFuYXRpb24gb2Ygd2h5IHRoaXMgY2hhbmdlIGlzIGRvbmUNCj4+PiDCoMKgwqDCoCBp
biB0aGUgY29tbWl0IG1lc3NhZ2UNCj4+Pg0KPj4+IMKgwqAgZHJpdmVycy9jbGsvaW14L2Nsay1p
bXg4bW0uYyB8IDU3IA0KPj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tDQo+Pj4gwqDCoCAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMjEgZGVs
ZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4
bW0uYyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1tLmMNCj4+PiBpbmRleCA2YjhlNzVkLi43
YThlNzEzIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1tLmMNCj4+
PiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbS5jDQo+Pj4gQEAgLTY4LDQzICs2OCw0
MyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9wbGwxNHh4X3JhdGVfdGFibGUgDQo+Pj4gaW14
OG1tX2RyYW1wbGxfdGJsW10gPSB7DQo+Pj4gwqDCoMKgwqDCoMKgIFBMTF8xNDQzWF9SQVRFKDY1
MDAwMDAwMFUsIDMyNSwgMywgMiwgMCksDQo+Pj4gwqDCoCB9Ow0KPj4+IC1zdGF0aWMgc3RydWN0
IGlteF9wbGwxNHh4X2NsayBpbXg4bW1fYXVkaW9fcGxsIF9faW5pdGRhdGEgPSB7DQo+Pj4gK3N0
YXRpYyBzdHJ1Y3QgaW14X3BsbDE0eHhfY2xrIGlteDhtbV9hdWRpb19wbGwgPSB7DQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLnR5cGUgPSBQTExfMTQ0M1gsDQo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLnJhdGVfdGFibGUgPSBpbXg4bW1fYXVkaW9wbGxfdGJsLA0KPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC5yYXRlX2NvdW50ID0gQVJSQVlfU0laRShpbXg4bW1fYXVkaW9wbGxfdGJsKSwN
Cj4+PiDCoMKgIH07DQo+Pj4gLXN0YXRpYyBzdHJ1Y3QgaW14X3BsbDE0eHhfY2xrIGlteDhtbV92
aWRlb19wbGwgX19pbml0ZGF0YSA9IHsNCj4+PiArc3RhdGljIHN0cnVjdCBpbXhfcGxsMTR4eF9j
bGsgaW14OG1tX3ZpZGVvX3BsbCA9IHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAudHlwZSA9
IFBMTF8xNDQzWCwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucmF0ZV90YWJsZSA9IGlteDht
bV92aWRlb3BsbF90YmwsDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnJhdGVfY291bnQgPSBB
UlJBWV9TSVpFKGlteDhtbV92aWRlb3BsbF90YmwpLA0KPj4+IMKgwqAgfTsNCj4+PiAtc3RhdGlj
IHN0cnVjdCBpbXhfcGxsMTR4eF9jbGsgaW14OG1tX2RyYW1fcGxsIF9faW5pdGRhdGEgPSB7DQo+
Pj4gK3N0YXRpYyBzdHJ1Y3QgaW14X3BsbDE0eHhfY2xrIGlteDhtbV9kcmFtX3BsbCA9IHsNCj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAudHlwZSA9IFBMTF8xNDQzWCwNCj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAucmF0ZV90YWJsZSA9IGlteDhtbV9kcmFtcGxsX3RibCwNCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAucmF0ZV9jb3VudCA9IEFSUkFZX1NJWkUoaW14OG1tX2RyYW1wbGxfdGJs
KSwNCj4+PiDCoMKgIH07DQo+Pj4gLXN0YXRpYyBzdHJ1Y3QgaW14X3BsbDE0eHhfY2xrIGlteDht
bV9hcm1fcGxsIF9faW5pdGRhdGEgPSB7DQo+Pj4gK3N0YXRpYyBzdHJ1Y3QgaW14X3BsbDE0eHhf
Y2xrIGlteDhtbV9hcm1fcGxsID0gew0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC50eXBlID0g
UExMXzE0MTZYLA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5yYXRlX3RhYmxlID0gaW14OG1t
X3BsbDE0MTZ4X3RibCwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucmF0ZV9jb3VudCA9IEFS
UkFZX1NJWkUoaW14OG1tX3BsbDE0MTZ4X3RibCksDQo+Pj4gwqDCoCB9Ow0KPj4+IC1zdGF0aWMg
c3RydWN0IGlteF9wbGwxNHh4X2NsayBpbXg4bW1fZ3B1X3BsbCBfX2luaXRkYXRhID0gew0KPj4+
ICtzdGF0aWMgc3RydWN0IGlteF9wbGwxNHh4X2NsayBpbXg4bW1fZ3B1X3BsbCA9IHsNCj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAudHlwZSA9IFBMTF8xNDE2WCwNCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAucmF0ZV90YWJsZSA9IGlteDhtbV9wbGwxNDE2eF90YmwsDQo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLnJhdGVfY291bnQgPSBBUlJBWV9TSVpFKGlteDhtbV9wbGwxNDE2eF90Ymwp
LA0KPj4+IMKgwqAgfTsNCj4+PiAtc3RhdGljIHN0cnVjdCBpbXhfcGxsMTR4eF9jbGsgaW14OG1t
X3ZwdV9wbGwgX19pbml0ZGF0YSA9IHsNCj4+PiArc3RhdGljIHN0cnVjdCBpbXhfcGxsMTR4eF9j
bGsgaW14OG1tX3ZwdV9wbGwgPSB7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnR5cGUgPSBQ
TExfMTQxNlgsDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnJhdGVfdGFibGUgPSBpbXg4bW1f
cGxsMTQxNnhfdGJsLA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5yYXRlX2NvdW50ID0gQVJS
QVlfU0laRShpbXg4bW1fcGxsMTQxNnhfdGJsKSwNCj4+PiDCoMKgIH07DQo+Pj4gLXN0YXRpYyBz
dHJ1Y3QgaW14X3BsbDE0eHhfY2xrIGlteDhtbV9zeXNfcGxsIF9faW5pdGRhdGEgPSB7DQo+Pj4g
K3N0YXRpYyBzdHJ1Y3QgaW14X3BsbDE0eHhfY2xrIGlteDhtbV9zeXNfcGxsID0gew0KPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC50eXBlID0gUExMXzE0MTZYLA0KPj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC5yYXRlX3RhYmxlID0gaW14OG1tX3BsbDE0MTZ4X3RibCwNCj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAucmF0ZV9jb3VudCA9IEFSUkFZX1NJWkUoaW14OG1tX3BsbDE0MTZ4X3RibCks
DQo+Pj4gQEAgLTM3NCw3ICszNzQsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqaW14OG1tX2Nsa28x
X3NlbHNbXSA9IA0KPj4+IHsib3NjXzI0bSIsICJzeXNfcGxsMV84MDBtIiwgIm9zY18yN20iLA0K
Pj4+IMKgwqAgc3RhdGljIHN0cnVjdCBjbGsgKmNsa3NbSU1YOE1NX0NMS19FTkRdOw0KPj4+IMKg
wqAgc3RhdGljIHN0cnVjdCBjbGtfb25lY2VsbF9kYXRhIGNsa19kYXRhOw0KPj4+IC1zdGF0aWMg
c3RydWN0IGNsayAqKiBjb25zdCB1YXJ0X2Nsa3NbXSBfX2luaXRjb25zdCA9IHsNCj4+PiArc3Rh
dGljIHN0cnVjdCBjbGsgKiogY29uc3QgdWFydF9jbGtzW10gPSB7DQo+Pj4gwqDCoMKgwqDCoMKg
ICZjbGtzW0lNWDhNTV9DTEtfVUFSVDFfUk9PVF0sDQo+Pj4gwqDCoMKgwqDCoMKgICZjbGtzW0lN
WDhNTV9DTEtfVUFSVDJfUk9PVF0sDQo+Pj4gwqDCoMKgwqDCoMKgICZjbGtzW0lNWDhNTV9DTEtf
VUFSVDNfUk9PVF0sDQo+Pj4gQEAgLTM4MiwxOSArMzgyLDIwIEBAIHN0YXRpYyBzdHJ1Y3QgY2xr
ICoqIGNvbnN0IHVhcnRfY2xrc1tdIA0KPj4+IF9faW5pdGNvbnN0ID0gew0KPj4+IMKgwqDCoMKg
wqDCoCBOVUxMDQo+Pj4gwqDCoCB9Ow0KPj4+IC1zdGF0aWMgaW50IF9faW5pdCBpbXg4bW1fY2xv
Y2tzX2luaXQoc3RydWN0IGRldmljZV9ub2RlICpjY21fbm9kZSkNCj4+PiArc3RhdGljIGludCBp
bXg4bW1fY2xvY2tzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+Pj4gwqDC
oCB7DQo+Pj4gLcKgwqDCoCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPj4+ICvCoMKgwqAgc3Ry
dWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4+PiArwqDCoMKgIHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnAgPSBkZXYtPm9mX25vZGU7DQo+Pj4gwqDCoMKgwqDCoMKgIHZvaWQgX19pb21lbSAq
YmFzZTsNCj4+PiDCoMKgwqDCoMKgwqAgaW50IHJldDsNCj4+PiDCoMKgwqDCoMKgwqAgY2xrc1tJ
TVg4TU1fQ0xLX0RVTU1ZXSA9IGlteF9jbGtfZml4ZWQoImR1bW15IiwgMCk7DQo+Pj4gLcKgwqDC
oCBjbGtzW0lNWDhNTV9DTEtfMjRNXSA9IG9mX2Nsa19nZXRfYnlfbmFtZShjY21fbm9kZSwgIm9z
Y18yNG0iKTsNCj4+PiAtwqDCoMKgIGNsa3NbSU1YOE1NX0NMS18zMktdID0gb2ZfY2xrX2dldF9i
eV9uYW1lKGNjbV9ub2RlLCAib3NjXzMyayIpOw0KPj4+IC3CoMKgwqAgY2xrc1tJTVg4TU1fQ0xL
X0VYVDFdID0gb2ZfY2xrX2dldF9ieV9uYW1lKGNjbV9ub2RlLCAiY2xrX2V4dDEiKTsNCj4+PiAt
wqDCoMKgIGNsa3NbSU1YOE1NX0NMS19FWFQyXSA9IG9mX2Nsa19nZXRfYnlfbmFtZShjY21fbm9k
ZSwgImNsa19leHQyIik7DQo+Pj4gLcKgwqDCoCBjbGtzW0lNWDhNTV9DTEtfRVhUM10gPSBvZl9j
bGtfZ2V0X2J5X25hbWUoY2NtX25vZGUsICJjbGtfZXh0MyIpOw0KPj4+IC3CoMKgwqAgY2xrc1tJ
TVg4TU1fQ0xLX0VYVDRdID0gb2ZfY2xrX2dldF9ieV9uYW1lKGNjbV9ub2RlLCAiY2xrX2V4dDQi
KTsNCj4+PiArwqDCoMKgIGNsa3NbSU1YOE1NX0NMS18yNE1dID0gb2ZfY2xrX2dldF9ieV9uYW1l
KG5wLCAib3NjXzI0bSIpOw0KPj4+ICvCoMKgwqAgY2xrc1tJTVg4TU1fQ0xLXzMyS10gPSBvZl9j
bGtfZ2V0X2J5X25hbWUobnAsICJvc2NfMzJrIik7DQo+Pj4gK8KgwqDCoCBjbGtzW0lNWDhNTV9D
TEtfRVhUMV0gPSBvZl9jbGtfZ2V0X2J5X25hbWUobnAsICJjbGtfZXh0MSIpOw0KPj4+ICvCoMKg
wqAgY2xrc1tJTVg4TU1fQ0xLX0VYVDJdID0gb2ZfY2xrX2dldF9ieV9uYW1lKG5wLCAiY2xrX2V4
dDIiKTsNCj4+PiArwqDCoMKgIGNsa3NbSU1YOE1NX0NMS19FWFQzXSA9IG9mX2Nsa19nZXRfYnlf
bmFtZShucCwgImNsa19leHQzIik7DQo+Pj4gK8KgwqDCoCBjbGtzW0lNWDhNTV9DTEtfRVhUNF0g
PSBvZl9jbGtfZ2V0X2J5X25hbWUobnAsICJjbGtfZXh0NCIpOw0KPj4+IMKgwqDCoMKgwqDCoCBu
cCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJmc2wsaW14OG1tLWFuYXRv
cCIpOw0KPj4+IMKgwqDCoMKgwqDCoCBiYXNlID0gb2ZfaW9tYXAobnAsIDApOw0KPj4+IEBAIC00
ODAsMTAgKzQ4MSwxMCBAQCBzdGF0aWMgaW50IF9faW5pdCBpbXg4bW1fY2xvY2tzX2luaXQoc3Ry
dWN0IA0KPj4+IGRldmljZV9ub2RlICpjY21fbm9kZSkNCj4+PiDCoMKgwqDCoMKgwqAgY2xrc1tJ
TVg4TU1fU1lTX1BMTDJfNTAwTV0gPSANCj4+PiBpbXhfY2xrX2ZpeGVkX2ZhY3Rvcigic3lzX3Bs
bDJfNTAwbSIsICJzeXNfcGxsMl9vdXQiLCAxLCAyKTsNCj4+PiDCoMKgwqDCoMKgwqAgY2xrc1tJ
TVg4TU1fU1lTX1BMTDJfMTAwME1dID0gDQo+Pj4gaW14X2Nsa19maXhlZF9mYWN0b3IoInN5c19w
bGwyXzEwMDBtIiwgInN5c19wbGwyX291dCIsIDEsIDEpOw0KPj4+IC3CoMKgwqAgbnAgPSBjY21f
bm9kZTsNCj4+PiAtwqDCoMKgIGJhc2UgPSBvZl9pb21hcChucCwgMCk7DQo+Pj4gLcKgwqDCoCBp
ZiAoV0FSTl9PTighYmFzZSkpDQo+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOw0K
Pj4+ICvCoMKgwqAgbnAgPSBkZXYtPm9mX25vZGU7DQo+Pj4gK8KgwqDCoCBiYXNlID0gZGV2bV9w
bGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPj4+ICvCoMKgwqAgaWYgKFdBUk5f
T04oSVNfRVJSKGJhc2UpKSkNCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIoYmFz
ZSk7DQo+Pj4gwqDCoMKgwqDCoMKgIC8qIENvcmUgU2xpY2UgKi8NCj4+PiDCoMKgwqDCoMKgwqAg
Y2xrc1tJTVg4TU1fQ0xLX0E1M19TUkNdID0gaW14X2Nsa19tdXgyKCJhcm1fYTUzX3NyYyIsIGJh
c2UgKyANCj4+PiAweDgwMDAsIDI0LCAzLCBpbXg4bW1fYTUzX3NlbHMsIEFSUkFZX1NJWkUoaW14
OG1tX2E1M19zZWxzKSk7DQo+Pj4gQEAgLTY4Miw0ICs2ODMsMTggQEAgc3RhdGljIGludCBfX2lu
aXQgaW14OG1tX2Nsb2Nrc19pbml0KHN0cnVjdCANCj4+PiBkZXZpY2Vfbm9kZSAqY2NtX25vZGUp
DQo+Pj4gwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPj4+IMKgwqAgfQ0KPj4+IC1DTEtfT0ZfREVD
TEFSRV9EUklWRVIoaW14OG1tLCAiZnNsLGlteDhtbS1jY20iLCBpbXg4bW1fY2xvY2tzX2luaXQp
Ow0KPj4+ICsNCj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgaW14OG1tX2Ns
a19vZl9tYXRjaFtdID0gew0KPj4+ICvCoMKgwqAgeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OG1t
LWNjbSIgfSwNCj4+PiArwqDCoMKgIHsgLyogU2VudGluZWwgKi8gfSwNCj4+PiArfTsNCj4+PiAr
TU9EVUxFX0RFVklDRV9UQUJMRShvZiwgaW14OG1tX2Nsa19vZl9tYXRjaCk7DQo+Pj4gKw0KPj4+
ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBpbXg4bW1fY2xrX2RyaXZlciA9IHsNCj4+
PiArwqDCoMKgIC5wcm9iZSA9IGlteDhtbV9jbG9ja3NfcHJvYmUsDQo+Pj4gK8KgwqDCoCAuZHJp
dmVyID0gew0KPj4+ICvCoMKgwqDCoMKgwqDCoCAubmFtZSA9ICJpbXg4bW0tY2NtIiwNCj4+PiAr
wqDCoMKgwqDCoMKgwqAgLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKGlteDhtbV9jbGtf
b2ZfbWF0Y2gpLA0KPj4+ICvCoMKgwqAgfSwNCj4+PiArfTsNCj4+PiArbW9kdWxlX3BsYXRmb3Jt
X2RyaXZlcihpbXg4bW1fY2xrX2RyaXZlcik7DQo+Pj4NCj4+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+PiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdA0KPj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+PiBodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCj4+
