Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D45940103E
	for <lists+linux-spi@lfdr.de>; Sun,  5 Sep 2021 16:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhIEOfE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 5 Sep 2021 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhIEOfE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 5 Sep 2021 10:35:04 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD127C061575;
        Sun,  5 Sep 2021 07:34:00 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s3so6687307ljp.11;
        Sun, 05 Sep 2021 07:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OwVOUJbbA5zybi3WVA5c4Z02aO6YtO65rBi8AS4nRto=;
        b=HMZdJtlNUiBNQ7q+PF9zxyfvBWOHkKZxTVcYdiVBG+Pb+gN+LcEs0dlpZdF2Yj4Bid
         FGqWwBJJ/f/rVhxUf5pr9c3pc39M1kvX1xOGIUOGCP5dlbwZdg6HvRrUiLeyqcCNvOYX
         NakcbHHwAgXDIK+vuTMyPFkjY2lpm1e1is2SJTnSXjPP/ftJsXv2TXoXuMn/P4670TWk
         oKDb0XT5GrB2zRJENAKuLk4jROxhCb8pgUOZ8CQRQbPpYFnVVAWZH/TT77R+eNEvEP0o
         LigNzQvxWRQr+aSpMur5Bh+Qq6RqRPHDgqGSsX+ylBiCGx/J0uqboucL5TWzM0fbnUQb
         BImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OwVOUJbbA5zybi3WVA5c4Z02aO6YtO65rBi8AS4nRto=;
        b=R7E6nUSFYTtNLvUKZF2J4Qswx6bp0xrhgC4F9vfxrCz2Hgzjpil4VA+IoXH82kwYEc
         Gu+jDKpHeVO2EB4wOwhc80+RscmzXh/7nzYj/8DNoA5l84t+oWPbOvoQ0jxQ6wS4jQ/x
         gbXc47AVzTUjFUfiHbqfY42/OOnbFP3NnCM80zANm2RgZEVkMs6xcD/GsMzdnWweq+li
         E410cOvBbt/mWlEBSi30Y077pHLOF1PZmw2VPoAOE+ausvsKI+ZXAvNuwEOYdPtbtZu1
         3ksVzh3TRCwF9z1car9TUn8fJq3nC55Db7p1ITt/yzqOpMOYVidxAOlBKt1T8I7zHzAW
         JQ7A==
X-Gm-Message-State: AOAM530Zej08O4neUkqkGTrIbG6v4zSBS1HjLTTdcIgRa6vLU1YBT3z8
        XBn/8IpVj0b+UXJ1Jht0/Uo=
X-Google-Smtp-Source: ABdhPJxEjzQ0mjjS3dwHGSA/rA/w6fowW+j7+kecrmPrIAEjpElf0b7qULeIeCbORx05VXowYRH9ig==
X-Received: by 2002:a05:651c:225:: with SMTP id z5mr7066045ljn.409.1630852438912;
        Sun, 05 Sep 2021 07:33:58 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id m17sm657424ljp.80.2021.09.05.07.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 07:33:58 -0700 (PDT)
Date:   Sun, 5 Sep 2021 17:33:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v2 2/2] spi: dw: Add support for Intel Thunder Bay SPI
Message-ID: <20210905143356.z2xomprpgsknz3fb@mobilestation>
References: <20210824085856.12714-1-nandhini.srikandan@intel.com>
 <20210824085856.12714-3-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824085856.12714-3-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Nandhini

On Tue, Aug 24, 2021 at 04:58:56PM +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Add support for Intel Thunder Bay SPI controller, which uses DesignWare
> DWC_ssi core.
> Bit 31 of CTRLR0 register is set for Thunder Bay, to
> configure the device as a master or as a slave serial peripheral.
> Bit 14(SSTE) of CTRLR0 register should be set(1) for Thunder Bay.

After reading your response to my v1 comments, I've got a better
notion of the features you are trying to implement here. Please see my
comments below.

> 
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> ---

Just to note for your future patchwork. Instead of having a single
general changelog text in the cover letter it is much more convenient
for reviewers to see both the summary changelog and a changelog of
individual patches here under '---' delimiter.

>  drivers/spi/spi-dw-core.c |  7 +++++--
>  drivers/spi/spi-dw-mmio.c | 20 +++++++++++++++++++-
>  drivers/spi/spi-dw.h      | 12 +++++++++---
>  3 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index a305074c482e..f7d45318db8a 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -300,8 +300,11 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
>  		/* CTRLR0[13] Shift Register Loop */
>  		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DWC_SSI_CTRLR0_SRL_OFFSET;
>  
> -		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> -			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;

