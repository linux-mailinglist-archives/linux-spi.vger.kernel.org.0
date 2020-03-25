Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAA681931EA
	for <lists+linux-spi@lfdr.de>; Wed, 25 Mar 2020 21:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCYUaW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Mar 2020 16:30:22 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:52786 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYUaW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Mar 2020 16:30:22 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F11DB80237;
        Thu, 26 Mar 2020 09:30:16 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1585168216;
        bh=XaEFD5bXoCo4LJkpEn40PUo8Y3kbJPmbHJNaZfJ2oVY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=UgsulxQU10jsUNTgcWX0h/QVrucu72c3LwkOhy0iOAOTKhfMGARTtKc5AXX+NkxDw
         OEHM2kB/i7EHtJdRn31xsm7Wf8iHo4LrZryxi9tzcym3G3voJmAGWFyxmnDoxTxPOL
         OsWcS7ipdfRzckedGx+B2ZuSAA0dV4jG+76hgLx9PH7TJBw8Ajcocl1OKwu+n7igxe
         i2tA5PSzwVQjJIOHmhhTd7RhtcqxthxBN9fzZ6aggk0Q7m5xQduQpwMk0WY/uSk1B/
         d9XKA1C/G1dY5uOq3d3KyPmZdzD7uwPnKIoTKN51IeZX7nQYJ9ZC1FoR5LUc5t5IAB
         iaIgjdBCRkA0A==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e7bbf560001>; Thu, 26 Mar 2020 09:30:14 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 26 Mar 2020 09:30:16 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Thu, 26 Mar 2020 09:30:16 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "lkp@intel.com" <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [linux-next:master 1837/11710] sh4-linux-ld: cannot find
 drivers/spi/.tmp_gl_spi-mux.o: No such file or directory
Thread-Topic: [linux-next:master 1837/11710] sh4-linux-ld: cannot find
 drivers/spi/.tmp_gl_spi-mux.o: No such file or directory
