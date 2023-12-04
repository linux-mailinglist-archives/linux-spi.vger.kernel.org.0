Return-Path: <linux-spi+bounces-123-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6912C803264
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 13:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF8F1C20A19
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0858B2375B;
	Mon,  4 Dec 2023 12:20:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3BEDF
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 04:20:13 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-60-K7DYLW98P6-DWLMqtfZ-_w-1; Mon, 04 Dec 2023 12:20:10 +0000
X-MC-Unique: K7DYLW98P6-DWLMqtfZ-_w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 4 Dec
 2023 12:19:51 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 4 Dec 2023 12:19:51 +0000
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
Thread-Index: AQHaI83ukY9MluaJ202j4i3vSuy9G7CUP/NAgAAvu4CABJ+L0A==
Date: Mon, 4 Dec 2023 12:19:51 +0000
Message-ID: <b0070511200c4e11b3b57e3c77e05388@AcuMS.aculab.com>
References: <20231127095842.389631-1-miquel.raynal@bootlin.com>
 <a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com>
 <0ce4c673-5c0b-4181-9d8b-53bcb0521f3e@raritan.com>
 <20231129094932.2639ca49@xps-13>
 <723263313.45007.1701348374765.JavaMail.zimbra@nod.at>
 <1192504136.46091.1701368767836.JavaMail.zimbra@nod.at>
 <20231130211543.2801a55b@xps-13>
 <d4ffca97-bb5d-4c42-a025-69b308c24f82@raritan.com>
 <4642281ef2e749a3b69bbea5474ecdf1@AcuMS.aculab.com>
 <c7980bbf-04aa-4c52-9c6c-f3a1169e90f9@raritan.com>
In-Reply-To: <c7980bbf-04aa-4c52-9c6c-f3a1169e90f9@raritan.com>
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

Li4uDQo+ID4+IFRoaXMgY2FsY3VsYXRpb24gaXMgYWN0dWFsbHkgd3JvbmcgYnkgZmFjdG9yIDEw
MDAuIEEgMjBNSHogU1BJIGJ1cyBpcyBub3QNCj4gPj4gcmVhbGx5IHNsb3cgYW5kIGl0IHdpbGwg
dHJhbnNmZXIgfjIuNU1CL3Mgb3ZlciBhIHNpbmdsZSBsYW5lLg0KPiA+PiBUaGUgY2FsY3VsYXRp
b24gd291bGQgYmUgcmlnaHQgZm9yIDIwa0h6IGJ1dCBJIHRoaW5rIHRoaXMgaXMgYSBtb3JlDQo+
ID4+IGVzb3RlcmljIGNhc2UsIGlzbid0IGl0Pw0KPiA+DQo+ID4gU29tZSBvZiB0aGUgc3VtcyBh
cmUgd3JvbmcsIGJ1dCB0aGUgY29uY2x1c2lvbiBtaWdodCBiZSByaWdodC4NCj4gPiBBIDRNQiB0
cmFuc2ZlciBhdCAyME1IeiBvbmx5IGhhcyA1IGNsb2Nrcy9ieXRlIC0gc2VlbXMgbG93IGlmIGl0
DQo+ID4gaXMgb25seSB1c2luZyAxIGRhdGEgYml0Lg0KPiANCj4gQ2FuJ3QgcmVhbGx5IGZvbGxv
dy4gRWFjaCBkYXRhIGJpdCByZXF1aXJlcyBvbmUgY2xvY2sgb24gc2luZ2xlIHdpcmUNCj4gU1BJ
LiBBZHJlc3NpbmcgYW5kIHRoZSBsaWtlIG1heSByZXF1aXJlIGEgYml0IG9mIG92ZXJoZWFkIGJ1
dCB0aGF0DQo+IHNob3VsZCBub3QgYmUgdGhhdCBtdWNoICgxMi41JT8pLg0KDQpUaGF0IGlzIGZv
ciA0TUIgaW4gb25lIHNlY29uZCBhdCAyME1Iei4NCg0KQW4gU1BJIHJlYWQgdHJhbnNmZXIgY2Fu
IGJlIHByZXR0eSBtdWNoIGFueSBsZW5ndGggLSB5b3UganVzdCBrZWVwDQpvbiBjbG9ja2luZyBv
dXQgZGF0YS4gVGhlIG92ZXJoZWFkIGlzIGluZGVwZW5kZW50IG9mIHRoZSBsZW5ndGguDQoNCkEg
bWVtb3J5IGNlbGwganVzdCByZW1pbmRlZCBtZSB0aGF0IHNvbWUgU1BJIGRldmljZXMgYXJlIG1h
ZGUNCm9mIHR3byAob3IgbW9yZSkgbWVtb3J5IGJsb2NrcyAtIGFuZCB5b3UgY2FuJ3QgZG8gc2Vx
dWVudGlhbA0KcmVhZHMgZnJvbSBvbmUgYmxvY2sgdG8gdGhlIG5leHQuDQooSXQgbWlnaHQgYmUg
bHlpbmcuLi4pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


