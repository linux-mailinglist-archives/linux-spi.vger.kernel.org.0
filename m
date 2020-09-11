Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A1726679E
	for <lists+linux-spi@lfdr.de>; Fri, 11 Sep 2020 19:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgIKM3e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Sep 2020 08:29:34 -0400
Received: from mail-am6eur05on2075.outbound.protection.outlook.com ([40.107.22.75]:64929
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbgIKM26 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Sep 2020 08:28:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGrcYQPlc1fT4ezz6yh7zXeepY9MyL2sk0rg/KeNsrbOm0e9Igd8vn8gc8TuX4T+58SYAfe8wSU4nJrbX0YhNKzWDl8njHmXLOx2GU9LBIxdFUmbBqNSVnlNATl/AHHXIKGfpWgtEOr7uj7Z0dLSHnwHmYO2lGX4riVCR6+nGyipODPXSEpp7+hGKWz+0CVyvCnd3t34hsn+afqRvjHSgAL5FhCpcDDwLiEPtD11vJrbtrOW8e6+7lcPUTYApL2CeXxSUeR7BDg+BiG189QFGYtS9Pc+yNh/JwUFj7+RV/eA0ft9FfGE1/47c7m1TVoAFrrdQwORi/z+TcBvhgSyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsB+mYQdx/O9EeJvRrQKXBulL4/8g97u0p9xLJZzaPU=;
 b=Nbru3lgYI9sb5DM/4hZj9WqL57aGmmcSRJLStgH6M9Jc+kpRhJ8XD7EyHy1/NWytarN7tfHNPv5fz5r/UoIgvT+cx2EDQp17dKUSkY8ONnktOO9b6JkEzS8DkrUzjWbSm58myeXinsVpP0G9azxqbQkTl3CfW+Xp/lDlQ9NfNUlDfk0YO5gaQT3YuMlgJVldM9GzYCUQ2jtj6bi6jvJ3neW0PFzAGz069NTq6Ty5Yai3e6TrlDHB2FAnGmf3nzq+IrJ8BPRWsYYHiNSR+QKNx+Q5QPtnyq0vHoccdom3UMEY13xMyQueGyNXwoaimMQg/0vl+LeOcBeGT41y3H2xSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsB+mYQdx/O9EeJvRrQKXBulL4/8g97u0p9xLJZzaPU=;
 b=X1KFI54LD3Dk1I/G+tter1AQa5SIITHoeuLiW7sYqicdxTxb79zIH+N90FIdweUXyUlKmZoX08vw0X0CyARiQkIktkyIBXnnCVCmsGrryQqLkIbWqJKIYC8odzgUEYVj+MxeJuEbBYXZY6m7zhUAOXY/Z2O5GH3sYCNkYFyBtOU=
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com (2603:10a6:7:21::31) by
 HE1PR0402MB3420.eurprd04.prod.outlook.com (2603:10a6:7:87::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.19; Fri, 11 Sep 2020 12:28:48 +0000
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::d899:49cb:a131:dd62]) by HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::d899:49cb:a131:dd62%5]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 12:28:47 +0000
From:   Ashish Kumar <ashish.kumar@nxp.com>
To:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Varun Sethi <V.Sethi@nxp.com>, Arokia Samy <arokia.samy@nxp.com>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Subject: RE: [EXT] [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
Thread-Topic: [EXT] [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
Thread-Index: AQHWiBWF1RqTTjTNrkyBYYIswnJLQqljXbCA
Date:   Fri, 11 Sep 2020 12:28:47 +0000
Message-ID: <HE1PR04MB31962FC006C6EB964AC2DAE895240@HE1PR04MB3196.eurprd04.prod.outlook.com>
References: <20200911082806.115-1-kuldip.dwivedi@puresoftware.com>
In-Reply-To: <20200911082806.115-1-kuldip.dwivedi@puresoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: puresoftware.com; dkim=none (message not signed)
 header.d=none;puresoftware.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [182.69.197.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cfd46541-862b-42bc-4365-08d8564e3b93
x-ms-traffictypediagnostic: HE1PR0402MB3420:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0402MB3420E596D28E972C9E11746395240@HE1PR0402MB3420.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6+u6CF425Jp5HEAPRRK92+6Vt4WQ183raCPCUrdaSJbXi8rSsgfTvl1nDsj9SgSIQN+rHm9psyEdiLs4SI9vKnuDDradb6zBS3lpeXANCER8lEuzDdG3wJk+UrXu9WJLHGVjYxOp0hEwUPMuFkUpDqSnVEpK+iDkX4gviQr3GGV70vtPb9CLcN4+e67kwioONYO+AJnrAAYUsOzLYkZYwviRUEa+Iur93LRW6pZs8QMZtE779S2Nx9O+wwaPP7tY3QZgEkEqQ9wo37CO4yaS4CFviZDPM4dLhv5SZ8AI2OEVP9izbRBUzJvwB7oy1h4oCLl2rr15T9cDXX2+BDLTXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3196.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(83380400001)(66946007)(9686003)(33656002)(86362001)(55016002)(52536014)(66556008)(76116006)(66476007)(5660300002)(66446008)(64756008)(110136005)(54906003)(26005)(7696005)(186003)(478600001)(4326008)(71200400001)(6506007)(53546011)(2906002)(316002)(8676002)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: TRBn/9Tpr3NHXeI1kC2UUvRqBRQsPbTAZy2cL8qhsAFgZZOaXe8MRlUAzijqB4sl8wo5VASnGAFzTkf039UFGG43YcAE/6yeFyxJjMOD9W3ZukufuoWWL26ws8FjnS6456QkK9LTcE9hdpf9AVjusNQ34MhNpWiJdESy2dVaiRzviyNDyWNhcibW1PUvUckBr7PImlM9g7NaNeouaqwQEw+jwrtdj+RCxf0i5v+5r0sDTifTZGYfaHSZxvuEHJCf/FjS+rEnNtTzHRy6fyScm5HXe3yzfu3m4PZYP/UIhRLsyIVF0YJPZACm9WnjNZJsVSXXUf57jKFf7ebwK2wiwl70dCnVIXU3u2KLjQky6eJ53Y1Alp/Iqwr78rUk3EzmFvHKX75/fAQ+EcakMXFOD2F/9mgXUePOdjNprlDIFNq4M6xQ8gTqsb7ff6V50leo6MCRHHK0y4roQhu1iepDWgk+OOMzGR0il5hDpBuZkJWU3c9gm/85lgcIknQcvYjX0lslRc71wueuaDFnlHCGjkmOEY7JiN01llzZptpJxX+8aoBeHs2OyGEwpILWySlcwzjtVH4INnI6xJebKvY1kC7CEMrK03fwvcZ76vVyK1X1TOrSTeOLbwvzS9PQXxQTaRRjzOx4VPtWUyB6sUHVtw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3196.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd46541-862b-42bc-4365-08d8564e3b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 12:28:47.8580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpYnrblWcJVXl9Hb6BAZZR0KOe4u6BvUO0szplDouy2VmPcAsYYmLJh9x4gDp3SSOO1cI6DRfD1A2w7cqaoh3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3420
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Kuldeep,

> -----Original Message-----
> From: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> Sent: Friday, September 11, 2020 1:58 PM
> To: Ashish Kumar <ashish.kumar@nxp.com>; Yogesh Gaur
> <yogeshgaur.83@gmail.com>; Mark Brown <broonie@kernel.org>; linux-
> spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Varun Sethi <V.Sethi@nxp.com>; Arokia Samy <arokia.samy@nxp.com>;
> Ard Biesheuvel <Ard.Biesheuvel@arm.com>; Samer El-Haj-Mahmoud
> <Samer.El-Haj-Mahmoud@arm.com>; Paul Yang <Paul.Yang@arm.com>;
> kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> Subject: [EXT] [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
>=20
> Caution: EXT Email
>=20
> Currently NXP fspi  driver has support of DT only. Adding ACPI
> support to the driver so that it can be used by UEFI firmware
> booting in ACPI mode. This driver will be probed if any firmware
> will expose HID "NXP0009" in DSDT table.
>=20
> Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> ---
Please capture version change summary.

Regards
Ashish=20
>=20
> Notes:
>     1. Add ACPI match table, NXP members are added to confirm HID for FSP=
I
>     2. Change the DT specific APIs to device property APIs
>            so that same API can be used in DT and ACPi mode.
>     3. Omit clock configuration part - in ACPI world, the firmware
>            is responsible for clock maintenance.
>     4. This patch is tested on LX2160A platform
>=20
>  drivers/spi/spi-nxp-fspi.c | 61 +++++++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 1ccda82da206..9e3991ec0dd2 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -3,7 +3,8 @@
>  /*
>   * NXP FlexSPI(FSPI) controller driver.
>   *
> - * Copyright 2019 NXP.
> + * Copyright 2019-2020 NXP
> + * Copyright 2020 Puresoftware Ltd.
>   *
>   * FlexSPI is a flexsible SPI host controller which supports two SPI
>   * channels and up to 4 external devices. Each channel supports
> @@ -30,6 +31,7 @@
>   *     Frieder Schrempf <frieder.schrempf@kontron.de>
>   */
>=20
> +#include <linux/acpi.h>
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
> @@ -563,6 +565,9 @@ static int nxp_fspi_clk_prep_enable(struct nxp_fspi
> *f)
>  {
>         int ret;
>=20
> +       if (is_acpi_node(f->dev->fwnode))
> +               return 0;
> +
>         ret =3D clk_prepare_enable(f->clk_en);
>         if (ret)
>                 return ret;
> @@ -576,10 +581,15 @@ static int nxp_fspi_clk_prep_enable(struct
> nxp_fspi *f)
>         return 0;
>  }
>=20
> -static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
> +static int nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
>  {
> +       if (is_acpi_node(f->dev->fwnode))
> +               return 0;
> +
>         clk_disable_unprepare(f->clk);
>         clk_disable_unprepare(f->clk_en);
> +
> +       return 0;
>  }
>=20
>  /*
> @@ -1001,7 +1011,7 @@ static int nxp_fspi_probe(struct platform_device
> *pdev)
>=20
>         f =3D spi_controller_get_devdata(ctlr);
>         f->dev =3D dev;
> -       f->devtype_data =3D of_device_get_match_data(dev);
> +       f->devtype_data =3D device_get_match_data(dev);
>         if (!f->devtype_data) {
>                 ret =3D -ENODEV;
>                 goto err_put_ctrl;
> @@ -1011,6 +1021,9 @@ static int nxp_fspi_probe(struct platform_device
> *pdev)
>=20
>         /* find the resources - configuration register address space */
>         res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "fspi_base");
> +#ifdef CONFIG_ACPI
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +#endif
>         f->iobase =3D devm_ioremap_resource(dev, res);
>         if (IS_ERR(f->iobase)) {
>                 ret =3D PTR_ERR(f->iobase);
> @@ -1019,6 +1032,9 @@ static int nxp_fspi_probe(struct platform_device
> *pdev)
>=20
>         /* find the resources - controller memory mapped space */
>         res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "fspi_mmap");
> +#ifdef CONFIG_ACPI
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +#endif
>         if (!res) {
>                 ret =3D -ENODEV;
>                 goto err_put_ctrl;
> @@ -1029,22 +1045,24 @@ static int nxp_fspi_probe(struct platform_device
> *pdev)
>         f->memmap_phy_size =3D resource_size(res);
>=20
>         /* find the clocks */
> -       f->clk_en =3D devm_clk_get(dev, "fspi_en");
> -       if (IS_ERR(f->clk_en)) {
> -               ret =3D PTR_ERR(f->clk_en);
> -               goto err_put_ctrl;
> -       }
> +       if (dev_of_node(&pdev->dev)) {
> +               f->clk_en =3D devm_clk_get(dev, "fspi_en");
> +               if (IS_ERR(f->clk_en)) {
> +                       ret =3D PTR_ERR(f->clk_en);
> +                       goto err_put_ctrl;
> +               }
>=20
> -       f->clk =3D devm_clk_get(dev, "fspi");
> -       if (IS_ERR(f->clk)) {
> -               ret =3D PTR_ERR(f->clk);
> -               goto err_put_ctrl;
> -       }
> +               f->clk =3D devm_clk_get(dev, "fspi");
> +               if (IS_ERR(f->clk)) {
> +                       ret =3D PTR_ERR(f->clk);
> +                       goto err_put_ctrl;
> +               }
>=20
> -       ret =3D nxp_fspi_clk_prep_enable(f);
> -       if (ret) {
> -               dev_err(dev, "can not enable the clock\n");
> -               goto err_put_ctrl;
> +               ret =3D nxp_fspi_clk_prep_enable(f);
> +               if (ret) {
> +                       dev_err(dev, "can not enable the clock\n");
> +                       goto err_put_ctrl;
> +               }
>         }
>=20
>         /* find the irq */
> @@ -1127,6 +1145,14 @@ static const struct of_device_id nxp_fspi_dt_ids[]
> =3D {
>  };
>  MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
>=20
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id nxp_fspi_acpi_ids[] =3D {
> +       { "NXP0009", .driver_data =3D (kernel_ulong_t)&lx2160a_data, },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, nxp_fspi_acpi_ids);
> +#endif
> +
>  static const struct dev_pm_ops nxp_fspi_pm_ops =3D {
>         .suspend        =3D nxp_fspi_suspend,
>         .resume         =3D nxp_fspi_resume,
> @@ -1136,6 +1162,7 @@ static struct platform_driver nxp_fspi_driver =3D {
>         .driver =3D {
>                 .name   =3D "nxp-fspi",
>                 .of_match_table =3D nxp_fspi_dt_ids,
> +               .acpi_match_table =3D ACPI_PTR(nxp_fspi_acpi_ids),
>                 .pm =3D   &nxp_fspi_pm_ops,
>         },
>         .probe          =3D nxp_fspi_probe,
> --
> 2.17.1

