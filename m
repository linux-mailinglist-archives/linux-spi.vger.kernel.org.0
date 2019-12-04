Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807281129C5
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 12:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfLDLAE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 06:00:04 -0500
Received: from mail-eopbgr1410111.outbound.protection.outlook.com ([40.107.141.111]:41363
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfLDLAD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Dec 2019 06:00:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq2jeSAPgEqUZHwVBeCmfpucXlPL4Ro3AAl9z1eHCD+VLsBWk4e+X5aYAmERciTUNc/qzdL69AAfjOy77jJKnvHnITP6J77ncIOe1nQAGWn7M5yH5WXxKcuUt5SZNLkPX8D/vu6s7pmoITaZocskvJl6oODClu60ViCdZdpvpdg6d9PW2V09bZQu766MEVpdeKR/b2gc7pwggOwc93GKVxB2OnXUNSeudee8hjSluJD6qiZL6IYLg1GxWQofoh6pmV4CKHn8bI3YjSl1r+BmbmJOKos5sKcXPOAkbTWKh8iLoBAS/hfKJcDkWJHT5cevVQRKdSEaAlOcDEqtfvVtBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8dFKkCmWEC4BLsVuqyf665SDE2UGmW2Km2WUdVItng=;
 b=gtcmE+arSK8/zeHGxEqQGQ8Wwjy/yOOE1GTkJQ3RCYnfd1/7558mQHyEdFRrne0WYEAxpg8pQzhSORT7rMgfG4EcrdieIj8coUBrB815sCJm+JRIIX5gXfFsVX0UqVb0FZZoysGvGNNbkTFU/S5aPYBHUkv7E1oHu4VCM7V0q8230PP3PhbdGniFkoILP9ig9MCmXJqRUYkiTSy62WckQOogJLa1Tocm2Fxzhh80H5pHbbMxVus6yOhBpNZfprRQuEHxv1YB4XOWBr0oFruBjx2yFRugxO6iHcyEtc8+mxDMr2s/GTz8wFFuNnjPk6LprdPxflA/nnTmTPg6rGGyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8dFKkCmWEC4BLsVuqyf665SDE2UGmW2Km2WUdVItng=;
 b=HKN5qRYWx5jZFqKhCjAyTGAyOz1NPgD23+vyCei35ohfto+djWXrydx1Jt1MJ5nR6ixwXxFEd6hSA191RUi+es+JrWaivqfYmodOgOGtPe9H1JJkkRxztE0I5Wfz9pz2oelXZPy+dkE2Pzt2L2AVBP68J35Fvbna8rOrH9568BQ=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1529.jpnprd01.prod.outlook.com (52.133.160.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25; Wed, 4 Dec 2019 11:00:00 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 11:00:00 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: RE: [PATCH 2/6] ARM: dts: r7s72100: Add SPIBSC clocks
Thread-Topic: [PATCH 2/6] ARM: dts: r7s72100: Add SPIBSC clocks
Thread-Index: AQHVqYw5ixK18pdXUUiJIFkvJ+Qioqeov9OAgAAB0RCAAAaVAIAA4QyAgAAG5gCAAAx5gIAAEVBQ
Date:   Wed, 4 Dec 2019 11:00:00 +0000
Message-ID: <TY1PR01MB1562A629EE48FE2C88518AAE8A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-3-chris.brandt@renesas.com>
 <CAMuHMdXUVdG_PMQEpz=QWLCaabfK8Mc41zFiymXJ4Rx_C2gzdg@mail.gmail.com>
 <TY1PR01MB1562F44E4FB80788922CE9BE8A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdX_sD+UHnOF+bdbT99zfK1V92+1kVzGnb9JXJyBd-Y5-w@mail.gmail.com>
 <20191204083821.GA3468@dell>
 <CAMuHMdXC+=2nH51ASu0u3WUchjM5bC_bROgcYM-OrsM7OgZpbg@mail.gmail.com>
 <20191204094741.GC3468@dell>
In-Reply-To: <20191204094741.GC3468@dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzViY2M1MzUtMTY4NS0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDM1YmNjNTM2LTE2ODUtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iNTUyIiB0PSIxMzIxOTkzMDc5ODY3NjU0OTIiIGg9IjVGc1hSU01CMEZENUM2QXUxQnRxaEV3Q2dmST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7355d31-8cac-4707-eafd-08d778a91b8f
x-ms-traffictypediagnostic: TY1PR01MB1529:
x-microsoft-antispam-prvs: <TY1PR01MB15297C568EAFB2629A76D8888A5D0@TY1PR01MB1529.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(99286004)(74316002)(54906003)(7736002)(110136005)(8676002)(76116006)(14444005)(86362001)(7696005)(76176011)(6506007)(33656002)(4744005)(71200400001)(64756008)(66446008)(305945005)(11346002)(66556008)(66476007)(5660300002)(26005)(102836004)(186003)(66946007)(52536014)(229853002)(2906002)(9686003)(6246003)(14454004)(6116002)(8936002)(478600001)(316002)(81156014)(55016002)(7416002)(71190400001)(4326008)(3846002)(6436002)(81166006)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1529;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s2djmGL4Rc0RXvAIub/8GreaH6CpOSdM5JpGbn7s+0MyhbjFSH8ijp/0DiGitOTcMzRFedtvCeNlb8t6r456oDaoRdNkJSCdwZEUmsHcYk4EfLjheaUurVEPSxEler4smiIHbR1U3cMU3ZJRjRsVpAozlsbWIN0YkLqc7u0SlPwIMFlSguIfIiC0U7s48w/51JekJfcz48SA/i2iSW5C/3FcU/7QhZ0MtKhaYNUw9U44acUX9P2P1vj9ljQZy1UNT8HI4EsyyHVZPox9mGTdTuikSJGkbL29zqxAw6TzcslMyeti70MAqAaFBN6bzObsgSiaJN757f0O4uw/VqsB4WZKjYsyco+TvUfDulrIb4xRck2VrPxjG/zrZ4dHrFiCsB51XpRCLSUMQWdt/76ZaO2oNPyIVEqHPSSJHt+ACY/1PMGBdiLKCgM9mHZIO4GG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7355d31-8cac-4707-eafd-08d778a91b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 11:00:00.2297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6zr6ck8FGpsaDGkb8CEDcaFQlnm2qE8ZTPvEBxt4or/+rXfzhJ8MpKRhcy4V0rDtJuMt2OgIit3eCA4bW7Flxoz+5zPx0PjGgd1sN1WDkeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1529
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgTGVlLA0KICBUaGFuayB5b3UuDQoNCkhpIEdlZXJ0LA0KDQpPbiBXZWQsIERlYyA0LCAyMDE5
LCBMZWUgSm9uZXMgd3JvdGU6DQo+IFRoZSB2ZW5kb3IgZHJpdmVyIGNhbiBjYWxsIG9mX2Nsa19k
ZXRlY3RfY3JpdGljYWwoKSB3aXRoICphbnkqIGluZGV4IGl0IHNlZXMNCj4gZml0LiAgSWYgaXQg
bWF0Y2hlcyBhIG51bWJlciBsaXN0ZWQgaW4gdGhlICdjbG9jay1jcml0aWNhbCcNCj4gYXJyYXks
IHRoZSBDTEtfSVNfQ1JJVElDQUwgZmxhZyBpcyBzZXQgaW4gdGhlIGZsYWdzIHBvaW50ZWQgdG8g
YnkgdGhlIDNyZA0KPiBmdW5jdGlvbiBwYXJhbWV0ZXIuDQoNClNpbmNlIHRoaXMgaXMgdGhlIGNh
c2UsIEknbGwgY2hhbmdlIHRoZSBkcml2ZXIgY29kZSBzbyB3ZSBjYW4gdXNlIGl0IGhvdyB3ZQ0K
cHJlZmVyOg0KaWUsDQogICBjbG9jay1jcml0aWNhbCA9IDxSN1M3MjEwMF9DTEtfU1BJQlNDMD47
DQoNCkNocmlzDQoNCg==
