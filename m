Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB4172388
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 17:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgB0Qge (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 11:36:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39652 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729970AbgB0Qge (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 11:36:34 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id EFBD52963F3;
        Thu, 27 Feb 2020 16:36:32 +0000 (GMT)
Date:   Thu, 27 Feb 2020 17:36:30 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 03/11] spi: spi-mem: allow specifying whether an op
 is DTR or not
Message-ID: <20200227173630.40da81da@collabora.com>
In-Reply-To: <20200226093703.19765-4-p.yadav@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
        <20200226093703.19765-4-p.yadav@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 26 Feb 2020 15:06:55 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> Each phase is given a separate 'is_dtr' field so mixed protocols like
> 4S-4D-4D can be supported.
> 
> Also add the mode bits SPI_RX_DTR and SPI_TX_DTR so controllers can
> specify whether they support DTR modes or not.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/spi/spi-mem.c       | 23 +++++++++++++++++++++++
>  include/linux/spi/spi-mem.h |  8 ++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index e5a46f0eb93b..cb13e0878b95 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -99,6 +99,16 @@ void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
>  }
>  EXPORT_SYMBOL_GPL(spi_controller_dma_unmap_mem_op_data);
>  
> +static int spi_check_dtr_req(struct spi_mem *mem, bool tx)
> +{
> +	u32 mode = mem->spi->mode;
> +
> +	if ((tx && (mode & SPI_TX_DTR)) || (!tx && (mode & SPI_RX_DTR)))
> +		return 0;
> +
> +	return -ENOTSUPP;
> +}
> +
>  static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
>  {
>  	u32 mode = mem->spi->mode;
> @@ -154,6 +164,19 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
>  				   op->data.dir == SPI_MEM_DATA_OUT))
>  		return false;
>  
> +	if (op->cmd.is_dtr && spi_check_dtr_req(mem, true))
> +		return false;
> +
> +	if (op->addr.is_dtr && spi_check_dtr_req(mem, true))
> +		return false;
> +
> +	if (op->dummy.is_dtr && spi_check_dtr_req(mem, true))
> +		return false;
> +
> +	if (op->data.dir != SPI_MEM_NO_DATA && op->data.is_dtr &&
> +	    spi_check_dtr_req(mem, op->data.dir == SPI_MEM_DATA_OUT))
> +		return false;
> +

Not all controllers use spi_mem_default_supports_op(). Those should be
patched to reject DTR ops too.

>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index af9ff2f0f1b2..4669082b4e3b 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -71,6 +71,7 @@ enum spi_mem_data_dir {
>   * struct spi_mem_op - describes a SPI memory operation
>   * @cmd.buswidth: number of IO lines used to transmit the command
>   * @cmd.opcode: operation opcode
> + * @cmd.is_dtr: whether the command opcode should be sent in DTR mode or not
>   * @addr.nbytes: number of address bytes to send. Can be zero if the operation
>   *		 does not need to send an address
>   * @addr.buswidth: number of IO lines used to transmit the address cycles
> @@ -78,10 +79,13 @@ enum spi_mem_data_dir {
>   *	      Note that only @addr.nbytes are taken into account in this
>   *	      address value, so users should make sure the value fits in the
>   *	      assigned number of bytes.
> + * @addr.is_dtr: whether the address should be sent in DTR mode or not
>   * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
>   *		  be zero if the operation does not require dummy bytes
>   * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
> + * @dummy.is_dtr: whether the dummy bytes should be sent in DTR mode or not
>   * @data.buswidth: number of IO lanes used to send/receive the data
> + * @data.is_dtr: whether the data should be sent in DTR mode or not
>   * @data.dir: direction of the transfer
>   * @data.nbytes: number of data bytes to send/receive. Can be zero if the
>   *		 operation does not involve transferring data
> @@ -92,21 +96,25 @@ struct spi_mem_op {
>  	struct {
>  		u8 buswidth;
>  		u8 opcode;
> +		bool is_dtr;

Hm, maybe use a bitfield here so we can pack other fields if needed.
Also not convince the 'is_' prefix is useful.

		u8 dtr : 1;

>  	} cmd;
>  
>  	struct {
>  		u8 nbytes;
>  		u8 buswidth;

Maybe move the dtr field here so the compiler can pack things instead of
adding extra padding for the u64 alignment.

		u8 dtr : 1;

>  		u64 val;
> +		bool is_dtr;
>  	} addr;
>  
>  	struct {
>  		u8 nbytes;
>  		u8 buswidth;
> +		bool is_dtr;
>  	} dummy;
>  
>  	struct {
>  		u8 buswidth;
> +		bool is_dtr;
>  		enum spi_mem_data_dir dir;
>  		unsigned int nbytes;
>  		union {

