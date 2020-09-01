Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73C625851C
	for <lists+linux-spi@lfdr.de>; Tue,  1 Sep 2020 03:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgIABZI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Aug 2020 21:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIABZG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Aug 2020 21:25:06 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4E5C0613ED
        for <linux-spi@vger.kernel.org>; Mon, 31 Aug 2020 18:25:05 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 61AEF84487;
        Tue,  1 Sep 2020 13:25:03 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1598923503;
        bh=+jlIR0yFHVUssNxas9cpoGDxlsd4nP3LGFJgftDmst0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=IVWtnOf+D+9uAYKTM176ep4b1NiAjRQPXXOQ3HtWNgk7oqEILxwncvgXWqQVPzSV+
         mUTLb8Z9i7UZOMJ3epa6WV0OqIe9xH3QU4FrI5ChzkMQOhMGnhWomu7vouWMFHf11o
         5hWlQ+25uP2cY6nWvxnnFzsKHN8nMFPFivICai7uS6fIhgL8sn/DOCGJ0SuiSaVN9D
         ZT0xBuw3l9ZjA0sEp1KjRZLCmPap/IIaLb+oX6zU3nVNSXm3HWze1jUbx2mckmVh8/
         LYQdaE+op+DtdandJp9ATZMtrDlh3SFERWVtSg0vMh2I4fAqib658AVvU/yVCh688G
         itZyY6jXLgSlw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f4da2f00001>; Tue, 01 Sep 2020 13:25:04 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Sep 2020 13:25:03 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Tue, 1 Sep 2020 13:25:03 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "paulus@samba.org" <paulus@samba.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: fsl_espi errors on v5.7.15
Thread-Topic: fsl_espi errors on v5.7.15
Thread-Index: AQHWceVnik7XsBYbp0S+yHVGh1hdQak2WMaAgAQdSwCAAz9MAIAAfdcAgAD5u4CAB+sMAIAAYfwAgAA6JQCAAPtUgIAAOXyAgABIbACAAAjRgIABm7wAgAD5+gCABBXPAIAAjqOAgAALRACAAAUXgIAA9CsAgADXoQA=
Date:   Tue, 1 Sep 2020 01:25:02 +0000
Message-ID: <39f36ad7-5dc5-f7ce-e2bc-1b59ff70e005@alliedtelesis.co.nz>
References: <42107721-614b-96e8-68d9-4b888206562e@alliedtelesis.co.nz>
 <1020029e-4cb9-62ba-c6d6-e6b9bdf93aac@gmail.com>
 <1598510348.1g7wt0s02s.astroid@bobo.none>
 <0068446e-06f8-6648-2f40-56f324c1ee6e@alliedtelesis.co.nz>
 <1598788275.m90vz24p6x.astroid@bobo.none>
 <524a0f50-f954-f5a7-eccb-66eece59c7c4@alliedtelesis.co.nz>
 <5ca7ba48-ef9c-2b7c-67ff-88d0a2c9f380@gmail.com>
 <6a9eb498-2982-05de-52f9-da5f6a626e49@alliedtelesis.co.nz>
 <5bf05188-a52e-c8c0-9d2d-c87eff6f1588@gmail.com>
