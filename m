Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0861F44EECE
	for <lists+linux-spi@lfdr.de>; Fri, 12 Nov 2021 22:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhKLVqq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Nov 2021 16:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbhKLVqp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Nov 2021 16:46:45 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054F3C061766;
        Fri, 12 Nov 2021 13:43:54 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id i63so21102408lji.3;
        Fri, 12 Nov 2021 13:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NIaDQDLU9AaDAEFed9FZSgxscq7xyjHPkW90Fkos5aQ=;
        b=bBcgwB/iBCHUGwkFseJ1f7Bztq8rM/ivQCUwnfT3OrqBWndosIFD7lPPZB8Jp4lh2v
         olVbrsk34L2brSyZyy/82yhppLYDhM0kiDX8mtSnXnmOtIqyRXat0oqYIwtRpTGmwlo0
         9ivjkqhwisHY63m+O8FLQoff7uOfn51Ur5l7ghNqPrpL8dz6zLlVSq9NKOTOhqYBlteA
         3Wd4Aeyz7sGWIEztRmsvpLvuHxJpibI66FpbLRShvmxA45/9g3Oa3FpdOcDFB4b6zKZh
         QmNDh89pemomqsu4QD5LHpnb1K1/lYdNTcKDJaFIzgyiORwiqGZwvOrrpkCvO7G+3a+C
         GFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NIaDQDLU9AaDAEFed9FZSgxscq7xyjHPkW90Fkos5aQ=;
        b=Lzi/XNBOnumNL0awTNvr8D6fh8LHIi/+rrBf0gGX0X1M//xL5qu1jxwvaU2q4ZwCNt
         2voNWwbgsTTrRoVbUVHvEdd2eECYA0w4VuwnMy6G8OvN5/WrPiGEZdKVv6H/wL6q+52+
         l7Lcnn/n63+lpaHnOjU/aMaxQYqxw8H9HpfLfaClcfWjrta0W4fSUr1o3RrlUjmgmshM
         hSHc4n8m9FOxKcvHfxk1oiRCzndO8XwqSLnrnqh6ndl1PCEe4vA6dERl4V1VyqeUKTDD
         Dr6wcKtmStxagrPy1WjDyjeHlfvpjJ+aOi1MKqmwJixNoZ0PZNKsbaeaU/+/uPREjPlC
         CP9g==
X-Gm-Message-State: AOAM530Q+MNM9DLko0jYolxZzuduTpWtNz9997jGOqQ+sHnEazVI6bnm
        zvY6ZR1MB8+YbE/zCj1o7f6P+NYR2Qo=
X-Google-Smtp-Source: ABdhPJyL6aX7Lt1i4l3smlVKB6koHTmKMdgPlJSJMXq0OU//3Jyer825gP/OCwNd8acwW6uP9/XtNA==
X-Received: by 2002:a05:651c:550:: with SMTP id q16mr18872400ljp.371.1636753432285;
        Fri, 12 Nov 2021 13:43:52 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id p18sm673079lfu.127.2021.11.12.13.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:43:51 -0800 (PST)
Date:   Sat, 13 Nov 2021 00:43:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] spi: dw: Convert to using the Bitfield access macros
Message-ID: <20211112214349.woiwnf7lpsn447mw@mobilestation>
References: <20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru>
 <20211112204927.8830-4-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VfEmjR1J92w=GgA2bJWj1DY35_eO3tCmVfT3fK+DK2ytA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfEmjR1J92w=GgA2bJWj1DY35_eO3tCmVfT3fK+DK2ytA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 12, 2021 at 11:23:54PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 12, 2021 at 10:51 PM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > The driver has been using the offset/bitwise-shift-based approach for the
