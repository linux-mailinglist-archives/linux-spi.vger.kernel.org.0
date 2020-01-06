Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C46131BBD
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2020 23:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgAFWoV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jan 2020 17:44:21 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40297 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFWoV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jan 2020 17:44:21 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E0E07886BF;
        Tue,  7 Jan 2020 11:44:17 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1578350657;
        bh=5mvKZjfPC/wHzMA/E152Kx26IjgKBDJmqvwsBn/fXBk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=gKkheQ+BkrW+2ZDGn09iL4H1laOixMPlxtONyw9lLvBgDus2BHFS48ysUwKFnh3qO
         aGiYmNakd+Jsd1khSVqNU4Q5VgHk9QiZkh89fx+eLVe4voH4tOYUBOB7+T8f8BZe9z
         X8O9LBko/b+UFUz7VvuG62lyVJ/NWTarA6KYZ73674j+DQX0s+oCu2xtYWyNVVDj0s
         RUU5tU353vpeDZmh4rT3MnVMDVyFwbLVfVuheFnXcGiYt+oO43etOtzNmS9aAi13o4
         F6rSb41QbflLaj60SgGBeApfetLVhOMXihZWr+jGL9iTOWKCSp8sWJG73J3wqWI4c6
         ctCuVgwmrKztQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e13b8420000>; Tue, 07 Jan 2020 11:44:18 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan 2020 11:44:16 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Tue, 7 Jan 2020 11:44:16 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "dries.vanpuymbroeck@dekimo.com" <dries.vanpuymbroeck@dekimo.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "anthony.derosa@syscall7.com" <anthony.derosa@syscall7.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Multiplex SPI Chip Selects
Thread-Topic: Multiplex SPI Chip Selects
Thread-Index: AQHVwK6/lje3qJHLR02SM15vWygu1Kfbt1oAgAEXgYCAAJt+gA==
Date:   Mon, 6 Jan 2020 22:44:15 +0000
Message-ID: <2db6a1c2463ca5cf41795b5348e17cfbd7de5fe3.camel@alliedtelesis.co.nz>
References: <CAB595VxuL+iOQD3Re1PbjP50GD51XuMML8_R6Ku2ywAAHcOcdw@mail.gmail.com>
         <a0171241162171ffac6429d29edfaa83fbd9a2ba.camel@alliedtelesis.co.nz>
         <CAB595VzfMRU4Pejuzi0jODvu9p_mh473-cdK92jxSxk3yPHtqw@mail.gmail.com>
