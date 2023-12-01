Return-Path: <linux-spi+bounces-113-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87310800979
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 12:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B35B2111F
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 11:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EA3210F3;
	Fri,  1 Dec 2023 11:14:37 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B7110DF
	for <linux-spi@vger.kernel.org>; Fri,  1 Dec 2023 03:14:31 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-7-aNUEPq_ZNbWhDy3jsI9dyQ-1; Fri, 01 Dec 2023 11:13:23 +0000
X-MC-Unique: aNUEPq_ZNbWhDy3jsI9dyQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Dec
 2023 11:13:06 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Dec 2023 11:13:06 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Ronald Wahl' <ronald.wahl@raritan.com>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>
CC: Mark Brown <broonie@kernel.org>, linux-spi <linux-spi@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Ryan Wanner
	<ryan.wanner@microchip.com>, stable <stable@vger.kernel.org>, "Richard
 Weinberger" <richard.weinberger@gmail.com>, David Woodhouse
	<dwmw2@infradead.org>
Subject: RE: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any signal
Thread-Topic: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any signal
Thread-Index: AQHaI83ukY9MluaJ202j4i3vSuy9G7CUP/NA
Date: Fri, 1 Dec 2023 11:13:06 +0000
Message-ID: <4642281ef2e749a3b69bbea5474ecdf1@AcuMS.aculab.com>
References: <20231127095842.389631-1-miquel.raynal@bootlin.com>
 <a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com>
 <0ce4c673-5c0b-4181-9d8b-53bcb0521f3e@raritan.com>
 <20231129094932.2639ca49@xps-13>
 <723263313.45007.1701348374765.JavaMail.zimbra@nod.at>
 <1192504136.46091.1701368767836.JavaMail.zimbra@nod.at>
 <20231130211543.2801a55b@xps-13>
 <d4ffca97-bb5d-4c42-a025-69b308c24f82@raritan.com>
In-Reply-To: <d4ffca97-bb5d-4c42-a025-69b308c24f82@raritan.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

