Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07D42B558A
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 01:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgKQAI6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 19:08:58 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46928 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgKQAI5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 19:08:57 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4165E806AC;
        Tue, 17 Nov 2020 13:08:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1605571732;
        bh=wKzDSvjyemjUgMegwRGh/s2qiK7Q90DAOnmI1lz/PbI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=1Mn1NPsyJ4VCOMRqXYFf64lqfBs4NKzopnp37oDl32X4jmdNr8Cht/xcfObflzftB
         /kFnyUbzF+bQmMIOlAxfXB0nKw/udlPmtuHimGIt/ExI3iACbQ8McE7wp4ZHx8Tz3e
         N9IAQfuRyslmTJzLOGkIl/rDKTa9e5fgcc/qNsKNZj4Z4Exn+8AG7P8lS8WNBXhUya
         X64xvc4KT9j6P1ImDv0rnVbIBPHlUXyPAlcO4wyz619IeU4c9ff8RPRcLEDkncct3K
         NKpl71g8k0Sjw/+MuzK9MHC9XuGOv3mg7UYwSxRdhNh/8oSBf+Zf8TJ9hp0Hr5yayZ
         g7dQet3NXIdQA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5fb314930000>; Tue, 17 Nov 2020 13:08:51 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 17 Nov 2020 13:08:51 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.008; Tue, 17 Nov 2020 13:08:51 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v5 2/2] spi: Add generic SPI multiplexer
Thread-Topic: [PATCH v5 2/2] spi: Add generic SPI multiplexer
Thread-Index: AQHV2ws2/p8yDzV/8U25Wa5FU7HxrKnHGE6AgAVDVAA=
Date:   Tue, 17 Nov 2020 00:08:50 +0000
Message-ID: <104152dd-a51e-1893-cc6b-022aecd89250@alliedtelesis.co.nz>
References: <20200204032838.20739-3-chris.packham@alliedtelesis.co.nz>
 <20201113154633.21542-1-nsaenzjulienne@suse.de>
In-Reply-To: <20201113154633.21542-1-nsaenzjulienne@suse.de>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C940F91EF07274D86BCE85D636E8CD6@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQpPbiAxNC8xMS8yMCA0OjQ2IGFtLCBOaWNvbGFzIFNhZW56IEp1bGllbm5lIHdyb3RlOg0KPiBV
cG9uIHJlZ2lzdGVyaW5nIHNwaS1tdXgncyBkZXZpY2VzIHRocm91Z2ggc3BpX2FkZF9kZXZpY2Uo
KSB0aGUga2VybmVsIGdldHMNCj4gc3R1Y2sgd2FpdGluZyBmb3IgdGhlICdzcGlfYWRkX2xvY2sn
IG11dGV4IHRvIGJlIHJlbGVhc2VkLiBUaGUgbXV0ZXggaGFwcGVucyB0bw0KPiBiZSBoZWxkIGJ5
IHNwaS1tdXgncyBwYXJlbnQgU1BJIGJ1cywgd2hpY2ggdW5sdWNraWx5LCBpcyB3YWl0aW5nIGZv
ciBzcGktbXV4J3MNCj4gcHJvYmUgdG8gZmluaXNoIGJlZm9yZSByZWxlYXNpbmcgaXQuDQoNCkkg
anVzdCByZS10ZXN0ZWQgbXkgc3lzdGVtIHdpdGggdjUuMTAuMC1yYzQgYW5kIGRpZG4ndCBzZWUg
YW55IHByb2JsZW0uIA0KTXkgZHRzIGlzIHByZXR0eSBzaW1pbGFyIHRvIHlvdXJzIHRoZSBvbmx5
IG9idmlvdXMgdGhpbmcgbWlzc2luZyBpcyANCmBtdXgtY29udHJvbC1uYW1lcyA9ICJzcGkiO2Ag
YW5kIEkgYWxzbyBzZXQgYCNzaXplLWNlbGxzID0gPDE+O2AgKGxldCBtZSANCmtub3cgaWYgeW91
IHdhbnQgbWUgdG8gcG9zdCB0aGUgd2hvbGUgdGhpbmcpLg0KDQpJdCBtaWdodCBiZSBkZXBlbmRl
bnQgb24gdGhlIGhvc3Qgc3BpIGNvbnRyb2xsZXIuIFRoZSByZS10ZXN0IEkganVzdCBkaWQgDQp3
YXMgb24gYSBib2FyZCB1c2luZyB0aGUgc3BpLW9yaW9uLmMgZHJpdmVyIGFuZCBJIHRlc3RlZCBt
eSBvcmlnaW5hbCANCmNoYW5nZSBvbiBhIGJvYXJkIHVzaW5nIHNwaS1iY20tcXNwaS5jIChJIGhh
dmVuJ3QgZ290IHRoZSBib2FyZCBoYW5keSANCnJpZ2h0IG5vdyBidXQgSSBjb3VsZCBnbyBhbmQg
ZmluZCBvbmUgaWYgbmVjZXNzYXJ5KS4NCg0KPiBJIG1pZ2h0IGFzd2VsbCBiZSBkb2luZyBzb21l
dGhpbmcgd3JvbmcuIEJ1dCBzbyBmYXIgSSB0cnVzdCBteSBEVA0KPiBpbXBsZW1lbnRhdGlvbjoN
Cj4NCj4gCSZzcGkgew0KPiAJCXN0YXR1cyA9ICJva2F5IjsNCj4gCQlwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOw0KPiAJCXBpbmN0cmwtMCA9IDwmc3BpMF9ncGlvNz47DQo+DQo+IAkJc3BpQDAg
ew0KPiAJCQljb21wYXRpYmxlID0gInNwaS1tdXgiOw0KPiAJCQlyZWcgPSA8MD47DQo+IAkJCSNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAJCQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4gCQkJc3BpLW1h
eC1mcmVxdWVuY3kgPSA8MTAwMDAwMDAwPjsNCj4NCj4gCQkJbXV4LWNvbnRyb2xzID0gPCZncGlv
X211eD47DQo+DQo+IAkJCXc1NTAwQDAgew0KPiAJCQkJY29tcGF0aWJsZSA9ICJ3aXpuZXQsdzU1
MDAiOw0KPiAJCQkJcmVnID0gPDA+Ow0KPiAJCQkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsN
Cj4gCQkJCXBpbmN0cmwtMCA9IDwmZXRoMV9waW5zPjsNCj4gCQkJCWludGVycnVwdC1wYXJlbnQg
PSA8JmdwaW8+Ow0KPiAJCQkJaW50ZXJydXB0cyA9IDwyNyBJUlFfVFlQRV9FREdFX0ZBTExJTkc+
Ow0KPiAJCQkJc3BpLW1heC1mcmVxdWVuY3kgPSA8MzAwMDAwMDA+Ow0KPiAJCQl9Ow0KPg0KPiAJ
CQlzcGktZmxhc2hAMSB7DQo+IAkJCQljb21wYXRpYmxlID0gImplZGVjLHNwaS1ub3IiOw0KPiAJ
CQkJcmVnID0gPDE+Ow0KPiAJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+IAkJCQkjc2l6ZS1j
ZWxscyA9IDwwPjsNCj4gCQkJCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDE2MDAwMDAwPjsNCj4gCQkJ
fTsNCj4gCQl9Ow0KPiAJfTsNCj4NCj4gUmVnYXJkcywNCj4gTmljb2xhcw==
