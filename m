Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2562A4ACD
	for <lists+linux-spi@lfdr.de>; Tue,  3 Nov 2020 17:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgKCQJ5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Nov 2020 11:09:57 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57712 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgKCQJ5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Nov 2020 11:09:57 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A3G9i12043428;
        Tue, 3 Nov 2020 10:09:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604419784;
        bh=ASRLdMFpDPF7L3jGqEBGSpdlOd3m9t3o2Wgd10aMWTM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=nO4fqgvvEGIUGo30PQRjIP/l1NjcMLhpChcn0uR7mPJxZ2J9DvZ/sliyNG33Fx3PG
         T7kyUTiE1zh1OcZpiPjajXdpwUAEpjm6dbIPtdJodBS+HHjmknYvrajIBg0ii+uNxH
         +ISWD4Sk24j7oawLkaQwcdSaCQejS+W87/9WbPWQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A3G9i1R115061
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Nov 2020 10:09:44 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 3 Nov
 2020 10:09:43 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 3 Nov 2020 10:09:44 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A3G9hxR016819;
        Tue, 3 Nov 2020 10:09:43 -0600
Date:   Tue, 3 Nov 2020 21:39:42 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
CC:     <broonie@kernel.org>, <vigneshr@ti.com>,
        <tudor.ambarus@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <simon.k.r.goldschmidt@gmail.com>, <dinguyen@kernel.org>,
        <richard@nod.at>, <cheol.yong.kim@intel.com>,
        <qi-ming.wu@intel.com>
Subject: Re: [PATCH v6 2/6] spi: cadence-quadspi: Disable the DAC for Intel
 LGM SoC
Message-ID: <20201103160834.mfbasmmlgsptnl5l@ti.com>
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201030053153.5319-3-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201030053153.5319-3-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 30/10/20 01:31PM, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> On Intel Lightning Mountain(LGM) SoCs QSPI controller do not use
> Direct Access Controller(DAC).
> 
> This patch adds a quirk to disable the Direct Access Controller
> for data transfer instead it uses indirect data transfer.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index d7b10c46fa70..6d6f7c440ece 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1107,6 +1107,13 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
>  	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
>  
>  	cqspi_controller_enable(cqspi, 1);
> +
> +	/* Disable direct access controller */
> +	if (!cqspi->use_direct_mode) {
> +		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
> +		reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
> +		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
> +	}

You did not address my comment here from last time around [0]. Please 
replace this hunk with the one below and test it. Also mention in the 
commit message that the DAC bit resets to 1 so there is no need to 
explicitly set it.

--- 8< ---
diff --git a/drivers/spi/spi-cadence-quadspi.c 
b/drivers/spi/spi-cadence-quadspi.c
index d7ad8b198a11..d2c5d448a944 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2156,10 +2156,12 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 	writel(cqspi->fifo_depth * cqspi->fifo_width / 8,
 	       cqspi->iobase + CQSPI_REG_INDIRECTWRWATERMARK);
 
-	/* Enable Direct Access Controller */
-	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
-	reg |= CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
-	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+	/* Disable Direct Access Controller */
+	if (!cqspi->use_dac_mode) {
+		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
+		reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
+		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+	}
 
 	cqspi_controller_enable(cqspi, 1);
 }
--- >8 ---

Same disclaimer as last time: not tested at all.

[0] https://lore.kernel.org/linux-spi/20201022090146.2uj5gfx73dsfumjl@ti.com/

PS: Please Cc me in the next revision. I missed 3 revisions in between 
because I'm not subscribed to this list. Otherwise I would have sent 
this much sooner :-)

>  }
>  
>  static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
> @@ -1388,6 +1395,10 @@ static const struct cqspi_driver_platdata am654_ospi = {
>  	.quirks = CQSPI_NEEDS_WR_DELAY,
>  };
>  
> +static const struct cqspi_driver_platdata intel_lgm_qspi = {
> +	.quirks = CQSPI_DISABLE_DAC_MODE,
> +};
> +
>  static const struct of_device_id cqspi_dt_ids[] = {
>  	{
>  		.compatible = "cdns,qspi-nor",
> @@ -1403,6 +1414,7 @@ static const struct of_device_id cqspi_dt_ids[] = {
>  	},
>  	{
>  		.compatible = "intel,lgm-qspi",
> +		.data = &intel_lgm_qspi,
>  	},
>  	{ /* end of table */ }
>  };
> -- 
> 2.11.0
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