Li4uDQo+IEFueXdheSwgdGhlIHdob2xlIGlzc3VlIHN0YXJ0ZWQgd2l0aCBjb21taXQgZTAyMDVk
NjIwM2MyICJzcGk6IGF0bWVsOg0KPiBQcmV2ZW50DQo+IGZhbHNlIHRpbWVvdXRzIG9uIGxvbmcg
dHJhbnNmZXJzIi4gQ2l0aW5nIHRoZSBjb21taXQgbWVzc2FnZSBoZXJlOg0KPiAgICAgICJzcGk6
IGF0bWVsOiBQcmV2ZW50IGZhbHNlIHRpbWVvdXRzIG9uIGxvbmcgdHJhbnNmZXJzDQo+IA0KPiAg
ICAgIEEgc2xvdyBTUEkgYnVzIGNsb2NrcyBhdCB+MjBNSHosIHdoaWNoIG1lYW5zIGl0IHdvdWxk
IHRyYW5zZmVyIGFib3V0DQo+ICAgICAgMjUwMCBieXRlcyBwZXIgc2Vjb25kIHdpdGggYSBzaW5n
bGUgZGF0YSBsaW5lLiBCaWcgdHJhbnNmZXJzLCBsaWtlIHdoZW4NCj4gICAgICBkZWFsaW5nIHdp
dGggZmxhc2hlcyBjYW4gZWFzaWx5IHJlYWNoIGEgZmV3IE1pQi4gVGhlIGN1cnJlbnQgRE1BDQo+
IHRpbWVvdXQNCj4gICAgICBpcyBzZXQgdG8gMSBzZWNvbmQsIHdoaWNoIG1lYW5zIGFueSB3b3Jr
aW5nIHRyYW5zZmVyIG9mIGFib3V0IDRNaUIgd2lsbA0KPiAgICAgIGFsd2F5cyBiZSBjYW5jZWxs
ZWQuDQo+IA0KPiAgICAgIFdpdGggdGhlIGFib3ZlIGRlcml2YXRpb25zLCBvbiBhIHNsb3cgYnVz
LCB3ZSBjYW4gYXNzdW1lIGV2ZXJ5IGJ5dGUNCj4gd2lsbA0KPiAgICAgIHRha2UgYXQgbW9zdCAw
LjRtcy4gU2FpZCBvdGhlcndpc2UsIHdlIGNvdWxkIGFkZCA0bXMgdG8gdGhlIDEtc2Vjb25kDQo+
ICAgICAgdGltZW91dCBkZWxheSBldmVyeSAxMGtpQi4gT24gYSA0TWlCIHRyYW5zZmVyLCBpdCB3
b3VsZCBicmluZyB0aGUNCj4gICAgICB0aW1lb3V0IGRlbGF5IHVwIHRvIDIuNnMgd2hpY2ggc3Rp
bGwgc2VlbXMgcmF0aGVyIGFjY2VwdGFibGUgZm9yIGENCj4gICAgICB0aW1lb3V0Lg0KPiANCj4g
ICAgICBUaGUgY29uc2VxdWVuY2Ugb2YgdGhpcyBpcyB0aGF0IGxvbmcgdHJhbnNmZXJzIG1pZ2h0
IGJlIGFsbG93ZWQsIHdoaWNoDQo+ICAgICAgaGVuY2UgcmVxdWlyZXMgdGhlIG5lZWQgdG8gaW50
ZXJydXB0IHRoZSB0cmFuc2ZlciBpZiB3YW50ZWQgYnkgdGhlDQo+ICAgICAgdXNlci4gV2UgY2Fu
IGhlbmNlIHN3aXRjaCB0byB0aGUgX2ludGVycnVwdGlibGUgdmFyaWFudCBvZg0KPiAgICAgIHdh
aXRfZm9yX2NvbXBsZXRpb24uIFRoaXMgbGVhZHMgdG8gYSBsaXR0bGUgYml0IG1vcmUgaGFuZGxp
bmcgdG8gYWxzbw0KPiAgICAgIGhhbmRsZSB0aGUgaW50ZXJydXB0ZWQgY2FzZSBidXQgbG9va3Mg
cmVhbGx5IGFjY2VwdGFibGUgb3ZlcmFsbC4NCj4gDQo+ICAgICAgV2hpbGUgYXQgaXQsIHdlIGRy
b3AgdGhlIHVzZWxlc3MsIG5vaXN5IGFuZCByZWR1bmRhbnQgV0FSTl9PTigpIGNhbGwuIg0KPiAN
Cj4gVGhpcyBjYWxjdWxhdGlvbiBpcyBhY3R1YWxseSB3cm9uZyBieSBmYWN0b3IgMTAwMC4gQSAy
ME1IeiBTUEkgYnVzIGlzIG5vdA0KPiByZWFsbHkgc2xvdyBhbmQgaXQgd2lsbCB0cmFuc2ZlciB+
Mi41TUIvcyBvdmVyIGEgc2luZ2xlIGxhbmUuDQo+IFRoZSBjYWxjdWxhdGlvbiB3b3VsZCBiZSBy
aWdodCBmb3IgMjBrSHogYnV0IEkgdGhpbmsgdGhpcyBpcyBhIG1vcmUNCj4gZXNvdGVyaWMgY2Fz
ZSwgaXNuJ3QgaXQ/DQoNClNvbWUgb2YgdGhlIHN1bXMgYXJlIHdyb25nLCBidXQgdGhlIGNvbmNs
dXNpb24gbWlnaHQgYmUgcmlnaHQuDQpBIDRNQiB0cmFuc2ZlciBhdCAyME1IeiBvbmx5IGhhcyA1
IGNsb2Nrcy9ieXRlIC0gc2VlbXMgbG93IGlmIGl0DQppcyBvbmx5IHVzaW5nIDEgZGF0YSBiaXQu
DQpUaGUgc3BpIGRldmljZXMgdXN1YWxseSBzdXBwb3J0ICduaWJibGUgbW9kZScgZm9yIHJlYWQv
d3JpdGUgdGhhdA0Kd2lsbCBzcGVlZCB0aGluZ3MgdXAgLSBwcm92aWRlZCB0aGUgZGF0YSBsaW5l
cyBhcmUgY29ubmVjdGVkLg0KDQpPVE9IIGEgYmV0dGVyIGZpeCBpcyAocHJvYmFibHkpIHRvIGRv
IHRoZSB0cmFuc2ZlciBpbiBzYW5lIHNpemVkIGNodW5rcy4NClRoZSBleHRyYSBpbnRlcnJ1cHQg
YW5kIGNvZGUgd29uJ3QgbWFrZSBtdWNoIGRpZmZlcmVuY2UgdG8gc29tZXRoaW5nDQp0aGF0IHRh
a2VzIHRoYXQgbG9uZy4NCg0KQXMgYW4gYXNpZGUsIGhhcyBhbnlvbmUgbWFuYWdlZCB0byBnZXQg
YW4gc3BpIG1lbW9yeSBkZXZpY2UgdG8gY2FsY3VsYXRlDQphIENSQz8gVGhlIG9uZXMgd2UgaGF2
ZSBjbGFpbSB0byBzdXBwb3J0IHRoZSByZXF1ZXN0IGJ1dCBJJ3ZlIGZhaWxlZCB0bw0KZ2V0IGl0
IHRvIHdvcmsuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


