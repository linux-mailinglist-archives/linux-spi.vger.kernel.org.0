Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2548B17E659
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 19:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgCISFM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 14:05:12 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:43435 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgCISFM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 14:05:12 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A755823EDA;
        Mon,  9 Mar 2020 19:05:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583777109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YTstUEAHOImHVubDPl/PQ3nYvKS6CDicl+KJS2YJ6Y=;
        b=EXbeZFXASRSaA835mHDnjE2AfBIpT2EYd4khZ1LQfA8ZnK7kEsPKkPpwAmMYyKO7UByG/X
        A410+PBrCP4qvhLHFcPMTfVWwxaD1FqBRHUWzay2+inMDYc+QqjdjT0CTdHTTZqqGfsqlf
        Hm6SOmKPKrsJfDlWPSTi6jMt51kFSPM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Mar 2020 19:05:09 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, peng.ma@nxp.com
Subject: Re: [PATCH 1/6] spi: spi-fsl-dspi: Don't access reserved fields in
 SPI_MCR
In-Reply-To: <20200309145624.10026-2-olteanv@gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
 <20200309145624.10026-2-olteanv@gmail.com>
Message-ID: <c35b3c34123b43b26204a2cf360e7ec1@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: A755823EDA
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.374];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,deif.com,sysam.it,gmail.com,embeddedor.com,nvidia.com,nxp.com];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> The SPI_MCR_PCSIS macro assumes that the controller has a number of 
> chip
> select signals equal to 6. That is not always the case, but actually is
> described through the driver-specific " signals equal to 6. That is not
> always the case, but actually is described through the driver-specific
> "spi-num-chipselects" device tree binding.

Repeated sentence? Was this your intention?

-michael

> LS1028A for example only has
> 4 chip selects.
> 
> Don't write to the upper bits of the PCSIS field, which are reserved in
> the reference manual.
> 
> Fixes: 349ad66c0ab0 ("spi:Add Freescale DSPI driver for Vybrid VF610 
> platform")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 0683a3fbd48c..0ce26c1cbf62 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -22,7 +22,7 @@
> 
>  #define SPI_MCR				0x00
>  #define SPI_MCR_MASTER			BIT(31)
> -#define SPI_MCR_PCSIS			(0x3F << 16)
> +#define SPI_MCR_PCSIS(x)		((x) << 16)
>  #define SPI_MCR_CLR_TXF			BIT(11)
>  #define SPI_MCR_CLR_RXF			BIT(10)
>  #define SPI_MCR_XSPI			BIT(3)
> @@ -1197,7 +1197,10 @@ static const struct regmap_config
> dspi_xspi_regmap_config[] = {
> 
>  static void dspi_init(struct fsl_dspi *dspi)
>  {
> -	unsigned int mcr = SPI_MCR_PCSIS;
> +	unsigned int mcr;
> +
> +	/* Set idle states for all chip select signals to high */
> +	mcr = SPI_MCR_PCSIS(GENMASK(dspi->ctlr->num_chipselect - 1, 0));
> 
>  	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
>  		mcr |= SPI_MCR_XSPI;
