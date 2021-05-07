Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBF137685A
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 17:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhEGP5v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 11:57:51 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:42175 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhEGP5v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 11:57:51 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0904C22172;
        Fri,  7 May 2021 17:56:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620403010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RlX56EVKnATFSbY1WCdGnFQlG9+VgC6LS9QI7u1IDuQ=;
        b=V8ZJFE6qkF+ARhwG4oqTCd375XiOM55ni++FlIQz05gVb2qIvUQYycjU+TS1awwla7S6PU
        wLlOGRvbHtnVfqqg2rs/pusnMuK7b5y5k9c8aT8ozXbGR4iK8WxRBbooQr+CqDUO5LebE0
        kAUqz3H+nsRQ2X9IPnPGu9vI197spv4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 May 2021 17:56:49 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 6/6] mtd: spi-nor: core; avoid odd length/address writes
 in 8D-8D-8D mode
In-Reply-To: <20210506191829.8271-7-p.yadav@ti.com>
References: <20210506191829.8271-1-p.yadav@ti.com>
 <20210506191829.8271-7-p.yadav@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <497da81bb1531b085941ea2e711cf9b6@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-05-06 21:18, schrieb Pratyush Yadav:
> On Octal DTR capable flashes like Micron Xcella the writes cannot start
> or end at an odd address in Octal DTR mode. Extra 0xff bytes need to be
> appended or prepended to make sure the start address and end address 
> are
> even. 0xff is used because on NOR flashes a program operation can only
> flip bits from 1 to 0, not the other way round. 0 to 1 flip needs to
> happen via erases.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
>  drivers/mtd/spi-nor/core.c | 72 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 3d66cc34af4d..265d8b25fc7f 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2022,6 +2022,71 @@ static int spi_nor_read(struct mtd_info *mtd,
> loff_t from, size_t len,
>  	return ret;
>  }
> 
> +/*
> + * On Octal DTR capable flashes like Micron Xcella the writes cannot 
> start or
> + * end at an odd address in Octal DTR mode. Extra 0xff bytes need to
> be appended
> + * or prepended to make sure the start address and end address are
> even. 0xff is
> + * used because on NOR flashes a program operation can only flip bits 
> from 1 to
> + * 0, not the other way round. 0 to 1 flip needs to happen via erases.
> + */
> +static int spi_nor_octal_dtr_write(struct spi_nor *nor, loff_t to, 
> size_t len,
> +				   const u8 *buf)
> +{
> +	u8 *tmp_buf;
> +	size_t bytes_written;
> +	loff_t start, end;
> +	int ret;
> +
> +	if (IS_ALIGNED(to, 2) && IS_ALIGNED(len, 2))
> +		return spi_nor_write_data(nor, to, len, buf);
> +
> +	tmp_buf = kmalloc(nor->page_size, GFP_KERNEL);
> +	if (!tmp_buf)
> +		return -ENOMEM;
> +
> +	memset(tmp_buf, 0xff, nor->page_size);

This could be replaced by just setting the first and the
last byte to 0xff. But this might be easier to read. I am
fine with both.

> +
> +	start = round_down(to, 2);
> +	end = round_up(to + len, 2);
> +
> +	memcpy(tmp_buf + (to - start), buf, len);
> +
> +	ret = spi_nor_write_data(nor, start, end - start, tmp_buf);
> +	if (ret == 0) {
> +		ret = -EIO;
> +		goto out;
> +	}
else if ? I've missed this in the other patch.

> +	if (ret < 0)
> +		goto out;
> +
> +	/*
> +	 * More bytes are written than actually requested, but that number 
> can't
> +	 * be reported to the calling function or it will confuse its
> +	 * calculations. Calculate how many of the _requested_ bytes were
> +	 * written.
> +	 */
> +	bytes_written = ret;
> +
> +	if (to != start)
> +		ret -= to - start;
> +
> +	/*
> +	 * Only account for extra bytes at the end if they were actually
> +	 * written. For example, if for some reason the controller could only
> +	 * complete a partial write then the adjustment for the extra bytes 
> at
> +	 * the end is not needed.
> +	 */
> +	if (start + bytes_written == end)
> +		ret -= end - (to + len);
> +
> +	if (ret < 0)
> +		ret = -EIO;

can this happen?

> +
> +out:
> +	kfree(tmp_buf);
> +	return ret;
> +}
> +
>  /*
>   * Write an address range to the nor chip.  Data must be written in
>   * FLASH_PAGESIZE chunks.  The address range may be any size provided
> @@ -2066,7 +2131,12 @@ static int spi_nor_write(struct mtd_info *mtd,
> loff_t to, size_t len,
>  		if (ret)
>  			goto write_err;
> 
> -		ret = spi_nor_write_data(nor, addr, page_remain, buf + i);
> +		if (nor->write_proto == SNOR_PROTO_8_8_8_DTR)
> +			ret = spi_nor_octal_dtr_write(nor, addr, page_remain,
> +						      buf + i);
> +		else
> +			ret = spi_nor_write_data(nor, addr, page_remain,
> +						 buf + i);
>  		if (ret < 0)
>  			goto write_err;
>  		written = ret;

-michael
