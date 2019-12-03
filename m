Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB8E91104BC
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 20:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfLCTJK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 14:09:10 -0500
Received: from mail-eopbgr1400103.outbound.protection.outlook.com ([40.107.140.103]:58272
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726075AbfLCTJK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Dec 2019 14:09:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpBpUi6LLWQua3rbstDO+gEZDTlwjpMk6vlKzLD00rsO77IGlsr4MH9c9TYxTdoOV7mSqRTF/Yo5JeAv+2WLJym00x4BFDykXNKIT12ClV2MqWUIg2Si4cqPPP3kS9pziDUah/JyGKr7PT3RpeNhm6fukpBolkWmt1drKzVaShKr7/ycC7t1JAcXNRTDBBZv57P/LFbvU1SgQ2aqCAArWRixIEph/k75+mMx3liW8v2giuiZGnsro7uZa5s7f3LDm2ogFjm6Ssw/5mAPdnzrdCKn/gR5BLwUmK3WdaqkQkTSnTSfpcRMytfyGcI3LPzViMxcOQE16pNKnhJNg7iPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv+my3jhUa07ztB6yLJ/oQS9CdEPLs8CagZmg5YEyjQ=;
 b=FeloEYF6cvdpsXo9F20G34IRLFKo+iMyoVhmcCvDOs1nYjO6OKNveNNYWRS1v+aCM98TwKvdWHr7/lnq0EwBIkrsiRLbE4FKI6uamydpIDpyKJoK4IS5HXsQohIzHg+LQEuc3elwRJ3t7Rk1LqEDQJpKaxV1rlTeO3haQUUmFyeS9adVZ+g1G3Swc2Vbfqi20eVTFLq/RqThsebUE4N4iOBjagVmvDuchKcgEi/6tm4ZfEDjZVsFxKqQxQQ1RN0K3G7GzXkBYXY+eFvjPw++9X9QNFzTq9IuE5cyBZB5ZICc7gGAzsSNx2Vpko1RDjdKdoKgm/Fd2MpLRRr1EVd17g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv+my3jhUa07ztB6yLJ/oQS9CdEPLs8CagZmg5YEyjQ=;
 b=FjF24jMTLL9K7HReuCFn1IarOWIwe/W9hVmfplDtDjJKr7RtI9z1/n93r7ShpZyrm7aLb7JxvB3NKtbe1vIcjE/Pq1s0AeU8aS2KDacGbY8A3abjrvNhHJ/OThVQcrEf6nftsXfgsrZe+akKpMa1O4R/A/syl29pD9naxn3EE2s=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1644.jpnprd01.prod.outlook.com (52.133.162.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 19:09:05 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 19:09:05 +0000
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
Subject: RE: [PATCH 3/6] clk: renesas: r7s9210: Add SPIBSC clock
Thread-Topic: [PATCH 3/6] clk: renesas: r7s9210: Add SPIBSC clock
Thread-Index: AQHVqYw+LjFTYBzcx0ONO00s2jlMoaeowc4AgAACl6A=
Date:   Tue, 3 Dec 2019 19:09:05 +0000
Message-ID: <TY1PR01MB1562D198A463C18B1D810DF48A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-4-chris.brandt@renesas.com>
 <CAMuHMdUxCdJXyY15f6sr+QFNpg9FLsa5pL3171bm_meJcBNR2g@mail.gmail.com>
In-Reply-To: <CAMuHMdUxCdJXyY15f6sr+QFNpg9FLsa5pL3171bm_meJcBNR2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNWU3YzQ5ZjYtMTYwMC0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDVlN2M0OWY3LTE2MDAtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTAyMiIgdD0iMTMyMTk4NzM3NDQwMDE5MTYyIiBoPSJLVUZHbXVaSEdWc2ZCUUFmVitXUVErOWNud3c9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52a5ae9d-3ae1-4c17-3519-08d778244469
x-ms-traffictypediagnostic: TY1PR01MB1644:
x-microsoft-antispam-prvs: <TY1PR01MB164493A3FD3906244C71FBB58A420@TY1PR01MB1644.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(14454004)(7416002)(186003)(4326008)(7696005)(86362001)(4744005)(7736002)(76176011)(6506007)(229853002)(26005)(11346002)(446003)(102836004)(8936002)(305945005)(14444005)(81166006)(6436002)(81156014)(99286004)(478600001)(2906002)(6916009)(71190400001)(9686003)(256004)(25786009)(71200400001)(8676002)(55016002)(74316002)(6246003)(5660300002)(66946007)(66446008)(66556008)(66476007)(316002)(76116006)(64756008)(6116002)(33656002)(52536014)(3846002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1644;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P1FN/4J5MYRf0h2fX/CGxk0nn9BAaXunRK0IwnxnAgNX26FrTmHX7BlHagyyeauQvoFShC6keYV6uWGCmcFNkSXRl9gslur0nNxe4H8uidd07ib7qCJ1E4eQuz5Msa+BacTtTqSuebZ5gJtvKTT5mu4KO1heboFr2c87ajmtC7WsNdESuysVvPkxr1BxU0FFRhgS26TsPP5FHtSMZICL2yTfvgCw8TAExQVothpB7d1oesxkGR93djqeoNI9ifsSHskjdFYbDDfdvReN0zT0PmP4JN0CGFDaI//4xnRJNS+TziBkhaYtTqcdcD61OSbUTAT4sY2cboH7TkCFdzuYrqFIZ2pObdktHoYWP2cTlnCCKB+BvLZJSixrZHjx+Gq0dCiqXSSPKzKk6Te21EffeT2IoHNP12ymgM41kxboEYVwFRVK+qokwuSUB4+92hFO
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a5ae9d-3ae1-4c17-3519-08d778244469
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 19:09:05.6216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CIdr1HoMDBmv6xyxDVlOoYoTl8J28jPb0fnEdUKfXNDcQj0wiv4LPvBWtaVJXtdnrla9znLVeOtuxhv1CeoP55kCrnPC6XtAFYrgapoqG6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1644
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIFR1ZSwgRGVjIDMsIDIwMTksIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90
ZToNCj4gPiArc3RhdGljIGNvbnN0IHVuc2lnbmVkIGludCByN3M5MjEwX2NyaXRfbW9kX2Nsa3Nb
XSBfX2luaXRjb25zdCA9IHsNCj4gPiArICAgICAgIE1PRF9DTEtfSURfMTAoODMpLCAgICAgIC8q
IFNQSUJTQyAqLw0KPiANCj4gVGhpcyBpcyBvbmx5IGEgY3JpdGljYWwgY2xvY2sgaWYgWElQIGlz
IGluIHVzZSwgcmlnaHQ/DQoNCkNvcnJlY3QuDQoNCg0KPiBDYW4gd2UgZG8gYmV0dGVyLCBhbmQg
b25seSBtYXJrIGl0IGNyaXRpY2FsIGlmIHdlIGRldGVjdCB0aGUgRkxBU0ggaXMgdXNlZCBpbg0K
PiBYSVAgbW9kZT8NCj4gRS5nLiBieSB1c2luZyBmb3JfZWFjaF9jb21wYXRpYmxlX25vZGUoLi4u
LCAibXRkLXJvbSIpLCBhbmQgY2hlY2tpbmcgaWYgYW55DQo+IG9mIHRoZSBjb3JyZXNwb25kaW5n
IHJlZ2lzdGVyIGJsb2NrcyBtYXRjaGVzIHRoZSBTUElCU0MgRkxBU0ggbWVtb3J5IHdpbmRvdz8N
Cg0KV2VsbC4uLnRlY2huaWNhbGx5Li4ueW91IGRvbid0IG5lZWQgdGhlICJtdGQtcm9tIiBwYXJ0
aXRpb24gd2hlbiB1c2luZyB0aGUgQVhGUw0KZmlsZSBzeXN0ZW0uIEJ1dCwgd2UgY2FuIG1ha2Ug
YSBydWxlIHRoYXQgeW91IGhhdmUgdG8gdXNlIGl0IHJlZ2FyZGxlc3MuDQoNCkluc3RlYWQsIEkg
dGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIGlmIHdlIGNvdWxkIGZsYWcgdGhlIGNsb2NrIGFzIGNy
aXRpY2FsIA0KaW4gYSBib2FyZC1zcGVjaWZpYyAuZHRzIGxpa2Ugd2UncmUgZ29pbmcgdG8gZG8g
d2l0aCB0aGUgUlovQTEgTVNUUCBkcml2ZXIuDQoNCkNhbiB3ZSBhZGQgc29tZXRoaW5nIGxpa2Ug
ICJjbG9jay1jcml0aWNhbCA9IDw4Mz47IiB0byB0aGUgY3BnLW1zc3IgZHJpdmVyPw0KDQpXaGF0
IGRvIHlvdSB0aGluaz8NCg0KQ2hyaXMNCg==
