Return-Path: <linux-spi+bounces-5758-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6E39D3246
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 03:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D452843D8
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 02:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30BB482DD;
	Wed, 20 Nov 2024 02:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="A1/tHHa/"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897DA224D4
	for <linux-spi@vger.kernel.org>; Wed, 20 Nov 2024 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732070487; cv=none; b=Ac9WqDUof4VbxX9Z7PwZ7w8Wr5Co/Ha/i4wGb1fRstNQ6FEqm/YpbeLVKsIAt3ns9ftSklR0lT0/tSDdFoAQ0SMiSrFrEwWiIctiJUwy02lG6oH5RM0RsoyMqRmAPvkPFc2C9ZDIrK3OJ/x7OOpfuAK1Fq48MTwCSjcnVZU/c7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732070487; c=relaxed/simple;
	bh=91eWlc5eZBkqkOB4ChVP5gUd5xtOD3zDkofW7pkJzPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hh60uGYVEA8xDrsjaLraBlYL/UUsAVwxV3UURwhUWKaWbIqvZULCLRS3k1xo8HRMYXqA/QCeh5e7ciY/ILPGKxHtimwmiIBn9QS/62xLSgp3uzQLALP/j/Cbg60s73YIXBfkDzW8m6ZmTvWthoNnOUiMzK7Ni9sShWn6vg88UY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=A1/tHHa/; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B01012C03E8;
	Wed, 20 Nov 2024 15:41:15 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1732070475;
	bh=91eWlc5eZBkqkOB4ChVP5gUd5xtOD3zDkofW7pkJzPU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=A1/tHHa/6D9mTAdRYbAVt53FJl69LZ1f6ptb25LDnPmozHo/jSawlnDVDDOgJIE3R
	 d6e1RVBthtiRc6bjXAokxnR87Nh/aNlx3tOU2PiYAx0926rJ4UJVgAfNQRd/8buW/D
	 AvjrFoVfmNff96WLKbZwlDpMpWj2r9VonrQy72jsyrsQegQMK73cAh2JetImOOiTC7
	 F9V/1UYtmZfxs7hjtmdLzZP7giBFS4VC1zgodLKQkkdEQtg0NAWYuB8uIYr1zXu16S
	 WuWATmOm407nQJaxph37f2dbSZy+mDd3kXE8OcYfHEzpgae/wlMSQ6vmG0VLdLs4U0
	 JHizCUiP2JH+Q==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B673d4c4b0001>; Wed, 20 Nov 2024 15:41:15 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Nov 2024 15:41:15 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Wed, 20 Nov 2024 15:41:15 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "broonie@kernel.org" <broonie@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "tsbogend@alpha.franken.de"
	<tsbogend@alpha.franken.de>, "markus.stockhausen@gmx.de"
	<markus.stockhausen@gmx.de>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] mips: dts: realtek: Add SPI NAND controller
Thread-Topic: [PATCH v5 2/3] mips: dts: realtek: Add SPI NAND controller
Thread-Index: AQHbH1U4/mGTnZ5p60+M9ubQPAR5c7K+0r2A
Date: Wed, 20 Nov 2024 02:41:15 +0000
Message-ID: <3c6f90bc-2223-447d-9094-81011a2815b0@alliedtelesis.co.nz>
References: <20241015225434.3970360-1-chris.packham@alliedtelesis.co.nz>
 <20241015225434.3970360-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20241015225434.3970360-3-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BC56FE4D01F6A489BDADE5E28104F2F@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Gam0nhXL c=1 sm=1 tr=0 ts=673d4c4b a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=ToiQWlOc-a4dKcAUQ18A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgVGhvbWFzLA0KDQpPbiAxNi8xMC8yNCAxMTo1NCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4g
