Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32413B7021
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhF2JgL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 05:36:11 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:60307 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhF2JgL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Jun 2021 05:36:11 -0400
Received: from twhfm1p2.macronix.com (twhfmlp2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 15T9XGuc013926;
        Tue, 29 Jun 2021 17:33:16 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 55299B94918F0AE99BFE;
        Tue, 29 Jun 2021 17:33:17 +0800 (CST)
In-Reply-To: <59855ba0-31d8-25b4-3000-ca493a83fe00@microchip.com>
References: <1621232088-12567-1-git-send-email-zhengxunli@mxic.com.tw> <1621232088-12567-2-git-send-email-zhengxunli@mxic.com.tw> <59855ba0-31d8-25b4-3000-ca493a83fe00@microchip.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     broonie@kernel.org, jaimeliao@mxic.com.tw,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        miquel.raynal@bootlin.com, p.yadav@ti.com
Subject: Re: [PATCH v5 1/2] mtd: spi-nor: macronix: add support for Macronix
 octaflash
MIME-Version: 1.0
X-KeepSent: 0F03D74E:5813696B-48258703:003378F0;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP6 SHF907 April 26, 2018
Message-ID: <OF0F03D74E.5813696B-ON48258703.003378F0-48258703.00347C73@mxic.com.tw>
From:   zhengxunli@mxic.com.tw
Date:   Tue, 29 Jun 2021 17:33:17 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2021/06/29 PM 05:33:17,
        Serialize complete at 2021/06/29 PM 05:33:17
Content-Type: text/plain; charset="Big5"
Content-Transfer-Encoding: base64
X-MAIL: TWHMLLG4.macronix.com 15T9XGuc013926
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


SGkgVHVkb3IsDQoNCjxUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20+IHdyb3RlIG9uIDIwMjEv
MDYvMjkgpFWkyCAwMjozNzowMToNCg0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiAN
Cj4gMjAyMS8wNi8yOSCkVaTIIDAyOjM3DQo+IA0KPiBUbw0KPiANCj4gPHpoZW5neHVubGlAbXhp
Yy5jb20udHc+LCA8bGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc+LCA8bGludXgtDQo+IHNw
aUB2Z2VyLmtlcm5lbC5vcmc+LCANCj4gDQo+IGNjDQo+IA0KPiA8cC55YWRhdkB0aS5jb20+LCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4sIDxicm9vbmllQGtlcm5lbC5vcmc+LA0KPiA8amFp
bWVsaWFvQG14aWMuY29tLnR3Pg0KPiANCj4gU3ViamVjdA0KPiANCj4gUmU6IFtQQVRDSCB2NSAx
LzJdIG10ZDogc3BpLW5vcjogbWFjcm9uaXg6IGFkZCBzdXBwb3J0IGZvciBNYWNyb25peCANCm9j
dGFmbGFzaA0KPiANCj4gT24gNS8xNy8yMSA5OjE0IEFNLCBaaGVuZ3h1biBMaSB3cm90ZToNCj4g
PiArICAgICAgIHsgIm14NjZsbTFnNDVnIiwgSU5GTygweGMyODUzYiwgMCwgMzIgKiAxMDI0LCA0
MDk2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNFQ1RfNEsgfCBTUElfTk9S
X09DVEFMX0RUUl9SRUFEIHwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElf
Tk9SX09DVEFMX0RUUl9QUCB8IA0KU1BJX05PUl80Ql9PUENPREVTKQ0KPiA+ICsgICAgICAgICAg
ICAgICAuZml4dXBzID0gJm9jdGFmbGFzaF9maXh1cHMgfSwNCj4gDQo+IEkgaGF2ZSBhIG14NjZs
bTFnNDVnIHdoaWNoIGRvZXMgbm90IGRlZmluZSBTRkRQIHRhYmxlcywgaG93IHlvdSdsbCANCj4g
ZGlmZmVyZW50aWF0ZQ0KPiBiZXR3ZWVuIHRoZSB0d28/IA0KPiBNaW5lIHdpbGwgZmFpbCBhZnRl
ciByZXNldC4gSSdtIHdvcmtpbmcgdG8gYWRkcmVzcyANCj4gdGhlIGZsYXNoIElEDQo+IGNvbGxp
c2lvbnMsIHdpbGwgc2VuZCBwYXRjaGVzIHNvb24uIEkgd29uJ3QgcXVldWUgYW55IG5ldyBmbGFz
aCANCj4gYWRkaXRpb25zIHVudGlsDQo+IHdlJ2xsIHNvbHZlIHRoZSBJRCBjb2xsaXNpb25zIHBy
b2JsZW0uDQoNClNvcnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZS4gSSB3aWxsIGRpc2N1c3Mgd2l0
aCBvdXIgZmxhc2ggdGVhbSBhcyBzb29uIGFzIA0KcG9zc2libGUuDQoNClRoYW5rcywNClpoZW5n
eHVuDQoNCg0KDQoNCkNPTkZJREVOVElBTElUWSBOT1RFOg0KDQpUaGlzIGUtbWFpbCBhbmQgYW55
IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiANCmFuZC9v
ciBwZXJzb25hbCBkYXRhLCB3aGljaCBpcyBwcm90ZWN0ZWQgYnkgYXBwbGljYWJsZSBsYXdzLiBQ
bGVhc2UgYmUgDQpyZW1pbmRlZCB0aGF0IGR1cGxpY2F0aW9uLCBkaXNjbG9zdXJlLCBkaXN0cmli
dXRpb24sIG9yIHVzZSBvZiB0aGlzIGUtbWFpbCANCihhbmQvb3IgaXRzIGF0dGFjaG1lbnRzKSBv
ciBhbnkgcGFydCB0aGVyZW9mIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIA0KdGhpcyBl
LW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdXMgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSB0
aGlzIG1haWwgYXMgDQp3ZWxsIGFzIGl0cyBhdHRhY2htZW50KHMpIGZyb20geW91ciBzeXN0ZW0u
IEluIGFkZGl0aW9uLCBwbGVhc2UgYmUgDQppbmZvcm1lZCB0aGF0IGNvbGxlY3Rpb24sIHByb2Nl
c3NpbmcsIGFuZC9vciB1c2Ugb2YgcGVyc29uYWwgZGF0YSBpcyANCnByb2hpYml0ZWQgdW5sZXNz
IGV4cHJlc3NseSBwZXJtaXR0ZWQgYnkgcGVyc29uYWwgZGF0YSBwcm90ZWN0aW9uIGxhd3MuIA0K
VGhhbmsgeW91IGZvciB5b3VyIGF0dGVudGlvbiBhbmQgY29vcGVyYXRpb24uDQoNCk1hY3Jvbml4
IEludGVybmF0aW9uYWwgQ28uLCBMdGQuDQoNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KDQoNCg0KPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KDQpDT05GSURFTlRJQUxJVFkgTk9URToNCg0KVGhpcyBlLW1haWwgYW5kIGFu
eSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gYW5kL29y
IHBlcnNvbmFsIGRhdGEsIHdoaWNoIGlzIHByb3RlY3RlZCBieSBhcHBsaWNhYmxlIGxhd3MuIFBs
ZWFzZSBiZSByZW1pbmRlZCB0aGF0IGR1cGxpY2F0aW9uLCBkaXNjbG9zdXJlLCBkaXN0cmlidXRp
b24sIG9yIHVzZSBvZiB0aGlzIGUtbWFpbCAoYW5kL29yIGl0cyBhdHRhY2htZW50cykgb3IgYW55
IHBhcnQgdGhlcmVvZiBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBp
biBlcnJvciwgcGxlYXNlIG5vdGlmeSB1cyBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIHRoaXMgbWFp
bCBhcyB3ZWxsIGFzIGl0cyBhdHRhY2htZW50KHMpIGZyb20geW91ciBzeXN0ZW0uIEluIGFkZGl0
aW9uLCBwbGVhc2UgYmUgaW5mb3JtZWQgdGhhdCBjb2xsZWN0aW9uLCBwcm9jZXNzaW5nLCBhbmQv
b3IgdXNlIG9mIHBlcnNvbmFsIGRhdGEgaXMgcHJvaGliaXRlZCB1bmxlc3MgZXhwcmVzc2x5IHBl
cm1pdHRlZCBieSBwZXJzb25hbCBkYXRhIHByb3RlY3Rpb24gbGF3cy4gVGhhbmsgeW91IGZvciB5
b3VyIGF0dGVudGlvbiBhbmQgY29vcGVyYXRpb24uDQoNCk1hY3Jvbml4IEludGVybmF0aW9uYWwg
Q28uLCBMdGQuDQoNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQ0K

