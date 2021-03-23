Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDA8346DCE
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 00:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhCWXSH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Mar 2021 19:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhCWXRl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Mar 2021 19:17:41 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D33C061574;
        Tue, 23 Mar 2021 16:17:40 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BDD7422235;
        Wed, 24 Mar 2021 00:17:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616541456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Ec/9X4nt6FyfqtrErVyYH+TwTzheb3cKb1BNoUs13I=;
        b=JoZfAk7VjK47eMqmTbMeO7pmCvZZUqa/q0nTpo+VhGuhOqpEGkurGVc2IZz4JpRnqR+x22
        D3x67jhVq6hzODUEwwOvhetS2wnXMNkpWpFb5kO2wh/mUkqGRaGb8fQe7ELoUa74d2B3SJ
        fFmq/b2bPnXs4kNfH0x0iMp9Ywggjpg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Mar 2021 00:17:36 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 2/6] mtd: spi-nor: core: consolidate read op creation
In-Reply-To: <20210311191216.7363-3-p.yadav@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-3-p.yadav@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <77a4d73b65bd371e93538886038f1acb@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-03-11 20:12, schrieb Pratyush Yadav:
> Currently the spi_mem_op to read from the flash is used in two places:
> spi_nor_create_read_dirmap() and spi_nor_spimem_read_data(). In a later
> commit this number will increase to three. Instead of repeating the 
> same
> code thrice, add a function that returns a template of the read op. The
> callers can then fill in the details like address, data length, data
> buffer location.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/mtd/spi-nor/core.c | 62 ++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 4a315cb1c4db..88888df009f0 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -183,6 +183,33 @@ static int spi_nor_controller_ops_erase(struct
> spi_nor *nor, loff_t offs)
>  	return nor->controller_ops->erase(nor, offs);
>  }
> 
> +/**
> + * spi_nor_spimem_get_read_op() - return a template for the spi_mem_op 
> used for
> + *                                reading data from the flash via 
> spi-mem.
> + * @nor:        pointer to 'struct spi_nor'
> + *
> + * Return: A template of the 'struct spi_mem_op' for used for reading 
> data from
> + * the flash. The caller is expected to fill in the address, data 
> length, and
> + * the data buffer.
> + */
> +static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor 
> *nor)
> +{
> +	struct spi_mem_op op =
> +		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
> +			   SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
> +			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
> +			   SPI_MEM_OP_DATA_IN(1, NULL, 0));
> +
> +	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
> +
> +	/* convert the dummy cycles to the number of bytes */
> +	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
> +	if (spi_nor_protocol_is_dtr(nor->read_proto))
> +		op.dummy.nbytes *= 2;
> +
> +	return op;
> +}
> +
>  /**
>   * spi_nor_spimem_read_data() - read data from flash's memory region 
> via
>   *                              spi-mem
> @@ -196,21 +223,14 @@ static int spi_nor_controller_ops_erase(struct
> spi_nor *nor, loff_t offs)
>  static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t 
> from,
>  					size_t len, u8 *buf)
>  {
> -	struct spi_mem_op op =
> -		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
> -			   SPI_MEM_OP_ADDR(nor->addr_width, from, 0),
> -			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
> -			   SPI_MEM_OP_DATA_IN(len, buf, 0));
> +	struct spi_mem_op op = spi_nor_spimem_get_read_op(nor);
>  	bool usebouncebuf;
>  	ssize_t nbytes;
>  	int error;
> 
> -	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
> -
> -	/* convert the dummy cycles to the number of bytes */
> -	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
> -	if (spi_nor_protocol_is_dtr(nor->read_proto))
> -		op.dummy.nbytes *= 2;
> +	op.addr.val = from;
> +	op.data.nbytes = len;
> +	op.data.buf.in = buf;
> 
>  	usebouncebuf = spi_nor_spimem_bounce(nor, &op);
> 
> @@ -3581,28 +3601,10 @@ EXPORT_SYMBOL_GPL(spi_nor_scan);
>  static int spi_nor_create_read_dirmap(struct spi_nor *nor)
>  {
>  	struct spi_mem_dirmap_info info = {
> -		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
> -				      SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
> -				      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
> -				      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
> +		.op_tmpl = spi_nor_spimem_get_read_op(nor),
>  		.offset = 0,
>  		.length = nor->mtd.size,
>  	};
> -	struct spi_mem_op *op = &info.op_tmpl;
> -
> -	spi_nor_spimem_setup_op(nor, op, nor->read_proto);
> -
> -	/* convert the dummy cycles to the number of bytes */
> -	op->dummy.nbytes = (nor->read_dummy * op->dummy.buswidth) / 8;
> -	if (spi_nor_protocol_is_dtr(nor->read_proto))
> -		op->dummy.nbytes *= 2;
> -
> -	/*
> -	 * Since spi_nor_spimem_setup_op() only sets buswidth when the number
> -	 * of data bytes is non-zero, the data buswidth won't be set here. 
> So,
> -	 * do it explicitly.
> -	 */
> -	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);

I guess this isn't needed anymore because spi_nor_spimem_get_read_op() 
uses a
data length of 1, right?

> 
>  	nor->dirmap.rdesc = devm_spi_mem_dirmap_create(nor->dev, nor->spimem,
>  						       &info);

-michael