QWRkIHRoZSBTUEktTkFORCBjb250cm9sbGVyIG9uIHRoZSBSVEw5MzAwIGZhbWlseSBvZiBkZXZp
Y2VzLiBUaGlzDQo+IHN1cHBvcnRzIHNlcmlhbC9kdWFsL3F1YWQgZGF0YSB3aWR0aCBhbmQgRE1B
IGZvciByZWFkL3Byb2dyYW0NCj4gb3BlcmF0aW9ucy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQ2hy
aXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KDQpIYXMgdGhp
cyBvbmUgZmFsbGVuIHRocm91Z2ggdGhlIGNyYWNrcz8NCg0KSSBzZWUgeW91IHBpY2tlZCB1cCBh
IGNvdXBsZSBvZiBteSBvdGhlciBjaGFuZ2VzIGZvciA2LjEzIGJ1dCB0aGlzIHNlZW1zIA0KdG8g
YmUgbWlzc2luZyBmcm9tIG1pcHMvbGludXguDQoNCj4gLS0tDQo+DQo+IE5vdGVzOg0KPiAgICAg
IENoYW5nZXMgaW4gdjQgJiB2NToNCj4gICAgICAtIG5vbmUNCj4gICAgICBDaGFuZ2VzIGluIHYz
Og0KPiAgICAgIC0gZHJvcCB3aWxkY2FyZCBydGw5MzAwLXNuYW5kIGNvbXBhdGlibGUNCj4gICAg
ICAtIGRyb3AgY2xvY2stbmFtZXMNCj4gICAgICBDaGFuZ2VzIGluIHYyOg0KPiAgICAgIC0gQWRk
IGNsb2Nrcw0KPg0KPiAgIGFyY2gvbWlwcy9ib290L2R0cy9yZWFsdGVrL3J0bDkzMHguZHRzaSB8
IDEzICsrKysrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2Jvb3QvZHRzL3JlYWx0ZWsvcnRsOTMweC5kdHNp
IGIvYXJjaC9taXBzL2Jvb3QvZHRzL3JlYWx0ZWsvcnRsOTMweC5kdHNpDQo+IGluZGV4IGYyNzE5
NDBmODJiZS4uYjAxYTQwZWMzMDY0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL21pcHMvYm9vdC9kdHMv
cmVhbHRlay9ydGw5MzB4LmR0c2kNCj4gKysrIGIvYXJjaC9taXBzL2Jvb3QvZHRzL3JlYWx0ZWsv
cnRsOTMweC5kdHNpDQo+IEBAIC0zMiw2ICszMiw4IEBAIGx4X2NsazogY2xvY2stMTc1bWh6IHsN
Cj4gICB9Ow0KPiAgIA0KPiAgICZzb2Mgew0KPiArCXJhbmdlcyA9IDwweDAgMHgxODAwMDAwMCAw
eDIwMDAwPjsNCj4gKw0KPiAgIAlpbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxlckAzMDAwIHsNCj4g
ICAJCWNvbXBhdGlibGUgPSAicmVhbHRlayxydGw5MzAwLWludGMiLCAicmVhbHRlayxydGwtaW50
YyI7DQo+ICAgCQlyZWcgPSA8MHgzMDAwIDB4MTg+LCA8MHgzMDE4IDB4MTg+Ow0KPiBAQCAtNTks
NiArNjEsMTcgQEAgdGltZXIwOiB0aW1lckAzMjAwIHsNCj4gICAJCWludGVycnVwdHMgPSA8Nz4s
IDw4PiwgPDk+LCA8MTA+LCA8MTE+Ow0KPiAgIAkJY2xvY2tzID0gPCZseF9jbGs+Ow0KPiAgIAl9
Ow0KPiArDQo+ICsJc25hbmQ6IHNwaUAxYTQwMCB7DQo+ICsJCWNvbXBhdGlibGUgPSAicmVhbHRl
ayxydGw5MzAxLXNuYW5kIjsNCj4gKwkJcmVnID0gPDB4MWE0MDAgMHg0ND47DQo+ICsJCWludGVy
cnVwdC1wYXJlbnQgPSA8JmludGM+Ow0KPiArCQlpbnRlcnJ1cHRzID0gPDE5PjsNCj4gKwkJY2xv
Y2tzID0gPCZseF9jbGs+Ow0KPiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJI3NpemUt
Y2VsbHMgPSA8MD47DQo+ICsJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsJfTsNCj4gICB9Ow0K
PiAgIA0KPiAgICZ1YXJ0MCB7

