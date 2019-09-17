Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 606AFB4A8E
	for <lists+linux-spi@lfdr.de>; Tue, 17 Sep 2019 11:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfIQJe2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Sep 2019 05:34:28 -0400
Received: from mail-eopbgr1320090.outbound.protection.outlook.com ([40.107.132.90]:32366
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727059AbfIQJe2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Sep 2019 05:34:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k43+5yRHENwxQ7JZ/ZiIRqCn/xEYW3DLmE1YogqHWFpa8sz/e0aUx6eW6NoO0K0caJs+hgzJF9DEXc9cd8dI/CHjULQozbjFg7574130HQU0qR3OwWcb4ZKqHXc1UdJo7uF6zs9zbFvSPSoutcgigI73UJxt6x+MQiu7oBKY37mn74o22wYkwYV+PlEPl/LWILwEsfqH86AFniD92lqXK4ZdagUxdA6LX8+FQdOreORZ2+RVnP6k6RUXn0L0kbt5t13EIkqBmhotBKuguTV19lucBBR3r28a1fyzH2bA1NCRzORabBpWEZOWySzXl4mLmofHVQlq4JX8Fy4oQ6rNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uv2CnDQU3CdbN9hYL4WIwQ+IZhsJ+S1dKG4bjcTDC8=;
 b=gsMF8M8VBHulDf9lvRzJEctv29Zxee+RAb2pos6AwlVWtV3mGadHDOtGnNwK3A8dVdO4s7KXKJeVc6P2aBNDxNFDk/hfJ5jBMT63SxR24R3jQl0EdwHzZ35SAqn8l/d3yJjTiGOiqpSXM8vbivnBaRjG4unNgoiLN2yX0WyvX64h6YU0gotpwpYxhLySXYNA0/yQSta0ozN0t7duAPrQCUQdJCvE4K2mywZg7CiakRKuBSEuyr2NQHGvud9nVXQ0k+Psfba+oPEUMm5sgWrKyeqEtJFbNuxdU+7Fy8dZeZnepL3ER16pLUUxokM03z6GDIYdTpvrNr9LIKVFYzgfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uv2CnDQU3CdbN9hYL4WIwQ+IZhsJ+S1dKG4bjcTDC8=;
 b=njG2uechqR0M+bBsm/Cu2okxVCSYOX7pMdcFHJchyIKlhcIot+5xWY32RelSdESVHzKsIBSyhb1nLk5jcwwmN+qENu2ORGauk4PKkYR6ueh62OJXdSXGVpDFR0Jjw3TlvQ54kO1/mMqEG0h95vpgjokZmZm6+RHyGhigOeHAEAQ=
Received: from TY2PR01MB2924.jpnprd01.prod.outlook.com (20.177.98.81) by
 TY2PR01MB2107.jpnprd01.prod.outlook.com (52.133.183.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.26; Tue, 17 Sep 2019 09:34:21 +0000
Received: from TY2PR01MB2924.jpnprd01.prod.outlook.com
 ([fe80::7ce4:f502:8430:51a]) by TY2PR01MB2924.jpnprd01.prod.outlook.com
 ([fe80::7ce4:f502:8430:51a%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 09:34:21 +0000
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] spi: dw: Add basic runtime PM support
Thread-Topic: [PATCH 2/3] spi: dw: Add basic runtime PM support
Thread-Index: AQHVaiyPrIzLbApuDUKmNvonSB+n+KcuY8iAgAAXkJCAAPSmgIAALxCA
Date:   Tue, 17 Sep 2019 09:34:21 +0000
Message-ID: <TY2PR01MB29248194652814C3FEB1C189DF8F0@TY2PR01MB2924.jpnprd01.prod.outlook.com>
References: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
 <1568376720-7402-3-git-send-email-gareth.williams.jx@renesas.com>
 <CAMuHMdUnzmYEcp0B5MG7itB1JHtNL7Stj9S2EFB0U0y_naQVBQ@mail.gmail.com>
 <TY2PR01MB2924AA1B012C2D305EE5C9B7DF8C0@TY2PR01MB2924.jpnprd01.prod.outlook.com>
 <CAMuHMdX9ZdLMmpHGqm2wmajwEDjuTY7s19PqwQ3kaVu8WLLykA@mail.gmail.com>
In-Reply-To: <CAMuHMdX9ZdLMmpHGqm2wmajwEDjuTY7s19PqwQ3kaVu8WLLykA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gareth.williams.jx@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24ba0765-f371-448d-c8d4-08d73b52387d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:TY2PR01MB2107;
x-ms-traffictypediagnostic: TY2PR01MB2107:|TY2PR01MB2107:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB210793E6231F947B60576320DF8F0@TY2PR01MB2107.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(189003)(199004)(81166006)(6246003)(9686003)(33656002)(81156014)(71200400001)(54906003)(26005)(476003)(11346002)(76116006)(4326008)(14454004)(446003)(71190400001)(25786009)(66476007)(66556008)(64756008)(66446008)(5660300002)(53546011)(6506007)(76176011)(86362001)(102836004)(52536014)(186003)(66066001)(7696005)(99286004)(6436002)(229853002)(55016002)(8676002)(7736002)(74316002)(316002)(66946007)(2906002)(6116002)(478600001)(305945005)(8936002)(486006)(3846002)(6916009)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB2107;H:TY2PR01MB2924.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: djJkH6QwvEP18yfBmsu4IWYPtMI8ms/bcI+9bUXIAmDqIJEbblVwFTcEi3YHcm/tPHot1ml3Cpa1IUdWsnFcaIjSYbc1oA0+XGJlu+Mu7CBBRgEIWUzX7hXFoj4PYv1Bf6zUrTWR8vi9BnvjRA5H1tMKBaUpdeRZsJYz6xPhM8EInEwwElwePGDCjnINr0tZrY3okB1ip/GvEFEV1caVvrSVEy53oWRIltVkQMro4oYnUaAx+m/yZVv3y51NEAtcDJCpae8o2SjELqvcHQvD2VSxsCtfveNu7kBPczwvosWFhLPNditGx2seJQRKHbJEqKc6JRdro4LsIgljdysd1+OAZ+OwfoDzn4gol96ag/9xP6PvHSwvL0YCYFaeExmnW/YST1e+ujkJ4d+ml+Bpuc6tLRXMIN+OBZQAMjWKl7I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ba0765-f371-448d-c8d4-08d73b52387d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 09:34:21.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xWtymTlgJHWBrnOPrMfkQgkB97UKDjgy5tDmI2c82ZVr8MmWNckvtpO6t3SyI4d0IeATvg+nJPw8ERxn2uu9HO944L2MnEkrmy8IjsEEPJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2107
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gT24gTW9uLCBTZXAgMTcsIDIwMTkgYXQgMDc6MzYgUE0gR2VlcnQgVXl0
dGVyaG9ldmVuDQo+IDxnZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+IA0KPiBIaSBHYXJl
dGgsDQo+IA0KPiBPbiBNb24sIFNlcCAxNiwgMjAxOSBhdCA2OjE0IFBNIEdhcmV0aCBXaWxsaWFt
cw0KPiA8Z2FyZXRoLndpbGxpYW1zLmp4QHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiA+IE9uIE1v
biwgU2VwIDE2LCAyMDE5IGF0IDE1OjM2IFBNIEdlZXJ0IFV5dHRlcmhvZXZlbg0KPiA+ID4gPGdl
ZXJ0QGxpbnV4LW02OGsub3JnPiB3cm90ZToNCj4gPiA+IE9uIEZyaSwgU2VwIDEzLCAyMDE5IGF0
IDI6MTMgUE0gR2FyZXRoIFdpbGxpYW1zDQo+ID4gPiA8Z2FyZXRoLndpbGxpYW1zLmp4QHJlbmVz
YXMuY29tPiB3cm90ZToNCj4gPiA+ID4gRnJvbTogUGhpbCBFZHdvcnRoeSA8cGhpbC5lZHdvcnRo
eUByZW5lc2FzLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gRW5hYmxlIHJ1bnRpbWUgUE0gc28gdGhh
dCB0aGUgY2xvY2sgdXNlZCB0byBhY2Nlc3MgdGhlIHJlZ2lzdGVycw0KPiA+ID4gPiBpbiB0aGUg
cGVyaXBoZXJhbCBpcyB0dXJuZWQgb24gdXNpbmcgYSBjbG9jayBkb21haW4uDQo+ID4gPiA+DQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBoaWwgRWR3b3J0aHkgPHBoaWwuZWR3b3J0aHlAcmVuZXNh
cy5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEdhcmV0aCBXaWxsaWFtcyA8Z2FyZXRoLndp
bGxpYW1zLmp4QHJlbmVzYXMuY29tPg0KPiA+ID4NCj4gPiA+IFRoYW5rcyBmb3IgeW91ciBwYXRj
aCENCj4gPiA+DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1kdy5jDQo+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvc3BpL3NwaS1kdy5jDQo+ID4gPiA+IEBAIC0xMCw2ICsxMCw3IEBADQo+ID4g
PiA+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgv
aGlnaG1lbS5oPg0KPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4gPiA+ICsj
aW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3Ns
YWIuaD4NCj4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9zcGkvc3BpLmg+DQo+ID4gPiA+DQo+ID4g
PiA+IEBAIC00OTcsNiArNDk4LDkgQEAgaW50IGR3X3NwaV9hZGRfaG9zdChzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdA0KPiA+ID4gZHdfc3BpICpkd3MpDQo+ID4gPiA+ICAgICAgICAgaWYgKGR3
cy0+c2V0X2NzKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgbWFzdGVyLT5zZXRfY3MgPSBkd3Mt
PnNldF9jczsNCj4gPiA+ID4NCj4gPiA+ID4gKyAgICAgICBwbV9ydW50aW1lX2VuYWJsZShkZXYp
Ow0KPiA+ID4gPiArICAgICAgIHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsNCj4gPiA+DQo+ID4g
PiBUaGUgc2Vjb25kIGxpbmUga2VlcHMgdGhlIGRldmljZSBwb3dlcmVkIGFsbCB0aGUgdGltZS4N
Cj4gPiA+IFdoYXQgYWJvdXQgc2V0dGluZyBzcGlfY29udHJvbGxlci5hdXRvX3J1bnRpbWVfcG0g
PSB0cnVlLCBzbyB0aGUgU1BJDQo+ID4gPiBjb2RlIGNhbiBtYW5hZ2UgaXRzIFJ1bnRpbWUgUE0g
c3RhdHVzPw0KPiA+DQo+ID4gVGhhdCBtYWtlcyBzZW5zZSBhbmQgd29ya3Mgb24gdGFyZ2V0LCBJ
IHdpbGwgY2hhbmdlIHRoaXMgZm9yIFYyLg0KPiANCj4gPiA+IEkgYXNzdW1lIHRoaXMgd2lsbCBi
ZSBjYWxsZWQgZnJvbSBkcml2ZXJzL3NwaS9zcGktZHctbW1pby5jLCB3aGljaA0KPiA+ID4gYWxy
ZWFkeSBlbmFibGVzIHRoZSBjbG9jayBleHBsaWNpdGx5IGFsbCB0aGUgdGltZXI/DQo+ID4gWWVz
LCBzcGktZHctbW1pby5jIGFscmVhZHkgZW5hYmxlcyB0aGUgYnVzIGNsb2NrLCBob3dldmVyIHdl
IHdhbnQgdG8NCj4gPiB1c2UgY2xvY2sNCj4gPg0KPiA+IGRvbWFpbiB0byBlbmFibGUgdGhlIGNs
b2NrIGFuZCBub3QgZXhwbGljaXRseSBwcm92aWRlIHBjbGsgaW4gdGhlIGR0cy4NCj4gPiBJZiB0
aGVyZSBhcmUgbm8gb3RoZXIgdXNlcyBvZiB0aGF0IHBjbGssIHdlIGNhbiByZW1vdmUgdGhhdCBs
YXRlciBvbi4NCj4gDQo+IElDLCB0aGF0J3MgdXNlZnVsIHNpZGViYW5kIGluZm9ybWF0aW9uLg0K
PiANCj4gInBjbGsiIGlzIGluZGVlZCBhbiBvcHRpb25hbCBjbG9jay4NCj4gInNzaV9jbGsiIG11
c3QgYmUgZmlyc3QuDQo+IA0KPiBIb3dldmVyLCB0byBtYWtlIHVzZSBvZiB0aGUgY2xvY2sgZG9t
YWluIGNvZGUsIHlvdSBzdGlsbCBoYXZlIHRvIGxpc3QgInBjbGsiDQo+IGluIERULCBidXQgdXNl
IGEgZGlmZmVyZW50IG5hbWUsIHRvIGF2b2lkIHNwaS1kdy1tbWlvLmMgZW5hYmxpbmcgaXQgYWxs
IHRoZQ0KPiB0aW1lPyBPciBkbyB5b3UgcGxhbiB0byBtb2RpZnkgc3BpLWR3LW1taW8uYyBmb3Ig
dGhhdD8NCj4gSW4gdGhlIGZvcm1lciBjYXNlLCB5b3Ugc2hvdWxkIGRvY3VtZW50IHRoYXQgaW4g
eW91ciBiaW5kaW5ncywgd2hpY2gNCj4gY3VycmVudGx5IGJ1aWxkIG9uIHRvcCBvZiBzbnBzLGR3
LWFwYi1zc2kudHh0LCB0aHVzIGluY2x1ZGUgInBjbGsiLg0KV2UgYXJlIGludGVuZGluZyB0byBk
byB0aGUgZm9ybWVyLCBzbyBJIHdpbGwgaW5jbHVkZSBhIGJpbmRpbmcgdXBkYXRlIGluIFYyIHRo
YXQNCm5vdGVzIHRvIHJlbmFtZSAicGNsayIgaW4gdGhlIGNhc2UgYSBjbG9jayBkb21haW4gaXMg
aW4gdXNlLiBUaGFua3MgZm9yIHBvaW50aW5nDQp0aGlzIG91dC4NCg0KPiBHcntvZXRqZSxlZXRp
bmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBH
ZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0t
IGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9u
cyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3
aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9y
IHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
LS0gTGludXMgVG9ydmFsZHMNCg0KS2luZCBSZWdhcmRzLA0KDQpHYXJldGgNCg==
