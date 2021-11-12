Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7694844EE85
	for <lists+linux-spi@lfdr.de>; Fri, 12 Nov 2021 22:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbhKLV1b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Nov 2021 16:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbhKLV1a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Nov 2021 16:27:30 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F875C061766;
        Fri, 12 Nov 2021 13:24:39 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o8so42774880edc.3;
        Fri, 12 Nov 2021 13:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wbah8by0dDebSIbBvPNVod7KUQ7vB76R3o3yFUA01YM=;
        b=oFBHfWQHzZKt9DeR92EwVMFVsc9yuL0K9KN7oEHwLCLEeD1ZbGJ5J3W/wzhVgadoRU
         lzXj9et78Aa3QUxXpbRNewa97VcmZTqovmnssITQz5TgKv20SZqSlgpHcjfJE+DvfkCP
         j7XADbY6Qpa8BU7+7Eo2XFLwC1V0brA375mAakc/xxa63p/1SJHZbWMoJRfV1e8gkkqn
         YZTzAq6RrapPvkFvnK9ZTQizsM0kmrJNA0TtLp85Fs+ODJCj5DhMSQHTE1BM55XaDElr
         exH4A9O8qvppMyyCvKlF74z5mbxM7GxkHzTovCXUmWJLmrLYxrFbubRiVSrG3uLmUMR/
         VORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wbah8by0dDebSIbBvPNVod7KUQ7vB76R3o3yFUA01YM=;
        b=2IMdns+wd71IIVwDWHVFvcKFclveAN/4FLYxaNYsPRd6mHWX35a4pNHAvl/BS+G5nP
         hd/quHn/nF/yc0a4KgAnlKaYh9fF0yO9wu/p2tWx9paoxwADlAN3ZfKHiPag7g7ZVOHI
         jGZVw8zKo4VtxguVSUxTkw4+B6K3RvIYTXshjt7r+7ry0H+Gkavs2dtmBLgORUDE0f/U
         5hs8LP8F1CgEs1AaWzatucyS9amoLJ6Thp045xS5EhRzJ2rO2SCHi19OEWV4gM9pBa+W
         wgmR9H7cvrbJvFLXDRclCD2xjtC2EODDjyIGqVk4VGHooLT8/gkdFU4xcxf+QDnRVCLx
         OiqA==
X-Gm-Message-State: AOAM530pQS2+ni50NFOLJtknNFujiJBOU8R3YhfsSK5CftP2tNaovfoi
        X7R1lfWgO26V8j2Ezfkm0ove7FzAGCwhMtrH1DM=
X-Google-Smtp-Source: ABdhPJwmh649IJPLC/KE2YV9o4G8lv8I5VVOZ0uf78hRST/JRIDLk7781RVxc1IcI+WeYSU9ALlix69vHdo/9TYRaXc=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr22346452ejq.567.1636752277886;
 Fri, 12 Nov 2021 13:24:37 -0800 (PST)
