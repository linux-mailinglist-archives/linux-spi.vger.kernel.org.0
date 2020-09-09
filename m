Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C972632FD
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 18:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbgIIQzN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 12:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbgIIPwj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Sep 2020 11:52:39 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA32EC06136F
        for <linux-spi@vger.kernel.org>; Wed,  9 Sep 2020 07:17:19 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o8so3781395ejb.10
        for <linux-spi@vger.kernel.org>; Wed, 09 Sep 2020 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=return-receipt-to:from:references:in-reply-to:mime-version
         :thread-index:disposition-notification-to:date:message-id:subject:to
         :cc;
        bh=T6MdcQq7UBfcu3zi/xljE+j78qjwHM+ABuBQhG098iA=;
        b=MGvNbJB3rgkGWBzUVF9CK9k0VJ2n1kCthAEiyagZiik7wISACeCyUrHQbCoY4pOH4R
         Q7cZH3y3NLQUll+g0a5GT5+F3F4ejpyJg5XIzC/8IfYTlaPNH7ELpgJ6bj7zgStFUmm2
         4Put7nAdAnAekhM4SRBBMdet+GxPo6xLWJFbXld6Vr45l77UY374xXxARwCXVpTuNAqp
         ga+knZzZ9trYT2630TwQ89pi8oi+keKuLiOBp4ElLZH2c8Ah4/rin7wHhzBv6isTL9Xx
         fryaiZQ1P4cS9skq36MPpePw9ZJh+2aaVTQ+uGgw2cEGTFr8c9ngjjUU+Gv3pSHkk8yS
         2mkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:return-receipt-to:from:references:in-reply-to
         :mime-version:thread-index:disposition-notification-to:date
         :message-id:subject:to:cc;
        bh=T6MdcQq7UBfcu3zi/xljE+j78qjwHM+ABuBQhG098iA=;
        b=UaRIX2hYuCenZ/TGDdK+JVWXA0sII1lC0ncCcagz29MFHlCNfU4GyeTgCBV+gRLWZE
         GrxlsauCZyivRSHAzxrOcXR6e9veM1annzyNP2kc9iRIurOodv5jr4WFy83B78H7weE/
         Z6KY+SbWPW6jHwa7PfmMHkKQ1tV5qDJK3h+qobvBMSSo2/wvwUlrDsgUPI8n7t8W4DHt
         UMtBPY6SPbr+3Ih/dvb7Lz80GVGoSrP1REjhylHovWJnqxmIBfSTb/5XbTb347gjwLfE
         OC4F2kq8GbMlyksrQbpM57tak3xSJoFkZ8OZzsWyudZ+XY1jLYrWGAHa9gqbiibpfKSv
         n68Q==
X-Gm-Message-State: AOAM5302bQTqb8uuUiQx+EeCjJJL6xJK6bMk/x6GIm2dX9lNr6Plfujh
        9LRe2pbpa3UZtwNfpKMB1cXMr64xjrL0QE+nVavQAQ==
X-Google-Smtp-Source: ABdhPJy6lMZdZ/cOve+0uzZ5AZkwS5S2bynNOM5AGX1JEk1K6IkMD+6SdNv4ZYSwqI54Dd2q2mhYXfQGDSuz5wUgOgo=
X-Received: by 2002:a17:906:c113:: with SMTP id do19mr3759708ejc.219.1599661038012;
 Wed, 09 Sep 2020 07:17:18 -0700 (PDT)