> +		if (dws->caps & DW_SPI_CAP_DWC_MST)
> +			cr0 |= DWC_SSI_CTRLR0_MST;

Since you've used a generic suffix here, are you sure the MST/SLV feature
toggled by the BIT(31) bit is generic for all DWC SSI controllers?
I am asking because I don't have DWC SSI IP manual, but there is a
CTRL0 register layout posted by your colleague Wan Ahmad Zainie a year
ago: https://patches.linaro.org/patch/214693/ . It doesn't have that bit
defined.

If you are and it's specific to all DWC SSI controllers of v1.01a and
newer, then why not to implement that flag setting up in the framework
of the "DW_SPI_CAP_DWC_SSI" capability? Thus we'd have all
"snps,dwc-ssi-1.01a"-compatible devices and devices with the
DW_SPI_CAP_DWC_SSI flag set working well if for some reason they have
got slave-mode enabled by default.

> +
> +		if (dws->caps & DW_SPI_CAP_DWC_SSTE)
> +			cr0 |= DWC_SSI_CTRLR0_SSTE;

Regarding SSTE flag and feature implemented behind it. First of all
AFAICS from the Wan Ahmad Zainie post sited above it is indeed generic
for both DWC SSI and DW APB SSI IP-cores of the controllers. Thus we
don't need an additional DWC SSI capability flag defined for it, but
need to have it generically implemented in the DW SPI core driver.
Secondly as you said it two weeks ago it defines a slave-specific
protocol, the way the SSI and CLK signals are driven between consecutive
frames:
>> SSTE (Slave Select Toggle Enable)
>> When SSTE bit is set to 1, the slave select line will toggle between
>>  consecutive data frames, with the serial clock being held to its default
>>  value while slave select line is high.
>> When SSTE bit is set to 0, slave select line will stay low and clock will
>>  run continuously for the duration of the transfer.
In general DWC SSI/DW APB SSI controller can be connected to slave
devices with SSTE and normal communication protocol requirements at
the same time by using different CS-lanes. Therefore the SSTE feature
turns to be Slave/Peripheral-device specific rather than
controller-specific and needs to be enabled/disabled when it's
required by a slave device.

Thus here is what I'd suggest to implement the SSTE feature generically:
1) Add a new SPI-slave Synopsys-specific DT-property into the bindings
file like this:
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -143,6 +143,12 @@ patternProperties:
           is an optional feature of the designware controller, and the
           upper limit is also subject to controller configuration.
 
+      snps,sste:
+        description: Slave select line will toggle between consecutive
+          data frames, with the serial clock being held to its default
+          value while slave select line is high.
+        type: boolean
+
 unevaluatedProperties: false
 
 required:

Please do that in a separate preparation patch submitted before the
"dt-bindings: spi: Add bindings for Intel Thunder Bay SoC" patch
in this series.

2) Add that property support into the driver like this:
diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index a305074c482e..5caa74b9aa74 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -27,6 +27,7 @@
 struct chip_data {
 	u32 cr0;
 	u32 rx_sample_dly;	/* RX sample delay */
+	bool sste;		/* Slave Select Toggle flag */
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -269,6 +270,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 
 static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 {
+	struct chip_data *chip = spi_get_ctldata(spi);
 	u32 cr0 = 0;
 
 	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
@@ -285,6 +287,9 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 
 		/* CTRLR0[11] Shift Register Loop */
 		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET;
+
+		/* CTRLR0[24] Slave Select Toggle Enable */
+		cr0 |= chip->sste << SPI_SSTE_OFFSET;
 	} else {
 		/* CTRLR0[ 7: 6] Frame Format */
 		cr0 |= SSI_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET;
@@ -300,6 +305,9 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 		/* CTRLR0[13] Shift Register Loop */
 		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << DWC_SSI_CTRLR0_SRL_OFFSET;
 
+		/* CTRLR0[14] Slave Select Toggle Enable */
+		cr0 |= chip->sste << DWC_SSI_CTRLR0_SSTE_OFFSET;
+
 		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
 			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
 	}
@@ -789,6 +797,9 @@ static int dw_spi_setup(struct spi_device *spi)
 		chip->rx_sample_dly = DIV_ROUND_CLOSEST(rx_sample_dly_ns,
 							NSEC_PER_SEC /
 							dws->max_freq);
+
+		/* Get slave select toggling feature requirement */
+		chip->sste = device_property_read_bool(&spi->dev, "snps,sste");
 	}
 
 	/*
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index b665e040862c..2ee3f839de39 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -65,8 +65,10 @@
 #define SPI_SLVOE_OFFSET		10
 #define SPI_SRL_OFFSET			11
 #define SPI_CFS_OFFSET			12
+#define SPI_SSTE_OFFSET			24
 
 /* Bit fields in CTRLR0 based on DWC_ssi_databook.pdf v1.01a */
