Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D466C13CE3F
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 21:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgAOUuL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 15:50:11 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:52631 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbgAOUuK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jan 2020 15:50:10 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A8981886BF;
        Thu, 16 Jan 2020 09:50:05 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1579121405;
        bh=dHE7kgWg+mXOsCfq2STIam2Qwtyxg6LEXAFFRxL3fxQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=frUuvqyDY0dbUAf9p4qfRiEZo2TRiCgzZvmM67JNmtRubBzLO8xjUxKFjFM9IiHys
         Pin0pv5blh4wIx/wWG69W1VHOckbO1TPW2m3OFscMmBubEpdHLhpgLFSuIYIjEVVMQ
         vfW6B0j9gXHb9UaQGgEr/3hlPAKWgXFOCj3aGaq0sKw7F/frhmjGasMVMy6drZkSKs
         Bzz3ljYl3l2XFe7e491agSTSyHZAiYNgG2qTKjukxxslbLPZFfapdhTNAv0X8zUdwi
         DlCF115ClldIo3wr4HKxdmiK6kiQQPIWD/IzUvPwvsIP2rMv4lYuk4hef+V8xi3eEG
         jSLbZ1P2n33dw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e1f7afd0000>; Thu, 16 Jan 2020 09:50:05 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jan 2020 09:50:00 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Thu, 16 Jan 2020 09:50:00 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "anthony.derosa@syscall7.com" <anthony.derosa@syscall7.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Document binding for generic SPI
 multiplexer
Thread-Topic: [PATCH 1/2] dt-bindings: spi: Document binding for generic SPI
 multiplexer
Thread-Index: AQHVyzPSC8iztSqm/U+939ZYv3kbhafrN7iAgAAinwA=
Date:   Wed, 15 Jan 2020 20:49:59 +0000
Message-ID: <ee0c179e6c41699e2ee70c8acd2b5c29712955a1.camel@alliedtelesis.co.nz>
References: <20200114233857.25933-1-chris.packham@alliedtelesis.co.nz>
         <20200114233857.25933-2-chris.packham@alliedtelesis.co.nz>
         <CAL_Jsq+AOiFV4Kcu=r3-kz42ZqSVR_0ZuKtnz8ak_sksW0D0wQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+AOiFV4Kcu=r3-kz42ZqSVR_0ZuKtnz8ak_sksW0D0wQ@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.14.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7F08148EF61BC438044039C31D7A680@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgUm9iLA0KDQpPbiBXZWQsIDIwMjAtMDEtMTUgYXQgMTI6NDUgLTA2MDAsIFJvYiBIZXJyaW5n
