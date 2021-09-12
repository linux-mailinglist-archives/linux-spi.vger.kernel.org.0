Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BA14081F0
	for <lists+linux-spi@lfdr.de>; Sun, 12 Sep 2021 23:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhILVym (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 Sep 2021 17:54:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40254 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbhILVym (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 Sep 2021 17:54:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E20851F42569
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 09/10] spi: amd: Add support for latest platform
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
        <20210908113450.788452-10-tanureal@opensource.cirrus.com>
Date:   Sun, 12 Sep 2021 17:53:19 -0400
In-Reply-To: <20210908113450.788452-10-tanureal@opensource.cirrus.com> (Lucas
        Tanure's message of "Wed, 8 Sep 2021 12:34:50 +0100")
Message-ID: <878s01ihps.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Lucas Tanure <tanureal@opensource.cirrus.com> writes:

> From: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
>
> Add support for AMDI0062 controller

Hi,

This patch is way more complex than it needs to be, making it much
harder to review.  A few comments inline.

I hope I didn't miss a newer version of this patch?

> Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>

Broken signoff chain, missing Co-developed-by tag.

> ---
>  drivers/spi/spi-amd.c | 128 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 104 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
> index 0face11740ea..788a5c42d811 100644
> --- a/drivers/spi/spi-amd.c
> +++ b/drivers/spi/spi-amd.c
> @@ -2,9 +2,10 @@
>  //
>  // AMD SPI controller driver
>  //
> -// Copyright (c) 2020, Advanced Micro Devices, Inc.
> +// Copyright (c) 2020-2021, Advanced Micro Devices, Inc.
>  //
>  // Authors: Sanjay R Mehta <sanju.mehta@amd.com>
> +//          Nehal Bakulchandra Shah <nehal-bakulchandra.shah@amd.com>
>  //          Lucas Tanure <tanureal@opensource.cirrus.com>
>  
>  #include <linux/acpi.h>
> @@ -14,33 +15,48 @@
>  #include <linux/delay.h>
>  #include <linux/spi/spi.h>
>  
> -#define AMD_SPI_CTRL0_REG	0x00
> -#define AMD_SPI_EXEC_CMD	BIT(16)
> -#define AMD_SPI_FIFO_CLEAR	BIT(20)
> -#define AMD_SPI_BUSY		BIT(31)
> +#define AMD_SPI_CTRL0_REG		0x00
> +#define AMD_SPI_EXEC_CMD		BIT(16)
> +#define AMD_SPI_FIFO_CLEAR		BIT(20)
> +#define AMD_SPI_BUSY			BIT(31)
> +#define AMD_SPI_ENABLE_REG		0x20
>  
> -#define AMD_SPI_OPCODE_MASK	0xFF
> +#define AMD_SPI_DUMMY_CYCL_REG		0x32
> +#define AMD_SPI_OPCODE_REG		0x45
> +#define AMD_SPI_CMD_TRIGGER_REG		0x47
> +#define AMD_SPI_TRIGGER_CMD		BIT(7)
> +#define AMD_SPI_OPCODE_MASK		0xFF
>  
> -#define AMD_SPI_ALT_CS_REG	0x1D
> -#define AMD_SPI_ALT_CS_MASK	0x3
> +#define AMD_SPI_ALT_CS_REG		0x1D
> +#define AMD_SPI_ALT_CS_MASK		GENMASK(1, 0)
>  
> -#define AMD_SPI_FIFO_BASE	0x80
> -#define AMD_SPI_TX_COUNT_REG	0x48
> -#define AMD_SPI_RX_COUNT_REG	0x4B
> -#define AMD_SPI_STATUS_REG	0x4C
> +#define AMD_SPI_FIFO_BASE		0x80
> +#define AMD_SPI_TX_COUNT_REG		0x48
> +#define AMD_SPI_RX_COUNT_REG		0x4B
> +#define AMD_SPI_STATUS_REG		0x4C
>  
> -#define AMD_SPI_FIFO_SIZE	70
> -#define AMD_SPI_MEM_SIZE	200
> +#define AMD_SPI_FIFO_SIZE		70
> +#define AMD_SPI_MEM_SIZE		200
>  
>  /* M_CMD OP codes for SPI */
> -#define AMD_SPI_XFER_TX		1
> -#define AMD_SPI_XFER_RX		2
> +#define AMD_SPI_XFER_TX			1
> +#define AMD_SPI_XFER_RX			2

If you drop the indentation changes, the real diff seems to be:

+#define AMD_SPI_ENABLE_REG     0x20

...

+#define AMD_SPI_DUMMY_CYCL_REG         0x32
+#define AMD_SPI_OPCODE_REG             0x45
+#define AMD_SPI_CMD_TRIGGER_REG        0x47
+#define AMD_SPI_TRIGGER_CMD            BIT(7)

...

-#define AMD_SPI_ALT_CS_MASK    0x3
+#define AMD_SPI_ALT_CS_MASK    GENMASK(1, 0)

Which is WAY simpler to review.  Even if it is nice to have the defines
aligned, I suggest not doing it if the patch becomes much harder to
review.

>
>  struct amd_spi {
>  	void __iomem *io_remap_addr;
>  	unsigned long io_base_addr;
>  	u32 rom_addr;
>  	struct list_head rbuf_head;
> +	const struct amd_spi_devtype_data *devtype_data;
> +	struct spi_device *spi_dev;
> +	struct spi_master *master;
> +};
> +
> +struct amd_spi_devtype_data {
> +	u8 version;
> +	int (*exec_op)(struct amd_spi *amd_spi);
> +	void (*set_op)(struct amd_spi *amd_spi, u8 cmd_opcode);
> +	int (*busy_wait)(struct amd_spi *amd_spi);
>  };
>  
>  struct amd_spi_read_buffer {
> @@ -90,16 +106,26 @@ static void amd_spi_select_chip(struct amd_spi *amd_spi, u8 cs)
>  	amd_spi_setclear_reg8(amd_spi, AMD_SPI_ALT_CS_REG, cs, AMD_SPI_ALT_CS_MASK);
>  }
>  
> +static inline void amd_spi_clear_chip(struct amd_spi *amd_spi, u8 chip_select)
> +{
> +	amd_spi_writereg8(amd_spi, AMD_SPI_ALT_CS_REG, chip_select & ~AMD_SPI_ALT_CS_MASK);
> +}
> +
>  static void amd_spi_clear_fifo_ptr(struct amd_spi *amd_spi)
>  {
>  	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, AMD_SPI_FIFO_CLEAR, AMD_SPI_FIFO_CLEAR);
>  }
>  
> -static void amd_spi_set_opcode(struct amd_spi *amd_spi, u8 cmd_opcode)
> +static void amd_spi_set_opcode_v1(struct amd_spi *amd_spi, u8 cmd_opcode)
>  {
>  	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, cmd_opcode, AMD_SPI_OPCODE_MASK);
>  }
>  
> +static void amd_spi_set_opcode_v2(struct amd_spi *amd_spi, u8 cmd_opcode)
> +{
> +	amd_spi_writereg8(amd_spi, AMD_SPI_OPCODE_REG, cmd_opcode);
> +}
> +