From:   Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
References: <20200908060227.299-1-kuldip.dwivedi@puresoftware.com> <HE1PR04MB3196017359FD8B44F44EE5EC95260@HE1PR04MB3196.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR04MB3196017359FD8B44F44EE5EC95260@HE1PR04MB3196.eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQN8fgwoxWwZ35Fh/WfiJFzRBjxO6ALsz7wopfz9D+A=
Date:   Wed, 9 Sep 2020 19:47:04 +0530
Message-ID: <37d2af0767af627e2534bbcacffa17d2@mail.gmail.com>
Subject: RE: [EXT] [PATCH v1] spi: spi-nxp-fspi: Add ACPI support
To:     Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Varun Sethi <V.Sethi@nxp.com>, Arokia Samy <arokia.samy@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> -----Original Message-----
> From: Ashish Kumar <ashish.kumar@nxp.com>
> Sent: Wednesday, September 9, 2020 4:57 PM
> To: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>; Yogesh Gaur
> <yogeshgaur.83@gmail.com>; Mark Brown <broonie@kernel.org>; linux-
> spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Varun Sethi <V.Sethi@nxp.com>; Arokia Samy <arokia.samy@nxp.com>
> Subject: RE: [EXT] [PATCH v1] spi: spi-nxp-fspi: Add ACPI support
>
> Hi Kuldeep Dwivedi,
Don't mind but It's Kuldip  not Kuldeep
>
> > -----Original Message-----
> > From: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> > Sent: Tuesday, September 8, 2020 11:32 AM
> > To: Ashish Kumar <ashish.kumar@nxp.com>; Yogesh Gaur
> > <yogeshgaur.83@gmail.com>; Mark Brown <broonie@kernel.org>; linux-
> > spi@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: Varun Sethi <V.Sethi@nxp.com>; Arokia Samy <arokia.samy@nxp.com>;
> > kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> > Subject: [EXT] [PATCH v1] spi: spi-nxp-fspi: Add ACPI support
> >
> > Caution: EXT Email
> >
> > Currently NXP fspi  driver has support of DT only. Adding ACPI support
> > to the driver so that it can be used by UEFI firmware booting in ACPI
> > mode. This driver will be probed if any firmware will expose HID
> > "NXP0009" in DSDT table.
> >
> > Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> Does these change affects non-ACPI FSPI driver in Linux? What test case
were run
> to verify the same?
I have verified on both DT and ACPI mode with below method. In this method
we
Used mtd utility to write some content and then read from same address.
Address 0x3000000 has been selected to avoid any data loss of existing
UEFI variables.
root@localhost:/mnt# ls
1.c  EFI  i2c_utils  mtd_debug  mtdinfo  reportfreq64
root@localhost:/mnt# cat 1.c
1234567890987654321
root@localhost:/mnt#
root@localhost:/mnt# ./mtdinfo
Count of MTD devices:           2
Present MTD devices:            mtd0, mtd1
Sysfs interface supported:      yes
root@localhost:/mnt# ./mtd_debug erase /dev/mtd1 0x3000000 0x1000
Erased 4096 bytes from address 0x03000000 in flash
root@localhost:/mnt# ./mtd_debug write /dev/mtd1 0x3000000 20 1.c
Copied 20 bytes from 1.c to address 0x03000000 in flash
root@lOcalhost:/mnt# ./mtd_debug read /dev/mtd1 0x3000000 20 2.c
Copied 20 bytes from address 0x03000000 in flash tO 2.c
root@localhost:/mnt# cat 2.c
1234567890987654321
> > ---
> >
> > Notes:
> >     1. Add ACPI match table
> >     2. Change the DT specific APIs to device property APIs
> >        so that same API can be used in DT and ACPi mode.
> >     3. Omit clock configuration part - in ACPI world, the firmware
> >        is responsible for clock maintenance.
> >     4. This patch is tested on LX2160A platform
> >
> >  drivers/spi/spi-nxp-fspi.c | 66
> > +++++++++++++++++++++++++++-----------
> >  1 file changed, 47 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> > index 1ccda82da206..acdb186ddfb2 100644
> > --- a/drivers/spi/spi-nxp-fspi.c
> > +++ b/drivers/spi/spi-nxp-fspi.c
> > @@ -3,7 +3,8 @@
> >  /*
> >   * NXP FlexSPI(FSPI) controller driver.
> >   *
> > - * Copyright 2019 NXP.
> > + * Copyright 2019-2020 NXP
> Why Update NXP copyright?
This is asked by NXP only
>
> > + * Copyright 2020 Puresoftware Ltd.
> >   *
> >   * FlexSPI is a flexsible SPI host controller which supports two SPI
> >   * channels and up to 4 external devices. Each channel supports @@
> > -30,6 +31,7 @@
> >   *     Frieder Schrempf <frieder.schrempf@kontron.de>
> >   */
> >
> > +#include <linux/acpi.h>
> >  #include <linux/bitops.h>
> >  #include <linux/clk.h>
> >  #include <linux/completion.h>
> > @@ -563,6 +565,9 @@ static int nxp_fspi_clk_prep_enable(struct
> > nxp_fspi
> > *f)
> >  {
> >         int ret;
> >
> > +       if (is_acpi_node(f->dev->fwnode))
> > +               return 0;
> > +
> >         ret = clk_prepare_enable(f->clk_en);
> >         if (ret)
> >                 return ret;
> > @@ -576,10 +581,15 @@ static int nxp_fspi_clk_prep_enable(struct
> > nxp_fspi *f)
> >         return 0;
> >  }
> >
> > -static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
> > +static int nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
> >  {
> > +       if (is_acpi_node(f->dev->fwnode))
> > +               return 0;
> > +
> >         clk_disable_unprepare(f->clk);
> >         clk_disable_unprepare(f->clk_en);
> > +
> > +       return 0;
> >  }
> >
> >  /*
> > @@ -900,6 +910,8 @@ static int nxp_fspi_default_setup(struct nxp_fspi
*f)
> >                 return ret;
> >
> >         /* Reset the module */
> > +       fspi_writel(f, FSPI_MCR0_SWRST, (base + FSPI_MCR0));
> > +
> Why is this SW reset needed now? This will alter nxp_fspi_resume()
function as
> well.
I observed a kernel panic during setting up the driver in
 nxp_fspi_default_setup function in ACPI boot and this is fixed.
