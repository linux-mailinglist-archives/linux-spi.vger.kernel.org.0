Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8351E02B2
	for <lists+linux-spi@lfdr.de>; Sun, 24 May 2020 22:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbgEXUSF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 May 2020 16:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388045AbgEXUSF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 May 2020 16:18:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F121FC061A0E;
        Sun, 24 May 2020 13:18:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2A9BD26107D;
        Sun, 24 May 2020 21:18:02 +0100 (BST)
Date:   Sun, 24 May 2020 22:17:58 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: Re: [PATCH v8 02/19] spi: spi-mem: allow specifying a command's
 extension
Message-ID: <20200524221758.7c30f336@collabora.com>
In-Reply-To: <20200522224042.29970-3-p.yadav@ti.com>
References: <20200522224042.29970-1-p.yadav@ti.com>
        <20200522224042.29970-3-p.yadav@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 23 May 2020 04:10:25 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
> index 69491f3a515d..4e4292f0ee1d 100644
> --- a/drivers/spi/spi-mxic.c
> +++ b/drivers/spi/spi-mxic.c
> @@ -356,6 +356,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
>  	int nio = 1, i, ret;
>  	u32 ss_ctrl;
>  	u8 addr[8];
> +	u8 opcode = op->cmd.opcode & 0xff;

You don't need the '& 0xff' here, the cast to an u8 will truncate the
value anyway.

>  
>  	ret = mxic_spi_set_freq(mxic, mem->spi->max_speed_hz);
>  	if (ret)
> @@ -393,7 +394,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
>  	writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
>  	       mxic->regs + HC_CFG);
>  
> -	ret = mxic_spi_data_xfer(mxic, &op->cmd.opcode, NULL, 1);
> +	ret = mxic_spi_data_xfer(mxic, &opcode, NULL, 1);
>  	if (ret)
>  		goto out;
>  
> diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
> index 17641157354d..41389856e14a 100644
> --- a/drivers/spi/spi-zynq-qspi.c
> +++ b/drivers/spi/spi-zynq-qspi.c
> @@ -527,20 +527,21 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
>  	struct zynq_qspi *xqspi = spi_controller_get_devdata(mem->spi->master);
>  	int err = 0, i;
>  	u8 *tmpbuf;
> +	u8 opcode = op->cmd.opcode & 0xff;
>  

Ditto.

>  	dev_dbg(xqspi->dev, "cmd:%#x mode:%d.%d.%d.%d\n",
> -		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
> +		opcode, op->cmd.buswidth, op->addr.buswidth,
>  		op->dummy.buswidth, op->data.buswidth);
>  
>  	zynq_qspi_chipselect(mem->spi, true);
>  	zynq_qspi_config_op(xqspi, mem->spi);
>  
> -	if (op->cmd.opcode) {
> +	if (opcode) {

Unrelated to this patch, but this test is wrong. I don't see why we
couldn't have a '0' opcode. The test should be dropped or done on the
new op->cmd.nbytes field.

>  		reinit_completion(&xqspi->data_completion);
> -		xqspi->txbuf = (u8 *)&op->cmd.opcode;
> +		xqspi->txbuf = &opcode;
>  		xqspi->rxbuf = NULL;
> -		xqspi->tx_bytes = sizeof(op->cmd.opcode);
> -		xqspi->rx_bytes = sizeof(op->cmd.opcode);
> +		xqspi->tx_bytes = op->cmd.nbytes;
> +		xqspi->rx_bytes = op->cmd.nbytes;
>  		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
>  		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
>  				ZYNQ_QSPI_IXR_RXTX_MASK);
