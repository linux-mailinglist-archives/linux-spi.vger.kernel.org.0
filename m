Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2336C29D733
	for <lists+linux-spi@lfdr.de>; Wed, 28 Oct 2020 23:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbgJ1WWK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Oct 2020 18:22:10 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:8496 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732614AbgJ1WWI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Oct 2020 18:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1603923726; x=1635459726;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z5jyUEF0NU9/b8JaUKYYGGwUYIZbyQtjAEl+wgIST8k=;
  b=n4Zk89pf/TAmCMFNIWW+fO0PCe3XeGq3U+11tgHqnQoXscLF/KvRC8+s
   Qs2Db0zqwAS6xvEyfeWPxe892tSu5oyLPYDPabTAysqnni99BbCjbTV/8
   /HnAa5dMK97M9Zdh/fWCiNOmNQGWJ6OyJXEUiolzOYcsZvKNc5jaRqx2a
   +Z+ROK4ubq8y/b2xA/VYMEt3HVRfdghjrz3ijQ9yrnrBhOLP1f7B5gWUL
   Hq14r4LgvueSdwVMqAHM4AAZfIoTPAD42KrnKI2ca8ayqZQgiPl+AzhuF
   lIxgHEwCHx5nPj0MUWjfpfPxBr9J010YdiYGeBRClE0JplWdoWOhMhiVA
   Q==;
IronPort-SDR: hdThovlQTOusEQY0IrFEi4jOMStY/DzwddaPKLbT7t9VPtc5mKKG+wTib7Rhb2ODFiI+s8Eipt
 z3MR5PhmgJ4jPD3iOQKsO96GNa8jK+mDSRL2ZZu63sraAvdq675fKiCL+BkkG+YYuM4cyBpu0L
 dFs3Rxf5gOTsbuJGLrVntfgmttNPbcRfNsyCO3crjl/5uylPZr9bjOaVZuXCWk8fvAbrVnC4kR
 QwdveHTvBkDifxe4g5gwQC+sznTAJiwQxUmUSHgYTIfWG0RRf5KDVOUMq9nDkvluj28LFob+68
 ObI=
X-IronPort-AV: E=Sophos;i="5.77,426,1596524400"; 
   d="scan'208";a="101244737"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Oct 2020 03:18:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 28 Oct 2020 03:18:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 28 Oct 2020 03:18:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsCCAG3qiypm8BXZFWHmJTroqgkzrX1jo90K/wfiIyfupaT17RvmTNTOFha4Vu+EhTSK7T9CjrDfpSffTnYkz7fDRjU/rH2fusfzbQLL6Jyz8skSQgAm9RHJt8pwB4liR/Ft6SJql5In5y/BU+3FFyF/Ok6D9RLzKJevyzCYIa5vwn9bRsfzsX8H+ivSb4ruqvXbGjZQ6A1Euk+VkM/Larbyz03ZYRGvP/pNQIFHmLdmFc3iNRd6k48cj2q9+eomxBySSEkkWSivkpggC2bYHnYasY9xaejPov4unZltw6YyvtS0Xw0rWURsKHlITM8Jxb+UWGQv8SJfM6zNGLWITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5jyUEF0NU9/b8JaUKYYGGwUYIZbyQtjAEl+wgIST8k=;
 b=fuFod6siNb6ysdDbyWmoP8YZt7VwrVl8ric9FNSgW6rte86Qa7SYkw515wl01G3eZ3iJwiy03RwbrdtV7gnDp9GWBEeWVrSVsY+m2xaHzIuG4ZLDQda0/xLf36NAC38HjB0LzVvWvmtcGeEv9JuWPCchllHEV5r9UrJ5ym1nrQOqJf2mMGDWNChkFpHHMU+0MuL+e/u52qv9Lt5ksVZVu973JOMallmBUE3PMQyxRxXuCYH0L9IDf/Fm+xRdZXmwffY4s2kazAMcatn6na9yqyC6Uo30l4VVMu/QfFsmIjVIJulm6KiLoZ+cIwv3KL9CM9kBbUQhhfSyuSx+mtv4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5jyUEF0NU9/b8JaUKYYGGwUYIZbyQtjAEl+wgIST8k=;
 b=X9d0z1mIUFx9m7UT2+RpHq14Q3myKxMfS7hPcZYIBUgfkI+PE6IWUHFL0Ee5Du7S/Va7fWBtf4LR9e2PQqZ0/+ZNp8MtlCR6MIxpvsQVC0RI0o4PX2lGuZmyPLJmnPVone0FP5z01K2UGPe45/SG8ACNsi0YfgiJKUSyP0Tzr2E=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR1101MB2302.namprd11.prod.outlook.com (2603:10b6:301:5a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Wed, 28 Oct
 2020 10:18:30 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::413f:1b5f:5cec:3bb4]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::413f:1b5f:5cec:3bb4%7]) with mapi id 15.20.3499.018; Wed, 28 Oct 2020
 10:18:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <masonccyang@mxic.com.tw>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>, <matthias.bgg@gmail.com>
