Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EFC34E62A
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 13:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhC3LNy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 07:13:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46306 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhC3LNZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 07:13:25 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12UBDA5S061546;
        Tue, 30 Mar 2021 06:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617102790;
        bh=uPvvfDy20lK56KbGP3G/CXExx2mMrLYUtNyTwjU5GQw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=hI/WjPY/SOVnWPEh7Yqj2tEONa2A/eqLnuExzIupUmYl3vow+KFkdG14m5lHLpc/o
         d3p45OxKuCkNWE3OmzCBVUjRleZOL8z3uNio2eAKU/acncUrARYrLmoj2kHeFHbSTa
         Evx2wQb2RvZ9rMDroeOJGD6DuzBCmsdd4AKuWG3w=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12UBDA7m025262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Mar 2021 06:13:10 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 30
 Mar 2021 06:13:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 30 Mar 2021 06:13:10 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12UBD9sO022539;
        Tue, 30 Mar 2021 06:13:09 -0500
Date:   Tue, 30 Mar 2021 16:43:08 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Brad Larson <brad@pensando.io>
CC:     <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <broonie@kernel.org>, <fancer.lancer@gmail.com>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <olof@lixom.net>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/13] spi: cadence-quadspi: Add QSPI support for
 Pensando Elba SoC
Message-ID: <20210330111308.7jjyj7nir6gmjnsv@ti.com>
References: <20210329015938.20316-1-brad@pensando.io>
 <20210329015938.20316-3-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210329015938.20316-3-brad@pensando.io>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 28/03/21 06:59PM, Brad Larson wrote:
> Add QSPI controller support for Pensando Elba SoC
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 52ddb3255d88..4aacb0b2dbc7 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1353,6 +1353,7 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
>  	cqspi->rx_chan = dma_request_chan_by_mask(&mask);
>  	if (IS_ERR(cqspi->rx_chan)) {
>  		int ret = PTR_ERR(cqspi->rx_chan);
> +

Unrelated whitespace change. Please move it into a separate cleanup 
patch.

>  		cqspi->rx_chan = NULL;
>  		return dev_err_probe(&cqspi->pdev->dev, ret, "No Rx DMA available\n");
>  	}
> @@ -1633,6 +1634,10 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
>  	.quirks = CQSPI_DISABLE_DAC_MODE,
>  };
>  
> +static const struct cqspi_driver_platdata pen_cdns_qspi = {
> +	.quirks = CQSPI_NEEDS_WR_DELAY | CQSPI_DISABLE_DAC_MODE,
> +};
> +
>  static const struct of_device_id cqspi_dt_ids[] = {
>  	{
>  		.compatible = "cdns,qspi-nor",
> @@ -1650,6 +1655,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
>  		.compatible = "intel,lgm-qspi",
>  		.data = &intel_lgm_qspi,
>  	},
> +	{
> +		.compatible = "pensando,cdns-qspi",
> +		.data = &pen_cdns_qspi,
> +	},
>  	{ /* end of table */ }
>  };
>  
> -- 
> 2.17.1
> 

Rest of the patch looks good to me.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
