Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB1113770
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 23:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfLDWNC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 17:13:02 -0500
Received: from mail-eopbgr1410101.outbound.protection.outlook.com ([40.107.141.101]:55606
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728031AbfLDWNB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Dec 2019 17:13:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpZ6iWpZBTQSey73mDM5l65ZLSnDClooqxyAEUZRYCDYJTph9ooUebJMfoMc/YE+sFB1OUPD7PAmZ6rPX7lybr49NRbUn0J1Mn4juCTfspaqdyyPWVPms6cLxJTksKcvJshqm8JqctO+M0pd2w6pf4DdLoXEQWE0ADEDfF4qbhKOmOvosaUficZ7nRP2TZkESzx9OUSzBH1v+Tw+vuV7hs8MmvNe73U5N0gPVdwqse5Mn9RHY7GGQFDCaqdVDLX8NWMdjJGEeXrnlAy5rsT4opqxx5ivYBI3BxE3emos1u5lVvLDHnoos/KsmWuKWnEpNo1mCauHVzYkM4ZVRgR/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6JWv5w7a1Pvga0UnVAvlmh8rejyI5K17pz1mdYqses=;
 b=N/GbCCLFSFP1oENtqFxlnTsUzQBPlIlqBMd+oOn6aBeHugZa3M9Yv7n5bOf4B/n0vbq7MoeVbSfOB+wV2PD0M+bvmAGLmPuNq1rSuq6XL5myOMIn0nmilh47KjtMusTESw2i3S27R/AZEjXBcumYNuNWz3BV3EJOw/JH/FZyN78BdLYoGdLTqzkoDnaeq/GUUnQ6VrvZGd+dx36lOQCDTeV2tFhzElWI/ZWaseonM0Ruo4clpsx07s92mWPMgvGruiRPB1O0pfFMJ7wrLiJToyP9IL/jWXgJYC4FAkcihFHumcHMESS4IpnrLur2jIMGBrFF2u5kEW4sfFMabIwAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6JWv5w7a1Pvga0UnVAvlmh8rejyI5K17pz1mdYqses=;
 b=NjDMvojrR49MniOIJQD7kz4OwKHq9RnrQRo0WE2Qv6PtQL070iD8F9HKyEDdbZQmub6l2/xc3XeENgehIo9yosqmpGx8yKimXgB6mKa0rjsdlTn5JsMWCOBz91oULidEfy7aPUOIzJWRX9pT90m87eLHAIZ3F4YY8fKbxlFMuVg=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1529.jpnprd01.prod.outlook.com (52.133.160.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25; Wed, 4 Dec 2019 22:12:58 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 22:12:57 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: RE: [PATCH 4/6] spi: Add SPIBSC driver
Thread-Topic: [PATCH 4/6] spi: Add SPIBSC driver
Thread-Index: AQHVqYxFvw0/++3CUEK7207HpOVVR6eou8UAgAF7GbA=
Date:   Wed, 4 Dec 2019 22:12:57 +0000
Message-ID: <TY1PR01MB1562B1CBD17676A559EBA5718A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-5-chris.brandt@renesas.com>
 <CAMuHMdVAZOa7OmT0s=RsVJsny9NujDzpdg4T+QoUXGe0kJjOTw@mail.gmail.com>
In-Reply-To: <CAMuHMdVAZOa7OmT0s=RsVJsny9NujDzpdg4T+QoUXGe0kJjOTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzgyM2FjZTQtMTZlMy0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDM4MjNhY2U1LTE2ZTMtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMjYxNCIgdD0iMTMyMTk5NzExNzU0MjE4ODYxIiBoPSJWajc2bXdyNGNxU3lGa085M3BiOTBJWTBPQnc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aed1abd5-d2b8-4bfb-3f75-08d779071e79
x-ms-traffictypediagnostic: TY1PR01MB1529:
x-microsoft-antispam-prvs: <TY1PR01MB15291414B6158F4C515C82018A5D0@TY1PR01MB1529.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(55016002)(2906002)(229853002)(9686003)(14454004)(6246003)(11346002)(305945005)(66476007)(66556008)(5660300002)(66446008)(25786009)(186003)(316002)(26005)(52536014)(66946007)(102836004)(6436002)(3846002)(71200400001)(71190400001)(64756008)(81166006)(4326008)(81156014)(6116002)(8936002)(478600001)(7416002)(76116006)(33656002)(54906003)(74316002)(99286004)(8676002)(7736002)(86362001)(6916009)(6506007)(76176011)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1529;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bY5+rvl6Wqs4WJXIKE3RtN3XzTB0HNJZAcfn1gTy2DNkP+LGnXKvsmwqC1OFrUC2ePLuQY/489kxFQYumAhRdnTD6ghmg+nm1PsDiPQCIv5EN+/u/sLthlHgXYWNnHEdmzUVoSeO+ncbKucahUCssa708vyfjT+/AuxKsKMprn+H3teMisQSz5b+KRLWhCA64+7HZq22UwECqwJxOpGM4FiDzBbaZUIicLhaCSjWX+7w188/jVon3YR/jVI4l5+BhQ49LvLaCYL/c3Iw/0A0S9RUrl4wDCS6eL0k/8xldYrs5JZNFOFO+HLtRWcl76rU8NazduzYq8vRf6qzjsINdz18qwKiYE3utEZLopzDl5Qdw+9coVHf2GLOeMqfLgVGJoOcZuQvqToqCnbVa6+OG0mM8MDq0sxr9kewYvlXbBq/KWSOyuytemukcnL/SrkZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed1abd5-d2b8-4bfb-3f75-08d779071e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 22:12:57.7809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5rJHPGu/b70z2D4jC6ECJm8d0NkkiPw6pBx8OUXBCgliUFsW6Pke97cOxXpn5Pxf6p4d6FTtf/um217JhNs8CMCNjcjNdw1px0kTXeVUR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1529
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcgYW5kIHN1Z2dlc3Rpb25zIQ0K
DQpPbiBUdWUsIERlYyAzLCAyMDE5LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+ID4gK3N0
YXRpYyBpbnQgc3BpYnNjX3dhaXRfdHJhbnNfY29tcGxldGlvbihzdHJ1Y3Qgc3BpYnNjX3ByaXYg
KnNic2MpIHsNCj4gPiArICAgICAgIGludCB0ID0gMjU2ICogMTAwMDAwOw0KPiA+ICsNCj4gPiAr
ICAgICAgIHdoaWxlICh0LS0pIHsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHNwaWJzY19yZWFk
KHNic2MsIENNTlNSKSAmIENNTlNSX1RFTkQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIDA7DQo+ID4gKyAgICAgICAgICAgICAgIG5kZWxheSgxKTsNCj4gPiArICAgICAgIH0N
Cj4gDQo+IFNvIHRoaXMgbWF5IGJ1c3kgbG9vcCBmb3IgdXAgdG8gMjUuNiBtcz8gT29wcy4uLg0K
PiANCj4gQ2FuIHlvdSB1c2UgdGhlIGludGVycnVwdCAoU1BJSEYpIGluc3RlYWQsIHNpZ25hbGxp
bmcgYSBjb21wbGV0aW9uPw0KDQpSWi9BMSBkb2Vzbid0IGhhdmUgYW55IGludGVycnVwdHMuIEFu
ZCBJIHRoaW5rIHRoZSBpbnRlcnJ1cHRzIGluIFJaL0EyIA0Kb25seSB3b3JrIGZvciBIeXBlckZs
YXNoIChub3QgUVNQSSkuDQoNCkJ1dCwgMjUuNm1zIGlzIHdheSB0b28gbG9uZyENCkknbGwgYXNz
dW1lIHRoZSBzbG93ZXN0IGNsb2NrIHRvIGJlIDFNSHogYW5kIHRoZSBtYXggRklGTyB0cmFuc2Zl
ciBvZiA0IGJ5dGVzLg0KVGhhdCdzIDMydXMsIHNvIHRoYXQncyB3aGF0IEknbGwgdXNlLg0KDQoN
Cj4gPiArICAgICAgICAgICAgICAgaWYgKHQtPmNzX2NoYW5nZSkgew0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGRldl9lcnIoc2JzYy0+ZGV2LCAiY3NfY2hhbmdlIG5vdCBzdXBwb3J0ZWQi
KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsNCj4gPiArICAgICAg
ICAgICAgICAgfQ0KPiA+ICsgICAgICAgfQ0KPiANCj4gSWYgeW91IHdvdWxkIGRvIHRoZSBjaGVj
a3MgYWJvdmUgaW4gLnByZXBhcmVfbWVzc2FnZSgpIChsaWtlIGUuZy4gcnNwaQ0KPiBkb2VzKS4u
Lg0KDQpPSywgVGhhbmtzLiA6KQ0KDQo+ID4gKyAgICAgICBjYXNlIDY6DQo+ID4gKyAgICAgICAg
ICAgICAgIGRyb3ByIHw9IERST1BSX09QRDAodHhfZGF0YVs1XSk7DQo+ID4gKyAgICAgICAgICAg
ICAgIG9wZGUgfD0gKDEgPDwgMCk7DQo+IA0KPiBCb3RoIGNoZWNrcGF0Y2ggYW5kIGdjYyB0ZWxs
IHlvdSB0byBhZGQgZmFsbHRocm91Z2ggY29tZW50cy4NCg0KT0ssIGZpeGVkLg0KDQoNCj4gLi4u
IGNhbid0IHlvdSBqdXN0IHVzZSAudHJhbnNmZXJfb25lKCksIGluc3RlYWQgb2YgZHVwbGljYXRp
bmcgdGhlIGxvZ2ljIGZyb20NCj4gc3BpX3RyYW5zZmVyX29uZV9tZXNzYWdlKCk/DQo+IE9yIGlz
IHRoZXJlIHNvbWUgc3BlY2lhbCBkZXRhaWwgdGhhdCdzIG5vdCBvYnZpb3VzIHRvIHRoZSBjYXN1
YWwgcmV2aWV3ZXI/DQoNCkkgZ3Vlc3MgLnRyYW5zZmVyX29uZSgpIGNvdWxkIGJlIHVzZWQgaWYg
SSBrZXB0IHNob3ZpbmcgbW9yZSBzdHVmZiBpbnRvIA0KLnByZXBhcmVfbWVzc2FnZSgpLg0KDQpC
dXQsIHRoZSBzY3Jld3kgdGhpbmcgYWJvdXQgdGhpcyBjb250cm9sbGVyIGlzIHRoYXQgbWVzc2Fn
ZXMgdGhhdCBhcmUgDQonVHggb25seScgYXJlIHByb2Nlc3NlZCBkaWZmZXJlbnRseSB0aGVuICdU
eCB0aGVuIFJ4JyBtZXNzYWdlcyBhbmQgbm90IA0KbGlrZSBhIHRyYWRpdGlvbmFsIFNQSSBjb250
cm9sbGVyLg0KQnkgaW1wbGVtZW50aW5nIGJvdGggY29uZGl0aW9ucyBpbiAuc3BpX3RyYW5zZmVy
X29uZV9tZXNzYWdlKCksIGl0IG1ha2VzDQp0aGF0IG1vcmUgY2xlYXIgZm9yIHRoZSBuZXh0IHBl
cnNvbiBpbiBteSBvcGluaW9uIGJlY2F1c2UgeW91IGNhbiBzZWUgDQp0aGF0IHNvbWV0aW1lcyB3
ZSBoYXZlIHRvIHdvcmsgd2l0aCB0aGUgZW50aXJlIG1lc3NhZ2UgYXMgYSB3aG9sZSwgbm90IA0K
anVzdCBpbmRpdmlkdWFsIHBpZWNlcy4NCg0KDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIG9mX3NwaWJzY19tYXRjaFtdID0gew0KPiA+ICsgICAgICAgeyAuY29tcGF0aWJs
ZSA9ICJyZW5lc2FzLHNwaWJzYyJ9LA0KPiA+ICsgICAgICAgeyAuY29tcGF0aWJsZSA9ICJyZW5l
c2FzLHI3czcyMTAwLXNwaWJzYyIsIC5kYXRhID0gKHZvaWQNCj4gKilIQVNfU1BCQ1J9LA0KPiA+
ICsgICAgICAgeyAuY29tcGF0aWJsZSA9ICJyZW5lc2FzLHI3czkyMTAtc3BpYnNjIn0sDQo+IA0K
PiBEbyB5b3UgbmVlZCB0byBtYXRjaCBhZ2FpbnN0IGFsbCAzIGluIHRoZSBkcml2ZXI/DQo+IERv
ZXMgU1BJQlNDIHdvcmsgb24gUlovQTEgd2hlbiBub3Qgc2V0dGluZyBIQVNfU1BCQ1I/DQo+IElm
IG5vdCwgdGhlIGZhbGxiYWNrIHRvICJyZW5lc2FzLHNwaWJzYyIgaXMgbm90IHZhbGlkIGZvciBS
Wi9BMS4NCg0KT0ssIEkgZHJvcHBlZCAicmVuZXNhcyxzcGlic2MiLg0KSSBsaWtlIGhhdmluZyBp
bmRpdmlkdWFsIFNvQyBuYW1lcyBhbnl3YXkuDQoNCkNocmlzDQo=