CC:     <juliensu@mxic.com.tw>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <p.yadav@ti.com>, <ycllin@mxic.com.tw>
Subject: Re: [PATCH v4 4/7] mtd: spi-nor: core: add configuration register 2
 read & write support
Thread-Topic: [PATCH v4 4/7] mtd: spi-nor: core: add configuration register 2
 read & write support
Thread-Index: AQHWrROufKem0XTf5EyIwQkm7wZSGQ==
Date:   Wed, 28 Oct 2020 10:18:30 +0000
Message-ID: <a6f65077-f435-4c8e-994e-38e2f5d437b1@microchip.com>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
 <1590737775-4798-5-git-send-email-masonccyang@mxic.com.tw>
In-Reply-To: <1590737775-4798-5-git-send-email-masonccyang@mxic.com.tw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: mxic.com.tw; dkim=none (message not signed)
 header.d=none;mxic.com.tw; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.127.107.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b0baf3b-2eeb-4ebf-8b34-08d87b2ad165
x-ms-traffictypediagnostic: MWHPR1101MB2302:
x-microsoft-antispam-prvs: <MWHPR1101MB2302B5C766407029B4D1B107F0170@MWHPR1101MB2302.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kaN1uAtbtzXccxxSBl+RuWT7PpMMHnYf3y8w2fO4xbnvYmSKAx+5nUhYV+oUNWhdJgqCQpCEXsBRMULQzjX3ez1Xz0mIQn0IewtagR0LPJTSpQaJeUgM6OC66oI8qKRV9ST3RZVK80evbTGS2x++kBRZJG4NoILkymaFsYx2nCdntCynoBX/BeplCz1QQKf2l+pZ8SVTgr8dFfK/kjiBgixp3+XywsoLJzi5Ojh26EXv/h1z/phNDBBE1QEqkXshLWkMGUwwhSkJD6+CddQy+NrmNfr5VF7bp9NxoRx5HUU6hsYlwTho9e9f2VMibA+4AKtxHOFomiJhDY/kR85NtIvjmcMXgoMq/DgAzME6jIzCx5OhEqZGVp+3ZUtKdmk9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(366004)(396003)(2616005)(66446008)(478600001)(6512007)(7416002)(76116006)(86362001)(54906003)(316002)(2906002)(66556008)(91956017)(36756003)(8936002)(110136005)(31696002)(6486002)(5660300002)(66946007)(66476007)(186003)(31686004)(26005)(64756008)(53546011)(6506007)(71200400001)(8676002)(4326008)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: q1FmSPUWENbq8gCyrdt1wWHjKYeC7YOl8Qv8vVJMqaCVUQTatx4NDd4kPjaygmyonk2V9VxWNygECvkvWaUQYzfynfsckGSsxphUiFZ9Ru5bGTkdZqdRv91+VXNr2UWq4HH7Rb+VlsXcFqe21llhDRUs+uEjgHLe4B+UPbNe0PzGZq8NqXCSymLY9pg22GFarXDriHZdN+h0VSathPbX/pmS5Bj3V0beJ6vWxEUG7VW/gASk3H59Lf4sI70eVvRgamiy9tmhLmgRWznLieOuSCXuaCP3RTRAN63u0wrs4KpOJnEUup7xXNcPr0/6+iJtU1FPp96P+JLaffioGOBSOrJ/34e4cFHUupu5MY7iNKqyoyHU5ZR1i9UPKDV3MzivXhmwhUq5sTzQINDQkKoXl1C+C4QnSJSuMJTs9m+hkd/GtX0alU03AmIC1OEwXKMJlTby6o1gQ1SVUdZAcXKd0cGE+0OqKnoNtEyLkEKttqnLYU+vaSVEpYDcoGLVjIOtMIF/TCNJeRsoOpj3LckkThhcc2eGXzSRnl38qcDGZV14kO8Yod/U4aOPbYQKtFiFeiNaxSHjXc3Ig11Z4UYILVy3zuR393HKaIG4gDnDIkCMNZg99/x2XUVTf7fzDIH4mJsFCgZEs2TMnDReTqFWmg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9FC21D946428248828746ACEE54FAD8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0baf3b-2eeb-4ebf-8b34-08d87b2ad165
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 10:18:30.3546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNalHdPT6wapfaBN38hvElQQDCkTgBUtK2XgXb8KkOp34rC42OLGohNzjmB8rhuXpsArnoBaUKYgYSZfQXSiSNc28XVi5E1jWf9k/xMDlF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2302
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGksIE1hc29uLCBZQyBMaW4sDQoNCk9uIDUvMjkvMjAgMTA6MzYgQU0sIE1hc29uIFlhbmcgd3Jv
dGU6DQo+IENvbmZpZ3VyYXRpb24gcmVnaXN0ZXIgMiBpcyB0byBzZXQgdGhlIGRldmljZSBvcGVy
YXRpb24gY29uZGl0aW9uIGxpa2UNCj4gU1RSIG9yIERUUiBtb2RlIGF0IGFkZHJlc3Mgb2Zmc2V0
IDAgYW5kIERRUyBtb2RlIGF0IGFkZHJlc3Mgb2Zmc2V0IDB4MjAwLg0KPiANCj4gRWFjaCBkZXZp
Y2UgaGFzIHZhcmlvdXMgYWRkcmVzcyBvZmZzZXQgZm9yIGl0J3Mgc3BlY2lmaWMgb3BlcmF0b2lu
DQo+IHNldHRpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXNvbiBZYW5nIDxtYXNvbmNjeWFu
Z0BteGljLmNvbS50dz4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyB8IDc4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZl
cnMvbXRkL3NwaS1ub3IvY29yZS5oIHwgIDIgKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgODAgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5j
IGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gaW5kZXggMzc5OTQxNy4uZmVkNjIzNiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gKysrIGIvZHJpdmVy
cy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gQEAgLTI2OSw2ICsyNjksODQgQEAgaW50IHNwaV9ub3Jf
d3JpdGVfZGlzYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiAgfQ0KPiAgDQo+ICAvKioNCj4g
KyAqIHNwaV9ub3JfcmVhZF9jcjIoKSAtIFJlYWQgdGhlIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIg
Mi4NCj4gKyAqIEBub3I6CXBvaW50ZXIgdG8gJ3N0cnVjdCBzcGlfbm9yJy4NCj4gKyAqIEBhZGRy
OglvZmZzZXQgYWRkcmVzcyB0byByZWFkLg0KPiArICogQGNyMjoJcG9pbnRlciB0byBhIERNQS1h
YmxlIGJ1ZmZlciB3aGVyZSB0aGUgdmFsdWUgb2YgdGhlDQo+ICsgKiAgICAgICAgICAgICAgQ29u
ZmlndXJhdGlvbiBSZWdpc3RlciAyICB3aWxsIGJlIHdyaXR0ZW4uDQo+ICsgKg0KPiArICogUmV0
dXJuOiAwIG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UuDQo+ICsgKi8NCj4gK2ludCBzcGlf
bm9yX3JlYWRfY3IyKHN0cnVjdCBzcGlfbm9yICpub3IsIHUzMiBhZGRyLCB1OCAqY3IyKQ0KDQpz
cGlfbm9yX3JlYWRfdm9sYXRpbGVfcmVnKCkgcGxlYXNlDQoNCmRvIHdlIG5lZWQgdG8gcGFzcyBs
ZW4gYXMgYW4gYXJndW1lbnQ/DQoNCnMvY3IyL2J1Zg0KDQp3aHkgZG8gd2UgbmVlZCBhZGRyIGZv
ciByZWdpc3RlciBpbnRlcmFjdGlvbnM/DQoNCj4gK3sNCj4gKwlpbnQgcmV0Ow0KPiArCXU4IGNt
ZCA9IG5vci0+cGFyYW1zLT5yZF9yZWdfY21kOw0KDQp5b3UnbGwgbmVlZCB0byByZWRlZmluZSB0
byByZF92cmVnX2NtZC4NCg0KPiArDQo+ICsJaWYgKG5vci0+c3BpbWVtKSB7DQo+ICsJCXN0cnVj
dCBzcGlfbWVtX29wIG9wID0NCj4gKwkJCVNQSV9NRU1fT1AoU1BJX01FTV9PUF9DTUQoY21kLCAx
KSwNCj4gKwkJCQkgICBTUElfTUVNX09QX0FERFIoNCwgYWRkciwgMSksDQoNCm5vci0+YWRkcl93
aWR0aD8NCg0KPiArCQkJCSAgIFNQSV9NRU1fT1BfRFVNTVkoNCwgMSksDQoNCm5vci0+cmVhZF9k
dW1teT8NCg0KPiArCQkJCSAgIFNQSV9NRU1fT1BfREFUQV9JTigxLCBjcjIsIDEpKTsNCg0KU1BJ
X01FTV9PUF9EQVRBX0lOKGxlbiwgY3IyLCAwKT8NCj4gKw0KPiArCQlzcGlfbm9yX3NwaW1lbV9z
ZXR1cF9vcChub3IsICZvcCwgbm9yLT5yZWdfcHJvdG8pOw0KPiArDQo+ICsJCXJldCA9IHNwaV9t
ZW1fZXhlY19vcChub3ItPnNwaW1lbSwgJm9wKTsNCj4gKwl9IGVsc2Ugew0KPiArCQlpZiAoc3Bp
X25vcl9wcm90b2NvbF9pc19kdHIobm9yLT5yZWdfcHJvdG8pKQ0KPiArCQkJcmV0ID0gLUVOT1RT
VVBQOw0KPiArCQllbHNlDQo+ICsJCQlyZXQgPSBub3ItPmNvbnRyb2xsZXJfb3BzLT5yZWFkX3Jl
Zyhub3IsIGNtZCwgY3IyLCAxKTsNCj4gKwl9DQo+ICsNCj4gKwlpZiAocmV0KQ0KPiArCQlkZXZf
ZGJnKG5vci0+ZGV2LCAiZXJyb3IgJWQgcmVhZGluZyBDUjJcbiIsIHJldCk7DQo+ICsNCj4gKwly
ZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICsvKioNCj4gKyAqIHNwaV9ub3Jfd3JpdGVfY3IyKCkg
LSBXcml0ZSB0aGUgQ29uZmlndXJhdGlvbiBSZWdpc3RlciAyLg0KPiArICogQG5vcjoJcG9pbnRl
ciB0byAnc3RydWN0IHNwaV9ub3InLg0KPiArICogQGFkZHI6CW9mZnNldCBhZGRyZXNzIHRvIHdy
aXRlLg0KPiArICogQGNyMjoJcG9pbnRlciB0byBhIERNQS1hYmxlIGJ1ZmZlciB3aGVyZSB0aGUg
dmFsdWUgb2YgdGhlDQo+ICsgKiAgICAgICAgICAgICAgQ29uZmlndXJhdGluIFJlZ2lzdGVyIDIg
d2lsbCBiZSByZWFkLg0KPiArICoNCj4gKyAqIFJldHVybjogMCBvbiBzdWNjZXNzLCAtZXJybm8g
b3RoZXJ3aXNlLg0KPiArICovDQo+ICtpbnQgc3BpX25vcl93cml0ZV9jcjIoc3RydWN0IHNwaV9u
b3IgKm5vciwgdTMyIGFkZHIsIHU4ICpjcjIpDQoNCnNwaV9ub3Jfd3JpdGVfdm9sYXRpbGVfcmVn
KCkgcGxlYXNlDQoNCkNoZWVycywNCnRhDQo=
