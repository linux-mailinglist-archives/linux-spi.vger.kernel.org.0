Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4053376932
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhEGRDQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 13:03:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41138 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhEGRDO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 May 2021 13:03:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 147H22iv059092;
        Fri, 7 May 2021 12:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620406922;
        bh=M9uXcU0z2Uxrjv02IUufwWOXXNfDJkZ+Xvp1k7QuVUU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=AUua5s/LQ1EJd6xUjnDciG57BGBLGpfZtpDVZNXA609FISiorrefrKPLA/HrswyXM
         f305tnc5NA87K79DSE1K8VoYVq07FPvw+nwVT7wa/SyWIWkui8yBTb6VrAanNkXBf0
         3SeLujy+6ljaAn94moYhtcRCYUWh1IcP8lM72M/0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 147H21X6009412
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 May 2021 12:02:02 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 7 May
 2021 12:02:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 7 May 2021 12:02:01 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 147H21ba064377;
        Fri, 7 May 2021 12:02:01 -0500
Date:   Fri, 7 May 2021 22:32:00 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 6/6] mtd: spi-nor: core; avoid odd length/address writes
 in 8D-8D-8D mode
Message-ID: <20210507170158.s76lebxn7v2wyvfy@ti.com>
References: <20210506191829.8271-1-p.yadav@ti.com>
 <20210506191829.8271-7-p.yadav@ti.com>
 <497da81bb1531b085941ea2e711cf9b6@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <497da81bb1531b085941ea2e711cf9b6@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 07/05/21 05:56PM, Michael Walle wrote:
> Am 2021-05-06 21:18, schrieb Pratyush Yadav:
> > On Octal DTR capable flashes like Micron Xcella the writes cannot start
> > or end at an odd address in Octal DTR mode. Extra 0xff bytes need to be
> > appended or prepended to make sure the start address and end address are
> > even. 0xff is used because on NOR flashes a program operation can only
> > flip bits from 1 to 0, not the other way round. 0 to 1 flip needs to
> > happen via erases.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > 
> > ---
> > 
> >  drivers/mtd/spi-nor/core.c | 72 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 71 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 3d66cc34af4d..265d8b25fc7f 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -2022,6 +2022,71 @@ static int spi_nor_read(struct mtd_info *mtd,
> > loff_t from, size_t len,
> >  	return ret;
> >  }
> > 
> > +/*
> > + * On Octal DTR capable flashes like Micron Xcella the writes cannot
> > start or
> > + * end at an odd address in Octal DTR mode. Extra 0xff bytes need to
> > be appended
> > + * or prepended to make sure the start address and end address are
> > even. 0xff is
> > + * used because on NOR flashes a program operation can only flip bits
> > from 1 to
> > + * 0, not the other way round. 0 to 1 flip needs to happen via erases.
> > + */
> > +static int spi_nor_octal_dtr_write(struct spi_nor *nor, loff_t to,
> > size_t len,
> > +				   const u8 *buf)
> > +{
> > +	u8 *tmp_buf;
> > +	size_t bytes_written;
> > +	loff_t start, end;
> > +	int ret;
> > +
> > +	if (IS_ALIGNED(to, 2) && IS_ALIGNED(len, 2))
> > +		return spi_nor_write_data(nor, to, len, buf);
> > +
> > +	tmp_buf = kmalloc(nor->page_size, GFP_KERNEL);
> > +	if (!tmp_buf)
> > +		return -ENOMEM;
> > +
> > +	memset(tmp_buf, 0xff, nor->page_size);
> 
> This could be replaced by just setting the first and the
> last byte to 0xff. But this might be easier to read. I am
> fine with both.

First, yes. Not the last. The buffer is allocated to nor->page_size for 
simplicity but the write could be smaller than nor->page_size. So you'd 
need to calculate the position of the other 0xff byte. It is much 
simpler to just initialize the whole buffer. It will be around 256 or 
512 bytes so not a big overhead.

> 
> > +
> > +	start = round_down(to, 2);
> > +	end = round_up(to + len, 2);
> > +
> > +	memcpy(tmp_buf + (to - start), buf, len);
> > +
> > +	ret = spi_nor_write_data(nor, start, end - start, tmp_buf);
> > +	if (ret == 0) {
> > +		ret = -EIO;
> > +		goto out;
> > +	}
> else if ? I've missed this in the other patch.

Following the style used in spi_nor_read(). Anyway, I've seen 
conflicting advice on which style to be used. Some people don't like 
else if when the if ends in a return since it is effectively an else if. 
Others like it the other way round. Dunno...

> 
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	/*
> > +	 * More bytes are written than actually requested, but that number
> > can't
> > +	 * be reported to the calling function or it will confuse its
> > +	 * calculations. Calculate how many of the _requested_ bytes were
> > +	 * written.
> > +	 */
> > +	bytes_written = ret;
> > +
> > +	if (to != start)
> > +		ret -= to - start;
> > +
> > +	/*
> > +	 * Only account for extra bytes at the end if they were actually
> > +	 * written. For example, if for some reason the controller could only
> > +	 * complete a partial write then the adjustment for the extra bytes at
> > +	 * the end is not needed.
> > +	 */
> > +	if (start + bytes_written == end)
> > +		ret -= end - (to + len);
> > +
> > +	if (ret < 0)
> > +		ret = -EIO;
> 
> can this happen?

I don't think so. IIRC this is left over from when I tried a different 
approach. Maybe I should change it to WARN_ON() to catch future 
programming errors? Though I don't mind if we drop it entirely.

> 
> > +
> > +out:
> > +	kfree(tmp_buf);
> > +	return ret;
> > +}
> > +
> >  /*
> >   * Write an address range to the nor chip.  Data must be written in
> >   * FLASH_PAGESIZE chunks.  The address range may be any size provided
> > @@ -2066,7 +2131,12 @@ static int spi_nor_write(struct mtd_info *mtd,
> > loff_t to, size_t len,
> >  		if (ret)
> >  			goto write_err;
> > 
> > -		ret = spi_nor_write_data(nor, addr, page_remain, buf + i);
> > +		if (nor->write_proto == SNOR_PROTO_8_8_8_DTR)
> > +			ret = spi_nor_octal_dtr_write(nor, addr, page_remain,
> > +						      buf + i);
> > +		else
> > +			ret = spi_nor_write_data(nor, addr, page_remain,
> > +						 buf + i);
> >  		if (ret < 0)
> >  			goto write_err;
> >  		written = ret;
> 
> -michael

Thanks for reviewing.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
