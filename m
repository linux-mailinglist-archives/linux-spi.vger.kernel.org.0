Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37724149CCE
	for <lists+linux-spi@lfdr.de>; Sun, 26 Jan 2020 21:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgAZUYD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Jan 2020 15:24:03 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40106 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAZUYC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 26 Jan 2020 15:24:02 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 72B64886BF;
        Mon, 27 Jan 2020 09:23:59 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580070239;
        bh=/cei+1/aa/IpjR1z8VZ4jbo6uJmdsPklSqfncjybmzo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=mY94TaUPAYVCO1VCqC0kwsDpANoJZAPW6IhI1zoPAO68gA+Tj6XRy3MPoNoHPKQAF
         ODfJv9mBuQ9RycL4NUUUS5dbsLtUe2mdG2adVmQOXItFas+s7AoigHEVtItRe1sQpv
         yw4aH9s1VRXxdsjDCWEYTrb8u+C/zjxsYoEZ2zfeZWacAU+Q5BcWdUhXv5t0OYEwcu
         yLxlS3FJlSxvz5sIKjBhuvwpfN2tquDaslriIj9f5aQIGx0/83LpRY5UxOJHKvXMOU
         AmHgAJ9y7FQcA+WJenuoJ4gHZ+SJCSLs0d/CqGt8AKMCFYqfZsJ3CwWVnAERneN1aG
         qJUr4ItypMFcA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e2df5600001>; Mon, 27 Jan 2020 09:24:00 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jan 2020 09:23:59 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Mon, 27 Jan 2020 09:23:59 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Document binding for generic SPI
 multiplexer
Thread-Topic: [PATCH v2 1/2] dt-bindings: spi: Document binding for generic
 SPI multiplexer
Thread-Index: AQHV0YvN7EoaAxM04U2fxNX2TRV5jKf3a3CAgAUkngA=
Date:   Sun, 26 Jan 2020 20:23:58 +0000
Message-ID: <651803fbdea412ecde7cd352b080d41d9f0a2a33.camel@alliedtelesis.co.nz>
References: <20200123012317.14808-1-chris.packham@alliedtelesis.co.nz>
         <20200123012317.14808-2-chris.packham@alliedtelesis.co.nz>
         <CAL_JsqLvM34WSBE29beBgJj0jLA6P_UwQUbTuEQcYJgrkg3v1A@mail.gmail.com>
