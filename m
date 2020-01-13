Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9777E1389DC
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2020 04:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbgAMDnn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 Jan 2020 22:43:43 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47887 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387402AbgAMDnn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 Jan 2020 22:43:43 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 23264891A9;
        Mon, 13 Jan 2020 16:43:40 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1578887020;
        bh=X/M2+RzoFycgvyO5lRFPYkxDZJIZQYY3IChNbm5C1GA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=mFXgxB+ugBRNsghk17G/IJJ6SH7Iy7hQ4mPES031jovVAn7TFNlFxjvCI96x4O7Nm
         9ryrnxUiXQPQuwgRfy+6rdBH/px0mJYuRCjjxnQyLDxTWVye/p6D+0BA/tb9KDVuNh
         8QhCQlgVHTyPYEUUn1r/L/pKAskXRQBB3YVJB0yWw6kZer0/ahh+JlXpETkWV6G4DC
         G4M50IvtmPy8Y26bSbJj9EKnzIAOAH8tTCtHMc5nlOPO/PMv0IqxCiM/xToU3j48Qr
         yciHsbCXyNqZJNfKruNhvW+kZsSqDrI1ZZglZzPCJcXo+Hk6sM11jfoAnck+1OZhc8
         mbZlwhXle0Tew==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e1be76a0001>; Mon, 13 Jan 2020 16:43:38 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3; Mon, 13 Jan 2020 16:43:40 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Mon, 13 Jan 2020 16:43:40 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "anthony.derosa@syscall7.com" <anthony.derosa@syscall7.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add spi-mux-gpio
Thread-Topic: [PATCH 1/3] dt-bindings: spi: Add spi-mux-gpio
Thread-Index: AQHU8OzvVDg4ZBlx30mrcO3i41SCvqZS/IYAgZXO+oA=
Date:   Mon, 13 Jan 2020 03:43:39 +0000
Message-ID: <58e3dcf5cf69fa5fda6f887dc442fec4d9901ffd.camel@alliedtelesis.co.nz>
References: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
         <20190412050213.17698-2-chris.packham@alliedtelesis.co.nz>
         <20190429213740.GA29098@bogus>
