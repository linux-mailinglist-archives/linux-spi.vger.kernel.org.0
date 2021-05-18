Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B88C387006
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 04:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbhERCtc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 22:49:32 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:33506 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346261AbhERCt3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 May 2021 22:49:29 -0400
Received: from twhfm1p2.macronix.com (twhfmlp2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 14I2laUE098161;
        Tue, 18 May 2021 10:47:36 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id B9839244289B2471891F;
        Tue, 18 May 2021 10:47:36 +0800 (CST)
In-Reply-To: <20210517160628.s65h6prjt5mw6bud@ti.com>
References: <1621232088-12567-1-git-send-email-zhengxunli@mxic.com.tw> <1621232088-12567-3-git-send-email-zhengxunli@mxic.com.tw> <20210517160628.s65h6prjt5mw6bud@ti.com>
To:     "Pratyush Yadav" <p.yadav@ti.com>
Cc:     broonie@kernel.org, jaimeliao@mxic.com.tw,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        miquel.raynal@bootlin.com, tudor.ambarus@microchip.com
Subject: Re: [PATCH v5 2/2] spi: mxic: patch for octal DTR mode support
MIME-Version: 1.0
X-KeepSent: 3240723E:EAE563CF-482586D9:000E8308;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP6 SHF907 April 26, 2018
Message-ID: <OF3240723E.EAE563CF-ON482586D9.000E8308-482586D9.000F5865@mxic.com.tw>
From:   zhengxunli@mxic.com.tw
Date:   Tue, 18 May 2021 10:47:36 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2021/05/18 AM 10:47:36,
        Serialize complete at 2021/05/18 AM 10:47:36
Content-Type: text/plain; charset="Big5"
Content-Transfer-Encoding: base64
X-MAIL: TWHMLLG4.macronix.com 14I2laUE098161
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


SGksDQoNCiJQcmF0eXVzaCBZYWRhdiIgPHAueWFkYXZAdGkuY29tPiB3cm90ZSBvbiAyMDIxLzA1
LzE4IKRXpMggMTI6MDY6MzA6DQoNCj4gIlByYXR5dXNoIFlhZGF2IiA8cC55YWRhdkB0aS5jb20+
IA0KPiAyMDIxLzA1LzE4IKRXpMggMTI6MDYNCj4gDQo+IFRvDQo+IA0KPiAiWmhlbmd4dW4gTGki
IDx6aGVuZ3h1bmxpQG14aWMuY29tLnR3PiwgDQo+IA0KPiBjYw0KPiANCj4gPGxpbnV4LW10ZEBs
aXN0cy5pbmZyYWRlYWQub3JnPiwgPGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc+LCANCj4gPHR1
ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4sIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPiwg
DQo+IDxicm9vbmllQGtlcm5lbC5vcmc+LCA8amFpbWVsaWFvQG14aWMuY29tLnR3Pg0KPiANCj4g
U3ViamVjdA0KPiANCj4gUmU6IFtQQVRDSCB2NSAyLzJdIHNwaTogbXhpYzogcGF0Y2ggZm9yIG9j
dGFsIERUUiBtb2RlIHN1cHBvcnQNCj4gDQo+IE9uIDE3LzA1LzIxIDAyOjE0UE0sIFpoZW5neHVu
IExpIHdyb3RlOg0KPiA+IERyaXZlciBwYXRjaCBmb3Igb2N0YWwgRFRSIG1vZGUgc3VwcG9ydC4N
Cj4gPiANCj4gPiBPd2luZyB0byB0aGUgc3BpX21lbV9kZWZhdWx0X3N1cHBvcnRzX29wKCkgaXMg
bm90IHN1cHBvcnQgZHRyDQo+ID4gb3BlcmF0aW9uLiBCYXNlZCBvbiBQcmF0eXVzaCBwYXRjaCAi
c3BpOiBzcGktbWVtOiBhZGQgc3BpX21lbV9kdHINCj4gDQo+IEkgZG9uJ3QgbGlrZSB0aGUgIkJh
c2VkIG9uIFByYXR5dXNoIHBhdGNoIi4gUGxlYXNlIG1lbnRpb24gdGhlIGNvbW1pdCANCj4gaGFz
aCBzbyBpdCBpcyBtdWNoIGVhc2llciB0byBmaW5kIGxhdGVyLiBGb3IgZXhhbXBsZSwgc2F5aW5n
IGJhc2VkIG9uIA0KPiBjb21taXQgNTM5Y2Y2OGNkNTFiIChzcGk6IHNwaS1tZW06IGFkZCBzcGlf
bWVtX2R0cl9zdXBwb3J0c19vcCgpLCANCj4gMjAyMS0wMi0wNCkgaXMgbXVjaCBiZXR0ZXIuDQo+
IA0KPiBCdXQgd2hpbGUgd2UgYXJlIG9uIHRoaXMgdG9waWMsIEkgZG9uJ3QgdGhpbmsgaXQgaXMg
bmVlZGVkIGFsbCB0aGF0IA0KPiBtdWNoLiBQZW9wbGUgdXNlIHByZS1leGlzdGluZyBBUElzIGFs
bCB0aGUgdGltZS4gSSBkb24ndCBzZWUgYW55IG5lZWQgdG8gDQoNCj4gc3BlY2lmaWNhbGx5IHBv
aW50IGl0IG91dC4gIFNvIEkgdGhpbmsgc2F5aW5nICJDYWxsIA0KPiBzcGlfbWVtX2R0cl9zdXBw
b3J0c19vcCgpIHRvIC4uLiIgaXMgYmV0dGVyLg0KDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlv
bi4NCiANCj4gPiBfc3VwcG9ydHNfb3AoKSIgYWRkIHNwaV9tZW1fZHRyX3N1cHBvcnRzX29wKCkg
dG8gc3VwcG9ydCBkdHIgYW5kDQo+ID4ga2VlcCBjaGVja2luZyB0aGUgYnVzd2lkdGggYW5kIGNv
bW1hbmQgYnl0ZXMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWmhlbmd4dW4gTGkgPHpoZW5n
eHVubGlAbXhpYy5jb20udHc+DQo+ID4gLS0tDQoNClRoYW5rcywNClpoZW5neHVuDQoNCg0KQ09O
RklERU5USUFMSVRZIE5PVEU6DQoNClRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5
IGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIA0KYW5kL29yIHBlcnNvbmFsIGRhdGEs
IHdoaWNoIGlzIHByb3RlY3RlZCBieSBhcHBsaWNhYmxlIGxhd3MuIFBsZWFzZSBiZSANCnJlbWlu
ZGVkIHRoYXQgZHVwbGljYXRpb24sIGRpc2Nsb3N1cmUsIGRpc3RyaWJ1dGlvbiwgb3IgdXNlIG9m
IHRoaXMgZS1tYWlsIA0KKGFuZC9vciBpdHMgYXR0YWNobWVudHMpIG9yIGFueSBwYXJ0IHRoZXJl
b2YgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgDQp0aGlzIGUtbWFpbCBpbiBlcnJvciwg
cGxlYXNlIG5vdGlmeSB1cyBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIHRoaXMgbWFpbCBhcyANCndl
bGwgYXMgaXRzIGF0dGFjaG1lbnQocykgZnJvbSB5b3VyIHN5c3RlbS4gSW4gYWRkaXRpb24sIHBs
ZWFzZSBiZSANCmluZm9ybWVkIHRoYXQgY29sbGVjdGlvbiwgcHJvY2Vzc2luZywgYW5kL29yIHVz
ZSBvZiBwZXJzb25hbCBkYXRhIGlzIA0KcHJvaGliaXRlZCB1bmxlc3MgZXhwcmVzc2x5IHBlcm1p
dHRlZCBieSBwZXJzb25hbCBkYXRhIHByb3RlY3Rpb24gbGF3cy4gDQpUaGFuayB5b3UgZm9yIHlv
dXIgYXR0ZW50aW9uIGFuZCBjb29wZXJhdGlvbi4NCg0KTWFjcm9uaXggSW50ZXJuYXRpb25hbCBD
by4sIEx0ZC4NCg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQoNCg0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoNCkNP
TkZJREVOVElBTElUWSBOT1RFOg0KDQpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1h
eSBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBhbmQvb3IgcGVyc29uYWwgZGF0YSwg
d2hpY2ggaXMgcHJvdGVjdGVkIGJ5IGFwcGxpY2FibGUgbGF3cy4gUGxlYXNlIGJlIHJlbWluZGVk
IHRoYXQgZHVwbGljYXRpb24sIGRpc2Nsb3N1cmUsIGRpc3RyaWJ1dGlvbiwgb3IgdXNlIG9mIHRo
aXMgZS1tYWlsIChhbmQvb3IgaXRzIGF0dGFjaG1lbnRzKSBvciBhbnkgcGFydCB0aGVyZW9mIGlz
IHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ug
bm90aWZ5IHVzIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgdGhpcyBtYWlsIGFzIHdlbGwgYXMgaXRz
IGF0dGFjaG1lbnQocykgZnJvbSB5b3VyIHN5c3RlbS4gSW4gYWRkaXRpb24sIHBsZWFzZSBiZSBp
bmZvcm1lZCB0aGF0IGNvbGxlY3Rpb24sIHByb2Nlc3NpbmcsIGFuZC9vciB1c2Ugb2YgcGVyc29u
YWwgZGF0YSBpcyBwcm9oaWJpdGVkIHVubGVzcyBleHByZXNzbHkgcGVybWl0dGVkIGJ5IHBlcnNv
bmFsIGRhdGEgcHJvdGVjdGlvbiBsYXdzLiBUaGFuayB5b3UgZm9yIHlvdXIgYXR0ZW50aW9uIGFu
ZCBjb29wZXJhdGlvbi4NCg0KTWFjcm9uaXggSW50ZXJuYXRpb25hbCBDby4sIEx0ZC4NCg0KPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQo=