Instead of creating two copies of each function and having indirect
branches, it would be way simpler to just save the version in
amd_spi and:

static void amd_spi_set_opcode(struct amd_spi *amd_spi, u8 cmd_opcode)
{
	switch (amd_spi->version) {
        case AMD_SPI_V1:
        	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG,
				       cmd_opcode, AMD_SPI_OPCODE_MASK);
 		break;
	case AMD_SPI_V2:
		amd_spi_writereg8(amd_spi, AMD_SPI_OPCODE_REG, cmd_opcode);
                break;
	default:
        	WARN_ON(1);
        }
}

Likewise for the other amd_spi_devtype_data hooks.

It is simpler, faster (avoids the indirect branches), avoids code
duplication, and you get the benefit of not touching the callers, which
will eliminate several of the hunks below.

>  static inline void amd_spi_set_rx_count(struct amd_spi *amd_spi, u8 rx_count)
>  {
>  	amd_spi_setclear_reg8(amd_spi, AMD_SPI_RX_COUNT_REG, rx_count, 0xff);
> @@ -110,7 +136,7 @@ static inline void amd_spi_set_tx_count(struct amd_spi *amd_spi, u8 tx_count)
>  	amd_spi_setclear_reg8(amd_spi, AMD_SPI_TX_COUNT_REG, tx_count, 0xff);
>  }
>  
> -static int amd_spi_busy_wait(struct amd_spi *amd_spi)
> +static int amd_spi_busy_wait_v1(struct amd_spi *amd_spi)
>  {
>  	int timeout = 100000;
>  
> @@ -124,11 +150,11 @@ static int amd_spi_busy_wait(struct amd_spi *amd_spi)
>  	return 0;
>  }
>  
> -static int amd_spi_execute_opcode(struct amd_spi *amd_spi)
> +static int amd_spi_execute_opcode_v1(struct amd_spi *amd_spi)
>  {
>  	int ret;
>  
> -	ret = amd_spi_busy_wait(amd_spi);
> +	ret = amd_spi_busy_wait_v1(amd_spi);
>  	if (ret)
>  		return ret;
>  
> @@ -138,6 +164,33 @@ static int amd_spi_execute_opcode(struct amd_spi *amd_spi)
>  	return 0;
>  }
>  
> +static int amd_spi_busy_wait_v2(struct amd_spi *amd_spi)
> +{
> +	int timeout = 100000;
> +
> +	while (amd_spi_readreg32(amd_spi, AMD_SPI_STATUS_REG) & AMD_SPI_BUSY) {
> +		usleep_range(10, 20);
> +		if (timeout-- < 0)
> +			return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}

This duplicates amd_spi_busy_wait_v1, except for the readreg call.  If
you follow the suggestion above, you'll avoid all this code duplication.

> +
> +static int amd_spi_execute_opcode_v2(struct amd_spi *amd_spi)
> +{
> +	int ret;
> +
> +	ret = amd_spi_busy_wait_v2(amd_spi);
> +	if (ret)
> +		return ret;
> +
> +	amd_spi_setclear_reg8(amd_spi, AMD_SPI_CMD_TRIGGER_REG, AMD_SPI_TRIGGER_CMD,
> +			      AMD_SPI_TRIGGER_CMD);
> +
> +	return 0;
> +}
> +
>  static int amd_spi_master_setup(struct spi_device *spi)
>  {
>  	struct amd_spi *amd_spi = spi_master_get_devdata(spi->master);
> @@ -159,20 +212,21 @@ static void amd_spi_clear_list(struct amd_spi *amd_spi)
>  
>  static int amd_spi_transfer(struct amd_spi *amd_spi, u8 opcode, u8 tx_len, u8 rx_len, u8 fifo_pos)
>  {
> +	const struct amd_spi_devtype_data *priv = amd_spi->devtype_data;
>  	struct amd_spi_read_buffer *rbuf;
>  	struct list_head *p;
>  	int ret, i;
>  
> -	amd_spi_set_opcode(amd_spi, opcode);
> +	priv->set_op(amd_spi, opcode);
>  	amd_spi_set_tx_count(amd_spi, tx_len);
>  	amd_spi_set_rx_count(amd_spi, rx_len);
>  
> -	ret = amd_spi_execute_opcode(amd_spi);
> +	ret = priv->exec_op(amd_spi);
>  	if (ret)
>  		return ret;
>  
>  	if (!list_empty(&amd_spi->rbuf_head)) {
> -		ret = amd_spi_busy_wait(amd_spi);
> +		ret = priv->busy_wait(amd_spi);
>  		if (ret)
>  			return ret;
>  		list_for_each(p, &amd_spi->rbuf_head) {
> @@ -262,6 +316,9 @@ static int amd_spi_transfer_one_message(struct spi_controller *ctrl, struct spi_
>  	msg->status = ret;
>  	spi_finalize_current_message(ctrl);
>

And the above hunk will disappear.

> +	if (amd_spi->devtype_data->version)
> +		amd_spi_clear_chip(amd_spi, msg->spi->chip_select);
> +

This should be explicit (amd_spi->devtype_data->version == AMD_SPI_V2)

>  	return ret;
>  }
>  
> @@ -293,6 +350,12 @@ static int amd_spi_probe(struct platform_device *pdev)
>  	}
>  	dev_dbg(dev, "io_remap_address: %p\n", amd_spi->io_remap_addr);
>  
> +	amd_spi->devtype_data = device_get_match_data(dev);
> +	if (!amd_spi->devtype_data) {
> +		err = -ENODEV;
> +		goto err_free_master;
> +	}
> +
>  	/* Initialize the spi_master fields */
>  	master->bus_num = 0;
>  	master->num_chipselect = 4;
> @@ -320,9 +383,25 @@ static int amd_spi_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> +static const struct amd_spi_devtype_data spi_v1 = {
> +	.exec_op	= amd_spi_execute_opcode_v1,
> +	.set_op		= amd_spi_set_opcode_v1,
> +	.busy_wait	= amd_spi_busy_wait_v1,
> +};
> +
> +static const struct amd_spi_devtype_data spi_v2 = {
> +	.version	= 1,

This is confusing.  The structure is called _v2, but the version field
says 1.  Please, be explicit:

#define AMD_SPI_V1  1
#define AMD_SPI_V2  2

And use the constants here.

Also, a nit regarding the summary line:  Surely someday there will
be a new "latest platform". It would be more meaningful to say
"Add support for AMDI0062" or maybe "Add support for rev2", if that makes
sense.

Thanks,

-- 
Gabriel Krisman Bertazi
