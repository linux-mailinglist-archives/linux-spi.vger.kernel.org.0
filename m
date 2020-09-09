Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADC3262E25
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 13:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgIILqT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 07:46:19 -0400
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:48622
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730083AbgIILpO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Sep 2020 07:45:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvq3Ns8xHl82FULm1DPkJJm7XozbaNvcka8E1Cdt++mwkIoxfYFKkSgW6hq3we1mW/QaGnLy2j0UXCEybOjR1tBsSt+msntN4cg4EBGHYrYviq7uSV/AzC92JGcL+DwV/1cI5J/lSHSC2TAfzRAURLmEkdU9G13PJkH83I8pqxxLNwd9pn0IPVDDu7DJGpOPuRrm//UvgzBIujw1wcAt0Truxt1LSiQsDHjknQiFf+rWHI4aICGlpgYjM6tgJ28YoiEu2MZZl9WkMziuQq3Iwbecba1k/igXbJciOL1odzg46ce+RHclckk+Z/TXiB2nTcL7egr31WCI98CALhqr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTU+VvFxQuiEKrPS0SQ/lTLYebk3AfnfwCMBI4OUiJs=;
 b=jM3P+LDG6yejK3TKOKwZa5Jv3145P6mQSM3IRKYXvpEqZEtqTqu1B+mZflm1HKKIZtKOkdnWDTeMPlwwBmRUgqTVATX7KWtkSOW/MIdCdUXJjM4cURyIE0ejJyD4nnvvayLtCJkrIglWaT50g2ONKS72RJHaDEFlLGGq7ZOfsmqIV5wHCyZt1xKbiCDTIXHiTUMhYHXs5fFCBOuzr00OvP3ZoTOWDt9PME2N6aR9ibRDp99f5mtrJa9XR9ossoeIM6/CDXZ/a7AZmzpDhfWlsoKypWeryCXGEudr6+NRgAw+5F+GVuKA3+cQb0hKhqJX9A8aYcy0ci55j5n8hknSUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTU+VvFxQuiEKrPS0SQ/lTLYebk3AfnfwCMBI4OUiJs=;
 b=iA0FGZJWhtSAFhebSscC8PAyIVedBoHtF4NrEi+oj7NJSCB0RR8xHHHMorKOeM+SAr/KQaIozxYWDa8CHYcd0RSX8VDJ1ZNh2GAq2oDXUJYVFHuQExj6QuiBtLTvmmmhbg4ZSySlk34it+C2eMm+ILBxS42ZvpE6etoi1SPZMUs=
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com (2603:10a6:7:21::31) by
 HE1PR0402MB3561.eurprd04.prod.outlook.com (2603:10a6:7:89::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Wed, 9 Sep 2020 11:27:18 +0000
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::d899:49cb:a131:dd62]) by HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::d899:49cb:a131:dd62%5]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 11:27:18 +0000
From:   Ashish Kumar <ashish.kumar@nxp.com>
To:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Varun Sethi <V.Sethi@nxp.com>, Arokia Samy <arokia.samy@nxp.com>
Subject: RE: [EXT] [PATCH v1] spi: spi-nxp-fspi: Add ACPI support
Thread-Topic: [EXT] [PATCH v1] spi: spi-nxp-fspi: Add ACPI support
Thread-Index: AQHWhaWudJxNb8lKBUu2hXu+NXNcFKlgIu4Q
Date:   Wed, 9 Sep 2020 11:27:17 +0000
Message-ID: <HE1PR04MB3196017359FD8B44F44EE5EC95260@HE1PR04MB3196.eurprd04.prod.outlook.com>
References: <20200908060227.299-1-kuldip.dwivedi@puresoftware.com>
In-Reply-To: <20200908060227.299-1-kuldip.dwivedi@puresoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: puresoftware.com; dkim=none (message not signed)
 header.d=none;puresoftware.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [182.69.247.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e53ca9a9-5a86-47b8-19e9-08d854b34fa8
x-ms-traffictypediagnostic: HE1PR0402MB3561:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0402MB35610CBF9E83F9C293DC4B9995260@HE1PR0402MB3561.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nEqt+LXUcsPPsC63rdp6IH8k5odb6vpvlPTt3kSxDNO1U3VdrxgG2gD7OcCyF62/Pp+2XWnCXlIROIrVml8kGBBUxLr6a1tufgSTpuDzsIkpkigVMZr8dkL3HYGeXGdK0IDenwnjmbOunksl1O4XTRFV3Lt+w26f1EBfjIcyBkGhOe1aT8Ohsjak2YmuH9N991xZ/rN+bJc81FkUW8kHJfP6mrvRp4IvJv0tk+9cAPwRu/k259l4TzOY9JD6GIXMjE4oB6t7zQqTJ+Y4Gq9jVRzLMhNBgvSo+h4/FM7l8GbGIXPJoSsouMdpMiQA50inZ6uXBEhXCUDknnVOxbeLrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3196.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(52536014)(64756008)(44832011)(66556008)(66476007)(4326008)(5660300002)(33656002)(478600001)(8936002)(9686003)(8676002)(55016002)(7696005)(86362001)(2906002)(6506007)(53546011)(26005)(71200400001)(54906003)(110136005)(66946007)(76116006)(66446008)(316002)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xPAlqigj0pZDqOy8tOQw1t8btaJfwXPwId/5lBWSL7GeYxWUoxEVZz4sygH/dxPph37sLzZCGc9BOVveHIzUhzn4mEEMLxDpRwNozl4EZWS+urqh1UlHwgtBEph0cB1wNM7+SVtGiUGPE9XikAyHvaR+obRoBXS/bAhXvGhhm3Z6rNc9f6/IbHWXFy1BEI3xKrIYx1KaMuF4g8l/Dw3IkCczPiOjXcyCqRnVOoLzmqzxsyGib4bcyFkJlNItX1BIiJejHpa54NIW+U3uYIubiw5HSblJ30+PI+x7+SZlTRKb0ee9Gfs7K6RmK5ZVvm+ik9qKmUN43CTFNiY6UPFvT/NwRCol92j2I4w8tf2sBhnya83f/4sXw6vSfVbzMgahgByLEzrWremxe+XryckcU4ILL40S5RN5tFnonXB/yZDmtWvx0pQ4hFEOv9re4okLX6jCpEVhFpL4HIdrUNl5TMVuMUZ5Ks3vZSDbPyNBGrmoi05rKRafFJtVtA1TZmPf0TySAQvVb1nBJREkkErkUgB96jsRD3bPnACHLIc687GONgzPYNh61dKAzwTwjhAuK65SLrH7dQKt+0Mzb/Ss+WYJIxFaP+FR3YVXvlfiazriW3kni5Z3WfW6Q+KzXt44+qmSx1I/qPvT9EDbieZQHQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3196.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53ca9a9-5a86-47b8-19e9-08d854b34fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 11:27:17.7325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAT/beGZVQzsVYV6MWukpWrx+bueg5O+wpRxA1xcInkF2K7nqZR962hyiFVR0opMU8ABHvobUuS39bzgTqh0hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3561
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Kuldeep Dwivedi,

> -----Original Message-----
> From: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> Sent: Tuesday, September 8, 2020 11:32 AM
> To: Ashish Kumar <ashish.kumar@nxp.com>; Yogesh Gaur
> <yogeshgaur.83@gmail.com>; Mark Brown <broonie@kernel.org>; linux-
> spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Varun Sethi <V.Sethi@nxp.com>; Arokia Samy <arokia.samy@nxp.com>;
> kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> Subject: [EXT] [PATCH v1] spi: spi-nxp-fspi: Add ACPI support
>=20
> Caution: EXT Email
>=20
> Currently NXP fspi  driver has support of DT only. Adding ACPI
> support to the driver so that it can be used by UEFI firmware
> booting in ACPI mode. This driver will be probed if any firmware
> will expose HID "NXP0009" in DSDT table.
>=20
> Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Does these change affects non-ACPI FSPI driver in Linux? What test case wer=
e run to verify the same?

> ---
>=20
> Notes:
>     1. Add ACPI match table
>     2. Change the DT specific APIs to device property APIs
>        so that same API can be used in DT and ACPi mode.
>     3. Omit clock configuration part - in ACPI world, the firmware
>        is responsible for clock maintenance.
>     4. This patch is tested on LX2160A platform
>=20
>  drivers/spi/spi-nxp-fspi.c | 66 +++++++++++++++++++++++++++-----------
>  1 file changed, 47 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 1ccda82da206..acdb186ddfb2 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -3,7 +3,8 @@
>  /*
>   * NXP FlexSPI(FSPI) controller driver.
>   *
> - * Copyright 2019 NXP.
> + * Copyright 2019-2020 NXP
Why Update NXP copyright?

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
> @@ -900,6 +910,8 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
>                 return ret;
>=20
>         /* Reset the module */
> +       fspi_writel(f, FSPI_MCR0_SWRST, (base + FSPI_MCR0));
> +
Why is this SW reset needed now? This will alter nxp_fspi_resume() function=
 as well.=20

>         /* w1c register, wait unit clear */
>         ret =3D fspi_readl_poll_tout(f, f->iobase + FSPI_MCR0,
>                                    FSPI_MCR0_SWRST, 0, POLL_TOUT, false);
> @@ -1001,7 +1013,7 @@ static int nxp_fspi_probe(struct platform_device
> *pdev)
>=20
>         f =3D spi_controller_get_devdata(ctlr);
>         f->dev =3D dev;
> -       f->devtype_data =3D of_device_get_match_data(dev);
> +       f->devtype_data =3D device_get_match_data(dev);
>         if (!f->devtype_data) {
>                 ret =3D -ENODEV;
>                 goto err_put_ctrl;
> @@ -1011,6 +1023,8 @@ static int nxp_fspi_probe(struct platform_device
> *pdev)
>=20
>         /* find the resources - configuration register address space */
>         res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "fspi_base");
> +       if (!res)
> +               res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
Why is this needed ?, _byname() will get you fspi_base value.

>         f->iobase =3D devm_ioremap_resource(dev, res);
>         if (IS_ERR(f->iobase)) {
>                 ret =3D PTR_ERR(f->iobase);
> @@ -1020,8 +1034,11 @@ static int nxp_fspi_probe(struct platform_device
> *pdev)
>         /* find the resources - controller memory mapped space */
>         res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "fspi_mmap");
>         if (!res) {
> -               ret =3D -ENODEV;
> -               goto err_put_ctrl;
> +               res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
Why is this needed? _byname() will get you fspi_mmap.
If fspi_mmap is not present then fetch 1st IORESOURE_MEM ?

Regards
Ashish=20
> +               if (!res) {
> +                       ret =3D -ENODEV;
> +                       goto err_put_ctrl;
> +               }
>         }
>=20
>         /* assign memory mapped starting address and mapped size. */
> @@ -1029,22 +1046,24 @@ static int nxp_fspi_probe(struct platform_device
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
> @@ -1127,6 +1146,14 @@ static const struct of_device_id nxp_fspi_dt_ids[]
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
> @@ -1136,6 +1163,7 @@ static struct platform_driver nxp_fspi_driver =3D {
>         .driver =3D {
>                 .name   =3D "nxp-fspi",
>                 .of_match_table =3D nxp_fspi_dt_ids,
> +               .acpi_match_table =3D ACPI_PTR(nxp_fspi_acpi_ids),
>                 .pm =3D   &nxp_fspi_pm_ops,
>         },
>         .probe          =3D nxp_fspi_probe,
> --
> 2.17.1

