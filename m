Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F6747765E
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 16:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhLPPwb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 16 Dec 2021 10:52:31 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:59893 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhLPPwa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 10:52:30 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C46A920000C;
        Thu, 16 Dec 2021 15:52:25 +0000 (UTC)
Date:   Thu, 16 Dec 2021 16:52:24 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v6 20/28] spi: spi-mem: Fill the spi-mem controller
 capabilities of all the drivers
Message-ID: <20211216165224.7d80a33c@xps13>
In-Reply-To: <20211216111654.238086-21-miquel.raynal@bootlin.com>
References: <20211216111654.238086-1-miquel.raynal@bootlin.com>
        <20211216111654.238086-21-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello all,

> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index c4da0c9b05e9..bfd5c6b2db0a 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -160,6 +160,9 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
>  	return true;
>  }
>  
> +const struct spi_controller_mem_caps spi_mem_no_caps = {};
> +EXPORT_SYMBOL_GPL(spi_mem_no_caps);

As suggested by Boris on IRC, we might just find a way to avoid
defining this empty structure and requesting all drivers to provide one.

As it turns out, there is no per-controller spi-mem initialization
where we could provide a default set of capabilities, but I believe we
could hide the little extra complexity with something like:

#define spi_mem_controller_is_capable(mem, cap) \
	((mem)->ctlr->caps && (mem)->ctrl->caps->##cap)

And using the above helper in spi_mem_default_supports_op(), which
would transparently handle the !caps situation.

> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 57e2499ec1ed..58c5cb985431 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2747,6 +2747,9 @@ static int spi_controller_check_ops(struct spi_controller *ctlr)
>  	if (ctlr->mem_ops) {
>  		if (!ctlr->mem_ops->exec_op)
>  			return -EINVAL;
> +
> +		if (!ctlr->mem_ops->caps)
> +			return -EINVAL;
>  	} else if (!ctlr->transfer && !ctlr->transfer_one &&
>  		   !ctlr->transfer_one_message) {
>  		return -EINVAL;
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 42f3850610b5..5f728f3113bd 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -366,6 +366,7 @@ bool spi_mem_dtr_supports_op(struct spi_mem *mem,
>  
>  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
>  
> +const struct spi_controller_mem_caps spi_mem_no_caps;
>  bool spi_mem_supports_op(struct spi_mem *mem,
>  			 const struct spi_mem_op *op);
>  


Thanks,
Miquèl
