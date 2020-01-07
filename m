Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F41C9131F64
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2020 06:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgAGFji (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jan 2020 00:39:38 -0500
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:42085
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbgAGFjh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 7 Jan 2020 00:39:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYbN3td9KIZ9Oe8HzhHVE8N9whR6ZCFb1eL69H8kvEhZxJEoX0dCXir5TublkVhumI9g+ijXnDuC0V6GuGbE/7zxPhx+Iop6XNpugj6nhSFtoQheJO5TXtNnAOE7cRcL+u5rBtp8l5FIwK57Ohj7R929CqjV1qIhAYTpPYoOJHQYJzusXOImw3czconjSDOh2u5m8bc16eCw+Exj+g2Q/2u9GccmkndyQHYMuDvJ57xBqLvPhwbroteOoIwHsNUkffdu9rVUHwyokDzkqFlo0PPHpHUOmmZWApbIiSJ6OFc+OhKWEDOY7VnLswgCbpyDLCO9SfqHw8+ryB0zU7fPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkAgNbpMv2uBzXlRPue5j9Sz4grmfLufd0f0m+AO1N8=;
 b=h4DLYu31u2GeqATT7jgfpOymCHZ4Na0zHeFZgbvE+iPk8wBWjOfZ1KhpUPXAsao10dJuyOnRmcn9SRowBTuTh9WdHvUQF9gnky5LD1gYvgakKYdKo2b8dkBh0cfIxv7flrt0Xxe7cf+6LW9tY5H933HKlX1Knt2x5JqgUnZ+dH0MY119iu/1Xf49CiYaLB6xb7dVEbWyuB6vJ/3qwcY+LGKH8TnchGD3JTdNfox3krJL35vXicsA77QGFAu7roxWPg/v6ll5cQmQjFrFIt/8d1o/I9rlFLZGVXEwc1GMiEnI78JJjWGW7rLYrUPmv/IG0iYoblTDB95oCc8dfUXWfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkAgNbpMv2uBzXlRPue5j9Sz4grmfLufd0f0m+AO1N8=;
 b=Me7+5dz7Nho5I9pT46mBq2Wg8PAd8s1H9MEUimeWdDuorRnECooDRAiAEuSVoDF3L1KwuJswN8cFZ9naW0qZ0TqrS1ZWN3PYDqGrOijolfws1ZnjlbW+4EEcg/AYaAQRpf1aACYVrxCYgAwJ++DzwhgNEOlHPP1lNYEoeuQHdYI=
Received: from AM0PR0402MB3556.eurprd04.prod.outlook.com (52.133.43.147) by
 AM0PR0402MB3810.eurprd04.prod.outlook.com (52.133.39.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Tue, 7 Jan 2020 05:39:34 +0000
Received: from AM0PR0402MB3556.eurprd04.prod.outlook.com
 ([fe80::918a:1621:497d:eac3]) by AM0PR0402MB3556.eurprd04.prod.outlook.com
 ([fe80::918a:1621:497d:eac3%7]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 05:39:33 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>
Subject: RE: [EXT] [PATCH] spi: nxp-fspi: Ensure width is respected in spi-mem
 operations
Thread-Topic: [EXT] [PATCH] spi: nxp-fspi: Ensure width is respected in
 spi-mem operations
Thread-Index: AQHVsF1Gddazlnw7/EW3ov3Q/OcPSafe1kNA
Date:   Tue, 7 Jan 2020 05:39:33 +0000
Message-ID: <AM0PR0402MB3556E16D1027FB5D6C3FDC88E03F0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
References: <20191211195730.26794-1-michael@walle.cc>
In-Reply-To: <20191211195730.26794-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuldeep.singh@nxp.com; 
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a1b3932-5185-429e-b364-08d79333f9cc
x-ms-traffictypediagnostic: AM0PR0402MB3810:|AM0PR0402MB3810:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR0402MB3810B2E961972DB1250F8F6AE03F0@AM0PR0402MB3810.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(13464003)(189003)(199004)(9686003)(186003)(66446008)(76116006)(66946007)(81156014)(81166006)(66556008)(64756008)(55016002)(66476007)(26005)(478600001)(44832011)(71200400001)(52536014)(53546011)(6506007)(54906003)(86362001)(33656002)(8936002)(8676002)(7696005)(316002)(110136005)(2906002)(5660300002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3810;H:AM0PR0402MB3556.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5+HLwrgn2TntJ25ZTiGphfpNx+glrda6KNDZ0I/9HUiguaAcxRCohZ/1Chw3R8fmp+fwrQv1AOj1YFpWISF92/lQUVDTOTmUPSb7IMkGX+L1dEmyPbv2nZCVmdFImY/mq1InQIlvAw9PkUzuzt9lml1PAsrtbWUpHf1w3cXCVcbu3Y9/sR4c+VKyK+kaZUGfeTD1CxsUsU+5HfBZjHrvZpg7z2E6FcH2lR+XLQiRKVDfBB7npgVloXvdQBb8JrGb1SKE9Kc6bfcP9JBhk0sDSHleIfdRDhsPtXXGTC8LPYIWHBWu5n5y6raGNN5itaRJuKy8Jwt7mFJBLgReg/iDw3Hlto92T3Hc0R3jgyPHxPcwGNMyxxMG8tIEZ1xVitI26RN9AL9uj8oS8u+l4oXs4JH9JDtx6sYlMmiPHcORjo7FoADoSKseZMZORMF9vgEq7HFX0hR8FZWyDOZKZCzmpBom0MMGlqYfd07h5FaOYQ8PWix7iG3uvSTu3un5b4V
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1b3932-5185-429e-b364-08d79333f9cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 05:39:33.8612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bAOvg6PKnv5mrpLU/gUea+cNcBRhc4CYnYJjIV7i4L/kz9ytmZF9MOCbdhoqvObqnmK5ylLotjKYkNhOhFfdEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3810
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Michael,

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Michael Walle
> Sent: Thursday, December 12, 2019 1:28 AM
> To: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>; Ashish Kumar
> <ashish.kumar@nxp.com>; Mark Brown <broonie@kernel.org>; Michael
> Walle <michael@walle.cc>
> Subject: [EXT] [PATCH] spi: nxp-fspi: Ensure width is respected in spi-me=
m
> operations
>=20
> Caution: EXT Email
>=20
> Make use of a core helper to ensure the desired width is respected when
> calling spi-mem operators.
>=20
> Otherwise only the SPI controller will be matched with the flash chip, wh=
ich
> might lead to wrong widths. Also consider the width specified by the user=
 in
> the device tree.

Could you please mention the flash and modes you tested. Does it support DU=
AL/QUAD mode?
I couldn't test these modes as NXP LS1028ARDB has "mt35xu02g" which support=
s SINGLE and OCTAL modes only.

Thanks
Kuldeep

>=20
> Fixes: a5356aef6a90 ("spi: spi-mem: Add driver for NXP FlexSPI controller=
")
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/spi/spi-nxp-fspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c inde=
x
> c36bb1bb464e..8c5084a3a617 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -439,7 +439,7 @@ static bool nxp_fspi_supports_op(struct spi_mem
> *mem,
>             op->data.nbytes > f->devtype_data->txfifo)
>                 return false;
>=20
> -       return true;
> +       return spi_mem_default_supports_op(mem, op);
>  }
>=20
>  /* Instead of busy looping invoke readl_poll_timeout functionality. */
> --
> 2.20.1