Thread-Index: AQHWAt25zsEifUErK0u+6w1dFbnyo6hY6LkA
Date:   Wed, 25 Mar 2020 20:30:16 +0000
Message-ID: <3ec603f5379aafd36f80490ef78108b225eac030.camel@alliedtelesis.co.nz>
References: <202003260124.NDYYFnCI%lkp@intel.com>
In-Reply-To: <202003260124.NDYYFnCI%lkp@intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.14.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <167EC392B42AF94294CF3B105C9163C5@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTI2IGF0IDAxOjM4ICswODAwLCBrYnVpbGQgdGVzdCByb2JvdCB3cm90
ZToNCj4gdHJlZTogICANCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdA0KPiBtYXN0ZXINCj4gaGVhZDogICBiZmQ3YTI0
ODUwMjM3M2RhOGIxYzhlYjBlODExZmRiMTljYzNmOGI2DQo+IGNvbW1pdDogZTllNDA1NDNhZDVi
MzhiODQ4ODc5NzY4MzU5ZmQxMzY1MDUyOTk2MSBbMTgzNy8xMTcxMF0gc3BpOg0KPiBBZGQgZ2Vu
ZXJpYyBTUEkgbXVsdGlwbGV4ZXINCj4gY29uZmlnOiBzaC1yYW5kY29uZmlnLWEwMDEtMjAyMDAz
MjUgKGF0dGFjaGVkIGFzIC5jb25maWcpDQo+IGNvbXBpbGVyOiBzaDQtbGludXgtZ2NjIChHQ0Mp
IDkuMi4wDQo+IHJlcHJvZHVjZToNCj4gICAgICAgICB3Z2V0IA0KPiBodHRwczovL3Jhdy5naXRo
dWJ1c2VyY29udGVudC5jb20vaW50ZWwvbGtwLXRlc3RzL21hc3Rlci9zYmluL21ha2UuY3Jvc3MN
Cj4gIC1PIH4vYmluL21ha2UuY3Jvc3MNCj4gICAgICAgICBjaG1vZCAreCB+L2Jpbi9tYWtlLmNy
b3NzDQo+ICAgICAgICAgZ2l0IGNoZWNrb3V0IGU5ZTQwNTQzYWQ1YjM4Yjg0ODg3OTc2ODM1OWZk
MTM2NTA1Mjk5NjENCj4gICAgICAgICAjIHNhdmUgdGhlIGF0dGFjaGVkIC5jb25maWcgdG8gbGlu
dXggYnVpbGQgdHJlZQ0KPiAgICAgICAgIEdDQ19WRVJTSU9OPTkuMi4wIG1ha2UuY3Jvc3MgQVJD
SD1zaCANCj4gDQo+IElmIHlvdSBmaXggdGhlIGlzc3VlLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0
YWcNCj4gUmVwb3J0ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiAN
Cj4gQWxsIGVycm9ycyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KPiANCj4gICAgc2g0LWxp
bnV4LW9iamNvcHk6IFVuYWJsZSB0byBjaGFuZ2UgZW5kaWFubmVzcyBvZiBpbnB1dCBmaWxlKHMp
DQo+ID4gPiBzaDQtbGludXgtbGQ6IGNhbm5vdCBmaW5kIGRyaXZlcnMvc3BpLy50bXBfZ2xfc3Bp
LW11eC5vOiBObyBzdWNoDQo+ID4gPiBmaWxlIG9yIGRpcmVjdG9yeQ0KPiA+ID4gc2g0LWxpbnV4
LW9iamNvcHk6ICdkcml2ZXJzL3NwaS8udG1wX214X3NwaS1tdXgubyc6IE5vIHN1Y2ggZmlsZQ0K
PiANCj4gICAgcm06IGNhbm5vdCByZW1vdmUgJ2RyaXZlcnMvc3BpLy50bXBfZ2xfc3BpLW11eC5v
JzogTm8gc3VjaCBmaWxlIG9yDQo+IGRpcmVjdG9yeQ0KPiAgICBybTogY2Fubm90IHJlbW92ZSAn
ZHJpdmVycy9zcGkvLnRtcF9teF9zcGktbXV4Lm8nOiBObyBzdWNoIGZpbGUgb3INCj4gZGlyZWN0
b3J5DQo+IC0tDQoNCkkgYXR0ZW1wdGVkIHRvIHJlcHJvZHVjZSB0aGlzLiBUaGUgc2g0IHRvb2xj
aGFpbiB3YXMgdW5oYXBweSB3aXRoIG15DQpzeXN0ZW0gKG1pc3NpbmcgbGliaXNsLnNvLjIyKS4g
SSBib2RnZWQgc29tZXRoaW5nIHRvZ2V0aGVyIGFuZCBnb3QNCmVycm9ycyBsaWtlIHRoaXMgYWxs
IG92ZXIgdGhlIHBsYWNlLiBJIGFsc28gdHJpZWQgdGhlIHByZXZpb3VzIGNvbW1pdA0KYW5kIHN0
aWxsIGdvdCB0aGUgc2FtZSBlcnJvcnMuDQoNCj4gICAgc2g0LWxpbnV4LW9iamNvcHk6IFVuYWJs
ZSB0byBjaGFuZ2UgZW5kaWFubmVzcyBvZiBpbnB1dCBmaWxlKHMpDQo+ID4gPiBzaDQtbGludXgt
bGQ6IGNhbm5vdCBmaW5kIGRyaXZlcnMvbXV4Ly50bXBfZ2xfY29yZS5vOiBObyBzdWNoDQo+ID4g
PiBmaWxlIG9yIGRpcmVjdG9yeQ0KPiA+ID4gc2g0LWxpbnV4LW9iamNvcHk6ICdkcml2ZXJzL211
eC8udG1wX214X2NvcmUubyc6IE5vIHN1Y2ggZmlsZQ0KPiANCj4gICAgcm06IGNhbm5vdCByZW1v
dmUgJ2RyaXZlcnMvbXV4Ly50bXBfZ2xfY29yZS5vJzogTm8gc3VjaCBmaWxlIG9yDQo+IGRpcmVj
dG9yeQ0KPiAgICBybTogY2Fubm90IHJlbW92ZSAnZHJpdmVycy9tdXgvLnRtcF9teF9jb3JlLm8n
OiBObyBzdWNoIGZpbGUgb3INCj4gZGlyZWN0b3J5DQo+IC0tDQo+ICAgIHNoNC1saW51eC1vYmpj
b3B5OiBVbmFibGUgdG8gY2hhbmdlIGVuZGlhbm5lc3Mgb2YgaW5wdXQgZmlsZShzKQ0KPiA+ID4g
c2g0LWxpbnV4LWxkOiBjYW5ub3QgZmluZCBkcml2ZXJzL211eC8udG1wX2dsX2FkZzc5MmEubzog
Tm8gc3VjaA0KPiA+ID4gZmlsZSBvciBkaXJlY3RvcnkNCj4gPiA+IHNoNC1saW51eC1vYmpjb3B5
OiAnZHJpdmVycy9tdXgvLnRtcF9teF9hZGc3OTJhLm8nOiBObyBzdWNoIGZpbGUNCj4gDQo+ICAg
IHJtOiBjYW5ub3QgcmVtb3ZlICdkcml2ZXJzL211eC8udG1wX2dsX2FkZzc5MmEubyc6IE5vIHN1
Y2ggZmlsZSBvcg0KPiBkaXJlY3RvcnkNCj4gICAgcm06IGNhbm5vdCByZW1vdmUgJ2RyaXZlcnMv
bXV4Ly50bXBfbXhfYWRnNzkyYS5vJzogTm8gc3VjaCBmaWxlIG9yDQo+IGRpcmVjdG9yeQ0KPiAt
LQ0KPiA+ID4gc2g0LWxpbnV4LWFyOiBkcml2ZXJzL211eC9jb3JlLm86IE5vIHN1Y2ggZmlsZSBv
ciBkaXJlY3RvcnkNCj4gDQo+IC0tDQo+ID4gPiBzaDQtbGludXgtbGQ6IGNhbm5vdCBmaW5kIGRy
aXZlcnMvbXV4L2FkZzc5MmEubzogTm8gc3VjaCBmaWxlIG9yDQo+ID4gPiBkaXJlY3RvcnkNCj4g
DQo+IC0tLQ0KPiAwLURBWSBDSSBLZXJuZWwgVGVzdCBTZXJ2aWNlLCBJbnRlbCBDb3Jwb3JhdGlv
bg0KPiBodHRwczovL2xpc3RzLjAxLm9yZy9oeXBlcmtpdHR5L2xpc3Qva2J1aWxkLWFsbEBsaXN0
cy4wMS5vcmcNCg==
