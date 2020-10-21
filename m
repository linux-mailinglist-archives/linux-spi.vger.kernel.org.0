Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EF4294FBB
	for <lists+linux-spi@lfdr.de>; Wed, 21 Oct 2020 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502132AbgJUPSC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Oct 2020 11:18:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35998 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501934AbgJUPSC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Oct 2020 11:18:02 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09LFHcw8115681;
        Wed, 21 Oct 2020 10:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603293458;
        bh=FIbHw4Dh5k6YKwhGIHiMGFdq5N3EVz29tjQGUrHK7QA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ASxhJRViw9M4pQ4dGLhrJ4xEpNJchfRqy6Y67crgwSl50Z1xc3vMkH7eWj287HgiI
         ve5is4iI4r1/EbXwmuUPP0Bf3tW5efJAXOpdlhImXa4VJqfFugPK4TcjZQVMpU8VQl
         gay8UX1RIf3owYK6Qd58+D2PqU/cHr+WbQrv5ZEE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09LFHcb0097185
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Oct 2020 10:17:38 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 21
 Oct 2020 10:17:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 21 Oct 2020 10:17:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09LFHbuO010849;
        Wed, 21 Oct 2020 10:17:37 -0500
Date:   Wed, 21 Oct 2020 20:47:36 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
CC:     <vigneshr@ti.com>, <tudor.ambarus@microchip.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <simon.k.r.goldschmidt@gmail.com>, <dinguyen@kernel.org>,
        <richard@nod.at>, <cheol.yong.kim@intel.com>,
        <qi-ming.wu@intel.com>
Subject: Re: [PATCH v2 2/6] spi: cadence-quadspi: Disable the DAC for Intel
 LGM SoC
Message-ID: <20201021140015.3ldwk4az5nlzhnvr@ti.com>
References: <20201021025507.51001-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201021025507.51001-3-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201021025507.51001-3-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 21/10/20 10:55AM, Ramuthevar,Vadivel MuruganX wrote:
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
> index d7b10c46fa70..3d017b484114 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1106,6 +1106,13 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
>  	reg |= CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
>  	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
>  
> +	/* Disable direct access controller */
> +	if (!cqspi->use_direct_mode) {
> +		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
> +		reg &= ~CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
> +		writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
> +	}
> +

Do you really need to disable the DAC controller? cqspi_read() and 
cqspi_write() already check for cqspi->use_direct_mode and avoid using 
direct mode if it is false. While I don't think it would do any harm I'm 
curious what prompted you to do this instead of just setting the quirk 
like cdns_qspi does.

Anyway, if you do insist on doing it, it does not make any sense to set 
a bit and then unset it immediately after. The datasheet I have says 
this bit resets to 1 so the block above the code you added should be 
removed.

>  	cqspi_controller_enable(cqspi, 1);
>  }
>  
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

-- 
Regards,
Pratyush Yadav
Texas Instruments India
