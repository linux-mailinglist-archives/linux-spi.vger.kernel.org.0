Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34D21DEBE5
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 17:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgEVPdA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 11:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgEVPdA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 11:33:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E149C061A0E;
        Fri, 22 May 2020 08:33:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2744D2A3A00;
        Fri, 22 May 2020 16:32:58 +0100 (BST)
Date:   Fri, 22 May 2020 17:32:54 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: Re: [PATCH v7 02/20] spi: spi-mem: allow specifying a command's
 extension
Message-ID: <20200522173254.05316d47@collabora.com>
In-Reply-To: <20200522101301.26909-3-p.yadav@ti.com>
References: <20200522101301.26909-1-p.yadav@ti.com>
        <20200522101301.26909-3-p.yadav@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 22 May 2020 15:42:43 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> In xSPI mode, flashes expect 2-byte opcodes. The second byte is called
> the "command extension". There can be 3 types of extensions in xSPI:
> repeat, invert, and hex. When the extension type is "repeat", the same
> opcode is sent twice. When it is "invert", the second byte is the
> inverse of the opcode. When it is "hex" an additional opcode byte based
> is sent with the command whose value can be anything.
> 
> So, make opcode a 16-bit value and add a 'nbytes', similar to how
> multiple address widths are handled.

A slightly different version of patch 5 should go before this patch,
otherwise your series is not bisectable. By slightly different, I mean
that you should only write one byte, but put this byte in a temporary
var. Or maybe you can squash patch 5 in this one and mention why you do
so in your commit message.

> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/spi/spi-mem.c       | 5 ++++-
>  include/linux/spi/spi-mem.h | 6 +++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 93e255287ab9..29dcd1d62710 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -159,6 +159,9 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
>  	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
>  		return false;
>  
> +	if (op->cmd.nbytes != 1)
> +		return false;
> +
>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
> @@ -173,7 +176,7 @@ static bool spi_mem_buswidth_is_valid(u8 buswidth)
>  
>  static int spi_mem_check_op(const struct spi_mem_op *op)
>  {
> -	if (!op->cmd.buswidth)
> +	if (!op->cmd.buswidth || !op->cmd.nbytes)
>  		return -EINVAL;
>  
>  	if ((op->addr.nbytes && !op->addr.buswidth) ||
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index e3dcb956bf61..159463cc659c 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -17,6 +17,7 @@
>  	{							\
>  		.buswidth = __buswidth,				\
>  		.opcode = __opcode,				\
> +		.nbytes = 1,					\
>  	}
>  
>  #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
> @@ -69,6 +70,8 @@ enum spi_mem_data_dir {
>  
>  /**
>   * struct spi_mem_op - describes a SPI memory operation
> + * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
> + *		sent MSB-first.
>   * @cmd.buswidth: number of IO lines used to transmit the command
>   * @cmd.opcode: operation opcode
>   * @cmd.dtr: whether the command opcode should be sent in DTR mode or not
> @@ -94,9 +97,10 @@ enum spi_mem_data_dir {
>   */
>  struct spi_mem_op {
>  	struct {
> +		u8 nbytes;
>  		u8 buswidth;
>  		u8 dtr : 1;
> -		u8 opcode;
> +		u16 opcode;
>  	} cmd;
>  
>  	struct {

