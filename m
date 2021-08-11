Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8413E88B6
	for <lists+linux-spi@lfdr.de>; Wed, 11 Aug 2021 05:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhHKDNP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Aug 2021 23:13:15 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:14220 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbhHKDNP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Aug 2021 23:13:15 -0400
Received: from twhfm1p2.macronix.com (twhfmlp2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id 17B3CZnF056449;
        Wed, 11 Aug 2021 11:12:35 +0800 (GMT-8)
        (envelope-from zhengxunli@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 1EC5346CD70567289807;
        Wed, 11 Aug 2021 11:12:36 +0800 (CST)
In-Reply-To: <20210810142405.2221540-1-yangyingliang@huawei.com>
References: <20210810142405.2221540-1-yangyingliang@huawei.com>
To:     "Yang Yingliang" <yangyingliang@huawei.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH -next] spi: mxic: add missing braces
MIME-Version: 1.0
X-KeepSent: F3887BAF:9F4586C4-4825872E:00113C05;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP6 SHF907 April 26, 2018
Message-ID: <OFF3887BAF.9F4586C4-ON4825872E.00113C05-4825872E.0011A20D@mxic.com.tw>
From:   zhengxunli@mxic.com.tw
Date:   Wed, 11 Aug 2021 11:12:35 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2021/08/11 AM 11:12:36,
        Serialize complete at 2021/08/11 AM 11:12:36
Content-Type: text/plain; charset="Big5"
Content-Transfer-Encoding: base64
X-MAIL: TWHMLLG4.macronix.com 17B3CZnF056449
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


IllhbmcgWWluZ2xpYW5nIiA8eWFuZ3lpbmdsaWFuZ0BodWF3ZWkuY29tPiB3cm90ZSBvbiAyMDIx
LzA4LzEwIKRVpMggDQoxMDoyNDowNToNCg0KPiAiWWFuZyBZaW5nbGlhbmciIDx5YW5neWluZ2xp
YW5nQGh1YXdlaS5jb20+IA0KPiAyMDIxLzA4LzEwIKRVpMggMTA6MTgNCj4gDQo+IFRvDQo+IA0K
PiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4sIDxsaW51eC1zcGlAdmdlci5rZXJuZWwu
b3JnPiwgDQo+IA0KPiBjYw0KPiANCj4gPGJyb29uaWVAa2VybmVsLm9yZz4sIDx6aGVuZ3h1bmxp
QG14aWMuY29tLnR3Pg0KPiANCj4gU3ViamVjdA0KPiANCj4gW1BBVENIIC1uZXh0XSBzcGk6IG14
aWM6IGFkZCBtaXNzaW5nIGJyYWNlcw0KPiANCj4gRml4IHRoZSBmb2xsb3dpbmcgd2FyaW5nOg0K
PiANCj4gZHJpdmVycy9zcGkvc3BpLW14aWMuYzogSW4gZnVuY3Rpb24goaVteGljX3NwaV9tZW1f
ZXhlY19vcKGmOg0KPiBkcml2ZXJzL3NwaS9zcGktbXhpYy5jOjQwMTozOiB3YXJuaW5nOiB0aGlz
IKGlaWahpiBjbGF1c2UgZG9lcyBub3QgDQo+IGd1YXJkLi4uIFstV21pc2xlYWRpbmctaW5kZW50
YXRpb25dDQo+ICAgIGlmIChvcC0+ZGF0YS5kaXIgPT0gU1BJX01FTV9EQVRBX0lOKQ0KPiAgICBe
fg0KPiBkcml2ZXJzL3NwaS9zcGktbXhpYy5jOjQwMzo0OiBub3RlOiAuLi50aGlzIHN0YXRlbWVu
dCwgYnV0IHRoZSANCj4gbGF0dGVyIGlzIG1pc2xlYWRpbmdseSBpbmRlbnRlZCBhcyBpZiBpdCB3
ZXJlIGd1YXJkZWQgYnkgdGhlIKGlaWahpg0KPiAgICAgaWYgKG9wLT5kYXRhLmR0cikNCj4gICAg
IF5+DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFlpbmdsaWFuZyA8eWFuZ3lpbmdsaWFuZ0Bo
dWF3ZWkuY29tPg0KDQpSZXZpZXdlZC1ieTogWmhlbmd4dW4gTGkgPHpoZW5neHVubGlAbXhpYy5j
b20udHc+DQoNCkNPTkZJREVOVElBTElUWSBOT1RFOg0KDQpUaGlzIGUtbWFpbCBhbmQgYW55IGF0
dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiANCmFuZC9vciBw
ZXJzb25hbCBkYXRhLCB3aGljaCBpcyBwcm90ZWN0ZWQgYnkgYXBwbGljYWJsZSBsYXdzLiBQbGVh
c2UgYmUgDQpyZW1pbmRlZCB0aGF0IGR1cGxpY2F0aW9uLCBkaXNjbG9zdXJlLCBkaXN0cmlidXRp
b24sIG9yIHVzZSBvZiB0aGlzIGUtbWFpbCANCihhbmQvb3IgaXRzIGF0dGFjaG1lbnRzKSBvciBh
bnkgcGFydCB0aGVyZW9mIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIA0KdGhpcyBlLW1h
aWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdXMgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSB0aGlz
IG1haWwgYXMgDQp3ZWxsIGFzIGl0cyBhdHRhY2htZW50KHMpIGZyb20geW91ciBzeXN0ZW0uIElu
IGFkZGl0aW9uLCBwbGVhc2UgYmUgDQppbmZvcm1lZCB0aGF0IGNvbGxlY3Rpb24sIHByb2Nlc3Np
bmcsIGFuZC9vciB1c2Ugb2YgcGVyc29uYWwgZGF0YSBpcyANCnByb2hpYml0ZWQgdW5sZXNzIGV4
cHJlc3NseSBwZXJtaXR0ZWQgYnkgcGVyc29uYWwgZGF0YSBwcm90ZWN0aW9uIGxhd3MuIA0KVGhh
bmsgeW91IGZvciB5b3VyIGF0dGVudGlvbiBhbmQgY29vcGVyYXRpb24uDQoNCk1hY3Jvbml4IElu
dGVybmF0aW9uYWwgQ28uLCBMdGQuDQoNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KDQoNCg0KPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KDQpDT05GSURFTlRJQUxJVFkgTk9URToNCg0KVGhpcyBlLW1haWwgYW5kIGFueSBh
dHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gYW5kL29yIHBl
cnNvbmFsIGRhdGEsIHdoaWNoIGlzIHByb3RlY3RlZCBieSBhcHBsaWNhYmxlIGxhd3MuIFBsZWFz
ZSBiZSByZW1pbmRlZCB0aGF0IGR1cGxpY2F0aW9uLCBkaXNjbG9zdXJlLCBkaXN0cmlidXRpb24s
IG9yIHVzZSBvZiB0aGlzIGUtbWFpbCAoYW5kL29yIGl0cyBhdHRhY2htZW50cykgb3IgYW55IHBh
cnQgdGhlcmVvZiBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBl
cnJvciwgcGxlYXNlIG5vdGlmeSB1cyBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIHRoaXMgbWFpbCBh
cyB3ZWxsIGFzIGl0cyBhdHRhY2htZW50KHMpIGZyb20geW91ciBzeXN0ZW0uIEluIGFkZGl0aW9u
LCBwbGVhc2UgYmUgaW5mb3JtZWQgdGhhdCBjb2xsZWN0aW9uLCBwcm9jZXNzaW5nLCBhbmQvb3Ig
dXNlIG9mIHBlcnNvbmFsIGRhdGEgaXMgcHJvaGliaXRlZCB1bmxlc3MgZXhwcmVzc2x5IHBlcm1p
dHRlZCBieSBwZXJzb25hbCBkYXRhIHByb3RlY3Rpb24gbGF3cy4gVGhhbmsgeW91IGZvciB5b3Vy
IGF0dGVudGlvbiBhbmQgY29vcGVyYXRpb24uDQoNCk1hY3Jvbml4IEludGVybmF0aW9uYWwgQ28u
LCBMdGQuDQoNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0K

