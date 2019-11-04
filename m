Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E78EE964
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2019 21:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfKDUX3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Nov 2019 15:23:29 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:44479 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfKDUX3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Nov 2019 15:23:29 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 907CE8365A;
        Tue,  5 Nov 2019 09:23:24 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1572899004;
        bh=LbFnKvc7CLUlS0furVCad1JHIwSt1C8lJgyb2pYnGXQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=fIkrS1D3gFfOdM4LUfxkrIp4KHIPaGBIf1on2HkaAzddlN7BmnYjU5MWgtCyr6mhT
         y0w6pM/jHN210FbIZb2BlhSOoqC9s85ToxQbVbo1NAtlGhkDe9zVqdvXiEm5o1s+tR
         6YhJBXbPRZThsLjr9jtFDh+Jny7oH/8SXopiJXZbpdTVBX2WTnAJ1XvWrv7Sqgl6No
         7wdgdJoFXBt7mVklG8681BM78AxBpmw/zSwfKf4Jk+ykHw2ThrHkDEKz2oJqsZJlUP
         TnEJ5Wq8vGIhZYxY4Mzaq2EvW0zKcVkWiA860EDYZ1Y8M8iC/imNGf3Aa/pXGK5mav
         N06SVAXzNLo6A==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5dc088b90000>; Tue, 05 Nov 2019 09:23:25 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Tue, 5 Nov 2019 09:23:20 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Tue, 5 Nov 2019 09:23:20 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spi-mem and gpio chipselects
Thread-Topic: spi-mem and gpio chipselects
Thread-Index: AQHVkqe/99KPV78Qa0mRy221SIO+EKd6HAYAgAB7fACAAASmAA==
Date:   Mon, 4 Nov 2019 20:23:20 +0000
Message-ID: <52aaa7364a0b40caf5f74817932de9e32d148772.camel@alliedtelesis.co.nz>
References: <cbe69f5457c4dd1c2cc96a247c6c6fca61c0d43c.camel@alliedtelesis.co.nz>
         <20191104124444.GB5238@sirena.co.uk>
         <039edb7cdd9114ad7a14e27f869db6c85d756418.camel@alliedtelesis.co.nz>
In-Reply-To: <039edb7cdd9114ad7a14e27f869db6c85d756418.camel@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:d0c9:dea8:da1e:f79e]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A84ED40793E494085BDB02FBCBEA280@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVHVlLCAyMDE5LTExLTA1IGF0IDA5OjA2ICsxMzAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0K
PiBPbiBNb24sIDIwMTktMTEtMDQgYXQgMTI6NDQgKzAwMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+
ID4gT24gTW9uLCBOb3YgMDQsIDIwMTkgYXQgMTI6MzU6MjRBTSArMDAwMCwgQ2hyaXMgUGFja2hh
bSB3cm90ZToNCj4gPiANCj4gPiA+IEknbSB3b3JraW5nIG9uIGEgcGxhdGZvcm0gdGhhdCBoYXMg
YSBzbGlnaHRseSBjb21wbGljYXRlZCBzY2hlbWUgZm9yDQo+ID4gPiBTUEkgY2hpcC1zZWxlY3Rz
IHVzaW5nIGdwaW9zWzFdLiBUaGUgc3BpIGNvbnRyb2xsZXIgZHJpdmVyIGluIHRoaXMgY2FzZQ0K
PiA+ID4gc3VwcG9ydHMgdGhlIHNwaS1tZW0gb3BlcmF0aW9ucyB3aGljaCBhcHBlYXIgdG8gYnlw
YXNzIHRoZSBnZW5lcmljDQo+ID4gPiBzcGlfc2V0X2NzKCkuDQo+ID4gPiBXb3VsZCB0aGVyZSBi
ZSBhbnkgaGFybSBpbiBhZGRpbmcgY2FsbHMgdG8gc3BpX3NldF9jcygpIHRvIHNwaS1tZW0uYz8N
Cj4gPiA+IE5haXZlbHkgc3BpX21lbV9hY2Nlc3Nfc3RhcnQoKSBhbmQgc3BpX21lbV9hY2Nlc3Nf
ZW5kKCkgc2VlbSBsaWtlDQo+ID4gPiBjb252ZW5pZW50IHBsYWNlcyB0byBzdGFydC4NCj4gPiAN
Cj4gPiBUaGF0J3Mgb25seSBnb2luZyB0byB3b3JrIGluIGNhc2VzIHdoZXJlIHRoZSBjb250cm9s
bGVyIHRyYW5zbGF0ZXMNCj4gPiB0aGluZ3MgaW50byBhIHNpbmdsZSBTUEkgb3BlcmF0aW9uIG9u
IHRoZSBmbGFzaCB3aGljaCBJJ20gbm90IHN1cmUgaXMNCj4gPiBhbHdheXMgZ29pbmcgdG8gYmUg
dGhlIGNhc2UuICBXZSdkIG5lZWQgYSB3YXkgdG8gZ3VhcmFudGVlIHRoYXQgdGhlDQo+ID4gY29u
dHJvbGxlciBpcyBnb2luZyB0byBkbyB0aGF0IGluIG9yZGVyIHRvIGF2b2lkIGRhdGEgY29ycnVw
dGlvbiBpc3N1ZXMuDQo+IA0KPiBJbiBteSBwYXJ0aWN1bGFyIGNhc2UgKHNwaS1iY20tcXNwaS5j
KSBiY21fcXNwaV9ic3BpX2V4ZWNfbWVtX29wKCkgZG9lcw0KPiBzZWVtIHRvIGFzc2VydCB0aGUg
bmF0aXZlIGNoaXAtc2VsZWN0IHRoZW4gZG8gaXQncyBvcGVyYXRpb24uIEFzIEkNCj4gdW5kZXJz
dGFuZCB0aGUgd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCkgd2lsbCBzY2hlZHVsZSBzbyBv
dGhlcg0KPiB0YXNrcyBtYXkgcnVuIGJ1dCBzcGlfbWVtX2FjY2Vzc19zdGFydCgpIGhhcyB0YWtl
biBhbiBpb19tdXRleCBzbw0KPiBhbnl0aGluZyB0aGF0IGFjY2Vzc2VzIHRoYXQgc3BpIGJ1cyB3
aWxsIGJsb2NrLg0KDQpJZiB3ZSBkbyBkZWNpZGUgdGhhdCBzcGktbWVtIG9wcyBhbmQgY3NfZ3Bp
b3MgYXJlIGluY29tcGF0aWJsZSB3ZSBjb3VsZA0KcHJvYmFibHkgZG8gc29tZXRoaW5nIHRoYXQg
ZGlzYWJsZXMgdGhlIG9wcyBzbyB0aGF0IHRoZSBzcGkgY29kZSBmYWxscw0KYmFjayB0byB1c2lu
ZyBzcGlfdHJhbnNmZXIuDQo=