In-Reply-To: <5bf05188-a52e-c8c0-9d2d-c87eff6f1588@gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9EA35C7C561544D81507B6F91F9A3C9@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQpPbiAxLzA5LzIwIDEyOjMzIGFtLCBIZWluZXIgS2FsbHdlaXQgd3JvdGU6DQo+IE9uIDMwLjA4
LjIwMjAgMjM6NTksIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBPbiAzMS8wOC8yMCA5OjQxIGFt
LCBIZWluZXIgS2FsbHdlaXQgd3JvdGU6DQo+Pj4gT24gMzAuMDguMjAyMCAyMzowMCwgQ2hyaXMg
UGFja2hhbSB3cm90ZToNCj4+Pj4gT24gMzEvMDgvMjAgMTI6MzAgYW0sIE5pY2hvbGFzIFBpZ2dp
biB3cm90ZToNCj4+Pj4+IEV4Y2VycHRzIGZyb20gQ2hyaXMgUGFja2hhbSdzIG1lc3NhZ2Ugb2Yg
QXVndXN0IDI4LCAyMDIwIDg6MDcgYW06DQo+Pj4+IDxzbmlwPg0KPj4+Pg0KPj4+Pj4+Pj4+PiBJ
J3ZlIGFsc28gbm93IHNlZW4gdGhlIFJYIEZJRk8gbm90IGVtcHR5IGVycm9yIG9uIHRoZSBUMjA4
MFJEQg0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFu
c2ZlciBkb25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQo+Pj4+Pj4+Pj4+IGZzbF9lc3BpIGZm
ZTExMDAwMC5zcGk6IFRyYW5zZmVyIGRvbmUgYnV0IFNQSUVfRE9OIGlzbid0IHNldCENCj4+Pj4+
Pj4+Pj4gZnNsX2VzcGkgZmZlMTEwMDAwLnNwaTogVHJhbnNmZXIgZG9uZSBidXQgU1BJRV9ET04g
aXNuJ3Qgc2V0IQ0KPj4+Pj4+Pj4+PiBmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBk
b25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQo+Pj4+Pj4+Pj4+IGZzbF9lc3BpIGZmZTExMDAw
MC5zcGk6IFRyYW5zZmVyIGRvbmUgYnV0IHJ4L3R4IGZpZm8ncyBhcmVuJ3QgZW1wdHkhDQo+Pj4+
Pj4+Pj4+IGZzbF9lc3BpIGZmZTExMDAwMC5zcGk6IFNQSUVfUlhDTlQgPSAxLCBTUElFX1RYQ05U
ID0gMzINCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gV2l0aCBteSBjdXJyZW50IHdvcmthcm91bmQg
b2YgZW1wdHlpbmcgdGhlIFJYIEZJRk8uIEl0IHNlZW1zDQo+Pj4+Pj4+Pj4+IHN1cnZpdmFibGUu
IEludGVyZXN0aW5nbHkgaXQgb25seSBldmVyIHNlZW1zIHRvIGJlIDEgZXh0cmEgYnl0ZSBpbiB0
aGUNCj4+Pj4+Pj4+Pj4gUlggRklGTyBhbmQgaXQgc2VlbXMgdG8gYmUgYWZ0ZXIgZWl0aGVyIGEg
UkVBRF9TUiBvciBhIFJFQURfRlNSLg0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBmc2xfZXNwaSBm
ZmUxMTAwMDAuc3BpOiB0eCA3MA0KPj4+Pj4+Pj4+PiBmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBy
eCAwMw0KPj4+Pj4+Pj4+PiBmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBFeHRyYSBSWCAwMA0KPj4+
Pj4+Pj4+PiBmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RP
TiBpc24ndCBzZXQhDQo+Pj4+Pj4+Pj4+IGZzbF9lc3BpIGZmZTExMDAwMC5zcGk6IFRyYW5zZmVy
IGRvbmUgYnV0IHJ4L3R4IGZpZm8ncyBhcmVuJ3QgZW1wdHkhDQo+Pj4+Pj4+Pj4+IGZzbF9lc3Bp
IGZmZTExMDAwMC5zcGk6IFNQSUVfUlhDTlQgPSAxLCBTUElFX1RYQ05UID0gMzINCj4+Pj4+Pj4+
Pj4gZnNsX2VzcGkgZmZlMTEwMDAwLnNwaTogdHggMDUNCj4+Pj4+Pj4+Pj4gZnNsX2VzcGkgZmZl
MTEwMDAwLnNwaTogcnggMDANCj4+Pj4+Pj4+Pj4gZnNsX2VzcGkgZmZlMTEwMDAwLnNwaTogRXh0
cmEgUlggMDMNCj4+Pj4+Pj4+Pj4gZnNsX2VzcGkgZmZlMTEwMDAwLnNwaTogVHJhbnNmZXIgZG9u
ZSBidXQgU1BJRV9ET04gaXNuJ3Qgc2V0IQ0KPj4+Pj4+Pj4+PiBmc2xfZXNwaSBmZmUxMTAwMDAu
c3BpOiBUcmFuc2ZlciBkb25lIGJ1dCByeC90eCBmaWZvJ3MgYXJlbid0IGVtcHR5IQ0KPj4+Pj4+
Pj4+PiBmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBTUElFX1JYQ05UID0gMSwgU1BJRV9UWENOVCA9
IDMyDQo+Pj4+Pj4+Pj4+IGZzbF9lc3BpIGZmZTExMDAwMC5zcGk6IHR4IDA1DQo+Pj4+Pj4+Pj4+
IGZzbF9lc3BpIGZmZTExMDAwMC5zcGk6IHJ4IDAwDQo+Pj4+Pj4+Pj4+IGZzbF9lc3BpIGZmZTEx
MDAwMC5zcGk6IEV4dHJhIFJYIDAzDQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+ICAgICBGcm9tIGFs
bCB0aGUgTWljcm9uIFNQSS1OT1IgZGF0YXNoZWV0cyBJJ3ZlIGdvdCBhY2Nlc3MgdG8gaXQgaXMN
Cj4+Pj4+Pj4+Pj4gcG9zc2libGUgdG8gY29udGludWFsbHkgcmVhZCB0aGUgU1IvRlNSLiBCdXQg
SSd2ZSBubyBpZGVhIHdoeSBpdA0KPj4+Pj4+Pj4+PiBoYXBwZW5zIHNvbWUgdGltZXMgYW5kIG5v
dCBvdGhlcnMuDQo+Pj4+Pj4+Pj4gU28gSSB0aGluayBJJ3ZlIGdvdCBhIHJlcHJvZHVjdGlvbiBh
bmQgSSB0aGluayBJJ3ZlIGJpc2VjdGVkIHRoZSBwcm9ibGVtDQo+Pj4+Pj4+Pj4gdG8gY29tbWl0
IDMyODJhM2RhMjViZCAoInBvd2VycGMvNjQ6IEltcGxlbWVudCBzb2Z0IGludGVycnVwdCByZXBs
YXkgaW4NCj4+Pj4+Pj4+PiBDIikuIE15IGRheSBpcyBqdXN0IGZpbmlzaGluZyBub3cgc28gSSBo
YXZlbid0IGFwcGxpZWQgdG9vIG11Y2ggc2NydXRpbnkNCj4+Pj4+Pj4+PiB0byB0aGlzIHJlc3Vs
dC4gR2l2ZW4gdGhlIHZhcmlvdXMgcmFiYml0IGhvbGVzIEkndmUgYmVlbiBkb3duIG9uIHRoaXMN
Cj4+Pj4+Pj4+PiBpc3N1ZSBhbHJlYWR5IEknZCB0YWtlIHRoaXMgaW5mb3JtYXRpb24gd2l0aCBh
IGdvb2QgZGVncmVlIG9mIHNrZXB0aWNpc20uDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+IE9LLCBzbyBh
biBlYXN5IHRlc3Qgc2hvdWxkIGJlIHRvIHJlLXRlc3Qgd2l0aCBhIDUuNCBrZXJuZWwuDQo+Pj4+
Pj4+PiBJdCBkb2Vzbid0IGhhdmUgeWV0IHRoZSBjaGFuZ2UgeW91J3JlIHJlZmVycmluZyB0bywg
YW5kIHRoZSBmc2wtZXNwaSBkcml2ZXINCj4+Pj4+Pj4+IGlzIGJhc2ljYWxseSB0aGUgc2FtZSBh
cyBpbiA1LjcgKGp1c3QgdHdvIHNtYWxsIGNoYW5nZXMgaW4gNS43KS4NCj4+Pj4+Pj4gVGhlcmUn
cyA2Y2MwYzE2ZDgyZjg4IGFuZCBtYXliZSBhbHNvIG90aGVyIGludGVycnVwdCByZWxhdGVkIHBh
dGNoZXMNCj4+Pj4+Pj4gYXJvdW5kIHRoaXMgdGltZSB0aGF0IGNvdWxkIGFmZmVjdCBib29rIEUs
IHNvIGl0J3MgZ29vZCBpZiB0aGF0IGV4YWN0DQo+Pj4+Pj4+IHBhdGNoIGlzIGNvbmZpcm1lZC4N
Cj4+Pj4+PiBNeSBjb25maXJtYXRpb24gaXMgYmFzaWNhbGx5IHRoYXQgSSBjYW4gaW5kdWNlIHRo
ZSBpc3N1ZSBpbiBhIDUuNCBrZXJuZWwNCj4+Pj4+PiBieSBjaGVycnktcGlja2luZyAzMjgyYTNk
YTI1YmQuIEknbSBhbHNvIGFibGUgdG8gImZpeCIgdGhlIGlzc3VlIGluDQo+Pj4+Pj4gNS45LXJj
MiBieSByZXZlcnRpbmcgdGhhdCBvbmUgY29tbWl0Lg0KPj4+Pj4+DQo+Pj4+Pj4gSSBib3RoIGNh
c2VzIGl0J3Mgbm90IGV4YWN0bHkgYSBjbGVhbiBjaGVycnktcGljay9yZXZlcnQgc28gSSBhbHNv
DQo+Pj4+Pj4gY29uZmlybWVkIHRoZSBiaXNlY3Rpb24gcmVzdWx0IGJ5IGJ1aWxkaW5nIGF0IDMy
ODJhM2RhMjViZCAod2hpY2ggc2Vlcw0KPj4+Pj4+IHRoZSBpc3N1ZSkgYW5kIHRoZSBjb21taXQg
anVzdCBiZWZvcmUgKHdoaWNoIGRvZXMgbm90KS4NCj4+Pj4+IFRoYW5rcyBmb3IgdGVzdGluZywg
dGhhdCBjb25maXJtcyBpdCB3ZWxsLg0KPj4+Pj4NCj4+Pj4+IFtzbmlwIHBhdGNoXQ0KPj4+Pj4N
Cj4+Pj4+PiBJIHN0aWxsIHNhdyB0aGUgaXNzdWUgd2l0aCB0aGlzIGNoYW5nZSBhcHBsaWVkLiBQ
UENfSVJRX1NPRlRfTUFTS19ERUJVRw0KPj4+Pj4+IGRpZG4ndCByZXBvcnQgYW55dGhpbmcgKGVp
dGhlciB3aXRoIG9yIHdpdGhvdXQgdGhlIGNoYW5nZSBhYm92ZSkuDQo+Pj4+PiBPa2F5LCBpdCB3
YXMgYSBiaXQgb2YgYSBzaG90IGluIHRoZSBkYXJrLiBJIHN0aWxsIGNhbid0IHNlZSB3aGF0DQo+
Pj4+PiBlbHNlIGhhcyBjaGFuZ2VkLg0KPj4+Pj4NCj4+Pj4+IFdoYXQgd291bGQgY2F1c2UgdGhp
cywgYSBsb3N0IGludGVycnVwdD8gQSBzcHVyaW91cyBpbnRlcnJ1cHQ/IE9yDQo+Pj4+PiBoaWdo
ZXIgaW50ZXJydXB0IGxhdGVuY3k/DQo+Pj4+Pg0KPj4+Pj4gSSBkb24ndCB0aGluayB0aGUgcGF0
Y2ggc2hvdWxkIGNhdXNlIHNpZ25pZmljYW50bHkgd29yc2UgbGF0ZW5jeSwNCj4+Pj4+IChpdCdz
IHN1cHBvc2VkIHRvIGJlIGEgYml0IGJldHRlciBpZiBhbnl0aGluZyBiZWNhdXNlIGl0IGRvZXNu
J3Qgc2V0DQo+Pj4+PiB1cCB0aGUgZnVsbCBpbnRlcnJ1cHQgZnJhbWUpLiBCdXQgaXQncyBwb3Nz
aWJsZS4NCj4+Pj4gTXkgd29ya2luZyB0aGVvcnkgaXMgdGhhdCB0aGUgU1BJX0RPTiBpbmRpY2F0
aW9uIGlzIGFsbCBhYm91dCB0aGUgVFgNCj4+Pj4gZGlyZWN0aW9uIGFuIG5vdyB0aGF0IHRoZSBp
bnRlcnJ1cHRzIGFyZSBmYXN0ZXIgd2UncmUgaGl0dGluZyBhbiBlcnJvcg0KPj4+PiBiZWNhdXNl
IHRoZXJlIGlzIHN0aWxsIFJYIGFjdGl2aXR5IGdvaW5nIG9uLiBIZWluZXIgZGlzYWdyZWVzIHdp
dGggbXkNCj4+Pj4gaW50ZXJwcmV0YXRpb24gb2YgdGhlIFNQSV9ET04gaW5kaWNhdGlvbiBhbmQg
dGhlIGZhY3QgdGhhdCBpdCBkb2Vzbid0DQo+Pj4+IGhhcHBlbiBldmVyeSB0aW1lIGRvZXMgdGhy
b3cgZG91YnQgb24gaXQuDQo+Pj4+DQo+Pj4gSXQncyByaWdodCB0aGF0IHRoZSBlU1BJIHNwZWMg
Y2FuIGJlIGludGVycHJldGVkIHRoYXQgU1BJX0RPTiByZWZlcnMgdG8NCj4+PiBUWCBvbmx5LiBI
b3dldmVyIHRoaXMgd291bGRuJ3QgcmVhbGx5IG1ha2Ugc2Vuc2UsIGJlY2F1c2UgYWxzbyBmb3Ig
UlgNCj4+PiB3ZSBwcm9ncmFtIHRoZSBmcmFtZSBsZW5ndGgsIGFuZCB0aGVyZWZvcmUgd2FudCB0
byBiZSBub3RpZmllZCBvbmNlIHRoZQ0KPj4+IGZ1bGwgZnJhbWUgd2FzIHJlY2VpdmVkLiBBbHNv
IHByYWN0aWNhbCBleHBlcmllbmNlIHNob3dzIHRoYXQgU1BJX0RPTg0KPj4+IGlzIHNldCBhbHNv
IGFmdGVyIFJYLW9ubHkgdHJhbnNmZXJzLg0KPj4+IFR5cGljYWwgU1BJIE5PUiB1c2UgY2FzZSBp
cyB0aGF0IHlvdSB3cml0ZSByZWFkIGNvbW1hbmQgKyBzdGFydCBhZGRyZXNzLA0KPj4+IGZvbGxv
d2VkIGJ5IGEgbG9uZ2VyIHJlYWQuIElmIHRoZSBUWC1vbmx5IGludGVycHJldGF0aW9uIHdvdWxk
IGJlIHJpZ2h0LA0KPj4+IHdlJ2QgYWx3YXlzIGVuZCB1cCB3aXRoIFNQSV9ET04gbm90IGJlaW5n
IHNldC4NCj4+Pg0KPj4+PiBJIGNhbid0IHJlYWxseSBleHBsYWluIHRoZSBleHRyYSBSWCBieXRl
IGluIHRoZSBmaWZvLiBXZSBrbm93IGhvdyBtYW55DQo+Pj4+IGJ5dGVzIHRvIGV4cGVjdCBhbmQg
d2UgcHVsbCB0aGF0IG1hbnkgZnJvbSB0aGUgZmlmbyBzbyBpdCdzIG5vdCBhcyBpZg0KPj4+PiB3
ZSdyZSBtaXNzaW5nIGFuIGludGVycnVwdCBjYXVzaW5nIHVzIHRvIHNraXAgdGhlIGxhc3QgYnl0
ZS4gSSd2ZSBiZWVuDQo+Pj4+IGxvb2tpbmcgZm9yIHNvbWUga2luZCBvZiBvZmYtYnktb25lIGNh
bGN1bGF0aW9uIGJ1dCBhZ2FpbiBpZiBpdCB3ZXJlDQo+Pj4+IHNvbWV0aGluZyBsaWtlIHRoYXQg
aXQnZCBoYXBwZW4gYWxsIHRoZSB0aW1lLg0KPj4+Pg0KPj4+IE1heWJlIGl0IGhlbHBzIHRvIGtu
b3cgd2hhdCB2YWx1ZSB0aGlzIGV4dHJhIGJ5dGUgaW4gdGhlIEZJRk8gaGFzLiBJcyBpdDoNCj4+
PiAtIGEgZHVwbGljYXRlIG9mIHRoZSBsYXN0IHJlYWQgYnl0ZQ0KPj4+IC0gb3IgdGhlIG5leHQg
Ynl0ZSAoYXQgPGVuZCBhZGRyZXNzPiArIDEpDQo+Pj4gLSBvciBhIGZpeGVkIHZhbHVlLCBlLmcu
IGFsd2F5cyAweDAwIG9yIDB4ZmYNCj4+IFRoZSB2YWx1ZXMgd2VyZSB1cCB0aHJlYWQgYSBiaXQg
YnV0IEknbGwgcmVwZWF0IHRoZW0gaGVyZQ0KPj4NCj4+IGZzbF9lc3BpIGZmZTExMDAwMC5zcGk6
IHR4IDcwDQo+PiBmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiByeCAwMw0KPj4gZnNsX2VzcGkgZmZl
MTEwMDAwLnNwaTogRXh0cmEgUlggMDANCj4+IGZzbF9lc3BpIGZmZTExMDAwMC5zcGk6IFRyYW5z
ZmVyIGRvbmUgYnV0IFNQSUVfRE9OIGlzbid0IHNldCENCj4+IGZzbF9lc3BpIGZmZTExMDAwMC5z
cGk6IFRyYW5zZmVyIGRvbmUgYnV0IHJ4L3R4IGZpZm8ncyBhcmVuJ3QgZW1wdHkhDQo+PiBmc2xf
ZXNwaSBmZmUxMTAwMDAuc3BpOiBTUElFX1JYQ05UID0gMSwgU1BJRV9UWENOVCA9IDMyDQo+PiBm
c2xfZXNwaSBmZmUxMTAwMDAuc3BpOiB0eCAwNQ0KPj4gZnNsX2VzcGkgZmZlMTEwMDAwLnNwaTog
cnggMDANCj4+IGZzbF9lc3BpIGZmZTExMDAwMC5zcGk6IEV4dHJhIFJYIDAzDQo+PiBmc2xfZXNw
aSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQo+
PiBmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCByeC90eCBmaWZvJ3Mg
YXJlbid0IGVtcHR5IQ0KPj4gZnNsX2VzcGkgZmZlMTEwMDAwLnNwaTogU1BJRV9SWENOVCA9IDEs
IFNQSUVfVFhDTlQgPSAzMg0KPj4gZnNsX2VzcGkgZmZlMTEwMDAwLnNwaTogdHggMDUNCj4+IGZz
bF9lc3BpIGZmZTExMDAwMC5zcGk6IHJ4IDAwDQo+PiBmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBF
eHRyYSBSWCAwMw0KPj4NCj4+DQo+PiBUaGUgcnggMDAgRXh0cmEgUlggMDMgaXMgYSBiaXQgY29u
Y2VybmluZy4gSSd2ZSBvbmx5IGV2ZXIgc2VlbiB0aGVtIHdpdGgNCj4+IGVpdGhlciBhIFJFQURf
U1Igb3IgYSBSRUFEX0ZTUi4gTmV2ZXIgYSBkYXRhIHJlYWQuDQo+Pg0KPiBKdXN0IHJlbWVtYmVy
ZWQgc29tZXRoaW5nIGFib3V0IFNQSUVfRE9OOg0KPiBUcmFuc2ZlcnMgYXJlIGFsd2F5cyBmdWxs
IGR1cGxleCwgdGhlcmVmb3JlIGluIGNhc2Ugb2YgYSByZWFkIHRoZSBjaGlwDQo+IHNlbmRzIGR1
bW15IHplcm8ncy4gSGF2aW5nIHNhaWQgdGhhdCBpbiBjYXNlIG9mIGEgcmVhZCBTUElFX0RPTiBt
ZWFucw0KPiB0aGF0IHRoZSBsYXN0IGR1bW15IHplcm8gd2FzIHNoaWZ0ZWQgb3V0Lg0KPg0KPiBS
RUFEX1NSIGFuZCBSRUFEX0ZTUiBhcmUgdGhlIHNob3J0ZXN0IHRyYW5zZmVycywgMSBieXRlIG91
dCBhbmQgMSBieXRlIGluLg0KPiBTbyB0aGUgaXNzdWUgbWF5IGhhdmUgYSBkZXBlbmRlbmN5IG9u
IHRoZSBsZW5ndGggb2YgdGhlIHRyYW5zZmVyLg0KPiBIb3dldmVyIEkgc2VlIG5vIGdvb2QgZXhw
bGFuYXRpb24gc28gZmFyLiBZb3UgY2FuIHRyeSBhZGRpbmcgYSBkZWxheSBvZg0KPiBhIGZldyBt
aXJvc2Vjb25kcyBiZXR3ZWVuIHRoZSBmb2xsb3dpbmcgdG8gY29tbWFuZHMgaW4gZnNsX2VzcGlf
YnVmcygpLg0KPg0KPiAJZnNsX2VzcGlfd3JpdGVfcmVnKGVzcGksIEVTUElfU1BJTSwgbWFzayk7
DQo+DQo+IAkvKiBQcmV2ZW50IGZpbGxpbmcgdGhlIGZpZm8gZnJvbSBnZXR0aW5nIGludGVycnVw
dGVkICovDQo+IAlzcGluX2xvY2tfaXJxKCZlc3BpLT5sb2NrKTsNCj4NCj4gTWF5YmUgZW5hYmxp
bmcgaW50ZXJydXB0cyBhbmQgc2VlaW5nIHRoZSBTUElFX0RPTiBpbnRlcnJ1cHQgYXJlIHRvbyBj
bG9zZS4NCkkgdGhpbmsgdGhpcyBtaWdodCBiZSBoZWFkaW5nIGluIHRoZSByaWdodCBkaXJlY3Rp
b24uIFBsYXlpbmcgYWJvdXQgd2l0aCANCmEgZGVsYXkgZG9lcyBzZWVtIHRvIG1ha2UgdGhlIHR3
byBzeW1wdG9tcyBsZXNzIGxpa2VseS4gQWx0aG91Z2ggSSBoYXZlIA0KdG8gc2V0IGl0IHF1aXRl
IGhpZ2ggKGkuZS4gbXNsZWVwKDEwMCkpIHRvIGNvbXBsZXRlbHkgYXZvaWQgYW55IA0KcG9zc2li
aWxpdHkgb2Ygc2VlaW5nIGVpdGhlciBtZXNzYWdlLg==
