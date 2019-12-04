Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E425112EFA
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 16:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfLDPvz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 10:51:55 -0500
Received: from mail-eopbgr1400097.outbound.protection.outlook.com ([40.107.140.97]:24704
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727878AbfLDPvz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Dec 2019 10:51:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khs1XFJb6HFawv1YXAYS8u8EmRVBY/vjiwRiEno2A5ClLuINrwiDHEa1JWeUYYYvvkIswDKZtKf3toJ+dxxFrguYoKhGdIlyOW2TFYeAVHCHH/QkqYzsKgYtoAKCIu2eO5xOruwlkCMnWtoF5eJCi8wKSTqKPAELd2YwfsqOeV+LgxURWtrTmlI9Bm4vVH0tNjkelJDlRaDGV6ldGvl2U8d+OvIcVdIdHwhgESIwp6pGUBzC/Ksu+eFAfboeIfmzFPlQFsiou1MMH5jdRSDyZXLc0pBt9ikEA7cR/DZA94/TjEmIVYLBhMfgvhiusknRxt+DOHlwQbB77r4zRskE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3BvTf3mhpXF/vFDNk8NhNyFxgQW4Y+/Df7sqiH+BFk=;
 b=agmR3orkzjfMcNv+jrpT8wWET9ACv4Zr21QZzO3RcJ28mGHuqb2QVgDAPiwWNbW9LNNIWESu/yE84bV2TeB6DskhtjbQQCsjZYiEAMWxfoUBBJIANH0PcYn8Kvre98gCfcG2xeSJVseq26TeESJGycQKHdk9viiBZ+Jl6/pG9Jc7M68nqgvcxnWmX+EVIYn87G2u7RzqqVh5a+H4qlDDB/Z1rJ95NzX85m1C29xAR+y3k5MjDAA4h2VVQCDZRVZD5EFYFdpQMU9Sz2MjyCdoTTGMAOoHQMQcNUQCiUZ5QNeAHcx7Z15J+xJ9kHSbANWIjdVYpYnm3wtSXuUMvxOfCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3BvTf3mhpXF/vFDNk8NhNyFxgQW4Y+/Df7sqiH+BFk=;
 b=INyhWzQKYVgJsEY/UfC4PvnykoJ56W7q8d5zSvdckaFwdkXWq2Fkj4csdEVDCJe5eES7hI+WXJsDSf6NQz8WVrxZyl7/xjip8cGIPTcLNBrxNYdH8y29olJ4XWMn5+xsWs4lg2p7AIXjbU7GQJz2jmIOGbh+0kVndqoZyUJUbbs=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1658.jpnprd01.prod.outlook.com (52.133.162.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 15:51:49 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 15:51:49 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: RE: [PATCH 4/6] spi: Add SPIBSC driver
Thread-Topic: [PATCH 4/6] spi: Add SPIBSC driver
Thread-Index: AQHVqYxFvw0/++3CUEK7207HpOVVR6eodlIAgAGlkoA=
Date:   Wed, 4 Dec 2019 15:51:48 +0000
Message-ID: <TY1PR01MB1562C00B477C60A6C264F2A28A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-5-chris.brandt@renesas.com>
 <20191203141944.GI1998@sirena.org.uk>
In-Reply-To: <20191203141944.GI1998@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZjkzZGI4NzctMTZhZC0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XGY5M2RiODc4LTE2YWQtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iNzgxIiB0PSIxMzIxOTk0ODMwNjU1NTU5MDMiIGg9IjRhdURweG5uL2NzSG9IdGJtc2x4UStrOU02bz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64a21164-114d-4210-e733-08d778d1df93
x-ms-traffictypediagnostic: TY1PR01MB1658:
x-microsoft-antispam-prvs: <TY1PR01MB1658E2EF49B51F37B09C15CA8A5D0@TY1PR01MB1658.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(189003)(199004)(8936002)(6116002)(2906002)(55016002)(74316002)(8676002)(102836004)(81156014)(3846002)(305945005)(7416002)(25786009)(81166006)(6246003)(4744005)(33656002)(71190400001)(26005)(71200400001)(4326008)(14454004)(5660300002)(9686003)(6506007)(6916009)(7736002)(86362001)(99286004)(76116006)(11346002)(66946007)(229853002)(76176011)(66476007)(6436002)(478600001)(66556008)(66446008)(64756008)(54906003)(7696005)(316002)(186003)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1658;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WilyjND4GrSGTTDahDL6R4WUCn4FU7XQMJKztFgIp8G739nHAGO3VrBPqCl05gMHh7eYY+E5t9eSEpy2z44GNsq73dFon09Y5dAclXA0hDtinJ7PILQWDHEDHQXlx/CjKZN8hSQ2ewAKh6athKysz/86hXpywrPnCFte1KbMjRBrTN4nuvY+RkICRBpda4Mkm7dcs8xTN5rbUDdcHsmCIurtXMSDH6GlZE38CKGq7UYMWo5tCkMS4lO25oDVmvXlM8HYRSpv2QzuKUCOhTQG//EsNq8/jAk/DP0XEDXElcpPioFw3goKZfR2asusiHAFhpjV368OB5N1mh3mJLD5QJgeXJCew03GmgcVuR2Qvc8DFHR/AcEZRUpuRV/XhEy5x2GTg29+0UD47CNdOUvmLMVMiFtLWDye+SS1JvFZU3QuCZRuG+WvxTk77Z20TuDc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a21164-114d-4210-e733-08d778d1df93
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 15:51:48.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZ/TgplNo8na3q22vK+EU/AoBbR0AQ4KLk3/wr3Za2pD+Sp/8jerWahZrsVQT0eeTwC9MI47Hmf13QxGpAjN/7q8AbQc90xf+FoxXa6MiWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1658
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Mark,

On Tue, Dec 3, 2019, Mark Brown wrote:
> > +static void spibsc_write(struct spibsc_priv *sbsc, int reg, u32 val)
> > +{
> > +	iowrite32(val, sbsc->base + reg);
> > +}
> > +static void spibsc_write8(struct spibsc_priv *sbsc, int reg, u8 val)
>=20
> Looking at a bunch of the stuff here it looks like you could benefit from
> regmap, it's got lots of debug infrastructure.

Thank you for the suggestion, but I looked into using regmap, and there=20
are a lot of drivers that use it, but I don't think it's going to work=20
well for me.
Regmap assumes that all the registers will be the same size. I have to=20
have functions that write with different widths (8/16/32) for a reason.


Chris
