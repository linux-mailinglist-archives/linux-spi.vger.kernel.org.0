Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5928B1100B6
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 16:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfLCPAM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 10:00:12 -0500
Received: from mail-eopbgr1410115.outbound.protection.outlook.com ([40.107.141.115]:36791
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfLCPAM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Dec 2019 10:00:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJwc3CQWEioQqqT6pbi8AZmpxeLNMN64zkshGga58z0v6cdIyq9LCOoZL9f9Kr3Ttn0S1s40eJfZHaGb/zUe/oQy3HdISIiaV0zw5m1CWSy8d/plOwzIxIIVnitKEc4wRkJLmp3aQ0vWWoDJ5VMg4BaiMerQK+jANL2VPYP2b11qx5bL2ocdsCGjBRY3HLTTrdvp/xVnyZ98kneCsXbNAKnx07Y1hn97UD0j4xV0KRCLezLgn6lcqa8qzmhClmXNc+9zhqCaM8RsP2CRuiZJQ+Cgg46HZZRvlV67GvErFl+QITW2bnuHsvzHnOwpSwm/SCQVTUWQCGL+ErSVERSm2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwsRmqi7yk04w9kf/0aqpJt18YPZLQH/5HrPnbwDYCc=;
 b=O1o+eYLjHQ5YsrehwBuNKqUgLXu3QZNgGt3H9pTU3WwoTdWSDsUpjf0aXvPhvJDaNXQ7HUm8XRv7ntvFZgDInnStFKs3USIkcBT0y7jaZXHMEEWCX52eIBb5ndt0VsGIb6cXgzsU6r0NrD9EJQNWDKjsL2NJOfuRKOgt+tRop9ORb+nUJkCyCoTzf/W73OrENvV7T1036krV+GuaIDFSM0cTmd8ST+KZla5yqm/g9Sv7IXAoOUPxe4W+sXRdnBx1/z0ogwCnDPyVoQLnLT0SPiMWxygwwgAZbHKwHkDSKlYcU8gRBvhQs7dKE+6J/8K5v9+QJ0bG+5KQ78mwOleOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwsRmqi7yk04w9kf/0aqpJt18YPZLQH/5HrPnbwDYCc=;
 b=Aj7LsSXilsjqcna+VEvKO6WIDhU1c6FCJVRzaxSfTu8EbLsfJI/3BoI0pSx4M9/y6PPH5CFEfeHsrWhRbdfQIAR7aZCHGdv4zqf4hNqVvr/NMNgi1qy8apltR2VMK1xlNDR4NJO590RGd4iA1CUeF3ptH6q081059Ouf2gKPc38=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1561.jpnprd01.prod.outlook.com (52.133.161.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 15:00:08 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 15:00:08 +0000
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
Thread-Index: AQHVqYxFvw0/++3CUEK7207HpOVVR6eodlIAgAAIHbA=
Date:   Tue, 3 Dec 2019 15:00:08 +0000
Message-ID: <TY1PR01MB15627FA556E5B8CE03D535118A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-5-chris.brandt@renesas.com>
 <20191203141944.GI1998@sirena.org.uk>
In-Reply-To: <20191203141944.GI1998@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOTczY2M1ZTUtMTVkZC0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDk3M2NjNWU2LTE1ZGQtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iNTYxIiB0PSIxMzIxOTg1ODgwNjgyMjc3NDEiIGg9InRqWHhsWGF1cTdFYTkvK01YT0kwcEE1QzJoUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37432c48-a07e-4dae-4320-08d778017d1a
x-ms-traffictypediagnostic: TY1PR01MB1561:
x-microsoft-antispam-prvs: <TY1PR01MB1561B19FAF44DA872A64CBD08A420@TY1PR01MB1561.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(199004)(189003)(7696005)(14454004)(186003)(7416002)(25786009)(33656002)(2906002)(55016002)(8936002)(102836004)(6916009)(316002)(76176011)(52536014)(11346002)(256004)(446003)(4326008)(6246003)(86362001)(99286004)(6436002)(3846002)(54906003)(6116002)(4744005)(478600001)(5660300002)(71190400001)(71200400001)(74316002)(66446008)(76116006)(64756008)(9686003)(305945005)(66476007)(66946007)(7736002)(229853002)(8676002)(81156014)(6506007)(66556008)(81166006)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1561;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u5nEvTE+JsO+kE+BcpCz3ZXLNU7iZlb9zCA2pJXPyRVZxdgaIddjkDYpWVLWKsjngg+yeMhGkUvAQ7G+F8Xhqq4LWtaoHGUH1djt7zan1AOXAHXzaI/M8pCCmoF1OCqNVmDcpWJDgJkWFqZgXw1HjG0Nk49PK7xhfP4LzymJsqC6ZEMJjPJOn7d5eAZWUYtwOW0J8GUEVeB0Sbyjyw4aBf6tNxKXJyPgyJGROaeBB3OHHGzbqnQc4nmvP8EGclw+w9oBgdhSyI+BFPuuQZC9q+V7fu1e0UTOuWmdThOSucity5LzLx0mwXA0fgus6TBNkGnNKfEjsLp0qVTUJ/E+4/mOrOThPKD0ItIK/EjyM+PxiSuRFgOvz0fbQ7nMoTjCb7L3PWE2a4yu1GXxWd8no0LSU91myiv+R1RoMlFatUDDQR9oNMWd6dJjXP4pkf1b
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37432c48-a07e-4dae-4320-08d778017d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 15:00:08.4408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4naSS+qoaCwkbVyInLyH4Jl+pqqmjLjJ3IhmTcnf/ExrKJCYGj/9d0m5asLQ9w8EWOtw/9ShPpfqFIaZZ7t+ikZBIQkqi/CtFZDEZ2sFeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1561
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Mark,

On Tue, Dec 3, 2019, Mark Brown wrote:
> On Mon, Dec 02, 2019 at 10:45:17PM -0500, Chris Brandt wrote:
>=20
> > +config SPI_SPIBSC
> > +	tristate "Renesas SPI Multi I/O Bus Controller"
> > +	depends on ARCH_R7S72100 || ARCH_R7S9210
>=20
> I'm not seeing any build dependency here, please add an || COMPILE_TEST f=
or
> build coverage.
(snip)

Thank you for your review!

I have no complaints about your comments so I will make the changes and
send out a v2.

Chris

