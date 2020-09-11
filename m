Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF472664BF
	for <lists+linux-spi@lfdr.de>; Fri, 11 Sep 2020 18:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIKQpU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Sep 2020 12:45:20 -0400
Received: from mail-am6eur05on2083.outbound.protection.outlook.com ([40.107.22.83]:28416
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbgIKPIV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Sep 2020 11:08:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn3VrUbptRXwAqlZnA7zlaNQ9PLjs5si79H6oVL6rkiCv8tZrgRvvbZFNzdivXA4zk61Ep/JWsf4cNTAqYoB3GPa0/gnFckF1xYWg2d4zGixmAc1ivb5lRqts4cEvkRd3lViz3k138lb9+N8xHFyLZH/GbwyZ5KA8LWiJxVY81i9xD0WxyKfLET9Mkjey+C8GbugqH20F4ZjLe9eTwBLUdAmY0hvpqwO90g6AcRtiFDIZXE3i6BBvdMGU3SsV5ihN4TTZHlOMAxyVC5XWhwGEBa384aEYQ+rri5oykacKSs7dc6/GQWGTLzKAjCVkrV1+poLiVJuaN9iMBPBnzlPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpfzcrcRI0D5KmbugVr5r/W6pvgpRoZrPTyyjiSNSy0=;
 b=PYrzl3jSkvssbhpoQzwjpLTK5x47P81h5dUd63zgOhOl6sfxM9ldUAimqfgyvQmhuEHFCNCvepw6FcGNTwHalKNQE6+E2sy9arGoQyoOcl6KulnFssZTbNE9E7IJLIdnuOBQm+HSwTgHAf43loyEEYvLzK91Zd3vpiHE9DPdtGOmFwqTFW9pgWemQO3KigFx/vZhvRKGYPSopNhqLQV6V1DnQCYxlYH0NqKcT9QAONYUnD65hEXOtLYJkmgoMTDKe+6Om61U39uAP51MOJAtO9+6LVASQbZAPJ4pPpzkvF07/vsxxnTvtAhmv3ZQPaMZR+kwzcupUq7ihkbhlTB+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpfzcrcRI0D5KmbugVr5r/W6pvgpRoZrPTyyjiSNSy0=;
 b=EQq17XPAg7baiHZcMBpm0OdphpRvOTRSXI6SHvZT7sbyTZtGHISLZc5FJkAp4v02aeeTAl8qpjUai3coZ5pSK8pBpAs3a4jcCy73Tu95he0Cn3VusYWS5Fa/eq5p4R8qoU/BPpyictY+pHcgWU06eZYescw6hlPV+6jejc4h1cA=
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com (2603:10a6:7:21::31) by
 HE1PR04MB3115.eurprd04.prod.outlook.com (2603:10a6:7:1a::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.17; Fri, 11 Sep 2020 13:25:57 +0000
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::d899:49cb:a131:dd62]) by HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::d899:49cb:a131:dd62%5]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 13:25:57 +0000
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
Subject: RE: [EXT] [PATCH v3] spi: spi-nxp-fspi: Add ACPI support
Thread-Topic: [EXT] [PATCH v3] spi: spi-nxp-fspi: Add ACPI support
Thread-Index: AQHWiDv/t1nI+oMTeEK7wKGOom49QaljbOIA
Date:   Fri, 11 Sep 2020 13:25:57 +0000
Message-ID: <HE1PR04MB3196FE21A068CB251775C48395240@HE1PR04MB3196.eurprd04.prod.outlook.com>
References: <20200911130331.6313-1-kuldip.dwivedi@puresoftware.com>
In-Reply-To: <20200911130331.6313-1-kuldip.dwivedi@puresoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: puresoftware.com; dkim=none (message not signed)
 header.d=none;puresoftware.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [182.69.197.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa753214-1429-443e-0186-08d8565637e2
x-ms-traffictypediagnostic: HE1PR04MB3115:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR04MB3115A8607C3DFDBC6FB896B895240@HE1PR04MB3115.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t8UWzsELp/MRIz3oI5UG+W1t1rsr54KINP/X6u5dZfgEUHZRgdn3wHkroAmfL8WW5X7AwPrXdPBFKia92Qpr2h+jQ273w+XF3biehomUAbfds567i5AWGpiqE2O9vfwuBEAMakuY8RWbk7hBbjt1+F2lRKFkJaXmbNHA8FMuHrLVmJRuc5fE7DigIR2x2Cz5S/wsTKYCQW3WBivUNGJ0RYHWUUrY9LQtwq3zxFVYc13w+wqsLgo2vl9ILc3yPVJitptudjIEfnZB+sDvxusGmoJfy6BKICVb0jQ7t6ebILFa7GME6eFrQsiojPX+vVul
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3196.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(71200400001)(7696005)(26005)(316002)(8936002)(55016002)(54906003)(44832011)(9686003)(110136005)(33656002)(186003)(478600001)(83380400001)(76116006)(8676002)(5660300002)(86362001)(64756008)(52536014)(53546011)(4326008)(6506007)(2906002)(66476007)(66946007)(66446008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Qcn0aWilgYdAJy9r95QOcCX7kzhy1ow68PJAsQvRnQc50dv5QKA1NcJr1JLLUmEfyk3Xb8W9UDeFph7HbotvMF6bN0RD8T+Opd55fi1s8eD9XR9Y0KEKMlng52Qf8YnwQCB+Nim/QwzJ+yvRdlzDdDiPb3UtK/HoGQJxEzpjbmWQ+li4BkUREPYKzE75GAqnfNz9nAEItHl3xexM3ZINAVjsWwwY8L/z6woeFFllrGRzd2zKjWTrbW7GseXo6jRNxbegSG1MED6AZE1oyiCc3gFB9gQltYclW9DBCb52E0Si+6odTGb+ZWHG9S0qbIdMLoOo4LtpVaPWWbGP4hj/oK3KhN/G5Z30/Raof0nGEqlAjTKoM+gCqzkXOQZ7jA+b75Cn+nTyo9ww0cIEcFUanDFcnknDfFRxGFQvWKq9I0zFCwm7FLJwVvD+hUGYjR1qr2DoKh5NOJ+9m6h5DZOyeXvG0XO0LTu7pazbaoYSSKs+TEO0UekZ1/HhGn50A6yc3vuWHzIf56Dq6Ktxr4QAjR/SAkvchWFM9VYT3HXp94nZpmhapEn1ecoeeOBWz1JYmUTm7kHbXHjvWReN9vNXH13Gy+U1GQYMsUFI6gesWUiTr6uxR9Jgt+lsFYjs3hVkjouUg/KVfGxsiEzy3fcUmg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3196.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa753214-1429-443e-0186-08d8565637e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 13:25:57.6290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +aU2v2ki5mqlvkja7o8jCjHY0DlJRC9zWbEJ9Ac4cFYEHSfU996XMh0GJGb2xD5D2BX2pn7qO2pQOl108hzWvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3115
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> Sent: Friday, September 11, 2020 6:34 PM
> To: Ashish Kumar <ashish.kumar@nxp.com>; Yogesh Gaur
> <yogeshgaur.83@gmail.com>; Mark Brown <broonie@kernel.org>; linux-
> spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Varun Sethi <V.Sethi@nxp.com>; Arokia Samy <arokia.samy@nxp.com>;
> Ard Biesheuvel <Ard.Biesheuvel@arm.com>; Samer El-Haj-Mahmoud
> <Samer.El-Haj-Mahmoud@arm.com>; Paul Yang <Paul.Yang@arm.com>;
> kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> Subject: [EXT] [PATCH v3] spi: spi-nxp-fspi: Add ACPI support
>=20
> Caution: EXT Email
>=20
> Currently NXP fspi  driver has support of DT only. Adding ACPI support to=
 the
> driver so that it can be used by UEFI firmware booting in ACPI mode. This
> driver will be probed if any firmware will expose HID "NXP0009" in DSDT
> table.
>=20
> Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Reviewed-by: Ashish Kumar <Ashish.Kumar@nxp.com>

Regards=20
Ashish=20
> ---
>=20
> Notes:
>     1. Add ACPI match table, NXP members are added to confirm HID for FSP=
I
>     2. Change the DT specific APIs to device property APIs
>        so that same API can be used in DT and ACPi mode.
>     3. Add node specific checks to use indexed based lookup API in case o=
f
>        ACPI.
>         if (is_acpi_node(f->dev->fwnode))
>                 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         else
>                 res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM=
,
> "fspi_base");
>     4. Omit clock configuration part - in ACPI world, the firmware
>        is responsible for clock maintenance.
>     5. This patch is tested on LX2160A platform
>=20
>  drivers/spi/spi-nxp-fspi.c | 69 +++++++++++++++++++++++++++-----------
>  1 file changed, 50 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c inde=
x
> 1ccda82da206..0d41406c036d 100644
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
>   * channels and up to 4 external devices. Each channel supports @@ -30,6
> +31,7 @@
>   *     Frieder Schrempf <frieder.schrempf@kontron.de>
>   */
>=20
> +#include <linux/acpi.h>
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
> @@ -563,6 +565,9 @@ static int nxp_fspi_clk_prep_enable(struct nxp_fspi
> *f)  {
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
> @@ -1010,7 +1020,12 @@ static int nxp_fspi_probe(struct platform_device
> *pdev)
>         platform_set_drvdata(pdev, f);
>=20
>         /* find the resources - configuration register address space */
> -       res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "fspi_base");
> +       if (is_acpi_node(f->dev->fwnode))
> +               res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       else
> +               res =3D platform_get_resource_byname(pdev,
> +                               IORESOURCE_MEM, "fspi_base");
> +
>         f->iobase =3D devm_ioremap_resource(dev, res);
>         if (IS_ERR(f->iobase)) {
>                 ret =3D PTR_ERR(f->iobase); @@ -1018,7 +1033,12 @@ static=
 int
> nxp_fspi_probe(struct platform_device *pdev)
>         }
>=20
>         /* find the resources - controller memory mapped space */
> -       res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "fspi_mmap");
> +       if (is_acpi_node(f->dev->fwnode))
> +               res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       else
> +               res =3D platform_get_resource_byname(pdev,
> +                               IORESOURCE_MEM, "fspi_mmap");
> +
>         if (!res) {
>                 ret =3D -ENODEV;
>                 goto err_put_ctrl;
> @@ -1029,22 +1049,24 @@ static int nxp_fspi_probe(struct platform_device
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
> @@ -1127,6 +1149,14 @@ static const struct of_device_id nxp_fspi_dt_ids[]
> =3D {  };  MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
>=20
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id nxp_fspi_acpi_ids[] =3D {
> +       { "NXP0009", .driver_data =3D (kernel_ulong_t)&lx2160a_data, },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, nxp_fspi_acpi_ids); #endif
> +
>  static const struct dev_pm_ops nxp_fspi_pm_ops =3D {
>         .suspend        =3D nxp_fspi_suspend,
>         .resume         =3D nxp_fspi_resume,
> @@ -1136,6 +1166,7 @@ static struct platform_driver nxp_fspi_driver =3D {
>         .driver =3D {
>                 .name   =3D "nxp-fspi",
>                 .of_match_table =3D nxp_fspi_dt_ids,
> +               .acpi_match_table =3D ACPI_PTR(nxp_fspi_acpi_ids),
>                 .pm =3D   &nxp_fspi_pm_ops,
>         },
>         .probe          =3D nxp_fspi_probe,
> --
> 2.17.1

