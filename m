Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A40C1E1E95
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 11:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgEZJbp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 05:31:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50298 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbgEZJbp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 May 2020 05:31:45 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04Q9VOEb096081;
        Tue, 26 May 2020 04:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590485484;
        bh=jD7sXlwKitwGx0YhJeaqEQlLnyjhXpd8mxOdk7QooZY=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=GUDC0wrP0Ch5wK7qYXrkHjfCuwrjhH7Tc4woRZ0YGuBScfA9Bpv4xBUWTexJdnfV3
         jwosfFsjV/yLgrlIx87iIbjPaOPwZ1W7AelQeN8QuhO01ssHvZ7Yx43DWeHlLLZSlU
         c4p13kIklbbKQQMbejyk0Ls75gMfIAeKg3A11SkQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04Q9VOqX038751;
        Tue, 26 May 2020 04:31:24 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 26
 May 2020 04:31:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 26 May 2020 04:31:24 -0500
Received: from [10.250.234.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04Q9VJ4V008663;
        Tue, 26 May 2020 04:31:20 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/6] mtd: spi-nor: cadence-quadspi: Drop
 cdns,is-decoded-cs property
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "simon.k.r.goldschmidt@gmail.com" <simon.k.r.goldschmidt@gmail.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "marex@denx.de" <marex@denx.de>
References: <20200508185411.487-1-vigneshr@ti.com>
 <20200508185411.487-2-vigneshr@ti.com>
Message-ID: <7ea8e0fd-9709-42b1-66d5-8976b73dd82a@ti.com>
Date:   Tue, 26 May 2020 15:01:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508185411.487-2-vigneshr@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 09/05/20 12:24 am, Vignesh Raghavendra wrote:
> Cadence QSPI provides a way to automatically decode CS based on the
> offset accessed within memory map window. This feature cannot be
> supported in spi-mem framework as controller driver would not have
> access to flash geometry. Therefore drop this feature in preparation to
> moving to spi-mem.
> 
> Note that, this feature never worked in the driver (Direct/Indirect mode
> accesses did not take into account size of flash on other CSs) and there
> are no users of this feature in kernel. Therefore dropping this should
> not cause a regression
> 

I realized cdns,is-decoded-cs property does not depend on
cqspi_configure_cs_and_sizes() and can still be supported w/o knowing
flash geometry... Will respin.. 

Regards
Vignesh

> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../mtd/spi-nor/controllers/cadence-quadspi.c | 59 +++----------------
>  1 file changed, 9 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
> index 494dcab4aaaa..fa54f85e16d7 100644
> --- a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
> @@ -77,11 +77,7 @@ struct cqspi_st {
>        dma_addr_t              mmap_phys_base;
>  
>        int                     current_cs;
> -     int                     current_page_size;
> -     int                     current_erase_size;
> -     int                     current_addr_width;
>        unsigned long           master_ref_clk_hz;
> -     bool                    is_decoded_cs;
>        u32                     fifo_depth;
>        u32                     fifo_width;
>        bool                    rclk_en;
> @@ -715,19 +711,15 @@ static void cqspi_chipselect(struct spi_nor *nor)
>        unsigned int reg;
>  
>        reg = readl(reg_base + CQSPI_REG_CONFIG);
> -     if (cqspi->is_decoded_cs) {
> -             reg |= CQSPI_REG_CONFIG_DECODE_MASK;
> -     } else {
> -             reg &= ~CQSPI_REG_CONFIG_DECODE_MASK;
> +     reg &= ~CQSPI_REG_CONFIG_DECODE_MASK;
>  
> -             /* Convert CS if without decoder.
> -              * CS0 to 4b'1110
> -              * CS1 to 4b'1101
> -              * CS2 to 4b'1011
> -              * CS3 to 4b'0111
> -              */
> -             chip_select = 0xF & ~(1 << chip_select);
> -     }
> +     /* Convert CS if without decoder.
> +      * CS0 to 4b'1110
> +      * CS1 to 4b'1101
> +      * CS2 to 4b'1011
> +      * CS3 to 4b'0111
> +      */
> +     chip_select = 0xF & ~(1 << chip_select);
>  
>        reg &= ~(CQSPI_REG_CONFIG_CHIPSELECT_MASK
>                 << CQSPI_REG_CONFIG_CHIPSELECT_LSB);
> @@ -736,32 +728,6 @@ static void cqspi_chipselect(struct spi_nor *nor)
>        writel(reg, reg_base + CQSPI_REG_CONFIG);
>  }
>  
> -static void cqspi_configure_cs_and_sizes(struct spi_nor *nor)
> -{
> -     struct cqspi_flash_pdata *f_pdata = nor->priv;
> -     struct cqspi_st *cqspi = f_pdata->cqspi;
> -     void __iomem *iobase = cqspi->iobase;
> -     unsigned int reg;
> -
> -     /* configure page size and block size. */
> -     reg = readl(iobase + CQSPI_REG_SIZE);
> -     reg &= ~(CQSPI_REG_SIZE_PAGE_MASK << CQSPI_REG_SIZE_PAGE_LSB);
> -     reg &= ~(CQSPI_REG_SIZE_BLOCK_MASK << CQSPI_REG_SIZE_BLOCK_LSB);
> -     reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
> -     reg |= (nor->page_size << CQSPI_REG_SIZE_PAGE_LSB);
> -     reg |= (ilog2(nor->mtd.erasesize) << CQSPI_REG_SIZE_BLOCK_LSB);
> -     reg |= (nor->addr_width - 1);
> -     writel(reg, iobase + CQSPI_REG_SIZE);
> -
> -     /* configure the chip select */
> -     cqspi_chipselect(nor);
> -
> -     /* Store the new configuration of the controller */
> -     cqspi->current_page_size = nor->page_size;
> -     cqspi->current_erase_size = nor->mtd.erasesize;
> -     cqspi->current_addr_width = nor->addr_width;
> -}
> -
>  static unsigned int calculate_ticks_for_ns(const unsigned int ref_clk_hz,
>                                           const unsigned int ns_val)
>  {
> @@ -867,18 +833,13 @@ static void cqspi_configure(struct spi_nor *nor)
>        int switch_cs = (cqspi->current_cs != f_pdata->cs);
>        int switch_ck = (cqspi->sclk != sclk);
>  
> -     if ((cqspi->current_page_size != nor->page_size) ||
> -         (cqspi->current_erase_size != nor->mtd.erasesize) ||
> -         (cqspi->current_addr_width != nor->addr_width))
> -             switch_cs = 1;
> -
>        if (switch_cs || switch_ck)
>                cqspi_controller_enable(cqspi, 0);
>  
>        /* Switch chip select. */
>        if (switch_cs) {
>                cqspi->current_cs = f_pdata->cs;
> -             cqspi_configure_cs_and_sizes(nor);
> +             cqspi_chipselect(nor);
>        }
>  
>        /* Setup baudrate divisor and delays */
> @@ -1145,8 +1106,6 @@ static int cqspi_of_get_pdata(struct platform_device *pdev)
>        struct device_node *np = pdev->dev.of_node;
>        struct cqspi_st *cqspi = platform_get_drvdata(pdev);
>  
> -     cqspi->is_decoded_cs = of_property_read_bool(np, "cdns,is-decoded-cs");
> -
>        if (of_property_read_u32(np, "cdns,fifo-depth", &cqspi->fifo_depth)) {
>                dev_err(&pdev->dev, "couldn't determine fifo-depth\n");
>                return -ENXIO;
> 
