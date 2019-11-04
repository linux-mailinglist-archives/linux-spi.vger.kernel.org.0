Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F651EE924
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2019 21:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfKDUGt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Nov 2019 15:06:49 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:44458 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfKDUGs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Nov 2019 15:06:48 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9209B8365A;
        Tue,  5 Nov 2019 09:06:43 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1572898003;
        bh=QjHD60cXYGA5rwMrtKgTa0FglpM0ZLFA0lhaMxRCaA0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=hvDu86LFPoy8xj/nPMCjWh3hLLJi9h8IsOfWCaoDVTzeB9pO2ok01VlECOdYIn/Om
         RB6BTNTNDbN5GkVnGwKl+C2V0ox0bRsQKEeH1k8pgNtsuwbsq9Z2S/XpYWpZ2sfN37
         YvlIuWoCC4Om3Em9L6FpDVNC4scfUdKg1LKMKZFoo7PvdeQHdeZ21AIanJCmDOsQvF
         4Wjlk/MEkkirsKgXzIy/QBWg41XsEUzNoFMxNpjIIK69loPzXr3cFouQViLT9R7bv/
         OsMqjNysZSArxrvctcb7pQJ1gwcAtRJ0IMXcsuZ0min32EckNqM6MEFzOeOR/SYDH6
         rUJ3GeGJAqBQg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5dc084d40000>; Tue, 05 Nov 2019 09:06:44 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Tue, 5 Nov 2019 09:06:43 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Tue, 5 Nov 2019 09:06:43 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spi-mem and gpio chipselects
Thread-Topic: spi-mem and gpio chipselects
Thread-Index: AQHVkqe/99KPV78Qa0mRy221SIO+EKd6HAYAgAB7fAA=
Date:   Mon, 4 Nov 2019 20:06:42 +0000
Message-ID: <039edb7cdd9114ad7a14e27f869db6c85d756418.camel@alliedtelesis.co.nz>
References: <cbe69f5457c4dd1c2cc96a247c6c6fca61c0d43c.camel@alliedtelesis.co.nz>
         <20191104124444.GB5238@sirena.co.uk>
In-Reply-To: <20191104124444.GB5238@sirena.co.uk>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:d0c9:dea8:da1e:f79e]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBD24C53A2CF2E449E990610426137AD@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gTW9uLCAyMDE5LTExLTA0IGF0IDEyOjQ0ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBNb24sIE5vdiAwNCwgMjAxOSBhdCAxMjozNToyNEFNICswMDAwLCBDaHJpcyBQYWNraGFtIHdy
b3RlOg0KPiANCj4gPiBJJ20gd29ya2luZyBvbiBhIHBsYXRmb3JtIHRoYXQgaGFzIGEgc2xpZ2h0
bHkgY29tcGxpY2F0ZWQgc2NoZW1lIGZvcg0KPiA+IFNQSSBjaGlwLXNlbGVjdHMgdXNpbmcgZ3Bp
b3NbMV0uIFRoZSBzcGkgY29udHJvbGxlciBkcml2ZXIgaW4gdGhpcyBjYXNlDQo+ID4gc3VwcG9y
dHMgdGhlIHNwaS1tZW0gb3BlcmF0aW9ucyB3aGljaCBhcHBlYXIgdG8gYnlwYXNzIHRoZSBnZW5l
cmljDQo+ID4gc3BpX3NldF9jcygpLg0KPiA+IFdvdWxkIHRoZXJlIGJlIGFueSBoYXJtIGluIGFk
ZGluZyBjYWxscyB0byBzcGlfc2V0X2NzKCkgdG8gc3BpLW1lbS5jPw0KPiA+IE5haXZlbHkgc3Bp
X21lbV9hY2Nlc3Nfc3RhcnQoKSBhbmQgc3BpX21lbV9hY2Nlc3NfZW5kKCkgc2VlbSBsaWtlDQo+
ID4gY29udmVuaWVudCBwbGFjZXMgdG8gc3RhcnQuDQo+IA0KPiBUaGF0J3Mgb25seSBnb2luZyB0
byB3b3JrIGluIGNhc2VzIHdoZXJlIHRoZSBjb250cm9sbGVyIHRyYW5zbGF0ZXMNCj4gdGhpbmdz
IGludG8gYSBzaW5nbGUgU1BJIG9wZXJhdGlvbiBvbiB0aGUgZmxhc2ggd2hpY2ggSSdtIG5vdCBz
dXJlIGlzDQo+IGFsd2F5cyBnb2luZyB0byBiZSB0aGUgY2FzZS4gIFdlJ2QgbmVlZCBhIHdheSB0
byBndWFyYW50ZWUgdGhhdCB0aGUNCj4gY29udHJvbGxlciBpcyBnb2luZyB0byBkbyB0aGF0IGlu
IG9yZGVyIHRvIGF2b2lkIGRhdGEgY29ycnVwdGlvbiBpc3N1ZXMuDQoNCkluIG15IHBhcnRpY3Vs
YXIgY2FzZSAoc3BpLWJjbS1xc3BpLmMpIGJjbV9xc3BpX2JzcGlfZXhlY19tZW1fb3AoKSBkb2Vz
DQpzZWVtIHRvIGFzc2VydCB0aGUgbmF0aXZlIGNoaXAtc2VsZWN0IHRoZW4gZG8gaXQncyBvcGVy
YXRpb24uIEFzIEkNCnVuZGVyc3RhbmQgdGhlIHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgp
IHdpbGwgc2NoZWR1bGUgc28gb3RoZXINCnRhc2tzIG1heSBydW4gYnV0IHNwaV9tZW1fYWNjZXNz
X3N0YXJ0KCkgaGFzIHRha2VuIGFuIGlvX211dGV4IHNvDQphbnl0aGluZyB0aGF0IGFjY2Vzc2Vz
IHRoYXQgc3BpIGJ1cyB3aWxsIGJsb2NrLg0K
