Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A65111BE3
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 23:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfLCWiQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 17:38:16 -0500
Received: from mail-eopbgr1410122.outbound.protection.outlook.com ([40.107.141.122]:32931
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727937AbfLCWiO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Dec 2019 17:38:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ep9ePc40QajS0LBGyvXPapUvVT9OGXq62W683fgUIwLuQTdbZw5i7GCCjnWzKKDLOIKGeUAkFYtfaX9LgVKlGhUi10h4Cox76YSEAHeG7q8KGp+I31B6/m/09gKGFs02Gpe3MUG+mI16TPPI0juzmwwZtcJrt2+Z4XkQdoNZfnkIVKadeFSqJgPYskihtscMhpCJf0ylNNWvDpul5LJuPztBTPdGErnqKlfQsSAbPKTkQbrgjO01F2iV4Uxc04ZwVLEKq7bkmPXp24I9yxYskT8VMIU1oL193vla0nw5bO/naDBLBUQguA0kQ65P2MlItnQujOZmfQRnhbgCyPlniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uFViwoJ0iWEkZq14k1C1T2+4t84+ogbubxZdDMJQ2Y=;
 b=BlsMZgIdbqJ91Y299u2HhsmNqx/TGoQFp6JPun4pgXMejNecFkyeXLGZnJjmucPyNGRVP9WN3I6pp3Bq3wraK28WTIiricjbJO8wFvw1CgYo1newTIscmTAOKLzvcvAgnI/6C0KcQ03UyCppXFwGDvtG114NRNqhbf+VvQWZXQWYuYVb8b+psBDBOwJewlvrGvTALG+FoFJaJvl1Kb4ucoEtCy1arYrNkOHek3yVTXQwmaVWYOTJ65gYy0QskycQJ9qQCsH4XO0GDeis1p3W+Et53vQf2DyeTTYdtNsOHlm8HQKxnp/dwMXE07cfpdL9/7kfmkF+UHS8ojdGIozsVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uFViwoJ0iWEkZq14k1C1T2+4t84+ogbubxZdDMJQ2Y=;
 b=c388fkeIjvj/cgb1+AyMZZOABF9otGIVUvuWOm5wqbX9q1UzmMGVPXXEGO+IuW04uspHT9wwX/+3GvZGKXdByUr5jmRXTcW1y5nuK+LlbZ9G3Smj4igkHtOsFhCX0TMp/lFZe5mFZW6u+HvDonJqb3FXPGLGO2YEUYvUbhD2RYw=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1577.jpnprd01.prod.outlook.com (52.133.162.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Tue, 3 Dec 2019 22:38:10 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 22:38:10 +0000
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
Subject: RE: [PATCH 5/6] ARM: dts: r7s9210: Add SPIBSC Device support
Thread-Topic: [PATCH 5/6] ARM: dts: r7s9210: Add SPIBSC Device support
Thread-Index: AQHVqYxLr50BLDCpM0CJ5tZyQuGVdqeoxIYAgAA7w5A=
Date:   Tue, 3 Dec 2019 22:38:10 +0000
Message-ID: <TY1PR01MB1562E550DD31E799446F0FD48A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-6-chris.brandt@renesas.com>
 <CAMuHMdXS_dSEGdMzHFuYraP=dU5WQFM+9DbPW1rFYH2reG2QhA@mail.gmail.com>
In-Reply-To: <CAMuHMdXS_dSEGdMzHFuYraP=dU5WQFM+9DbPW1rFYH2reG2QhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOTNkNmM1OWYtMTYxZC0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDkzZDZjNWExLTE2MWQtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iNzkzIiB0PSIxMzIxOTg4NjI4ODg3ODk0MDYiIGg9Ii83d2RtbmZzMjFpUUExc1ptUHRoQnowUzZsZz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db91b09a-f6b4-4b2b-3398-08d7784179cb
x-ms-traffictypediagnostic: TY1PR01MB1577:
x-microsoft-antispam-prvs: <TY1PR01MB15777593168FF3D677B5B36C8A420@TY1PR01MB1577.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(199004)(189003)(4744005)(4326008)(74316002)(186003)(229853002)(11346002)(14454004)(33656002)(446003)(6246003)(6916009)(25786009)(305945005)(8936002)(7736002)(55016002)(86362001)(9686003)(6436002)(478600001)(5660300002)(52536014)(7416002)(76176011)(7696005)(3846002)(66446008)(66476007)(66946007)(71190400001)(81156014)(81166006)(71200400001)(64756008)(6506007)(316002)(8676002)(66556008)(54906003)(6116002)(76116006)(256004)(102836004)(2906002)(99286004)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1577;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IbSYnJo3B8GnKLGLo+gfbBI1VaxDGULSNPDN8ffBR3EvnoCfvJwGKXtro+HoB+kdn9xZMKtzuIOxZJB9kZdJAk0Jf2Rk9AQ8SDgA6NS38269SA4ZxkEIbXScjNP46T7m7a2iUGab3Tf722S16D6mtKnRSmMzxBYYHkA+++7CMxkGSnET1w4yj7WYqziE6sMLbthvm58TSparVm+gO3LHFTdXerBt3QsXOTwhhx2+Gv+mACgiZMqzjx/q1qGgd3PLZKYo6ei4BcZVyxaU6K62M+clVTz5gAfpXCfPs2zGmuXrk515OJ/Gi2fAprZJmGadNBfrnr2pHV/nIh2MhMfgBehiH4BrcDEBLxVuono/5Y28xdXPS92nTkRBdYRkguygQ5gKpdXce78U8Xv2OxJem45vOrG9N3L0vlWDAHeCKcZtmwpRN0TYnwHutZpKkcyh
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db91b09a-f6b4-4b2b-3398-08d7784179cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 22:38:10.5803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qMoYX0Y0G5tkQZtGfxb4NOP27a/tDoU2FMFJJXKIWqcUSqJaLrpQgowT1VZbZ85lJXYD4qf40Eyfb78cMcHaDcmnnpj7PQ6u/OJEcG46mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1577
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIFR1ZSwgRGVjIDMsIDIwMTksIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90
ZToNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgxZjgwMDAwMCAweDhjPiwg
PDB4MjAwMDAwMDANCj4gPiArIDB4MTAwMDAwMDAgPjsNCj4gDQo+IEFueSBzcGVjaWZpYyByZWFz
b24geW91J3JlIHVzaW5nIDB4OGMsIG5vdCAweDEwMD8NCg0KQmVjYXVzZS4uLi5JIGtlZXAgZm9y
Z2V0dGluZyB3aGF0IGlzIHRoZSBsYXRlc3QgJ2NvcnJlY3QnIHNpemU6DQogIEEuIFRoZSBleGFj
dCBzaXplIG9mIHRoZSByZWdpc3RlciByYW5nZQ0Kb3INCiAgQi4gVGhlIHNpemUgcm91bmRlZCB1
cCB0byBsb29rIG5pY2VyDQoNCg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9
IDwmY3BnIENQR19NT0QgODM+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHBvd2VyLWRv
bWFpbnMgPSA8JmNwZz47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2Vs
bHMgPSA8MT47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47
DQo+IA0KPiBpbnRlcnJ1cHRzPw0KDQpJIGd1ZXNzIEkgY2FuIHB1dCBpdCBpbiB0aGVyZSBqdXN0
IHRvIGNvcnJlY3RseSAnZG9jdW1lbnQgdGhlIGhhcmR3YXJlJw0KaW4gdGhlIERldmljZSBUcmVl
IGZpbGUuDQoNCkNocmlzDQoNCg==