In-Reply-To: <CAL_JsqLvM34WSBE29beBgJj0jLA6P_UwQUbTuEQcYJgrkg3v1A@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:1597:7b21:1304:4303]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB389E764116794CA5C5D03E7E553173@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTIzIGF0IDA3OjUxIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gV2VkLCBKYW4gMjIsIDIwMjAgYXQgNzoyNCBQTSBDaHJpcyBQYWNraGFtDQo+IDxjaHJpcy5w
YWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+IHdyb3RlOg0KPiA+IA0KPiA+IEFkZCBiaW5kaW5n
IGRvY3VtZW50YXRpb24gZm9yIHRoZSBzcGktbXV4IGRyaXZlci4gVGhpcyBhbGxvd3MgYSBnZW5l
cmljDQo+ID4gbXVsdGlwbGV4ZXIgdG8gYmUgdXNlZCB0byBwcm92aWRlIGFjY2VzcyB0byBtdWx0
aXBsZSBTUEkgZGV2aWNlcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFt
IDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+ID4gLS0tDQo+ID4gDQo+ID4g
Tm90ZXM6DQo+ID4gICAgIENoYW5nZXMgaW4gdjI6DQo+ID4gICAgIC0gdXBkYXRlIGxpY2Vuc2UN
Cj4gPiAgICAgLSBtYWtlIGR0X2JpbmRpbmdfY2hlY2sgY2xlYW4NCj4gDQo+IFN1cmUgYWJvdXQg
dGhhdD8NCj4gDQoNCkkgd2FzIHdoZW4gSSB3cm90ZSB0aGF0LCBidXQgbm93IEkgdGhpbmsgSSBu
ZWVkIHRvIGNvbnN1bHQgbXkgc3BlbGwNCmJvb2suDQoNCkl0IGFwcGVhcnMgdGhlIGluY2FudGF0
aW9uIEkgc2hvdWxkIGJlIHVzaW5nIGlzDQoNCiAgbWFrZSBBUkNIPWFybSBkZWZjb25maWcNCiAg
bWFrZSBBUkNIPWFybSBkdF9iaW5kaW5nX2NoZWNrIFwNCiAgICAgRFRfU0NIRU1BX0ZJTEVTPURv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLW11eC55YW1sDQoNCkkgY2Fu
IHNlZSB0aGUgc2ltcGxlIGZhaWx1cmVzIChub3Qgc3VyZSBob3cgSSBtaXNzZWQgdGhlbSkuIEJ1
dCBvbmUNCnRoYXQgcmVtYWlucyBpczoNCg0KV2FybmluZyAoc3BpX2J1c19icmlkZ2UpOiAvZXhh
bXBsZS0wL3NwaS9zcGktbXV4QDA6IG5vZGUgbmFtZSBmb3IgU1BJDQpidXNlcyBzaG91bGQgYmUg
J3NwaScNCg0KSSBjb3VsZCBmaXggdGhhdCBieSBoYXZpbmcNCg0KIHNwaSB7DQogICAgc3BpQDAg
ew0KICAgICAgIGNvbXBhdGlibGUgPSAic3BpLW11eCI7DQogICAgfTsNCiB9Ow0KDQpJcyB0aGF0
IHdoYXQgd2Ugd2FudD8gT3Igc2hvdWxkIEkgYmUgYWRkaW5nIGF3YXJlbmVzcyBvZiBzcGktbXV4
ZXMgdG8NCmR0Yz8NCg0KPiA+IA0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3Bp
LW11eC55YW1sICAgICAgfCA4NCArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA4NCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1tdXgueWFtbA0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1tdXgueWFt
bCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLW11eC55YW1sDQo+
ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjRiZGIzMWUy
MjU3ZQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc3BpL3NwaS1tdXgueWFtbA0KPiA+IEBAIC0wLDAgKzEsODQgQEANCj4gPiAr
IyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KPiA+
ICslWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3Nj
aGVtYXMvc3BpL3NwaS1tdXgueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogR2VuZXJpYyBT
UEkgTXVsdGlwbGV4ZXINCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgVGhpcyBi
aW5kaW5nIGRlc2NyaWJlcyBhIFNQSSBidXMgbXVsdGlwbGV4ZXIgdG8gcm91dGUgdGhlIFNQSSBj
aGlwIHNlbGVjdA0KPiA+ICsgIHNpZ25hbHMuIFRoaXMgY2FuIGJlIHVzZWQgd2hlbiB5b3UgbmVl
ZCBtb3JlIGRldmljZXMgdGhhbiB0aGUgU1BJIGNvbnRyb2xsZXINCj4gPiArICBoYXMgY2hpcCBz
ZWxlY3RzIGF2YWlsYWJsZS4gQW4gZXhhbXBsZSBzZXR1cCBpcyBzaG93biBpbiBBU0NJSSBhcnQ7
IHRoZSBhY3R1YWwNCj4gPiArICBzZXR0aW5nIG9mIHRoZSBtdWx0aXBsZXhlciB0byBhIGNoYW5u
ZWwgbmVlZHMgdG8gYmUgZG9uZSBieSBhIHNwZWNpZmljIFNQSSBtdXgNCj4gPiArICBkcml2ZXIu
DQo+ID4gKw0KPiA+ICsgICAgICAgIE1PU0kgLy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tKy0tLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tXA0KPiA+ICsgICAgICAgIE1JU08gfC8tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rfC0tLS0tLS0rfC0tLS0tLS0rfC0tLS0tLS1cfA0K
PiA+ICsgICAgICAgICBTQ0wgfHwvLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSt8fC0tLS0t
LSt8fC0tLS0tLSt8fC0tLS0tLVx8fA0KPiA+ICsgICAgICAgICAgICAgfHx8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHx8fCAgICAgIHx8fCAgICAgIHx8fCAgICAgIHx8fA0KPiA+ICsgICAg
ICArLS0tLS0tLS0tLS0tKyAgICAgICAgICAgICAgICAgICAgICAgIHx8fCAgICAgIHx8fCAgICAg
IHx8fCAgICAgIHx8fA0KPiA+ICsgICAgICB8IFNvQyAgfHx8ICAgfCAgICAgICAgICAgICAgICAg
ICAgICArLSsrKy0rICArLSsrKy0rICArLSsrKy0rICArLSsrKy0rDQo+ID4gKyAgICAgIHwgICAg
ICB8fHwgICB8ICAgICAgICAgICAgICAgICAgICAgIHwgZGV2IHwgIHwgZGV2IHwgIHwgZGV2IHwg
IHwgZGV2IHwNCj4gPiArICAgICAgfCAgICstLSsrKy0rIHwgQ1MtWCAgKy0tLS0tLStcICAgICAg
Ky0tKy0tKyAgKy0tKy0tKyAgKy0tKy0tKyAgKy0tKy0tKw0KPiA+ICsgICAgICB8ICAgfCBTUEkg
ICstfC0tLS0tLS0rIE11eCAgfFxcICAgQ1MtMCB8ICAgICAgICB8ICAgICAgICB8ICAgICAgICB8
DQo+ID4gKyAgICAgIHwgICArLS0tLS0tKyB8ICAgICAgICstLSstLS0rXFxcLS0tLS0tLS8gICBD
Uy0xIHwgICAgICAgIHwgICAgICAgIHwNCj4gPiArICAgICAgfCAgICAgICAgICAgIHwgICAgICAg
ICAgfCAgICBcXFwtLS0tLS0tLS0tLS0tLS0tLyAgIENTLTIgfCAgICAgICAgfA0KPiA+ICsgICAg
ICB8ICAgKy0tLS0tLSsgfCAgICAgICAgICB8ICAgICBcXC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0vICAgQ1MtMyB8DQo+ID4gKyAgICAgIHwgICB8ID8gICAgKy18LS0tLS0tLS0tLS8gICAgICBc
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS8NCj4gPiArICAgICAgfCAgICstLS0t
LS0rIHwNCj4gPiArICAgICAgKy0tLS0tLS0tLS0tLSsNCj4gPiArDQo+ID4gK2FsbE9mOg0KPiA+
ICsgIC0gJHJlZjogIi9zY2hlbWFzL3NwaS9zcGktY29udHJvbGxlci55YW1sIyINCj4gPiArDQo+
ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBh
bGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21w
YXRpYmxlOg0KPiA+ICsgICAgY29uc3Q6IHNwaS1tdXgNCj4gPiArDQo+ID4gKyAgbXV4LWNvbnRy
b2xzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsg
ICAtIGNvbXBhdGlibGUNCj4gPiArICAgLSByZWcNCj4gPiArICAgLSBzcGktbWF4LWZyZXF1ZW5j
eQ0KPiA+ICsgICAtIG11eC1jb250cm9scw0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAg
IC0gfA0KPiA+ICsgICAgIG11eDogbXV4LWNvbnRyb2xsZXIgew0KPiA+ICsgICAgICAgY29tcGF0
aWJsZSA9ICJncGlvLW11eCI7DQo+ID4gKyAgICAgICAjbXV4LWNvbnRyb2wtY2VsbHMgPSA8MD47
DQo+ID4gKw0KPiA+ICsgICAgICAgbXV4LWdwaW9zID0gPCZncGlvMCAzIEdQSU9fQUNUSVZFX0hJ
R0g+Ow0KPiA+ICsgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgIHNwaSB7DQo+ID4gKyAgICAgICBz
cGktbXV4QDAgew0KPiA+ICsgICAgICAgICBjb21wYXRpYmxlID0gInNwaS1tdXgiOw0KPiA+ICsg
ICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICAgI3NpemUtY2VsbHMg
PSA8MD47DQo+ID4gKyAgICAgICAgIHJlZyA9IDwwPjsNCj4gPiArICAgICAgICAgc3BpLW1heC1m
cmVxdWVuY3kgPSA8MTAwMDAwMDAwPjsNCj4gPiArDQo+ID4gKyAgICAgICAgIG11eC1jb250cm9s
cyA9IDwmbXV4Pg0KPiANCj4gTWlzc2luZyBzZW1pY29sb24uDQo+IA0KPiA+ICsNCj4gPiArICAg
ICAgICAgc3BpLWZsYXNoQDAgew0KPiA+ICsgICAgICAgICAgIGNvbXBhdGlibGUgPSAiamVkZWMs
c3BpLW5vciI7DQo+ID4gKyAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAg
ICAgICAgICAgI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgICAgcmVnID0gPDA+Ow0K
PiA+ICsgICAgICAgICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDQwMDAwMDAwPjsNCj4gPiArICAg
ICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAgIHNwaS1kZXZpY2VAMSB7DQo+ID4gKyAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJsaW5lYXJ0ZWNobm9sb2d5LGx0YzI0ODgiOw0KPiA+ICsgICAg
ICAgICAgIHJlZyA9IDwxPjsNCj4gPiArICAgICAgICAgICBzcGktbWF4LWZyZXF1ZW5jeSA9IDwx
MDAwMDAwMD47DQo+ID4gKyAgICAgICAgIH07DQo+ID4gKyAgICAgICB9Ow0KPiA+ICsgICAgIH07
DQo+ID4gLS0NCj4gPiAyLjI1LjANCj4gPiANCg==