In-Reply-To: <20190429213740.GA29098@bogus>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:d1a1:ea74:6baa:5aa3]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8595220A5D21948B7B8DF3BEB85C8AB@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgUm9iLA0KDQpPbiBNb24sIDIwMTktMDQtMjkgYXQgMTY6MzcgLTA1MDAsIFJvYiBIZXJyaW5n
IHdyb3RlOg0KPiBPbiBGcmksIEFwciAxMiwgMjAxOSBhdCAwNTowMjoxMVBNICsxMjAwLCBDaHJp
cyBQYWNraGFtIHdyb3RlOg0KPiA+IEFkZCBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIHNwaS1t
dXgtZ3BpbyB3aGljaCBpcyBhIHNsaWdodGx5IG1vcmUNCj4gPiBjb21wbGljYXRlZCBoYXJkd2Fy
ZSBpbXBsZW1lbnRhdGlvbiBvZiB1c2luZyBncGlvcyB0byBzdGVlciBTUEkgY2hpcA0KPiA+IHNl
bGVjdHMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFj
a2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9zcGkvc3BpLW11eC1ncGlvLnR4dCAgfCA0NSArKysrKysrKysrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1tdXgtZ3Bpby50
eHQNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NwaS9zcGktbXV4LWdwaW8udHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NwaS9zcGktbXV4LWdwaW8udHh0DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBp
bmRleCAwMDAwMDAwMDAwMDAuLmEzMmYyNTMyMWQzNw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS1tdXgtZ3Bpby50
eHQNCj4gPiBAQCAtMCwwICsxLDQ1IEBADQo+ID4gK1NQSSBidXMgZ3BpbyBtdWx0aXBsZXhlcg0K
PiA+ICsNCj4gPiArVGhlIFNQSSBidXMgZ3BpbyBtdWx0aXBsZXhlciBjYW4gYmUgdXNlZCB0byBp
bXBsZW1lbnQgbW9yZSBjb21wbGljYXRlZCBhY2Nlc3MNCj4gPiArbG9naWMgdGhhbiBjYW4gYmUg
c3VwcG9ydGVkIHdpdGggdGhlIGNzLWdwaW9zIHByb3BlcnR5IG9mIGEgU1BJIGJ1cy4NCj4gPiAr
DQo+ID4gK0luIHRoZSBleGFtcGxlIGJlbG93IHdlIGhhdmUgYSBTb0Mgd2l0aCBhIHNpbmdsZSBT
UEkgQ1MgdGhhdCBpcyBnYXRlZCBieSB0aGUNCj4gPiArc3RhdGUgb2YgYSBncGlvIHRvIHNlbGVj
dCB0aGUgZGVzaXJlZCBTUEkgZGV2aWNlLg0KPiA+ICsNCj4gPiArICAgICArLS0tLS0tLS0tLSsg
IENTICAgICstLS0tLSsgQ1MwICArLS0tLSsNCj4gPiArICAgICB8ICAgICAgICAgIHwtLS0tLS0t
LXwgICAgIHwtLS0tLS18ICAgIHwNCj4gPiArICAgICB8ICAgICAgICAgIHwgICAgICAgIHwgXCAv
IHwgICAgICArLS0tLSsNCj4gPiArICAgICB8ICAgU29DICAgIHwgICAgICAgIHwgICsgIHwNCj4g
PiArICAgICB8ICAgICAgICAgIHwgIEdQSU8gIHwgLyBcIHwgQ1MxICArLS0tLSsNCj4gPiArICAg
ICB8ICAgICAgICAgIHwtLS0tLS0tLXwgICAgIHwtLS0tLS18ICAgIHwNCj4gPiArICAgICArLS0t
LS0tLS0tLSsgICAgICAgICstLS0tLSsgICAgICArLS0tLSsNCj4gPiArDQo+ID4gK1JlcXVpcmVk
IHByb3BlcnRpZXM6DQo+ID4gKy0gY29tcGF0aWJsZQktIG11c3QgYmUgInNwaS1tdXgtZ3BpbyIN
Cj4gPiArLSBncGlvcwkJLSBncGlvcyB1c2VkIHRvIGltcGxlbWVudCB0aGUgbXVsdGlwbGV4aW5n
IGxvZ2ljDQo+ID4gKy0gc3BpLXBhcmVudC1idXMgLSBwYXJlbnQgc3BpIGJ1cyB0byB1c2UNCj4g
PiArDQo+ID4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+ID4gKy0gc3BpLXBhcmVudC1jcyAtIGNo
aXAgc2VsZWN0IG9uIHBhcmVudCBidXMgdG8gdXNlLiBEZWZhdWx0cyB0byAwIGlmIG5vdA0KPiA+
ICsgICAgICAgICAgICAgICAgICBzcGVjaWZpZWQuDQo+ID4gKw0KPiA+ICtFeGFtcGxlIGZvciBh
IG11bHRpcGxleGVyIHdpdGggYSBzaW5nbGUgZ3BpbzoNCj4gPiArDQo+ID4gKwlzcGktbXV4IHsN
Cj4gPiArCQljb21wYXRpYmxlID0gInNwaS1tdXgtZ3BpbyI7DQo+ID4gKwkJI2FkZHJlc3MtY2Vs
bHMgPSA8MT47DQo+ID4gKwkJI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKwkJZ3Bpb3MgPSA8Jmdw
aW8wIDEgMD47DQo+ID4gKwkJc3BpLXBhcmVudC1idXMgPSA8JnNwaTA+Ow0KPiA+ICsJCXNwaS1w
YXJlbnQtY3MgPSA8MD47DQo+IA0KPiBXaHkgaXMgdGhpcyBvdXQgb2YgYmFuZD8gV2UgY2FuIGRv
IHNvbWV0aGluZyBzaW1pbGFyIHRvIEkyQyBhbmQgdXNlIHRoZSANCj4gbXV4LWNvbnRyb2wgYmlu
ZGluZzoNCj4gDQo+IHNwaSB7DQo+IAltdXhAMCB7DQo+IAkJY29tcGF0aWJsZSA9ICJzcGktbXV4
IjsNCj4gCQlyZWcgIjAiOyANCj4gCQltdXgtY29udHJvbHMgPSAuLi47DQo+IA0KPiAJCXNwaS1k
ZXZAMCB7fTsNCj4gCQlzcGktZGV2QDEge307DQo+IAl9Ow0KPiANCj4gCXNwaS1kZXZAMSB7fTsN
Cj4gDQo+IH07DQoNCkkndmUgYmVlbiByZS12aXNpdGluZyB0aGlzIHRocmVhZCBhbmQgYW4gb2xk
ZXIgb25lWzFdIHdpdGggYW4gZXllIG9uDQppbXBsZW1lbnRpbmcgYSBzb2x1dGlvbiB3aXRoIG11
eC1jb250cm9scy4NCg0KT25lIHRoaW5nIEknbSBjb25mdXNlZCBhYm91dCBpcyB5b3VyIGNvbW1l
bnQgdGhhdCB0aGUgbXV4IHNob3VsZCBiZSBpbi0NCmJhbmQgbGlrZSBpMmMuIExvb2tpbmcgYXQg
dGhlIG9uZSB1c2VyIG9mIGkyYy1tdXggKGF0OTEtbmF0dGUuZHRzaSkgaXQNCmFsc28gYXBwZWFy
cyBvdXQgb2YgYmFuZCBhbmQgZGV0ZXJtaW5lIHRoZSBwYXJlbnQgYnVzIHdpdGggYSBpMmMtcGFy
ZW50IA0KcHJvcGVydHkgKHNpbWlsYXIgdG8gaG93IEkgZGlkIGl0IGluIG15IG9yaWdpbmFsIHN1
Ym1pc3Npb24pLiBJIGFsc28NCmNhbid0IHNlZSBob3cgdGhlIG11eCB3b3VsZCB3b3JrIGluLWJh
bmQgc2luY2UgaXQgbGFja3MgdGhlIGNvcnJlY3QNCiNhZGRyZXNzLWNlbGxzIGV0YyBmb3IgYSBz
cGkgZGV2aWNlLg0KDQpJJ20gd29uZGVyaW5nIGlmIEkndmUgbWlzc2VkIHNvbWV0aGluZyBvYnZp
b3VzLg0KDQotLQ0KWzFdIC0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8yNzA2
MTUxLw0K
