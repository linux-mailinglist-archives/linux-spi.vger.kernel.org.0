Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0975293E02
	for <lists+linux-spi@lfdr.de>; Tue, 20 Oct 2020 16:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407732AbgJTOA3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Oct 2020 10:00:29 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:41608 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407726AbgJTOA3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Oct 2020 10:00:29 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A18DA3B2BD6;
        Tue, 20 Oct 2020 13:44:05 +0000 (UTC)
X-Originating-IP: 103.82.80.92
Received: from localhost (unknown [103.82.80.92])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id CCB24FF80D;
        Tue, 20 Oct 2020 13:43:40 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     vigneshr@ti.com, tudor.ambarus@microchip.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        miquel.raynal@bootlin.com, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, richard@nod.at, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Subject: Re: [RESENDPATCH v1 2/6] spi: cadence-quadspi: Disable the DAC for
 Intel LGM SoC
References: <20201020023226.33559-1-vadivel.muruganx.ramuthevar@linux.intel.com>
        <20201020023226.33559-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Date:   Tue, 20 Oct 2020 19:13:37 +0530
In-Reply-To: <20201020023226.33559-3-vadivel.muruganx.ramuthevar@linux.intel.com>
        (Vadivel MuruganX Ramuthevar's message of "Tue, 20 Oct 2020 10:32:22
        +0800")
Message-ID: <87y2k1dncm.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 20 2020, Ramuthevar,Vadivel MuruganX wrote:

Hi,

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