IHdyb3RlOg0KPiBPbiBUdWUsIEphbiAxNCwgMjAyMCBhdCA1OjM5IFBNIENocmlzIFBhY2toYW0N
Cj4gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+ID4gDQo+ID4g
QWRkIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIHNwaS1tdXggZHJpdmVyLiBUaGlzIGFs
bG93cyBhDQo+ID4gZ2VuZXJpYw0KPiA+IG11bHRpcGxleGVyIHRvIGJlIHVzZWQgdG8gcHJvdmlk
ZSBhY2Nlc3MgdG8gbXVsdGlwbGUgU1BJIGRldmljZXMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiA+
IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLW11eC55YW1sICAgICAg
fCA4Mg0KPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDgyIGlu
c2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zcGkvc3BpLQ0KPiA+IG11eC55YW1sDQo+IA0KPiBCZSBzdXJlIHRvIHJ1
biAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJy4NCj4gDQoNCldpbGwgZG8uDQoNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktbXV4
LnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLW11
eC55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAu
LjEwMjZkMDNhNjljNw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1tdXgueWFtbA0KPiA+IEBAIC0wLDAgKzEsODIg
QEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiANCj4gRHVhbCBs
aWNlbnNlIG5ldyBiaW5kaW5ncyBwbGVhc2U6DQo+IA0KPiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0y
LUNsYXVzZSkNCj4gDQoNCkRvbmUNCg0KPiA+ICslWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRp
ZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc3BpL3NwaS1tdXgueWFtbCMNCj4gPiAr
JHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+
ID4gKw0KPiA+ICt0aXRsZTogR2VuZXJpYyBTUEkgTXVsdGlwbGV4ZXINCj4gPiArDQo+ID4gK2Rl
c2NyaXB0aW9uOiB8DQo+ID4gKyAgVGhpcyBiaW5kaW5nIGRlc2NyaWJlcyBhIFNQSSBidXMgbXVs
dGlwbGV4ZXIgdG8gcm91dGUgdGhlIFNQSQ0KPiA+IGNoaXAgc2VsZWN0DQo+ID4gKyAgc2lnbmFs
cy4gVGhpcyBjYW4gYmUgdXNlZCB3aGVuIHlvdSBuZWVkIG1vcmUgZGV2aWNlcyB0aGFuIHRoZQ0K
PiA+IFNQSSBjb250cm9sbGVyDQo+ID4gKyAgaGFzIGNoaXAgc2VsZWN0cyBhdmFpbGFibGUuIEFu
IGV4YW1wbGUgc2V0dXAgaXMgc2hvd24gaW4gQVNDSUkNCj4gPiBhcnQ7IHRoZSBhY3R1YWwNCj4g
PiArICBzZXR0aW5nIG9mIHRoZSBtdWx0aXBsZXhlciB0byBhIGNoYW5uZWwgbmVlZHMgdG8gYmUg
ZG9uZSBieSBhDQo+ID4gc3BlY2lmaWMgU1BJIG11eA0KPiA+ICsgIGRyaXZlci4NCj4gPiArDQo+
ID4gKyAgICAgICAgTU9TSSAvLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0t
LS0rLS0tLS0tLS0rLQ0KPiA+IC0tLS0tLS1cDQo+ID4gKyAgICAgICAgTUlTTyB8Ly0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSt8LS0tLS0tLSt8LS0tLS0tLSt8LQ0KPiA+IC0tLS0tLVx8
DQo+ID4gKyAgICAgICAgIFNDTCB8fC8tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tK3x8LS0t
LS0tK3x8LS0tLS0tK3x8LQ0KPiA+IC0tLS0tXHx8DQo+ID4gKyAgICAgICAgICAgICB8fHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfHx8ICAgICAgfHx8ICAgICAgfHx8IA0KPiA+ICAgICAg
fHx8DQo+ID4gKyAgICAgICstLS0tLS0tLS0tDQo+ID4gLS0rICAgICAgICAgICAgICAgICAgICAg
ICAgfHx8ICAgICAgfHx8ICAgICAgfHx8ICAgICAgfHx8DQo+ID4gKyAgICAgIHwgU29DICB8fHwg
ICB8ICAgICAgICAgICAgICAgICAgICAgICstKysrLSsgICstKysrLSsgICstKysrLQ0KPiA+ICsg
ICstKysrLSsNCj4gPiArICAgICAgfCAgICAgIHx8fCAgIHwgICAgICAgICAgICAgICAgICAgICAg
fCBkZXYgfCAgfCBkZXYgfCAgfCBkZXYNCj4gPiB8ICB8IGRldiB8DQo+ID4gKyAgICAgIHwgICAr
LS0rKystKyB8IENTLVggICstLS0tLS0rXCAgICAgICstLSstLSsgICstLSstLSsgICstLSsNCj4g
PiAtLSsgICstLSstLSsNCj4gPiArICAgICAgfCAgIHwgU1BJICArLXwtLS0tLS0tKyBNdXggIHxc
XCAgIENTLTANCj4gPiB8ICAgICAgICB8ICAgICAgICB8ICAgICAgICB8DQo+ID4gKyAgICAgIHwg
ICArLS0tLS0tKyB8ICAgICAgICstLSstLS0rXFxcLS0tLS0tLS8gICBDUy0xDQo+ID4gfCAgICAg
ICAgfCAgICAgICAgfA0KPiA+ICsgICAgICB8ICAgICAgICAgICAgfCAgICAgICAgICB8ICAgIFxc
XC0tLS0tLS0tLS0tLS0tLS0vICAgQ1MtMg0KPiA+IHwgICAgICAgIHwNCj4gPiArICAgICAgfCAg
ICstLS0tLS0rIHwgICAgICAgICAgfCAgICAgXFwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gLyAgIENTLTMgfA0KPiA+ICsgICAgICB8ICAgfCA/ICAgICstfC0tLS0tLS0tLS0vICAgICAg
XC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gLS0tLS0tLS0vDQo+ID4gKyAgICAgIHwg
ICArLS0tLS0tKyB8DQo+ID4gKyAgICAgICstLS0tLS0tLS0tLS0rDQo+ID4gKw0KPiA+ICthbGxP
ZjoNCj4gPiArICAtICRyZWY6ICIvc2NoZW1hcy9zcGkvc3BpLWNvbnRyb2xsZXIueWFtbCMiDQo+
ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBjb25z
dDogc3BpLW11eA0KPiA+ICsNCj4gPiArICBtdXgtY29udHJvbDoNCj4gPiArICAgICRyZWY6ICIv
c2NoZW1hcy9tdXgvbXV4LWNvbnRyb2xsZXIueWFtbCMiDQo+IA0KPiBUaGF0IGZpbGUgZG9lc24n
dCBleGlzdC4gSWYgaXQgZGlkLCBpdCB3b3VsZCBzdGlsbCBiZSB3cm9uZyBhcyB0aGF0DQo+IHdv
dWxkIGJlIHRoZSBwcm92aWRlciBzaWRlIGFuZCB0aGlzIGlzIHRoZSBjbGllbnQuDQo+IA0KPiBU
aGUgY29ycmVjdCBuYW1lIGlzIGFsc28gJ211eC1jb250cm9scycuDQo+IA0KPiBZb3UgY2FuIGFz
c3VtZSBpdCBoYXMgYSBzY2hlbWEgYWxyZWFkeSBhbmQgeW91IGp1c3QgbmVlZCB0byBkZWZpbmUN
Cj4gaG93DQo+IG1hbnkgZW50cmllcyBpdCBoYXMgKG1heEl0ZW1zOiAxKS4NCg0KSSBtaWdodCBu
ZWVkIGEgbGl0dGxlIGhhbmQgaG9sZGluZyBvbiB0aGlzLiBTaG91bGQgSSBhc3N1bWUgdGhhdCB0
aGVyZQ0KaXMgYSBzZXBhcmF0ZSBzY2hlbWEgZm9yIHRoZSBjb25zdW1lcj8gT3IgbGVhdmUgb3V0
IHRoZSAkcmVmIGVudGlyZWx5Pw0KDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAgLSBj
b21wYXRpYmxlDQo+ID4gKyAgIC0gcmVnDQo+ID4gKyAgIC0gc3BpLW1heC1mcmVxdWVuY3kNCj4g
PiArICAgLSBtdXgtY29udHJvbA0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgIC0gfA0K
PiA+ICsgICAgIG11eDogbXV4LWNvbnRyb2xsZXIgew0KPiA+ICsgICAgICAgY29tcGF0aWJsZSA9
ICJncGlvLW11eCI7DQo+ID4gKyAgICAgICAjbXV4LWNvbnRyb2wtY2VsbHMgPSA8MD47DQo+ID4g
Kw0KPiA+ICsgICAgICAgbXV4LWdwaW9zID0gPCZncGlvMCAzIEdQSU9fQUNUSVZFX0hJR0g+Ow0K
PiA+ICsgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgIHNwaSB7DQo+ID4gKyAgICAgICBzcGktbXV4
IHsNCj4gDQo+IHNwaS1tdXhAMA0KPiANCg0KRG9uZS4NCg0KPiA+ICsgICAgICAgICBjb21wYXRp
YmxlID0gInNwaS1tdXgiOw0KPiA+ICsgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4g
PiArICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgICAgIHJlZyA9IDwwPjsN
Cj4gPiArICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAwMDAwMDAwPjsNCj4gDQo+IEkg
ZG9uJ3QgdGhpbmsgdGhpcyBtYWtlcyBzZW5zZSBoZXJlLiBUaGUgbXV4IGRvZXNuJ3QgcmVhbGx5
IGhhdmUgYW55DQo+IGZyZXF1ZW5jeSBnaXZlbiB0aGUgY2xvY2sgYW5kIGRhdGEgbGluZXMgYXJl
bid0IHJvdXRlZCB0aHJ1IHRoZSBtdXgNCj4gKHRob3VnaCBtYXliZSB0aGF0J3MgcG9zc2libGUg
aWYgc29tZSBpc29sYXRpb24gaXMgbmVlZGVkKS4NCj4gDQoNCkl0J3MgbmVlZGVkIHRvIHNhdGlz
Znkgb2Zfc3BpX3BhcnNlX2R0KCkuVG8gcmVtb3ZlIGl0IEknZCBuZWVkIHRvIGFkZA0KYW4gZXNj
YXBlIGhhdGNoIHRvIGFsbG93IHRoaXMgcHJvcGVydHkgdG8gYmUgb21pdHRlZCBmb3Igc3BpLW11
eGVzLiBPcg0KY2hhbmdlIGl0IHRvIGJlIGEgcGxhdGZvcm0gZGV2aWNlIGFuZCB0YWtlIHRoZSBw
YXJlbnQgc3BpIGJ1cyBhcyBhDQpwaGFuZGxlLg0KDQo+ID4gKw0KPiA+ICsgICAgICAgICBtdXgt
Y29udHJvbCA9IDwmbXV4Pg0KPiA+ICsgICAgICAgICBtdXgtY29udHJvbC1uYW1lcyA9ICJzcGki
Ow0KPiANCj4gTm90IGRvY3VtZW50ZWQuIERyb3AgaXQgYXMgaXQncyBub3QgYWxsIHRoYXQgdXNl
ZnVsIHdoZW4gdGhlcmUncyBvbmx5DQo+IDEgZW50cnkuDQoNCkRvbmUuIEFsc28gdXBkYXRlZCBt
dXgtY29udHJvbCAtPiBtdXgtY29udHJvbHMNCg0KPiA+ICsNCj4gPiArICAgICAgICAgc3BpLWZs
YXNoQDAgew0KPiA+ICsgICAgICAgICAgIGNvbXBhdGlibGUgPSAiamVkZWMsc3BpLW5vciI7DQo+
ID4gKyAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgICAgI3Np
emUtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgICAgcmVnID0gPDA+Ow0KPiA+ICsgICAgICAg
ICAgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDQwMDAwMDAwPjsNCj4gPiArICAgICAgICAgfTsNCj4g
PiArDQo+ID4gKyAgICAgICAgIHNwaS1kZXZpY2VAMSB7DQo+ID4gKyAgICAgICAgICAgY29tcGF0
aWJsZSA9ICJzcGlkZXYiOw0KPiANCj4gTm90IGEgdmFsaWQgY29tcGF0aWJsZS4NCj4gDQoNClBp
Y2tlZCBhIGRpZmZlcmVudCBvbmUuDQoNCj4gPiArICAgICAgICAgICByZWcgPSA8MT47DQo+ID4g
KyAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAwMDAwMDA+Ow0KPiA+ICsgICAgICAg
ICB9Ow0KPiA+ICsgICAgICAgfTsNCj4gPiArICAgICB9Ow0KPiA+IC0tDQo+ID4gMi4yNS4wDQo+
ID4gDQo=