+#define DWC_SSI_CTRLR0_SSTE_OFFSET	14
 #define DWC_SSI_CTRLR0_SRL_OFFSET	13
 #define DWC_SSI_CTRLR0_TMOD_OFFSET	10
 #define DWC_SSI_CTRLR0_TMOD_MASK	GENMASK(11, 10)

Please also do that in a separate preparation patch.

3) If MST BIT(31) feature is generic, then please discard the
DW_SPI_CAP_KEEMBAY_MST capability flag and set the MST bit for each
DWC SSI device with DW_SPI_CAP_DWC_SSI capability set. If it's
Intel-specific, then convert the DW_SPI_CAP_KEEMBAY_MST capability
macro name to DW_SPI_CAP_INTEL_MST.

Please also do that in a separate preparation patch.

4) After all of that you can add the "Thunder Bay SPI" controller
support into the DW SPI MMIO driver by placing the
"intel,thunderbay-ssi" compatibility string into the OF-device table.
Since both Thunder and Keembay SPIs are based on the same IP-core then
you can just reuse the dw_spi_keembay_init() for both of them after
renaming it to something like dw_spi_intel_init().

-Sergey

>  	}
>  
>  	return cr0;
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 3379720cfcb8..2bd1dedd90b0 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -217,7 +217,24 @@ static int dw_spi_dwc_ssi_init(struct platform_device *pdev,
>  static int dw_spi_keembay_init(struct platform_device *pdev,
>  			       struct dw_spi_mmio *dwsmmio)
>  {
> -	dwsmmio->dws.caps = DW_SPI_CAP_KEEMBAY_MST | DW_SPI_CAP_DWC_SSI;
> +	/*
> +	 * Set MST to make keem bay SPI as master.
> +	 */
> +	dwsmmio->dws.caps = DW_SPI_CAP_DWC_MST | DW_SPI_CAP_DWC_SSI;
> +
> +	return 0;
> +}
> +
> +static int dw_spi_thunderbay_init(struct platform_device *pdev,
> +				  struct dw_spi_mmio *dwsmmio)
> +{
> +	/*
> +	 * Set MST to make thunder bay SPI as master.
> +	 * Set SSTE to enable slave select toggle bit which is required
> +	 * for the slave devices connected to the thunder bay SPI controller.
> +	 */
> +	dwsmmio->dws.caps = DW_SPI_CAP_DWC_MST | DW_SPI_CAP_DWC_SSTE |
> +			    DW_SPI_CAP_DWC_SSI;
>  
>  	return 0;
>  }
> @@ -349,6 +366,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>  	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_dw_apb_init},
>  	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
>  	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
> +	{ .compatible = "intel,thunderbay-ssi", .data = dw_spi_thunderbay_init},
>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
>  	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
>  	{ /* end of table */}
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index b665e040862c..9fffe0a02f3a 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -76,11 +76,16 @@
>  #define DWC_SSI_CTRLR0_DFS_OFFSET	0
>  
>  /*
> - * For Keem Bay, CTRLR0[31] is used to select controller mode.
> + * CTRLR0[31] is used to select controller mode.
>   * 0: SSI is slave
>   * 1: SSI is master
>   */
> -#define DWC_SSI_CTRLR0_KEEMBAY_MST	BIT(31)
> +#define DWC_SSI_CTRLR0_MST		BIT(31)
> +
> +/*
> + * CTRLR0[14] is used to enable/disable Slave Select Toggle bit
> + */
> +#define DWC_SSI_CTRLR0_SSTE		BIT(14)
>  
>  /* Bit fields in CTRLR1 */
>  #define SPI_NDF_MASK			GENMASK(15, 0)
> @@ -122,9 +127,10 @@ enum dw_ssi_type {
>  
>  /* DW SPI capabilities */
>  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
> -#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> +#define DW_SPI_CAP_DWC_MST		BIT(1)
>  #define DW_SPI_CAP_DWC_SSI		BIT(2)
>  #define DW_SPI_CAP_DFS32		BIT(3)
> +#define DW_SPI_CAP_DWC_SSTE		BIT(4)
>  
>  /* Slave spi_transfer/spi_mem_op related */
>  struct dw_spi_cfg {
> -- 
> 2.17.1
> 
