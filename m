Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD2E44D878
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 15:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhKKOph (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 09:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhKKOpg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Nov 2021 09:45:36 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DF5C061766;
        Thu, 11 Nov 2021 06:42:46 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id k2so4869315lji.4;
        Thu, 11 Nov 2021 06:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qhkGC9vs+8mYqWAc/dPeeYNcQUYIT811ZL6Z1XhKGYo=;
        b=c8xWz4NHfAPgjgi2BVEhU5gMof1yx4VeIE8Wv57iMbxnMxsV7SHOnEj/ruRhZ/HEEb
         6xkgwY2UTFZ/JXR882wpyXq1J7tqVZDis2ITf5Ezm8PzMQV5fFkIl2tCRiLySjYtbAns
         ilp5xiDL8fARog9DfUcgV87p1tiz/LKqVqwVAVqcNXSjQKbsSsXwoWK+ZDfqT1qlwrB3
         hkJhGti8TotgUZOEKmaKOQJOExglC9m7XZ0W57MWjbuqYAU+JaM01oUKZ2VgH9Vs6eWw
         Ilq+C78xuSNvhvyIThysIfuBhQnJIpHk5dV+jfvlny2uFtSMU9UaMys3+hhzGM8kffIs
         gO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qhkGC9vs+8mYqWAc/dPeeYNcQUYIT811ZL6Z1XhKGYo=;
        b=ruaMlbv2l+fUSAWoRkx/LLctbmbWJqSp5yN1FKJIr6MD9Ui9vko1VN9i9W09vppNkv
         W/15f0RgzzmGa0XDvns30B8JeP8CB4Fkempo4pe4wiLGl7Kk/CUzTRV0XpAiCQVZckDS
         HKXB45/+kPfN/NxS2ybaPCp2GgNbReifSr5E0GABFC/jhqlHcdyUqzbJM2NzEg/j13mR
         N6hrrrsLWLqBk4yTjmoXymvGUg/BR9oZsOv+2xAsiNusft4UcANGyxTNNEZZdgKMMmG8
         j+YaTaM700WqjEgx3L91DPsCOnZnipYPsETUrIv6OVD5t9WtTNOGywT8LHSOu5RvY9tZ
         RlKQ==
X-Gm-Message-State: AOAM5309dpeKP0Np70kziYKm9pY3O5JdVxFg9mwzmQtBrJTlyBiByyWt
        SXgBibhfnwpvArk4Xwy9C7Y=
X-Google-Smtp-Source: ABdhPJzBpTrPjYJKy4Mj6D38F5gugRbf42XlOEdoGKheJxH3UqPDdtnu2MsjpEClCBLvFvXomDSd0w==
X-Received: by 2002:a2e:8744:: with SMTP id q4mr2662604ljj.277.1636641765087;
        Thu, 11 Nov 2021 06:42:45 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id y1sm301343lfd.204.2021.11.11.06.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 06:42:44 -0800 (PST)
Date:   Thu, 11 Nov 2021 17:42:42 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v3 2/5] spi: dw: Add SSTE support for DWC SSI controller
Message-ID: <20211111144242.af3h5r4ayufcelsz@mobilestation>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-3-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111065201.10249-3-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 11, 2021 at 02:51:58PM +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Add support for Slave Select Toggle Enable (SSTE) in DWC SSI controller
> via DTS. The slave select line will toggle between consecutive data frames,
> with the serial clock being held to its default value while slave
> select line is high.
> 
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> ---
>  drivers/spi/spi-dw-core.c | 11 +++++++++++
>  drivers/spi/spi-dw.h      |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index a305074c482e..bfa075a4f779 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -27,6 +27,7 @@
>  struct chip_data {
>  	u32 cr0;
>  	u32 rx_sample_dly;	/* RX sample delay */

> +	bool sste;		/* Slave select Toggle flag */

As Mark said there is no need in the new DT-property thus there is no
need in the sste flag being preserved in the chip-data structure
seeing there is a dedicated flag has been defined for this mode.

>  };
>  
>  #ifdef CONFIG_DEBUG_FS
> @@ -269,6 +270,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>  
>  static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
>  {
> +	struct chip_data *chip = spi_get_ctldata(spi);
>  	u32 cr0 = 0;
>  
>  	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
> @@ -285,6 +287,9 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
>  
>  		/* CTRLR0[11] Shift Register Loop */
>  		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET;

> +
> +		/* CTRLR0[24] Slave Select Toggle Enable */
> +		cr0 |= chip->sste << SPI_SSTE_OFFSET;

Just check for the SPI_CS_WORD flag state here directly. Like this:
+ cr0 |= ((spi->mode & SPI_CS_WORD) ? 1 : 0) << SPI_SSTE_OFFSET;

>  	} else {
>  		/* CTRLR0[ 7: 6] Frame Format */
>  		cr0 |= SSI_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET;
> @@ -300,6 +305,9 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
>  		/* CTRLR0[13] Shift Register Loop */
>  		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DWC_SSI_CTRLR0_SRL_OFFSET;
>  

> +		/* CTRLR0[14] Slave Select Toggle Enable */
> +		cr0 |= chip->sste << DWC_SSI_CTRLR0_SSTE_OFFSET;
> +

the same as above.

>  		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
>  			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
>  	}
> @@ -789,6 +797,9 @@ static int dw_spi_setup(struct spi_device *spi)
>  		chip->rx_sample_dly = DIV_ROUND_CLOSEST(rx_sample_dly_ns,
>  							NSEC_PER_SEC /
>  							dws->max_freq);

> +
> +		/* Get slave select toggling feature requirement */
> +		chip->sste = device_property_read_bool(&spi->dev, "snps,sste");

As Mark said there is no need in this new DT-property.

-Sergey

>  	}
>  
>  	/*
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index b665e040862c..2ee3f839de39 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -65,8 +65,10 @@
>  #define SPI_SLVOE_OFFSET		10
>  #define SPI_SRL_OFFSET			11
>  #define SPI_CFS_OFFSET			12
> +#define SPI_SSTE_OFFSET			24
>  
>  /* Bit fields in CTRLR0 based on DWC_ssi_databook.pdf v1.01a */
> +#define DWC_SSI_CTRLR0_SSTE_OFFSET	14
>  #define DWC_SSI_CTRLR0_SRL_OFFSET	13
>  #define DWC_SSI_CTRLR0_TMOD_OFFSET	10
>  #define DWC_SSI_CTRLR0_TMOD_MASK	GENMASK(11, 10)
> -- 
> 2.17.1
> 