> > CSR fields R/W operations since it was merged into the kernel. It can be
> > simplified by using the macros defined in the linux/bitfield.h and
> > linux/bit.h header files like BIT(), GENMASK(), FIELD_PREP(), FIELD_GET(),
> > etc where it is required, for instance in the cached cr0 preparation
> > method. Thus in order to have the FIELD_*()-macros utilized we just need
> > to convert the macros with the CSR-fields offsets to the masks with the
> > corresponding registers fields definition. That's where the GENMASK() and
> > BIT() macros come in handy. After that the masks can be used in the
> > FIELD_*()-macros where it's appropriate.
> >
> > We also need to convert the macros with the CRS-bit flags using the manual
> > bitwise shift operations (x << y) to using the BIT() macro. Thus we'll
> > have a more coherent set of the CSR-related macros.
> >
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/spi/spi-dw-core.c | 31 +++++++++++--------
> >  drivers/spi/spi-dw.h      | 64 +++++++++++++++++++--------------------
> >  2 files changed, 50 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > index 4d91ffb5c0d8..b4cbcd38eaba 100644
> > --- a/drivers/spi/spi-dw-core.c
> > +++ b/drivers/spi/spi-dw-core.c
> > @@ -5,6 +5,7 @@
> >   * Copyright (c) 2009, Intel Corporation.
> >   */
> >
> > +#include <linux/bitfield.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/module.h>
> > @@ -254,7 +255,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
> >  {
> >         struct spi_controller *master = dev_id;
> >         struct dw_spi *dws = spi_controller_get_devdata(master);
> > -       u16 irq_status = dw_readl(dws, DW_SPI_ISR) & 0x3f;
> > +       u16 irq_status = dw_readl(dws, DW_SPI_ISR) & DW_SPI_INT_MASK;
> >
> >         if (!irq_status)
> >                 return IRQ_NONE;
> > @@ -273,32 +274,38 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
> >
> >         if (!(dws->caps & DW_SPI_CAP_DWC_HSSI)) {
> >                 /* CTRLR0[ 5: 4] Frame Format */
> > -               cr0 |= DW_SPI_CTRLR0_FRF_MOTO_SPI << DW_PSSI_CTRLR0_FRF_OFFSET;
> > +               cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_FRF_MASK, DW_SPI_CTRLR0_FRF_MOTO_SPI);
> >
> >                 /*
> >                  * SPI mode (SCPOL|SCPH)
> >                  * CTRLR0[ 6] Serial Clock Phase
> >                  * CTRLR0[ 7] Serial Clock Polarity
> >                  */
> > -               cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DW_PSSI_CTRLR0_SCOL_OFFSET;
> > -               cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DW_PSSI_CTRLR0_SCPH_OFFSET;
> > +               if (spi->mode & SPI_CPOL)
> > +                       cr0 |= DW_PSSI_CTRLR0_SCPOL;
> > +               if (spi->mode & SPI_CPHA)
> > +                       cr0 |= DW_PSSI_CTRLR0_SCPHA;
> >
> >                 /* CTRLR0[11] Shift Register Loop */
> > -               cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DW_PSSI_CTRLR0_SRL_OFFSET;
> > +               if (spi->mode & SPI_LOOP)
> > +                       cr0 |= DW_PSSI_CTRLR0_SRL;
> >         } else {
> >                 /* CTRLR0[ 7: 6] Frame Format */
> > -               cr0 |= DW_SPI_CTRLR0_FRF_MOTO_SPI << DW_HSSI_CTRLR0_FRF_OFFSET;
> > +               cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_FRF_MASK, DW_SPI_CTRLR0_FRF_MOTO_SPI);
> >
> >                 /*
> >                  * SPI mode (SCPOL|SCPH)
> >                  * CTRLR0[ 8] Serial Clock Phase
> >                  * CTRLR0[ 9] Serial Clock Polarity
> >                  */
> > -               cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DW_HSSI_CTRLR0_SCPOL_OFFSET;
> > -               cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DW_HSSI_CTRLR0_SCPH_OFFSET;
> > +               if (spi->mode & SPI_CPOL)
> > +                       cr0 |= DW_HSSI_CTRLR0_SCPOL;
> > +               if (spi->mode & SPI_CPHA)
> > +                       cr0 |= DW_HSSI_CTRLR0_SCPHA;
> >
> >                 /* CTRLR0[13] Shift Register Loop */
> > -               cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DW_HSSI_CTRLR0_SRL_OFFSET;
> > +               if (spi->mode & SPI_LOOP)
> > +                       cr0 |= DW_HSSI_CTRLR0_SRL;
> >
> >                 if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> >                         cr0 |= DW_HSSI_CTRLR0_KEEMBAY_MST;
> > @@ -320,10 +327,10 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
> >
> >         if (!(dws->caps & DW_SPI_CAP_DWC_HSSI))
> >                 /* CTRLR0[ 9:8] Transfer Mode */
> > -               cr0 |= cfg->tmode << DW_PSSI_CTRLR0_TMOD_OFFSET;
> > +               cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_TMOD_MASK, cfg->tmode);
> >         else
> >                 /* CTRLR0[11:10] Transfer Mode */
> > -               cr0 |= cfg->tmode << DW_HSSI_CTRLR0_TMOD_OFFSET;
> > +               cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_TMOD_MASK, cfg->tmode);
> >
> >         dw_writel(dws, DW_SPI_CTRLR0, cr0);
> >
> > @@ -850,7 +857,7 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
> >
> >                 if (!(cr0 & DW_PSSI_CTRLR0_DFS_MASK)) {
> >                         dws->caps |= DW_SPI_CAP_DFS32;
> > -                       dws->dfs_offset = DW_PSSI_CTRLR0_DFS32_OFFSET;
> > +                       dws->dfs_offset = __bf_shf(DW_PSSI_CTRLR0_DFS32_MASK);
> >                         dev_dbg(dev, "Detected 32-bits max data frame size\n");
> >                 }
> >         } else {
> > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> > index 893b78c43a50..634085eadad1 100644
> > --- a/drivers/spi/spi-dw.h
> > +++ b/drivers/spi/spi-dw.h
> 

> Haven't deeply checked this, but below changes require to have bits.h
> to be included.
> Please, double check this is included already.

Checked. It's there. The bits.h file inclusion has been added
in commit cc760f3143f5 ("spi: dw: Convert CS-override to DW SPI
capabilities"). Thanks for pointing this out anyway.

-Sergey

> 
> > @@ -41,39 +41,36 @@
> >  #define DW_SPI_CS_OVERRIDE             0xf4
> >
> >  /* Bit fields in CTRLR0 (DWC APB SSI) */
> > -#define DW_PSSI_CTRLR0_DFS_OFFSET              0
> >  #define DW_PSSI_CTRLR0_DFS_MASK                        GENMASK(3, 0)
> > -#define DW_PSSI_CTRLR0_DFS32_OFFSET            16
> > +#define DW_PSSI_CTRLR0_DFS32_MASK              GENMASK(20, 16)
> >
> > -#define DW_PSSI_CTRLR0_FRF_OFFSET              4
> > +#define DW_PSSI_CTRLR0_FRF_MASK                        GENMASK(5, 4)
> >  #define DW_SPI_CTRLR0_FRF_MOTO_SPI             0x0
> >  #define DW_SPI_CTRLR0_FRF_TI_SSP               0x1
> >  #define DW_SPI_CTRLR0_FRF_NS_MICROWIRE         0x2
> >  #define DW_SPI_CTRLR0_FRF_RESV                 0x3
> >
> > -#define DW_PSSI_CTRLR0_MODE_OFFSET             6
> > -#define DW_PSSI_CTRLR0_SCPH_OFFSET             6
> > -#define DW_PSSI_CTRLR0_SCOL_OFFSET             7
> > +#define DW_PSSI_CTRLR0_MODE_MASK               GENMASK(7, 6)
> > +#define DW_PSSI_CTRLR0_SCPHA                   BIT(6)
> > +#define DW_PSSI_CTRLR0_SCPOL                   BIT(7)
> >
> > -#define DW_PSSI_CTRLR0_TMOD_OFFSET             8
> > -#define DW_PSSI_CTRLR0_TMOD_MASK               (0x3 << DW_PSSI_CTRLR0_TMOD_OFFSET)
> > +#define DW_PSSI_CTRLR0_TMOD_MASK               GENMASK(9, 8)
> >  #define DW_SPI_CTRLR0_TMOD_TR                  0x0     /* xmit & recv */
> >  #define DW_SPI_CTRLR0_TMOD_TO                  0x1     /* xmit only */
> >  #define DW_SPI_CTRLR0_TMOD_RO                  0x2     /* recv only */
> >  #define DW_SPI_CTRLR0_TMOD_EPROMREAD           0x3     /* eeprom read mode */
> >
> > -#define DW_PSSI_CTRLR0_SLVOE_OFFSET            10
> > -#define DW_PSSI_CTRLR0_SRL_OFFSET              11
> > -#define DW_PSSI_CTRLR0_CFS_OFFSET              12
> > +#define DW_PSSI_CTRLR0_SLV_OE                  BIT(10)
> > +#define DW_PSSI_CTRLR0_SRL                     BIT(11)
> > +#define DW_PSSI_CTRLR0_CFS                     BIT(12)
> >
> >  /* Bit fields in CTRLR0 (DWC SSI with AHB interface) */
> > -#define DW_HSSI_CTRLR0_SRL_OFFSET              13
> > -#define DW_HSSI_CTRLR0_TMOD_OFFSET             10
> > +#define DW_HSSI_CTRLR0_DFS_MASK                        GENMASK(4, 0)
> > +#define DW_HSSI_CTRLR0_FRF_MASK                        GENMASK(7, 6)
> > +#define DW_HSSI_CTRLR0_SCPHA                   BIT(8)
> > +#define DW_HSSI_CTRLR0_SCPOL                   BIT(9)
> >  #define DW_HSSI_CTRLR0_TMOD_MASK               GENMASK(11, 10)
> > -#define DW_HSSI_CTRLR0_SCPOL_OFFSET            9
> > -#define DW_HSSI_CTRLR0_SCPH_OFFSET             8
> > -#define DW_HSSI_CTRLR0_FRF_OFFSET              6
> > -#define DW_HSSI_CTRLR0_DFS_OFFSET              0
> > +#define DW_HSSI_CTRLR0_SRL                     BIT(13)
> >
> >  /*
> >   * For Keem Bay, CTRLR0[31] is used to select controller mode.
> > @@ -86,26 +83,27 @@
> >  #define DW_SPI_NDF_MASK                                GENMASK(15, 0)
> >
> >  /* Bit fields in SR, 7 bits */
> > -#define DW_SPI_SR_MASK                         0x7f    /* cover 7 bits */
> > -#define DW_SPI_SR_BUSY                         (1 << 0)
> > -#define DW_SPI_SR_TF_NOT_FULL                  (1 << 1)
> > -#define DW_SPI_SR_TF_EMPT                      (1 << 2)
> > -#define DW_SPI_SR_RF_NOT_EMPT                  (1 << 3)
> > -#define DW_SPI_SR_RF_FULL                      (1 << 4)
> > -#define DW_SPI_SR_TX_ERR                       (1 << 5)
> > -#define DW_SPI_SR_DCOL                         (1 << 6)
> > +#define DW_SPI_SR_MASK                         GENMASK(6, 0)
> > +#define DW_SPI_SR_BUSY                         BIT(0)
> > +#define DW_SPI_SR_TF_NOT_FULL                  BIT(1)
> > +#define DW_SPI_SR_TF_EMPT                      BIT(2)
> > +#define DW_SPI_SR_RF_NOT_EMPT                  BIT(3)
> > +#define DW_SPI_SR_RF_FULL                      BIT(4)
> > +#define DW_SPI_SR_TX_ERR                       BIT(5)
> > +#define DW_SPI_SR_DCOL                         BIT(6)
> >
> >  /* Bit fields in ISR, IMR, RISR, 7 bits */
> > -#define DW_SPI_INT_TXEI                                (1 << 0)
> > -#define DW_SPI_INT_TXOI                                (1 << 1)
> > -#define DW_SPI_INT_RXUI                                (1 << 2)
> > -#define DW_SPI_INT_RXOI                                (1 << 3)
> > -#define DW_SPI_INT_RXFI                                (1 << 4)
> > -#define DW_SPI_INT_MSTI                                (1 << 5)
> > +#define DW_SPI_INT_MASK                                GENMASK(5, 0)
> > +#define DW_SPI_INT_TXEI                                BIT(0)
> > +#define DW_SPI_INT_TXOI                                BIT(1)
> > +#define DW_SPI_INT_RXUI                                BIT(2)
> > +#define DW_SPI_INT_RXOI                                BIT(3)
> > +#define DW_SPI_INT_RXFI                                BIT(4)
> > +#define DW_SPI_INT_MSTI                                BIT(5)
> >
> >  /* Bit fields in DMACR */
> > -#define DW_SPI_DMACR_RDMAE                     (1 << 0)
> > -#define DW_SPI_DMACR_TDMAE                     (1 << 1)
> > +#define DW_SPI_DMACR_RDMAE                     BIT(0)
> > +#define DW_SPI_DMACR_TDMAE                     BIT(1)
> >
> >  /* Mem/DMA operations helpers */
> >  #define DW_SPI_WAIT_RETRIES                    5
> > --
> > 2.33.0
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
