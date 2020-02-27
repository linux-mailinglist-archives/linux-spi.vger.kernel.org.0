Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCEC1723BE
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 17:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgB0QoS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 11:44:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39850 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgB0QoS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 11:44:18 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 09D71296435;
        Thu, 27 Feb 2020 16:44:09 +0000 (GMT)
Date:   Thu, 27 Feb 2020 17:44:06 +0100
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
Subject: Re: [PATCH v2 04/11] spi: spi-mem: allow specifying a command's
 extension
Message-ID: <20200227174406.66bf6f84@collabora.com>
In-Reply-To: <20200226093703.19765-5-p.yadav@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
        <20200226093703.19765-5-p.yadav@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 26 Feb 2020 15:06:56 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> In xSPI mode, flashes expect 2-byte opcodes. The second byte is called
> the "command extension". There can be 3 types of extensions in xSPI:
> repeat, invert, and hex. When the extension type is "repeat", the same
> opcode is sent twice. When it is "invert", the second byte is the
> inverse of the opcode. When it is "hex" an additional opcode byte based
> is sent with the command whose value can be anything.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/spi/spi-mem.c       | 23 +++++++++++++++++++++++
>  include/linux/spi/spi-mem.h | 24 ++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index cb13e0878b95..3838ddc9aeec 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -462,6 +462,29 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
>  
> +int spi_mem_get_cmd_ext(const struct spi_mem_op *op, u8 *ext)
> +{
> +	switch (op->cmd.ext_type) {
> +	case SPI_MEM_EXT_INVERT:
> +		*ext = ~op->cmd.opcode;
> +		break;
> +
> +	case SPI_MEM_EXT_REPEAT:
> +		*ext = op->cmd.opcode;
> +		break;
> +
> +	case SPI_MEM_EXT_HEX:
> +		*ext = op->cmd.ext;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_mem_get_cmd_ext);
> +
>  static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
>  				      u64 offs, size_t len, void *buf)
>  {
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 4669082b4e3b..06ccab17e4d0 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -67,11 +67,31 @@ enum spi_mem_data_dir {
>  	SPI_MEM_DATA_OUT,
>  };
>  
> +/**
> + * enum spi_mem_cmd_ext - describes the command opcode extension in DTR mode
> + * @SPI_MEM_EXT_NONE: no extension. This is the default, and is used in Legacy
> + *		      SPI mode
> + * @SPI_MEM_EXT_REPEAT: the extension is same as the opcode
> + * @SPI_MEM_EXT_INVERT: the extension is the bitwise inverse of the opcode
> + * @SPI_MEM_EXT_HEX: the extension is any hex value. The command and opcode
> + *		     combine to form a 16-bit opcode.
> + */
> +enum spi_mem_cmd_ext {
> +	SPI_MEM_EXT_NONE = 0,
> +	SPI_MEM_EXT_REPEAT,
> +	SPI_MEM_EXT_INVERT,
> +	SPI_MEM_EXT_HEX,
> +};
> +
>  /**
>   * struct spi_mem_op - describes a SPI memory operation
>   * @cmd.buswidth: number of IO lines used to transmit the command
>   * @cmd.opcode: operation opcode
>   * @cmd.is_dtr: whether the command opcode should be sent in DTR mode or not
> + * @cmd.ext_type: type of the command opcode extension in DTR mode
> + * @cmd.ext: value of the command opcode extension in DTR mode. It is
> + *	     only set when 'ext_type' is 'SPI_MEM_EXT_HEX'. In all other
> + *	     cases, the extension can be directly derived from the opcode.
>   * @addr.nbytes: number of address bytes to send. Can be zero if the operation
>   *		 does not need to send an address
>   * @addr.buswidth: number of IO lines used to transmit the address cycles
> @@ -97,6 +117,8 @@ struct spi_mem_op {
>  		u8 buswidth;
>  		u8 opcode;
>  		bool is_dtr;
> +		enum spi_mem_cmd_ext ext_type;
> +		u8 ext;

Could we instead make opcode an u16 (or u8[2]) and pass the number of
bytes, as done for the other addr? Mode can be extracted from the
opcode/nbytes values if really needed, and the caller would be
responsible for filling those fields properly (which shouldn't be too
hard)

>  	} cmd;
>  
>  	struct {
> @@ -361,6 +383,8 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
>  
>  void spi_mem_driver_unregister(struct spi_mem_driver *drv);
>  
> +int spi_mem_get_cmd_ext(const struct spi_mem_op *op, u8 *ext);
> +
>  #define spi_mem_driver_register(__drv)                                  \
>  	spi_mem_driver_register_with_owner(__drv, THIS_MODULE)
>  

