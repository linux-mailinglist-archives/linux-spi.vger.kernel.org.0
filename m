Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53A31129D7
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 12:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfLDLFC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 06:05:02 -0500
Received: from mail-eopbgr1410132.outbound.protection.outlook.com ([40.107.141.132]:24320
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfLDLFB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Dec 2019 06:05:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHShL1W+EwOftuAT2YLgApirgFlnzNKCs5/QPzXj84ia44kSNnkOGaBBGZguip1TZuBNYXGkJSQeSGsMmjU3FHxMfaKTL0x+pZLQoDFox5Ld5+97SUgOqbqGgI1mErsFoyamt2v/pS26I/zWGxAdp4du21MdpfHjRsyqb3QAxlULh5/SzKUgZ4oEaJitXSwJwc0zJRFMZTGIc3BQP6IG7DCHecXk/0ASf5ipsj9v9I53AkdO0LcI4OrkCVRF4+C5cCvMyq3W9G5GX3lYjbiz7KoWhUXgcargJgdepr8PdFTmnAPDBXQ4KWG4caTGH2vG3aYM7FD95dYd2gxtcix56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9ss5nB8wguFQ1B3p+HjPs+frnBfDFkYWY10f7IeGa4=;
 b=cly6fcSYPRB5srlp+eEEXh2Xb/UkifmcPcPjzrbMtYmvcNwwfCsyHWnLp/DwF9pPQhvyHgwwAHU+c+Li/GZ/T9UbByNJDxNQUAMJMSDJMDCDV/5pvG2UeaeYOtl2OeHWM4/vul8MJU4wZylGZ52ndbcq48/K3r8SB/JmNdXcMRPv+RAFQI1JSkuk/ZmdEhf77wV/B9j6HtuvhSxX2mihkmaIsVRngO+S9P6XL9eqx8YTgDXd+sdRM0O1tvxYIeXm0C4NIaaq9zvpDpnpgZhwykVwKfK1SflX9kdMoxuW8HlXv6dGbztberZtIlNxwclI61CNj6sa/KioMq3TpCis5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9ss5nB8wguFQ1B3p+HjPs+frnBfDFkYWY10f7IeGa4=;
 b=G6zHp3Y+XyDbD03IAzrf3NBVjqDG3U8neRd/bRBc3zu9lfgTgINPr5C16/sPImPZFR5xlxg0pGdT0APIrqpqrR7FVfsbCLBxSfAb5d2mpNeZwr7r1mcoOHSZhfeNpX+39/0BbWZwDZI3LVu3vppAqXOVX1pNSMtdkv1pleOstBM=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1529.jpnprd01.prod.outlook.com (52.133.160.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25; Wed, 4 Dec 2019 11:04:58 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 11:04:58 +0000
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
Thread-Index: AQHVqYxLr50BLDCpM0CJ5tZyQuGVdqeoxIYAgAA7w5CAAJ2TgIAANB8Q
Date:   Wed, 4 Dec 2019 11:04:58 +0000
Message-ID: <TY1PR01MB15628A9E2AF5C56940830B098A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-6-chris.brandt@renesas.com>
 <CAMuHMdXS_dSEGdMzHFuYraP=dU5WQFM+9DbPW1rFYH2reG2QhA@mail.gmail.com>
 <TY1PR01MB1562E550DD31E799446F0FD48A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdVO2ud70cxVUHpCpvvZiMidHG1091bg3iOoOnFGOqpqWQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVO2ud70cxVUHpCpvvZiMidHG1091bg3iOoOnFGOqpqWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZTc3OGI5YWQtMTY4NS0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XGU3NzhiOWFmLTE2ODUtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iNDk3IiB0PSIxMzIxOTkzMTA5Njg0MDA5MDUiIGg9IlhYN21rekY2Z1hGcXlzREZSRk5ESmo0Z214QT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e59e1a52-ecef-43d7-ecfc-08d778a9cd44
x-ms-traffictypediagnostic: TY1PR01MB1529:
x-microsoft-antispam-prvs: <TY1PR01MB15296F7A3E862E41301F52798A5D0@TY1PR01MB1529.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(2906002)(9686003)(229853002)(14454004)(6246003)(11346002)(305945005)(5660300002)(66476007)(66556008)(66446008)(71200400001)(64756008)(66946007)(52536014)(186003)(26005)(102836004)(4326008)(6436002)(3846002)(81166006)(25786009)(71190400001)(81156014)(55016002)(6116002)(8936002)(478600001)(7416002)(316002)(76116006)(74316002)(99286004)(54906003)(8676002)(7736002)(4744005)(6916009)(86362001)(33656002)(6506007)(76176011)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1529;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vtieUWsQkt2Mfkes8+WynT8Inj/6qg8ok0jkIsmOxnSqpE1bFAeUM8Rnd7RzfxqjLhUcAtf0TfohddiHF8ys7yV+PpRfVN8gqdfitK/DJn71mP3vA3tcV8S4UrCRnr8I4MOrCaOcwmWk45mDgyQq94MxTXguKkQ8IMTqGGww/l5jjwOocFFpzhVXx3z19zkJ6rKf8gNyCn1CzN5yhiAWdBqj5pdIYPpwokxEE6C8xrVIIBagXFnPBqCFFTQ8b0iXcPoiqhd/dlEO8woPkUBhqG8Hb2GW1OlxZMXo/e2BdCM/KHPmpLA+R0wQw4AZrKLICkwjVsegwP1+VxKzDaZso3mVXygXdyIgBC5kGYIsNiIRdc09bbVimHOoq48Gr1Ih/mBzs6kCd3J3m8zmEWxd4oUNvOwjxB3OhPIZxclabeErY3jDgNWK29+rmhp+ZdaW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59e1a52-ecef-43d7-ecfc-08d778a9cd44
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 11:04:58.2948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3kM0zElZ7NSb/Us29cclMLTBR1MZfJgyY41Ti4OA9Yhe3Cs7enhcgtf9SLVcNgK4okMLbSNqD/TCDwNz/I5vBtJ6dG2j8kDhd3VJ2j4w84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1529
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIFdlZCwgRGVjIDQsIDIwMTksIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90
ZToNCj4gPiBCZWNhdXNlLi4uLkkga2VlcCBmb3JnZXR0aW5nIHdoYXQgaXMgdGhlIGxhdGVzdCAn
Y29ycmVjdCcgc2l6ZToNCj4gPiAgIEEuIFRoZSBleGFjdCBzaXplIG9mIHRoZSByZWdpc3RlciBy
YW5nZSBvcg0KPiA+ICAgQi4gVGhlIHNpemUgcm91bmRlZCB1cCB0byBsb29rIG5pY2VyDQo+IA0K
PiBDLiBUaGUgc2l6ZSB1c2VkIGJ5IHRoZSBvbi1jaGlwIGFkZHJlc3MgZGVjb2RlciBwcm92aWRp
bmcgdGhlIG1vZHVsZSdzDQo+ICAgIHNlbGVjdCBzaWduYWw/IEkgZG91YnQgdGhhdCdzIG5vdCBh
IHBvd2VyIG9mIHR3byA7LSkNCg0KUG9pbnQgdGFrZW4gOikNCg0KSSdsbCBjaGFuZ2UgaXQuDQoN
CkNocmlzDQo=