In-Reply-To: <CAB595VzfMRU4Pejuzi0jODvu9p_mh473-cdK92jxSxk3yPHtqw@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:58ea:709b:f54a:25e0]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDC42EFBF9BF2346A0738A1FFAA48CB3@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gTW9uLCAyMDIwLTAxLTA2IGF0IDA4OjI3IC0wNTAwLCBBbnRob255IERlUm9zYSB3cm90ZToN
Cj4gSGkgQ2hyaXMsDQo+IA0KPiBPbiBTdW4sIEphbiA1LCAyMDIwIGF0IDM6NDcgUE0gQ2hyaXMg
UGFja2hhbQ0KPiA8Q2hyaXMuUGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56PiB3cm90ZToNCj4g
PiANCj4gPiBIaSBBbnRob255LA0KPiA+IA0KPiA+ID4gT24gV2VkLCAyMDIwLTAxLTAxIGF0IDA5
OjIxIC0wNTAwLCBBbnRob255IERlUm9zYSB3cm90ZToNCj4gPiA+IEhpIENocmlzLA0KPiA+ID4g
DQo+ID4gPiBJIHNhdyB5b3VyIHRocmVhZFsxXSBhYm91dCBtdWx0aXBsZXhpbmcgY2hpcCBzZWxl
Y3RzIG9uIHRoZSBTUEkgYnVzDQo+ID4gPiBhbmQgd29uZGVyZWQgd2hhdCBzb2x1dGlvbiB5b3Ug
c2V0dGxlZCBvbiBpbiB0aGUgZW5kLiBMb29rcyBsaWtlIHlvdXINCj4gPiA+IHBhdGNoIHdhcyBu
b3QgaW50ZWdyYXRlZCBpbnRvIHRoZSBrZXJuZWwsIGlzIHRoYXQgcmlnaHQ/IEkgaGF2ZSBhDQo+
ID4gPiBzaW1pbGFyIHByb2JsZW0gd2hlcmUgSSBuZWVkIHRvIHVzZSBHUElPcyB0byBtdWx0aXBs
ZXggdGhlIENTMCBwaW4gb24NCj4gPiA+IGEgcmFzcGJlcnJ5IHBpLiBBbnkgaW5zaWdodHMgd291
bGQgYmUgYXBwcmVjaWF0ZWQuDQo+ID4gPiANCj4gPiANCj4gPiBGb3IgdGhlIHNpbXBsZSBjYXNl
IHRoZSBleGlzdGluZyBjcy1ncGlvcyBzdXBwb3J0IHdvcmtzIHdlbGwuIFNvIHVzaW5nDQo+ID4g
dGhhdCBpZiB5b3UgY2FuIGlzIG15IHJlY29tbWVuZGF0aW9uLg0KPiA+IA0KPiA+IFVuZm9ydHVu
YXRlbHkgZm9yIG1lIGl0J3Mgbm90IHRoYXQgc2ltcGxlIGJlY2F1c2UgSSBoYXZlIDIgcGxhdGZv
cm1zDQo+ID4gd2hpY2ggbmVlZCBib3RoIHRoZSBncGlvIENTIGFuZCB0aGUgbmF0aXZlIENTMC4g
VGhpcyBpcyB3aGVyZSB0aGluZ3MNCj4gPiBnZXQgYSBiaXQgdHJpY2t5Lg0KPiA+IA0KPiA+IFRo
ZSBleGlzdGluZyBjb2RlIHdpbGwgaW52ZXJ0IHRoZSBuYXRpdmUgQ1MwIChiZWNhdXNlIFNQSV9D
U19ISUdIIGlzDQo+ID4gc2V0KSBJIHRoaW5rIHRoaXMgaXMgYSBzdHJhaWdodCBjb3JuZXItY2Fz
ZSBidWcgYW5kIHdlIHNob3VsZCBlaXRoZXINCj4gPiBub3QgaW52ZXJ0IHRoZSBuYXRpdmUgQ1Mw
IG9yIGhhdmUgYSBzZXBhcmF0ZSBmbGFnIHRvIGluZGljYXRlIHdoZW4gdGhlDQo+ID4gbmF0aXZl
IENTMCBuZWVkcyBpbnZlcnRpbmcuDQo+ID4gDQo+ID4gRm9yIHRoZSAyIHBsYXRmb3JtcyBJJ20g
ZGVhbGluZyB3aXRoIEkgaGF2ZSBhIGNvbXBsaWNhdGlvbiBpbiB0aGUgSFcNCj4gPiBkZXNpZ24g
d2hlcmUgdGhlIGdwaW8gaXMgdXNlZCB0byBzdGVlciB0aGUgbmF0aXZlIENTMCAoYXMgb3Bwb3Nl
ZCB0bw0KPiA+IHJlcGxhY2luZyBpdCkgd2hpY2ggaXMgd2hhdCBteSBvcmlnaW5hbCBzZXJpZXMg
YXR0ZW1wdGVkIHRvIGRlYWwgd2l0aC4NCj4gPiBJIGVuZGVkIHVwIGltcGxlbWVudGluZyBhIGdw
aW8tb3Zlci1ncGlvIGNvbnRyb2xsZXIgdGhhdCBwcmVzZW50ZWQgMg0KPiA+IHZpcnR1YWwgZ3Bp
b3Mgd2hpY2ggcmVmbGVjdGVkIHRoZSBoaWdoLWxvdyBzdGF0ZSBvZiBhIHNpbmdsZSBwaHlzaWNh
bA0KPiA+IGdwaW8gKGJhc2ljYWxseSBpbXBsZW1lbnRlZCBNYXJrJ3Mgc3VnZ2VzdGlvbiBmcm9t
IHRoZSB0aHJlYWQpLiBJDQo+ID4gaGF2ZW4ndCBhdHRlbXB0ZWQgdG8gdXBzdHJlYW0gdGhlIGRy
aXZlciBiZWNhdXNlIEkgY29uc2lkZXIgaXQgYSBTVyBmaXgNCj4gPiBmb3IgcXVpcmsgb2Ygb3Vy
IEhXIGRlc2lnbnMsIGJ1dCBpZiB0aGVyZSBpcyBpbnRlcmVzdCBJIGNvdWxkIGF0IGxlYXN0DQo+
ID4gc2VuZCBpdCBvdXQuDQo+DQo+IFRoYW5rcyBmb3IgeW91ciByZXNwb25zZS4gVGhlIGNzLWdw
aW9zIGFyZSBub3Qgc3VmZmljaWVudCBmb3IgbWUsDQo+IGJlY2F1c2UgdGhlIGNzLWdwaW9zIHBy
b3ZpZGUgTiBtb3JlIGNoaXAgc2VsZWN0cywgYnV0IHdlIG5lZWQgMl5OIG1vcmUNCj4gY2hpcCBz
ZWxlY3RzLiBXZSBhcmUgdXNpbmcgYSA0OjE2IGFkZHJlc3MgZGVjb2RlciB0aGF0IGlzIGNvbnRy
b2xsZWQNCj4gYnkgR1BJT3MgdG8gZXh0ZW5kIHRoZSBudW1iZXIgb2YgY2hpcCBzZWxlY3RzIGF2
YWlsYWJsZSBsaWtlIHRoaXMNCj4gKHJlcXVpcmVzIGZpeGVkLXdpZHRoIGZvbnQgdG8gdmlldyk6
DQo+IA0KPiArICAgICAgTU9TSSAvLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0t
LS0tLS0rLS0tLS0tLS0rLS0tLS0tLS1cDQo+ICsgICAgICBNSVNPIHwvLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tK3wtLS0tLS0tK3wtLS0tLS0tK3wtLS0tLS0tXHwNCj4gKyAgICAgICBT
Q0wgfHwvLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSt8fC0tLS0tLSt8fC0tLS0tLSt8fC0t
LS0tLVx8fA0KPiArICAgICAgICAgICB8fHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgfHx8
ICAgICAgfHx8ICAgICAgfHx8ICAgICAgfHx8DQo+ICsgICAgKy0tLS0tLS0tLS0tLSsgICAgICAg
ICAgICAgICAgICAgICAgICB8fHwgICAgICB8fHwgICAgICB8fHwgICAgICB8fHwNCj4gKyAgICB8
IFNvQyAgfHx8ICAgfCAgICAgICAgICAgICAgICAgICAgICArLSsrKy0rICArLSsrKy0rICArLSsr
Ky0rICArLSsrKy0rDQo+ICsgICAgfCAgICAgIHx8fCAgIHwgICAgICAgICAgICAgICAgICAgICAg
fCBkZXYgfCAgfCBkZXYgfCAgfCBkZXYgfCAgfCBkZXYgfA0KPiArICAgIHwgICArLS0rKystKyB8
IENTLVggICstLS0tLS0rXCAgICAgICstLSstLSsgICstLSstLSsgICstLSstLSsgICstLSstLSsN
Cj4gKyAgICB8ICAgfCBTUEkgICstfC0tLS0tLS0rIE11eCAgfFxcICAgQ1MtMCB8ICAgICAgICB8
ICAgICAgICB8ICAgICAgICB8DQo+ICsgICAgfCAgICstLS0tLS0rIHwgICAgICAgKy0tKystLStc
XFwtLS0tLS0tLyAgIENTLTEgfCAgICAgICAgfCAgICAgICAgfA0KPiArICAgIHwgICAgICAgICAg
ICB8ICAgICAgICAgIHx8ICAgXFxcLS0tLS0tLS0tLS0tLS0tLS8gICBDUy0yIHwgICAgICAgIHwN
Cj4gKyAgICB8ICAgKy0tLS0tLSsgfCAgICAgICAgICB8fCAgICBcXC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0vICAgQ1MtMyB8DQo+ICsgICAgfCAgIHwgR1BJTyArLXwtLS0tLS0tLS0tL3wgICAg
IFwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLw0KPiArICAgIHwgICB8ICAgICAg
Ky18LS0tLS0tLS0tLS0vDQo+ICsgICAgfCAgICstLS0tLS0rIHwNCj4gKyAgICArLS0tLS0tLS0t
LS0tKw0KPiANCj4gVGhpcyBwcm9wb3NlZCBwYXRjaCBkb2VzIGV4YWN0bHkgd2hhdCBJIG5lZWQg
dG8gZG86DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMjcwNjE1MS8sIGJ1
dCBJIHdhcyB3b25kZXJpbmcgd2h5DQo+IG5vdGhpbmcgbGlrZSB0aGlzIGFscmVhZHkgZXhpc3Rz
IG9yIHdoeSB0aGF0IHBhdGNoIGhhZCBub3QgYmVlbg0KPiBpbmNsdWRlZCBpbiB0aGUgbWFpbmxp
bmUga2VybmVsLg0KDQpZZWFoIHRoYXQncyB0aGUga2luZCBvZiB0aGluZyBJIGhhZCBpbiBtaW5k
IGluIHRoZSB0aHJlYWQgSSBzdGFydGVkLg0KTm93IHRoYXQgbXV4LWNvbnRyb2xzIGlzIGEgdGhp
bmcgaXQnZCBwcm9iYWJseSBiZSBldmVuIGVhc2llciB0byBkbw0Kc29tZXRoaW5nIGxpa2UgdGhp
cy4NCg0KSSBkb24ndCBrbm93IHdoeSBEcmllcycgcGF0Y2ggc2VyaWVzIGRpZG4ndCBsYW5kLiBU
aGUgcmVhc29uIG15IG9uZQ0KZGlkbid0IGxhbmQgd2FzIGR1ZSB0byBzb21lIGltcGxlbWVudGF0
aW9uIGRldGFpbHMgYW5kIHRoZSBhYmlsaXR5IHRvDQpkbyBzb21ldGhpbmcgc2ltcGxlciB3aXRo
IGEgZmFrZSBncGlvLg0KDQpJIHByb2JhYmx5IHdvbid0IGdldCB0byBhbnl0aGluZyBmb3IgdGhl
IG5leHQgY291cGxlIG9mIHdlZWtzIGJ1dCBhZnRlcg0KdGhhdCBJIGNhbiBoYXZlIGEgdHJ5IGF0
IHJlc3VycmVjdGluZyB0aGUgY29kZSBmcm9tIHRoZSBvbGQgdGhyZWFkLiBJDQpoYXZlIGEgaGFy
ZHdhcmUgcGxhdGZvcm0gc3VpdGFibGUgZm9yIHRlc3RpbmcuDQoNCj4gDQo+ID4gDQo+ID4gUmVn
YXJkcywNCj4gPiBDaHJpcw0KPiA+IA0KPiA+IC0tDQo+ID4gWzFdIC0NCj4gPiBodHRwczovL2x3
bi5uZXQvbWwvZGV2aWNldHJlZS8yMDE5MDQxMjA1MDIxMy4xNzY5OC0xLWNocmlzLnBhY2toYW1A
YWxsaWVkdGVsZXNpcy5jby5uei8NCg==
