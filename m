Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE836EC30
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2019 23:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfD2Vmo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Apr 2019 17:42:44 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5631 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfD2Vmo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Apr 2019 17:42:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc76fd80000>; Mon, 29 Apr 2019 14:42:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Apr 2019 14:42:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Apr 2019 14:42:42 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Apr
 2019 21:42:41 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.55) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 29 Apr 2019 21:42:41 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3365.namprd12.prod.outlook.com (20.178.55.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Mon, 29 Apr 2019 21:42:39 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::a426:a072:b48b:530c]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::a426:a072:b48b:530c%5]) with mapi id 15.20.1835.016; Mon, 29 Apr 2019
 21:42:39 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        "Laxman Dewangan" <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Timo Alho <talho@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Subject: RE: Applied "spi: tegra114: fix PIO transfer" to the spi tree
Thread-Topic: Applied "spi: tegra114: fix PIO transfer" to the spi tree
Thread-Index: AQHU9HIZWfAyUvEJtE2bm8Px22uuI6ZTvtwA
Date:   Mon, 29 Apr 2019 21:42:39 +0000
Message-ID: <BYAPR12MB33989027C79790E4B3CC827CC2390@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1555363834-32155-2-git-send-email-skomatineni@nvidia.com>
 <20190416163257.956F211281C6@debutante.sirena.org.uk>
In-Reply-To: <20190416163257.956F211281C6@debutante.sirena.org.uk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59b443c5-c1ad-41b7-418d-08d6cceb9a6d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR12MB3365;
x-ms-traffictypediagnostic: BYAPR12MB3365:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR12MB3365A5344235A59FDE3192C5C2390@BYAPR12MB3365.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(366004)(376002)(189003)(199004)(66476007)(9686003)(68736007)(54906003)(8676002)(53546011)(55016002)(66556008)(11346002)(64756008)(97736004)(446003)(66446008)(66946007)(14454004)(6506007)(478600001)(476003)(6306002)(86362001)(73956011)(81166006)(53936002)(316002)(8936002)(229853002)(71190400001)(81156014)(186003)(6246003)(6916009)(26005)(52536014)(4326008)(99286004)(2906002)(74316002)(486006)(76116006)(966005)(5660300002)(71200400001)(102836004)(33656002)(6116002)(14444005)(6436002)(66066001)(7696005)(76176011)(7736002)(25786009)(3846002)(305945005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3365;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yJvhBM7WhTvuSyyrHp4l/iEP2QROrDdTYRk/XL0gp/XGRc+1PFvmiI01essYWH8IC4vYm8HHTeeBnuaR/WMdjPXNuGcbiAR1USgqQQI+VcdlB0XpsD5HGs+4BuY+lFGE74atsUVHCJxqZ6b88mKakPk4fiBIKt7AxSJPhkGURlyLwhKTrZx18AmJvXbYfUHC6afdttA6gqwKBDuPiOQwUrI/bSHGr0n9s8k33dzTAixHu7tUkl1pzBIYbYz4IP51TShK3VtBmlkIC4XzuaxL3jGDjs8H+gIB/cKaJYOVZwkUD8CH4EH2S0NW95xbx5Rw3v0B1CmvbnRpJ1uBLo8AHm1gbI40bWQjk136A9u70zU5IY1l9XjhKn0wHDWtekU0FYdABBZaVR/xlBflFGde/4vT+4dxtkqpM2S2o12EiOg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b443c5-c1ad-41b7-418d-08d6cceb9a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 21:42:39.7394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3365
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556574168; bh=ihpE31p04nocg4sCII8t968IekNKyNDgZKURokzCDHs=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-ms-exchange-purlcount:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=WcY6rzKf7dcRID1uS1w0h5upKfWTkAP5hod2mUqnW40dLJUtyeVVj/GOvpqASLpgn
         Lk3nSDvyTxj/1EgnUfrwQrR1SGmPffFOP+aC4v3HleYYfPSKlDnGuQ+0Fk9pHfns5u
         yd1MUyLT9CBOBpHhWcJzRBKH8pVlomYvkGAnaGbZ92ddulGxg2b2cDoEJ7EKR38sUO
         3Gwcn6LVE1YjlBSKXuT2ssIWhL1ZOZ6KzYmjD42r++CR9mchEOPNretFc6fGgPW7UD
         HAmqqJ6dQALNZ2osy4i9wGrB+c9Bd5era/F2XQayEQcDOg4aSAKqzQkZ/C69iFmmVL
         eJE5Uobgm+ZBg==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

I don't see below patches that I see as applied in latest linux-next.
Can you please confirm if they are applied?

Applied "spi: tegra114: fix PIO transfer" to the spi tree
Applied "spi: expand mode support" to the spi tree

Thanks
Sowjanya

> The patch

>   spi: tegra114: fix PIO transfer

> has been applied to the spi tree at

>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.=
1

> All being well this means that it will be integrated into the linux-next =
tree (usually sometime in the next 24 hours) and sent to Linus during the n=
ext merge window (or sooner if it is a bug fix), however if problems are di=
scovered then the patch may be dropped or reverted. =20

> You may get further e-mails resulting from automated or manual testing an=
d review of the tree, please engage with people reporting problems and send=
 followup patches addressing any issues that are reported if needed.

> If any updates are required or you are submitting further changes they sh=
ould be sent as incremental updates against current git, existing patches w=
ill not be replaced.

> Please add any relevant lists and maintainers to the CCs when replying to=
 this mail.

>
> Thanks,
> Mark

>
> From 3f6e3f7843a6a1667ed890ca51a1388fc7bf3429 Mon Sep 17 00:00:00 2001
> From: Sowjanya Komatineni <skomatineni@nvidia.com>
> Date: Mon, 15 Apr 2019 14:30:26 -0700
> Subject: [PATCH] spi: tegra114: fix PIO transfer
>
> This patch fixes PIO mode transfer to use PIO bit in SPI_COMMAND1 registe=
r.
> Current driver uses DMA_EN instead of PIO bit.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/spi/spi-tegra114.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c inde=
x b57f10182fae..21e4fdad013f 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -641,8 +641,9 @@ static int tegra_spi_start_cpu_based_transfer(
>
>  	tspi->is_curr_dma_xfer =3D false;
> =20
> -	val |=3D SPI_DMA_EN;
> -	tegra_spi_writel(tspi, val, SPI_DMA_CTL);
> +	val =3D tspi->command1_reg;
> +	val |=3D SPI_PIO;
> +	tegra_spi_writel(tspi, val, SPI_COMMAND1);
>  	return 0;
>  }
>=20
> --
> 2.20.1

