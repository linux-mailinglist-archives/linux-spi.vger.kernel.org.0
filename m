Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F4B15C8F9
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2020 17:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgBMQ5a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Feb 2020 11:57:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:25200 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbgBMQ53 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 13 Feb 2020 11:57:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 08:57:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,437,1574150400"; 
   d="scan'208";a="313781182"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2020 08:57:28 -0800
Received: from bgsmsx154.gar.corp.intel.com (10.224.48.47) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 13 Feb 2020 08:57:27 -0800
Received: from bgsmsx101.gar.corp.intel.com ([169.254.1.159]) by
 BGSMSX154.gar.corp.intel.com ([169.254.7.48]) with mapi id 14.03.0439.000;
 Thu, 13 Feb 2020 22:27:25 +0530
From:   "Srivastava, Shobhit" <shobhit.srivastava@intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Rajat Jain <rajatja@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Mark Brown" <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        "rajatxjain@gmail.com" <rajatxjain@gmail.com>,
        "evgreen@google.com" <evgreen@google.com>,
        "Muthukrishnan, Porselvan" <porselvan.muthukrishnan@intel.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: RE: Re: [PATCH] spi: pxa2xx: Add CS control clock quirk
Thread-Topic: Re: [PATCH] spi: pxa2xx: Add CS control clock quirk
Thread-Index: AdXijjRJ6+7qPvvhRvGfTavxCinpyg==
Date:   Thu, 13 Feb 2020 16:57:24 +0000
Message-ID: <CB4ED07B85D6BB40B8B44F6D5442E4F6572C1523@BGSMSX101.gar.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2IwZTZmYzgtMDNkZS00ZjM2LWFjNjItNjkwZTkzNDQ3ZmMxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoib2d3ajZpbVBmaHNEd0dTcnZxcTUwTDQwT0FiZ0x1dlF5eFFTZStcL3JOZVFXK1g5cStqME5tcU9uVjdqSlVqSUEifQ==
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQo+IEhpDQo+IA0KPiArIEFuZHkNCj4gDQo+IE9uIDIvMTIvMjAgMTI6MzQgQU0sIFJhamF0IEph
aW4gd3JvdGU6DQo+ID4gRnJvbTogRXZhbiBHcmVlbiA8ZXZncmVlbkBjaHJvbWl1bS5vcmc+DQo+
ID4NCj4gPiBEYXRlOiBXZWQsIDI5IEphbiAyMDIwIDEzOjU0OjE2IC0wODAwDQo+ID4gU3ViamVj
dDogW1BBVENIXSBzcGk6IHB4YTJ4eDogQWRkIENTIGNvbnRyb2wgY2xvY2sgcXVpcmsNCj4gPg0K
PiBUaGlzIHBhdGNoIHN1YmplY3QgaXMgbWlzc2luZyBmcm9tIG1haWwgc3ViamVjdC4NCj4gDQpB
ZGRlZA0KDQo+ID4gSW4gc29tZSBjaXJjdW1zdGFuY2VzIG9uIEludGVsIExQU1MgY29udHJvbGxl
cnMsIHRvZ2dsaW5nIHRoZSBMUFNTIENTDQo+ID4gY29udHJvbCByZWdpc3RlciBkb2Vzbid0IGFj
dHVhbGx5IGNhdXNlIHRoZSBDUyBsaW5lIHRvIHRvZ2dsZS4NCj4gPiBUaGlzIHNlZW1zIHRvIGJl
IGZhaWx1cmUgb2YgZHluYW1pYyBjbG9jayBnYXRpbmcgdGhhdCBvY2N1cnMgYWZ0ZXINCj4gPiBn
b2luZyB0aHJvdWdoIGEgc3VzcGVuZC9yZXN1bWUgdHJhbnNpdGlvbiwgd2hlcmUgdGhlIGNvbnRy
b2xsZXIgaXMNCj4gPiBzZW50IHRocm91Z2ggYSByZXNldCB0cmFuc2l0aW9uLiBUaGlzIHJ1aW5z
IFNQSSB0cmFuc2FjdGlvbnMgdGhhdA0KPiA+IGVpdGhlciByZWx5IG9uIGRlbGF5X3VzZWNzLCBv
ciB0b2dnbGUgdGhlIENTIGxpbmUgd2l0aG91dCBzZW5kaW5nDQo+ID4gZGF0YS4NCj4gPg0KPiA+
IFdoZW5ldmVyIENTIGlzIHRvZ2dsZWQsIG1vbWVudGFyaWx5IHNldCB0aGUgY2xvY2sgZ2F0aW5n
IHJlZ2lzdGVyIHRvDQo+ID4gIkZvcmNlIE9uIiB0byBwb2tlIHRoZSBjb250cm9sbGVyIGludG8g
YWN0aW5nIG9uIENTLg0KPiA+DQo+IENvdWxkIHlvdSBzaGFyZSB0aGUgdGVzdCBjYXNlIGhvdyB0
byB0cmlnZ2VyIHRoaXM/IFdoYXQncyB0aGUgcGxhdGZvcm0gaGVyZT8NCj4gSSdkIGxpa2UgdG8g
Y2hlY2sgZG9lcyB0aGlzIHJlcHJvZHVjZSBvbiBvdGhlciBJbnRlbCBMUFNTIHBsYXRmb3JtcyBz
byBpcyB0aGVyZQ0KPiBuZWVkIHRvIGFkZCBxdWlyayBmb3IgdGhlbSB0b28uDQo+IA0KVGhpcyBp
cyBvbiBhIENvbWV0TGFrZSBwbGF0Zm9ybS4gV2UgYXJlIHByb2JpbmcgdGhlIFNQSV9DUyBsaW5l
IG9uIGEgc2NvcGUuIA0KRXZlbiB0aG91Z2ggdGhlIHdyaXRlcyB0byBTUElfQ1NfQ09OVFJPTCBy
ZWdpc3RlciBhcmUgc3VjY2Vzc2Z1bCwgaXQgZG9lc27igJl0IHRvZ2dsZSB0aGUgQ1MgbGluZS4N
CkhlbmNlIGNoZWNraW5nIG9uIGEgc2NvcGUgaXMgYmV0dGVyLg0KDQpFYXN5IHdheSB0byB0ZXN0
IHRoaXMgaXMgdG8gcHJvZ3JhbSB0aGUgY3MgY29udHJvbCByZWdpc3RlciB2aWEgaW90b29scyBh
bmQgc2VlIGlmIHRoZSBDUyBsaW5lIHRvZ2dsZXMuIA0KVGhpcyBoYXMgdG8gYmUgZG9uZSBhZnRl
ciBvbmUgY3ljbGUgb2YgUzBpeC4NCg0KPiA+IFNpZ25lZC1vZmYtYnk6IEV2YW4gR3JlZW4gPGV2
Z3JlZW5AY2hyb21pdW0ub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJhamF0IEphaW4gPHJhamF0
amFAZ29vZ2xlLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc3BpL3NwaS1weGEyeHguYyB8
IDIzICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1weGEyeHgu
YyBiL2RyaXZlcnMvc3BpL3NwaS1weGEyeHguYyBpbmRleA0KPiA+IDRjN2E3MWYwZmIzZS4uMmUz
MTgxNThmY2E5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1weGEyeHguYw0KPiA+
ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1weGEyeHguYw0KPiA+IEBAIC03MCw2ICs3MCwxMCBAQCBN
T0RVTEVfQUxJQVMoInBsYXRmb3JtOnB4YTJ4eC1zcGkiKTsNCj4gPiAgICNkZWZpbmUgTFBTU19D
QVBTX0NTX0VOX1NISUZUCQkJOQ0KPiA+ICAgI2RlZmluZSBMUFNTX0NBUFNfQ1NfRU5fTUFTSwkJ
CSgweGYgPDwNCj4gTFBTU19DQVBTX0NTX0VOX1NISUZUKQ0KPiA+DQo+ID4gKyNkZWZpbmUgTFBT
U19QUklWX0NMT0NLX0dBVEUgMHgzOA0KPiA+ICsjZGVmaW5lIExQU1NfUFJJVl9DTE9DS19HQVRF
X0NMS19DVExfTUFTSyAweDMgI2RlZmluZQ0KPiA+ICtMUFNTX1BSSVZfQ0xPQ0tfR0FURV9DTEtf
Q1RMX0ZPUkNFX09OIDB4Mw0KPiA+ICsNCj4gPiAgIHN0cnVjdCBscHNzX2NvbmZpZyB7DQo+ID4g
ICAJLyogTFBTUyBvZmZzZXQgZnJvbSBkcnZfZGF0YS0+aW9hZGRyICovDQo+ID4gICAJdW5zaWdu
ZWQgb2Zmc2V0Ow0KPiA+IEBAIC04Niw2ICs5MCw4IEBAIHN0cnVjdCBscHNzX2NvbmZpZyB7DQo+
ID4gICAJdW5zaWduZWQgY3Nfc2VsX3NoaWZ0Ow0KPiA+ICAgCXVuc2lnbmVkIGNzX3NlbF9tYXNr
Ow0KPiA+ICAgCXVuc2lnbmVkIGNzX251bTsNCj4gPiArCS8qIFF1aXJrcyAqLw0KPiA+ICsJdW5z
aWduZWQgY3NfY2xrX3N0YXlzX2dhdGVkIDogMTsNCj4gPiAgIH07DQo+ID4NCj4gPiAgIC8qIEtl
ZXAgdGhlc2Ugc29ydGVkIHdpdGggZW51bSBweGFfc3NwX3R5cGUgKi8gQEAgLTE1Niw2ICsxNjIs
NyBAQA0KPiA+IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbHBzc19jb25maWcgbHBzc19wbGF0Zm9ybXNb
XSA9IHsNCj4gPiAgIAkJLnR4X3RocmVzaG9sZF9oaSA9IDU2LA0KPiA+ICAgCQkuY3Nfc2VsX3No
aWZ0ID0gOCwNCj4gPiAgIAkJLmNzX3NlbF9tYXNrID0gMyA8PCA4LA0KPiA+ICsJCS5jc19jbGtf
c3RheXNfZ2F0ZWQgPSB0cnVlLA0KPiA+ICAgCX0sDQo+ID4gICB9Ow0KPiA+DQo+ID4gQEAgLTM4
Myw2ICszOTAsMjIgQEAgc3RhdGljIHZvaWQgbHBzc19zc3BfY3NfY29udHJvbChzdHJ1Y3Qgc3Bp
X2RldmljZQ0KPiAqc3BpLCBib29sIGVuYWJsZSkNCj4gPiAgIAllbHNlDQo+ID4gICAJCXZhbHVl
IHw9IExQU1NfQ1NfQ09OVFJPTF9DU19ISUdIOw0KPiA+ICAgCV9fbHBzc19zc3Bfd3JpdGVfcHJp
dihkcnZfZGF0YSwgY29uZmlnLT5yZWdfY3NfY3RybCwgdmFsdWUpOw0KPiA+ICsJaWYgKGNvbmZp
Zy0+Y3NfY2xrX3N0YXlzX2dhdGVkKSB7DQo+ID4gKwkJdTMyIGNsa2dhdGU7DQo+ID4gKw0KPiA+
ICsJCS8qDQo+ID4gKwkJICogQ2hhbmdpbmcgQ1MgYWxvbmUgd2hlbiBkeW5hbWljIGNsb2NrIGdh
dGluZyBpcyBvbiB3b24ndA0KPiA+ICsJCSAqIGFjdHVhbGx5IGZsaXAgQ1MgYXQgdGhhdCB0aW1l
LiBUaGlzIHJ1aW5zIFNQSSB0cmFuc2ZlcnMNCj4gPiArCQkgKiB0aGF0IHNwZWNpZnkgZGVsYXlz
LCBvciBoYXZlIG5vIGRhdGEuIFRvZ2dsZSB0aGUgY2xvY2sgbW9kZQ0KPiA+ICsJCSAqIHRvIGZv
cmNlIG9uIGJyaWVmbHkgdG8gcG9rZSB0aGUgQ1MgcGluIHRvIG1vdmUuDQo+ID4gKwkJICovDQo+
ID4gKwkJY2xrZ2F0ZSA9IF9fbHBzc19zc3BfcmVhZF9wcml2KGRydl9kYXRhLA0KPiBMUFNTX1BS
SVZfQ0xPQ0tfR0FURSk7DQo+ID4gKwkJdmFsdWUgPSAoY2xrZ2F0ZSAmIH5MUFNTX1BSSVZfQ0xP
Q0tfR0FURV9DTEtfQ1RMX01BU0spDQo+IHwNCj4gPiArCQkJTFBTU19QUklWX0NMT0NLX0dBVEVf
Q0xLX0NUTF9GT1JDRV9PTjsNCj4gPiArDQo+ID4gKwkJX19scHNzX3NzcF93cml0ZV9wcml2KGRy
dl9kYXRhLCBMUFNTX1BSSVZfQ0xPQ0tfR0FURSwNCj4gdmFsdWUpOw0KPiA+ICsJCV9fbHBzc19z
c3Bfd3JpdGVfcHJpdihkcnZfZGF0YSwgTFBTU19QUklWX0NMT0NLX0dBVEUsDQo+IGNsa2dhdGUp
Ow0KPiA+ICsJfQ0KPiA+ICAgfQ0KPiA+DQo+IEkgd29uZGVyIGlzIGl0IGVub3VnaCB0byBoYXZl
IHRoaXMgcXVpY2sgdG9nZ2xpbmcgb25seSBvciBpcyB0aW1lIG9yIGFjdHVhbGx5DQo+IG51bWJl
ciBvZiBjbG9jayBjeWNsZXMgZGVwZW5kZW50PyBOb3cgdGhlcmUgaXMgbm8gZGVsYXkgYmV0d2Vl
biBidXQgSSdtDQo+IHRoaW5raW5nIGlmIGl0IG5lZWRzIGNlcnRhaW4gbnVtYmVyIGN5Y2xlcyBk
b2VzIHRoaXMgc3RpbGwgd29yayB3aGVuIHVzaW5nIGxvdw0KPiBzc3BfY2xrIHJhdGVzIHNpbWls
YXIgdGhhbiBpbiBjb21taXQgZDAyODNlYjJkYmMxICgic3BpOg0KPiBweGEyeHg6IEFkZCBvdXRw
dXQgY29udHJvbCBmb3IgbXVsdGlwbGUgSW50ZWwgTFBTUyBjaGlwIHNlbGVjdHMiKS4NCj4gDQo+
IEknbSB0aGlua2luZyBjYW4gdGhpcyBiZSBkb25lIG9ubHkgb25jZSBhZnRlciByZXN1bWUgYW5k
IG1heSBvdGhlciBMUFNTDQo+IGJsb2NrcyBuZWVkIHRoZSBzYW1lPyBJLmUuIHNob3VsZCB0aGlz
IGJlIGRvbmUgaW4gZHJpdmVycy9tZmQvaW50ZWwtbHBzcy5jPw0KPiANClRoaXMgYmVoYXZpb3Ig
aXMgc2VlbiBhZnRlciBTMGl4IHJlc3VtZSwgYnV0IGl0IGlzIG5vdCBzZWVuIGFmdGVyIFMzIHJl
c3VtZS4NCkkgYW0gdGhpbmtpbmcgdGhhdCBpdCBoYXBwZW5zIGJlY2F1c2Ugd2UgYXJlIG5vdCBl
bmFibGluZyB0aGUgU1NQIGFmdGVyIHJlc3VtZS4gDQpJdCBpcyBkZWZlcnJlZCB1bnRpbCB3ZSBu
ZWVkIHRvIHNlbmQgZGF0YS4gQnkgZW5hYmxpbmcgdGhlIFNTUCBpbiByZXN1bWUsIEkgZG9u4oCZ
dCBzZWUgdGhlIGlzc3VlLg0KRm9yIFMzLCBJIHRoaW5rIEJJT1MgcmUtZW5hYmxlcyB0aGUgU1NQ
IGluIHJlc3VtZSBmbG93Lg0KDQo+IEphcmtrbw0KDQpSZWdhcmRzLA0KU2hvYmhpdA0K