>
> >         /* w1c register, wait unit clear */
> >         ret = fspi_readl_poll_tout(f, f->iobase + FSPI_MCR0,
> >                                    FSPI_MCR0_SWRST, 0, POLL_TOUT,
> > false); @@ -1001,7 +1013,7 @@ static int nxp_fspi_probe(struct
> > platform_device
> > *pdev)
> >
> >         f = spi_controller_get_devdata(ctlr);
> >         f->dev = dev;
> > -       f->devtype_data = of_device_get_match_data(dev);
> > +       f->devtype_data = device_get_match_data(dev);
> >         if (!f->devtype_data) {
> >                 ret = -ENODEV;
> >                 goto err_put_ctrl;
> > @@ -1011,6 +1023,8 @@ static int nxp_fspi_probe(struct platform_device
> > *pdev)
> >
> >         /* find the resources - configuration register address space
*/
> >         res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > "fspi_base");
> > +       if (!res)
> > +               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> Why is this needed ?, _byname() will get you fspi_base value.
In ACPI we can not pass resource value by name  where as we have to pass
By index. So in 0th Index there is FSPI_BASE and in 1st index FSPIMM_BASE.
For reference Please see , Line :23 and Line:24
https://source.codeaurora.org/external/qoriq/qoriq-components/edk2-platfor
ms/tree/Platform/NXP/LX2160aRdbPkg/AcpiTables/Dsdt/FSPI.asl?h=LX2160_UEFI_
ACPI_EAR3
>
> >         f->iobase = devm_ioremap_resource(dev, res);
> >         if (IS_ERR(f->iobase)) {
> >                 ret = PTR_ERR(f->iobase); @@ -1020,8 +1034,11 @@
> > static int nxp_fspi_probe(struct platform_device
> > *pdev)
> >         /* find the resources - controller memory mapped space */
> >         res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > "fspi_mmap");
> >         if (!res) {
> > -               ret = -ENODEV;
> > -               goto err_put_ctrl;
> > +               res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> Why is this needed? _byname() will get you fspi_mmap.
> If fspi_mmap is not present then fetch 1st IORESOURE_MEM ?
In ACPI we can not pass resource value by name  where as we have to pass
By index. So in 0th Index there is FSPI_BASE and in 1st index FSPIMM_BASE.
For reference Please see , Line :23 and Line:24
https://source.codeaurora.org/external/qoriq/qoriq-components/edk2-platfor
ms/tree/Platform/NXP/LX2160aRdbPkg/AcpiTables/Dsdt/FSPI.asl?h=LX2160_UEFI_
ACPI_EAR3
>
> Regards
> Ashish
> > +               if (!res) {
> > +                       ret = -ENODEV;
> > +                       goto err_put_ctrl;
> > +               }
> >         }
> >
> >         /* assign memory mapped starting address and mapped size. */
> > @@ -1029,22 +1046,24 @@ static int nxp_fspi_probe(struct
> > platform_device
> > *pdev)
> >         f->memmap_phy_size = resource_size(res);
> >
> >         /* find the clocks */
> > -       f->clk_en = devm_clk_get(dev, "fspi_en");
> > -       if (IS_ERR(f->clk_en)) {
> > -               ret = PTR_ERR(f->clk_en);
> > -               goto err_put_ctrl;
> > -       }
> > +       if (dev_of_node(&pdev->dev)) {
> > +               f->clk_en = devm_clk_get(dev, "fspi_en");
> > +               if (IS_ERR(f->clk_en)) {
> > +                       ret = PTR_ERR(f->clk_en);
> > +                       goto err_put_ctrl;
> > +               }
> >
> > -       f->clk = devm_clk_get(dev, "fspi");
> > -       if (IS_ERR(f->clk)) {
> > -               ret = PTR_ERR(f->clk);
> > -               goto err_put_ctrl;
> > -       }
> > +               f->clk = devm_clk_get(dev, "fspi");
> > +               if (IS_ERR(f->clk)) {
> > +                       ret = PTR_ERR(f->clk);
> > +                       goto err_put_ctrl;
> > +               }
> >
> > -       ret = nxp_fspi_clk_prep_enable(f);
> > -       if (ret) {
> > -               dev_err(dev, "can not enable the clock\n");
> > -               goto err_put_ctrl;
> > +               ret = nxp_fspi_clk_prep_enable(f);
> > +               if (ret) {
> > +                       dev_err(dev, "can not enable the clock\n");
> > +                       goto err_put_ctrl;
> > +               }
> >         }
> >
> >         /* find the irq */
> > @@ -1127,6 +1146,14 @@ static const struct of_device_id
> > nxp_fspi_dt_ids[] = {  };  MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
> >
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id nxp_fspi_acpi_ids[] = {
> > +       { "NXP0009", .driver_data = (kernel_ulong_t)&lx2160a_data, },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(acpi, nxp_fspi_acpi_ids); #endif
> > +
> >  static const struct dev_pm_ops nxp_fspi_pm_ops = {
> >         .suspend        = nxp_fspi_suspend,
> >         .resume         = nxp_fspi_resume,
> > @@ -1136,6 +1163,7 @@ static struct platform_driver nxp_fspi_driver =
{
> >         .driver = {
> >                 .name   = "nxp-fspi",
> >                 .of_match_table = nxp_fspi_dt_ids,
> > +               .acpi_match_table = ACPI_PTR(nxp_fspi_acpi_ids),
> >                 .pm =   &nxp_fspi_pm_ops,
> >         },
> >         .probe          = nxp_fspi_probe,
> > --
> > 2.17.1
Thanks,