MIME-Version: 1.0
References: <20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru> <20211112204927.8830-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20211112204927.8830-4-Sergey.Semin@baikalelectronics.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 12 Nov 2021 23:23:54 +0200
Message-ID: <CAHp75VfEmjR1J92w=GgA2bJWj1DY35_eO3tCmVfT3fK+DK2ytA@mail.gmail.com>
Subject: Re: [PATCH 3/4] spi: dw: Convert to using the Bitfield access macros
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 12, 2021 at 10:51 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> The driver has been using the offset/bitwise-shift-based approach for the
> CSR fields R/W operations since it was merged into the kernel. It can be
> simplified by using the macros defined in the linux/bitfield.h and
> linux/bit.h header files like BIT(), GENMASK(), FIELD_PREP(), FIELD_GET(),
> etc where it is required, for instance in the cached cr0 preparation
> method. Thus in order to have the FIELD_*()-macros utilized we just need
> to convert the macros with the CSR-fields offsets to the masks with the
> corresponding registers fields definition. That's where the GENMASK() and
> BIT() macros come in handy. After that the masks can be used in the
> FIELD_*()-macros where it's appropriate.
>
> We also need to convert the macros with the CRS-bit flags using the manual
> bitwise shift operations (x << y) to using the BIT() macro. Thus we'll
> have a more coherent set of the CSR-related macros.
>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/spi/spi-dw-core.c | 31 +++++++++++--------
>  drivers/spi/spi-dw.h      | 64 +++++++++++++++++++--------------------
>  2 files changed, 50 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 4d91ffb5c0d8..b4cbcd38eaba 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2009, Intel Corporation.
>   */
>
> +#include <linux/bitfield.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> @@ -254,7 +255,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>  {
>         struct spi_controller *master = dev_id;
>         struct dw_spi *dws = spi_controller_get_devdata(master);
> -       u16 irq_status = dw_readl(dws, DW_SPI_ISR) & 0x3f;
> +       u16 irq_status = dw_readl(dws, DW_SPI_ISR) & DW_SPI_INT_MASK;
>
>         if (!irq_status)
>                 return IRQ_NONE;
> @@ -273,32 +274,38 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
>
>         if (!(dws->caps & DW_SPI_CAP_DWC_HSSI)) {
>                 /* CTRLR0[ 5: 4] Frame Format */
> -               cr0 |= DW_SPI_CTRLR0_FRF_MOTO_SPI << DW_PSSI_CTRLR0_FRF_OFFSET;
> +               cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_FRF_MASK, DW_SPI_CTRLR0_FRF_MOTO_SPI);
>
>                 /*
>                  * SPI mode (SCPOL|SCPH)
>                  * CTRLR0[ 6] Serial Clock Phase
>                  * CTRLR0[ 7] Serial Clock Polarity
>                  */
> -               cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DW_PSSI_CTRLR0_SCOL_OFFSET;
> -               cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DW_PSSI_CTRLR0_SCPH_OFFSET;
> +               if (spi->mode & SPI_CPOL)
> +                       cr0 |= DW_PSSI_CTRLR0_SCPOL;
> +               if (spi->mode & SPI_CPHA)
> +                       cr0 |= DW_PSSI_CTRLR0_SCPHA;
>
>                 /* CTRLR0[11] Shift Register Loop */
> -               cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DW_PSSI_CTRLR0_SRL_OFFSET;
> +               if (spi->mode & SPI_LOOP)
> +                       cr0 |= DW_PSSI_CTRLR0_SRL;
>         } else {
>                 /* CTRLR0[ 7: 6] Frame Format */
> -               cr0 |= DW_SPI_CTRLR0_FRF_MOTO_SPI << DW_HSSI_CTRLR0_FRF_OFFSET;
> +               cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_FRF_MASK, DW_SPI_CTRLR0_FRF_MOTO_SPI);
>
>                 /*
>                  * SPI mode (SCPOL|SCPH)
>                  * CTRLR0[ 8] Serial Clock Phase
>                  * CTRLR0[ 9] Serial Clock Polarity
>                  */
> -               cr0 |= ((spi->mode & SPI_CPOL) ? 1 : 0) << DW_HSSI_CTRLR0_SCPOL_OFFSET;
> -               cr0 |= ((spi->mode & SPI_CPHA) ? 1 : 0) << DW_HSSI_CTRLR0_SCPH_OFFSET;
> +               if (spi->mode & SPI_CPOL)
> +                       cr0 |= DW_HSSI_CTRLR0_SCPOL;
> +               if (spi->mode & SPI_CPHA)
> +                       cr0 |= DW_HSSI_CTRLR0_SCPHA;
>
>                 /* CTRLR0[13] Shift Register Loop */
> -               cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DW_HSSI_CTRLR0_SRL_OFFSET;
> +               if (spi->mode & SPI_LOOP)
> +                       cr0 |= DW_HSSI_CTRLR0_SRL;
>
>                 if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
>                         cr0 |= DW_HSSI_CTRLR0_KEEMBAY_MST;
> @@ -320,10 +327,10 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
>
>         if (!(dws->caps & DW_SPI_CAP_DWC_HSSI))
>                 /* CTRLR0[ 9:8] Transfer Mode */
> -               cr0 |= cfg->tmode << DW_PSSI_CTRLR0_TMOD_OFFSET;
> +               cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_TMOD_MASK, cfg->tmode);
>         else
>                 /* CTRLR0[11:10] Transfer Mode */
> -               cr0 |= cfg->tmode << DW_HSSI_CTRLR0_TMOD_OFFSET;
> +               cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_TMOD_MASK, cfg->tmode);
>
>         dw_writel(dws, DW_SPI_CTRLR0, cr0);
>
> @@ -850,7 +857,7 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
>
>                 if (!(cr0 & DW_PSSI_CTRLR0_DFS_MASK)) {
>                         dws->caps |= DW_SPI_CAP_DFS32;
> -                       dws->dfs_offset = DW_PSSI_CTRLR0_DFS32_OFFSET;
> +                       dws->dfs_offset = __bf_shf(DW_PSSI_CTRLR0_DFS32_MASK);
>                         dev_dbg(dev, "Detected 32-bits max data frame size\n");
>                 }
>         } else {
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 893b78c43a50..634085eadad1 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h

Haven't deeply checked this, but below changes require to have bits.h
to be included.
Please, double check this is included already.

> @@ -41,39 +41,36 @@
>  #define DW_SPI_CS_OVERRIDE             0xf4
>
>  /* Bit fields in CTRLR0 (DWC APB SSI) */
> -#define DW_PSSI_CTRLR0_DFS_OFFSET              0
>  #define DW_PSSI_CTRLR0_DFS_MASK                        GENMASK(3, 0)
> -#define DW_PSSI_CTRLR0_DFS32_OFFSET            16
> +#define DW_PSSI_CTRLR0_DFS32_MASK              GENMASK(20, 16)
>
> -#define DW_PSSI_CTRLR0_FRF_OFFSET              4
> +#define DW_PSSI_CTRLR0_FRF_MASK                        GENMASK(5, 4)
>  #define DW_SPI_CTRLR0_FRF_MOTO_SPI             0x0
>  #define DW_SPI_CTRLR0_FRF_TI_SSP               0x1
>  #define DW_SPI_CTRLR0_FRF_NS_MICROWIRE         0x2
>  #define DW_SPI_CTRLR0_FRF_RESV                 0x3
>
> -#define DW_PSSI_CTRLR0_MODE_OFFSET             6
> -#define DW_PSSI_CTRLR0_SCPH_OFFSET             6
> -#define DW_PSSI_CTRLR0_SCOL_OFFSET             7
> +#define DW_PSSI_CTRLR0_MODE_MASK               GENMASK(7, 6)
> +#define DW_PSSI_CTRLR0_SCPHA                   BIT(6)
> +#define DW_PSSI_CTRLR0_SCPOL                   BIT(7)
>
> -#define DW_PSSI_CTRLR0_TMOD_OFFSET             8
> -#define DW_PSSI_CTRLR0_TMOD_MASK               (0x3 << DW_PSSI_CTRLR0_TMOD_OFFSET)
> +#define DW_PSSI_CTRLR0_TMOD_MASK               GENMASK(9, 8)
>  #define DW_SPI_CTRLR0_TMOD_TR                  0x0     /* xmit & recv */
>  #define DW_SPI_CTRLR0_TMOD_TO                  0x1     /* xmit only */
>  #define DW_SPI_CTRLR0_TMOD_RO                  0x2     /* recv only */
>  #define DW_SPI_CTRLR0_TMOD_EPROMREAD           0x3     /* eeprom read mode */
>
> -#define DW_PSSI_CTRLR0_SLVOE_OFFSET            10
> -#define DW_PSSI_CTRLR0_SRL_OFFSET              11
> -#define DW_PSSI_CTRLR0_CFS_OFFSET              12
> +#define DW_PSSI_CTRLR0_SLV_OE                  BIT(10)
> +#define DW_PSSI_CTRLR0_SRL                     BIT(11)
> +#define DW_PSSI_CTRLR0_CFS                     BIT(12)
>
>  /* Bit fields in CTRLR0 (DWC SSI with AHB interface) */
> -#define DW_HSSI_CTRLR0_SRL_OFFSET              13
> -#define DW_HSSI_CTRLR0_TMOD_OFFSET             10
> +#define DW_HSSI_CTRLR0_DFS_MASK                        GENMASK(4, 0)
> +#define DW_HSSI_CTRLR0_FRF_MASK                        GENMASK(7, 6)
> +#define DW_HSSI_CTRLR0_SCPHA                   BIT(8)
> +#define DW_HSSI_CTRLR0_SCPOL                   BIT(9)
>  #define DW_HSSI_CTRLR0_TMOD_MASK               GENMASK(11, 10)
> -#define DW_HSSI_CTRLR0_SCPOL_OFFSET            9
> -#define DW_HSSI_CTRLR0_SCPH_OFFSET             8
> -#define DW_HSSI_CTRLR0_FRF_OFFSET              6
> -#define DW_HSSI_CTRLR0_DFS_OFFSET              0
> +#define DW_HSSI_CTRLR0_SRL                     BIT(13)
>
>  /*
>   * For Keem Bay, CTRLR0[31] is used to select controller mode.
> @@ -86,26 +83,27 @@
>  #define DW_SPI_NDF_MASK                                GENMASK(15, 0)
>
>  /* Bit fields in SR, 7 bits */
> -#define DW_SPI_SR_MASK                         0x7f    /* cover 7 bits */
> -#define DW_SPI_SR_BUSY                         (1 << 0)
> -#define DW_SPI_SR_TF_NOT_FULL                  (1 << 1)
> -#define DW_SPI_SR_TF_EMPT                      (1 << 2)
> -#define DW_SPI_SR_RF_NOT_EMPT                  (1 << 3)
> -#define DW_SPI_SR_RF_FULL                      (1 << 4)
> -#define DW_SPI_SR_TX_ERR                       (1 << 5)
> -#define DW_SPI_SR_DCOL                         (1 << 6)
> +#define DW_SPI_SR_MASK                         GENMASK(6, 0)
> +#define DW_SPI_SR_BUSY                         BIT(0)
> +#define DW_SPI_SR_TF_NOT_FULL                  BIT(1)
> +#define DW_SPI_SR_TF_EMPT                      BIT(2)
> +#define DW_SPI_SR_RF_NOT_EMPT                  BIT(3)
> +#define DW_SPI_SR_RF_FULL                      BIT(4)
> +#define DW_SPI_SR_TX_ERR                       BIT(5)
> +#define DW_SPI_SR_DCOL                         BIT(6)
>
>  /* Bit fields in ISR, IMR, RISR, 7 bits */
> -#define DW_SPI_INT_TXEI                                (1 << 0)
> -#define DW_SPI_INT_TXOI                                (1 << 1)
> -#define DW_SPI_INT_RXUI                                (1 << 2)
> -#define DW_SPI_INT_RXOI                                (1 << 3)
> -#define DW_SPI_INT_RXFI                                (1 << 4)
> -#define DW_SPI_INT_MSTI                                (1 << 5)
> +#define DW_SPI_INT_MASK                                GENMASK(5, 0)
> +#define DW_SPI_INT_TXEI                                BIT(0)
> +#define DW_SPI_INT_TXOI                                BIT(1)
> +#define DW_SPI_INT_RXUI                                BIT(2)
> +#define DW_SPI_INT_RXOI                                BIT(3)
> +#define DW_SPI_INT_RXFI                                BIT(4)
> +#define DW_SPI_INT_MSTI                                BIT(5)
>
>  /* Bit fields in DMACR */
> -#define DW_SPI_DMACR_RDMAE                     (1 << 0)
> -#define DW_SPI_DMACR_TDMAE                     (1 << 1)
> +#define DW_SPI_DMACR_RDMAE                     BIT(0)
> +#define DW_SPI_DMACR_TDMAE                     BIT(1)
>
>  /* Mem/DMA operations helpers */
>  #define DW_SPI_WAIT_RETRIES                    5
> --
> 2.33.0
>


-- 
With Best Regards,
Andy Shevchenko
