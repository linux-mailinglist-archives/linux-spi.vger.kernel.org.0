Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC1D36BD03
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 03:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhD0Bty (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Apr 2021 21:49:54 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:10397 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhD0Btx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Apr 2021 21:49:53 -0400
Received: from twhfm1p2.macronix.com (twhfmlp2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 13R1majp016941;
        Tue, 27 Apr 2021 09:48:36 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id C65D0F8794AF8785BB8B;
        Tue, 27 Apr 2021 09:48:36 +0800 (CST)
In-Reply-To: <20210426165358.GI4590@sirena.org.uk>
References: <1618900179-14546-1-git-send-email-zhengxunli@mxic.com.tw> <1618900179-14546-4-git-send-email-zhengxunli@mxic.com.tw> <20210426165358.GI4590@sirena.org.uk>
To:     "Mark Brown" <broonie@kernel.org>
Cc:     jaimeliao@mxic.com.tw, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, miquel.raynal@bootlin.com,
        tudor.ambarus@microchip.com
Subject: Re: [PATCH v3 3/3] spi: mxic: patch for octal DTR mode support
MIME-Version: 1.0
X-KeepSent: 9A94F8F9:DF8D5789-482586C4:0008EE9F;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP6 SHF907 April 26, 2018
Message-ID: <OF9A94F8F9.DF8D5789-ON482586C4.0008EE9F-482586C4.0009F19F@mxic.com.tw>
From:   zhengxunli@mxic.com.tw
Date:   Tue, 27 Apr 2021 09:48:37 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2021/04/27 AM 09:48:36,
        Serialize complete at 2021/04/27 AM 09:48:36
Content-Type: text/plain; charset="Big5"
Content-Transfer-Encoding: base64
X-MAIL: TWHMLLG4.macronix.com 13R1majp016941
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


SGkgTWFyaywNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQoiTWFyayBCcm93biIgPGJyb29u
aWVAa2VybmVsLm9yZz4gd3JvdGUgb24gMjAyMS8wNC8yNyCkV6TIIDEyOjUzOjU4Og0KDQo+ICJN
YXJrIEJyb3duIiA8YnJvb25pZUBrZXJuZWwub3JnPiANCj4gMjAyMS8wNC8yNyCkV6TIIDEyOjU0
DQo+IA0KPiBUbw0KPiANCj4gIlpoZW5neHVuIExpIiA8emhlbmd4dW5saUBteGljLmNvbS50dz4s
IA0KPiANCj4gY2MNCj4gDQo+IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnLCBsaW51eC1z
cGlAdmdlci5rZXJuZWwub3JnLCANCj4gdHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tLCBtaXF1
ZWwucmF5bmFsQGJvb3RsaW4uY29tLCANCmphaW1lbGlhb0BteGljLmNvbS50dw0KPiANCj4gU3Vi
amVjdA0KPiANCj4gUmU6IFtQQVRDSCB2MyAzLzNdIHNwaTogbXhpYzogcGF0Y2ggZm9yIG9jdGFs
IERUUiBtb2RlIHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwgQXByIDIwLCAyMDIxIGF0IDAyOjI5OjM5
UE0gKzA4MDAsIFpoZW5neHVuIExpIHdyb3RlOg0KPiANCj4gPiAtICAgcmV0dXJuIHNwaV9tZW1f
ZGVmYXVsdF9zdXBwb3J0c19vcChtZW0sIG9wKTsNCj4gPiArICAgYWxsX2ZhbHNlID0gIW9wLT5j
bWQuZHRyICYmICFvcC0+YWRkci5kdHIgJiYgIW9wLT5kdW1teS5kdHIgJiYNCj4gPiArICAgICAg
ICAgICFvcC0+ZGF0YS5kdHI7DQo+ID4gKw0KPiA+ICsgICBpZiAoYWxsX2ZhbHNlKQ0KPiANCj4g
VGhpcyBmZWVscyBsaWtlIHdlIG1pZ2h0IHdhbnQgYSBzcGlfbWVtX29wX2lzX2R0cigpIGhlbHBl
cj8gIEkgY2FuIHNlZQ0KPiBvdGhlciBjb250cm9sbGVycyB3YW50aW5nIGEgc2ltaWxhciBjaGVj
ay4NCg0KWWVzLCBzaW5jZSBzcGlfbWVtX2RlZmF1bHRfc3VwcG9ydHNfb3AgZG9lcyBub3Qgc3Vw
cG9ydCBhbnkgZHRyIA0Kb3BlcmF0aW9ucywNCndlIG5lZWQgc3BpX21lbV9vcF9pcyBkdHIoKSB0
byBoZWxwIHVzIGNoZWNrIGR0ciBvcGVyYXRpb25zLg0KDQpUaGFua3MsDQpaaGVuZ3h1biBMaQ0K
DQoNCkNPTkZJREVOVElBTElUWSBOT1RFOg0KDQpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1l
bnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiANCmFuZC9vciBwZXJzb25h
bCBkYXRhLCB3aGljaCBpcyBwcm90ZWN0ZWQgYnkgYXBwbGljYWJsZSBsYXdzLiBQbGVhc2UgYmUg
DQpyZW1pbmRlZCB0aGF0IGR1cGxpY2F0aW9uLCBkaXNjbG9zdXJlLCBkaXN0cmlidXRpb24sIG9y
IHVzZSBvZiB0aGlzIGUtbWFpbCANCihhbmQvb3IgaXRzIGF0dGFjaG1lbnRzKSBvciBhbnkgcGFy
dCB0aGVyZW9mIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIA0KdGhpcyBlLW1haWwgaW4g
ZXJyb3IsIHBsZWFzZSBub3RpZnkgdXMgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSB0aGlzIG1haWwg
YXMgDQp3ZWxsIGFzIGl0cyBhdHRhY2htZW50KHMpIGZyb20geW91ciBzeXN0ZW0uIEluIGFkZGl0
aW9uLCBwbGVhc2UgYmUgDQppbmZvcm1lZCB0aGF0IGNvbGxlY3Rpb24sIHByb2Nlc3NpbmcsIGFu
ZC9vciB1c2Ugb2YgcGVyc29uYWwgZGF0YSBpcyANCnByb2hpYml0ZWQgdW5sZXNzIGV4cHJlc3Ns
eSBwZXJtaXR0ZWQgYnkgcGVyc29uYWwgZGF0YSBwcm90ZWN0aW9uIGxhd3MuIA0KVGhhbmsgeW91
IGZvciB5b3VyIGF0dGVudGlvbiBhbmQgY29vcGVyYXRpb24uDQoNCk1hY3Jvbml4IEludGVybmF0
aW9uYWwgQ28uLCBMdGQuDQoNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KDQoNCg0KPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KDQpDT05GSURFTlRJQUxJVFkgTk9URToNCg0KVGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2ht
ZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gYW5kL29yIHBlcnNvbmFs
IGRhdGEsIHdoaWNoIGlzIHByb3RlY3RlZCBieSBhcHBsaWNhYmxlIGxhd3MuIFBsZWFzZSBiZSBy
ZW1pbmRlZCB0aGF0IGR1cGxpY2F0aW9uLCBkaXNjbG9zdXJlLCBkaXN0cmlidXRpb24sIG9yIHVz
ZSBvZiB0aGlzIGUtbWFpbCAoYW5kL29yIGl0cyBhdHRhY2htZW50cykgb3IgYW55IHBhcnQgdGhl
cmVvZiBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwg
cGxlYXNlIG5vdGlmeSB1cyBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIHRoaXMgbWFpbCBhcyB3ZWxs
IGFzIGl0cyBhdHRhY2htZW50KHMpIGZyb20geW91ciBzeXN0ZW0uIEluIGFkZGl0aW9uLCBwbGVh
c2UgYmUgaW5mb3JtZWQgdGhhdCBjb2xsZWN0aW9uLCBwcm9jZXNzaW5nLCBhbmQvb3IgdXNlIG9m
IHBlcnNvbmFsIGRhdGEgaXMgcHJvaGliaXRlZCB1bmxlc3MgZXhwcmVzc2x5IHBlcm1pdHRlZCBi
eSBwZXJzb25hbCBkYXRhIHByb3RlY3Rpb24gbGF3cy4gVGhhbmsgeW91IGZvciB5b3VyIGF0dGVu
dGlvbiBhbmQgY29vcGVyYXRpb24uDQoNCk1hY3Jvbml4IEludGVybmF0aW9uYWwgQ28uLCBMdGQu
DQoNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0K

