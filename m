Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D884F1E80E
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2019 07:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfEOFzb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 May 2019 01:55:31 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:58032 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfEOFzb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 May 2019 01:55:31 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x4F5t4Y4029231;
        Wed, 15 May 2019 13:55:04 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 0114B7DFC3239B44020E;
        Wed, 15 May 2019 13:55:05 +0800 (CST)
In-Reply-To: <20190514065216.GL4319@dell>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw> <1556092536-17095-3-git-send-email-masonccyang@mxic.com.tw> <20190514065216.GL4319@dell>
To:     "Lee Jones" <lee.jones@linaro.org>
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Simon Horman" <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        sergei.shtylyov@cogentembedded.com, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v12 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
MIME-Version: 1.0
X-KeepSent: 794FCFCD:155B914B-482583FB:001EDBB3;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF794FCFCD.155B914B-ON482583FB.001EDBB3-482583FB.0020821B@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Wed, 15 May 2019 13:55:05 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/05/15 PM 01:55:05,
        Serialize complete at 2019/05/15 PM 01:55:05
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: base64
X-MAIL: TWHMLLG4.macronix.com x4F5t4Y4029231
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


SGkgSm9uZXMsDQoNCg0KPiA+ICsNCj4gPiArc3RydWN0IHJwY19zcGkgew0KPiA+ICsgICBzdHJ1
Y3QgcnBjX21mZCAqbWZkOw0KPiANCj4gVGhlIHRlcm0gTUZEIGlzbid0IGEgcmVhbCB0aGluZy4g
IFdoYXQgeW91J3JlIG9idGFpbmluZyBiZWxvdyBpcw0KPiBkcml2ZXIgZGF0YSBhbmQgaXMgbm9y
bWFsbHkgYXJ0aWN1bGF0ZWQgYXMgJ2RkYXRhJyBpbiBkcml2ZXJzLg0KDQp5ZXMsIGl0J3MganVz
dCBpbXBseSB0aGF0IGRhdGEgaXMgZnJvbSBNRkQuDQoNClNob3VsZCBJIHJlbmFtZSAibWZkIiA/
DQoNCj4gDQo+ID4gKyAgIHUzMiBjdXJfc3BlZWRfaHo7DQo+ID4gKyAgIHUzMiBjbWQ7DQo+ID4g
KyAgIHUzMiBhZGRyOw0KPiA+ICsgICB1MzIgZHVtbXk7DQo+ID4gKyAgIHUzMiBzbWNyOw0KPiA+
ICsgICB1MzIgc21lbnI7DQo+ID4gKyAgIHUzMiB4ZmVybGVuOw0KPiA+ICsgICB1MzIgdG90YWx4
ZmVybGVuOw0KPiA+ICsgICBlbnVtIHNwaV9tZW1fZGF0YV9kaXIgeGZlcl9kaXI7DQo+ID4gK307
DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiArc3RhdGljIHZvaWQgcnBjX3NwaV9od19pbml0KHN0cnVj
dCBycGNfc3BpICpycGMpDQo+ID4gK3sNCj4gPiArICAgLy8NCj4gPiArICAgLy8gTk9URTogVGhl
IDB4MjYwIGFyZSB1bmRvY3VtZW50ZWQgYml0cywgYnV0IHRoZXkgbXVzdCBiZSBzZXQuDQo+ID4g
KyAgIC8vICAgIFJQQ19QSFlDTlRfU1RSVElNIGlzIHN0cm9iZSB0aW1pbmcgYWRqdXN0bWVudCBi
aXQsDQo+ID4gKyAgIC8vICAgIDB4MCA6IHRoZSBkZWxheSBpcyBiaWdnZXN0LA0KPiA+ICsgICAv
LyAgICAweDEgOiB0aGUgZGVsYXkgaXMgMm5kIGJpZ2dlc3QsDQo+ID4gKyAgIC8vICAgIE9uIEgz
IEVTMS54LCB0aGUgdmFsdWUgc2hvdWxkIGJlIDAsIHdoaWxlIG9uIG90aGVycywNCj4gPiArICAg
Ly8gICAgdGhlIHZhbHVlIHNob3VsZCBiZSA2Lg0KPiA+ICsgICAvLw0KPiANCj4gQysrIHN0eWxl
IGNvbW1lbnRzPyAgSXMgdGhhdCBhIHRoaW5nIG5vdz8NCg0KSXQncyBraW5kIG9mIE1hcmsncyBw
cmV2aW91cyBjb21tZW50cy4NCg0KPiANCj4gPiArICAgcmVnbWFwX3dyaXRlKHJwYy0+bWZkLT5y
ZWdtYXAsIFJQQ19QSFlDTlQsIFJQQ19QSFlDTlRfQ0FMIHwNCj4gPiArICAgICAgICAgICAgICBS
UENfUEhZQ05UX1NUUlRJTSg2KSB8IDB4MjYwKTsNCj4gPiArDQo+ID4gKyAgIC8vDQo+ID4gKyAg
IC8vIE5PVEU6IFRoZSAweDE1MTExNDQgYXJlIHVuZG9jdW1lbnRlZCBiaXRzLCBidXQgdGhleSBt
dXN0IGJlIHNldA0KPiA+ICsgICAvLyAgICAgICBmb3IgUlBDX1BIWU9GRlNFVDEuDQo+ID4gKyAg
IC8vICAgIFRoZSAweDMxIGFyZSB1bmRvY3VtZW50ZWQgYml0cywgYnV0IHRoZXkgbXVzdCBiZSBz
ZXQNCj4gPiArICAgLy8gICAgZm9yIFJQQ19QSFlPRkZTRVQyLg0KPiA+ICsgICAvLw0KPiA+ICsg
ICByZWdtYXBfd3JpdGUocnBjLT5tZmQtPnJlZ21hcCwgUlBDX1BIWU9GRlNFVDEsDQo+ID4gKyAg
ICAgICAgICAgUlBDX1BIWU9GRlNFVDFfRERSVE1HKDMpIHwgMHgxNTExMTQ0KTsNCj4gPiArICAg
cmVnbWFwX3dyaXRlKHJwYy0+bWZkLT5yZWdtYXAsIFJQQ19QSFlPRkZTRVQyLCAweDMxIHwNCj4g
PiArICAgICAgICAgICBSUENfUEhZT0ZGU0VUMl9PQ1RUTUcoNCkpOw0KPiA+ICsgICByZWdtYXBf
d3JpdGUocnBjLT5tZmQtPnJlZ21hcCwgUlBDX1NTTERSLCBSUENfU1NMRFJfU1BOREwoNykgfA0K
PiA+ICsgICAgICAgICAgIFJQQ19TU0xEUl9TTE5ETCg3KSB8IFJQQ19TU0xEUl9TQ0tETCg3KSk7
DQo+ID4gKyAgIHJlZ21hcF93cml0ZShycGMtPm1mZC0+cmVnbWFwLCBSUENfQ01OQ1IsIFJQQ19D
TU5DUl9NRCB8DQo+ID4gKyAgICAgICAgICAgUlBDX0NNTkNSX1NGREUgfCBSUENfQ01OQ1JfTU9J
SU9fSElaIHwgUlBDX0NNTkNSX0lPRlZfSElaIA0KfA0KPiA+ICsgICAgICAgICAgIFJQQ19DTU5D
Ul9CU1ooMCkpOw0KPiA+ICt9DQo+IA0KPiAtLSANCj4gTGVlIEpvbmVzIFvA7sfty7ldDQo+IExp
bmFybyBTZXJ2aWNlcyBUZWNobmljYWwgTGVhZA0KPiBMaW5hcm8ub3JnIKmmIE9wZW4gc291cmNl
IHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPiBGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0
ZXIgfCBCbG9nDQoNCnRoYW5rcyAmIGJlc3QgcmVnYXJkcywNCk1hc29uDQoNCkNPTkZJREVOVElB
TElUWSBOT1RFOg0KDQpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWlu
IGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiANCmFuZC9vciBwZXJzb25hbCBkYXRhLCB3aGljaCBp
cyBwcm90ZWN0ZWQgYnkgYXBwbGljYWJsZSBsYXdzLiBQbGVhc2UgYmUgDQpyZW1pbmRlZCB0aGF0
IGR1cGxpY2F0aW9uLCBkaXNjbG9zdXJlLCBkaXN0cmlidXRpb24sIG9yIHVzZSBvZiB0aGlzIGUt
bWFpbCANCihhbmQvb3IgaXRzIGF0dGFjaG1lbnRzKSBvciBhbnkgcGFydCB0aGVyZW9mIGlzIHBy
b2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIA0KdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBu
b3RpZnkgdXMgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSB0aGlzIG1haWwgYXMgDQp3ZWxsIGFzIGl0
cyBhdHRhY2htZW50KHMpIGZyb20geW91ciBzeXN0ZW0uIEluIGFkZGl0aW9uLCBwbGVhc2UgYmUg
DQppbmZvcm1lZCB0aGF0IGNvbGxlY3Rpb24sIHByb2Nlc3NpbmcsIGFuZC9vciB1c2Ugb2YgcGVy
c29uYWwgZGF0YSBpcyANCnByb2hpYml0ZWQgdW5sZXNzIGV4cHJlc3NseSBwZXJtaXR0ZWQgYnkg
cGVyc29uYWwgZGF0YSBwcm90ZWN0aW9uIGxhd3MuIA0KVGhhbmsgeW91IGZvciB5b3VyIGF0dGVu
dGlvbiBhbmQgY29vcGVyYXRpb24uDQoNCk1hY3Jvbml4IEludGVybmF0aW9uYWwgQ28uLCBMdGQu
DQoNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KDQoNCg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KDQpDT05GSURFTlRJ
QUxJVFkgTk9URToNCg0KVGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29udGFp
biBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gYW5kL29yIHBlcnNvbmFsIGRhdGEsIHdoaWNoIGlz
IHByb3RlY3RlZCBieSBhcHBsaWNhYmxlIGxhd3MuIFBsZWFzZSBiZSByZW1pbmRlZCB0aGF0IGR1
cGxpY2F0aW9uLCBkaXNjbG9zdXJlLCBkaXN0cmlidXRpb24sIG9yIHVzZSBvZiB0aGlzIGUtbWFp
bCAoYW5kL29yIGl0cyBhdHRhY2htZW50cykgb3IgYW55IHBhcnQgdGhlcmVvZiBpcyBwcm9oaWJp
dGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB1
cyBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIHRoaXMgbWFpbCBhcyB3ZWxsIGFzIGl0cyBhdHRhY2ht
ZW50KHMpIGZyb20geW91ciBzeXN0ZW0uIEluIGFkZGl0aW9uLCBwbGVhc2UgYmUgaW5mb3JtZWQg
dGhhdCBjb2xsZWN0aW9uLCBwcm9jZXNzaW5nLCBhbmQvb3IgdXNlIG9mIHBlcnNvbmFsIGRhdGEg
aXMgcHJvaGliaXRlZCB1bmxlc3MgZXhwcmVzc2x5IHBlcm1pdHRlZCBieSBwZXJzb25hbCBkYXRh
IHByb3RlY3Rpb24gbGF3cy4gVGhhbmsgeW91IGZvciB5b3VyIGF0dGVudGlvbiBhbmQgY29vcGVy
YXRpb24uDQoNCk1hY3Jvbml4IEludGVybmF0aW9uYWwgQ28uLCBMdGQuDQoNCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0K

