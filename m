Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A5117E75B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 19:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgCISiv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 14:38:51 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38299 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgCISiu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 14:38:50 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 517C323EDA;
        Mon,  9 Mar 2020 19:38:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583779128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIYhl3hOwDQGX1uE6iNMK8JIcA2bt00RM3gT2bSjN4M=;
        b=sz0+gFHPZkigcov5P1QNKrsDGR4Axp+OmoxRrAPJxGuuxDsbOnsKUrfnnPLJiRLDxNlqGA
        KKSA5dqNlSsnVUuVjJ1Ic74XGBKlodg+QsAzN8zShXwHe2mmBms8pjqTPdOJNToNJTnr0M
        l/T0KqDFFhVy5t8FnyesfK8l4f43NJQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Mar 2020 19:38:48 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, peng.ma@nxp.com
Subject: Re: [PATCH 4/6] spi: spi-fsl-dspi: Add support for LS1028A
In-Reply-To: <20200309145624.10026-5-olteanv@gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
 <20200309145624.10026-5-olteanv@gmail.com>
Message-ID: <02a2816d2f39bf621dfee543ed612ae0@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 517C323EDA
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.384];
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
> This is similar to the DSPI instantiation on LS1028A, except that:
>  - The A-011218 erratum has been fixed, so DMA works
>  - The endianness is different, which has implications on XSPI mode
> 
> Some benchmarking with the following command:
> 
> spidev_test --device /dev/spidev2.0 --bpw 8 --size 256 --cpha --iter
> 10000000 --speed 20000000
> 
> shows that in DMA mode, it can achieve around 2400 kbps, and in XSPI
> mode, the same command goes up to 4700 kbps. This is somewhat to be
> expected, since the DMA buffer size is extremely small at 8 bytes, the
> winner becomes whomever can prepare the buffers for transmission
> quicker, and DMA mode has higher overhead there. So XSPI FIFO mode has
> been chosen as the operating mode for this chip.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 5624b9ee77db..264d184e7296 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -131,6 +131,7 @@ struct fsl_dspi_devtype_data {
>  enum {
>  	LS1021A,
>  	LS1012A,
> +	LS1028A,
>  	LS1043A,
>  	LS1046A,
>  	LS2080A,
> @@ -163,6 +164,14 @@ static const struct fsl_dspi_devtype_data
> devtype_data[] = {
>  		.pushr_cmd		= 0,
>  		.pushr_tx		= 2,
>  	},
> +	[LS1028A] = {
> +		.trans_mode		= DSPI_DMA_MODE,

shouldn't this be DSPI_XSPI_MODE according to your cover letter?

-michael

> +		.dma_bufsize		= 8,
> +		.max_clock_factor	= 8,
> +		.fifo_size		= 4,
> +		.pushr_cmd		= 2,
> +		.pushr_tx		= 0,
> +	},
>  	[LS1043A] = {
>  		/* Has A-011218 DMA erratum */
>  		.trans_mode		= DSPI_XSPI_MODE,
> @@ -1113,6 +1122,9 @@ static const struct of_device_id 
> fsl_dspi_dt_ids[] = {
>  	}, {
>  		.compatible = "fsl,ls1012a-dspi",
>  		.data = &devtype_data[LS1012A],
> +	}, {
> +		.compatible = "fsl,ls1028a-dspi",
> +		.data = &devtype_data[LS1028A],
>  	}, {
>  		.compatible = "fsl,ls1043a-dspi",
>  		.data = &devtype_data[LS1043A],
