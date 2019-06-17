Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A6347E73
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2019 11:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfFQJax (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 05:30:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40351 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfFQJax (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 05:30:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so9137407wre.7
        for <linux-spi@vger.kernel.org>; Mon, 17 Jun 2019 02:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RIQHxnayIGS540Niq5Hrt/TIAmNLG1rVSg1z8VMAWfY=;
        b=I05raPXC7/eRhJ2832/2JXcuK/DiAGBsfV+Wo6HVAhKZQS+9WhJDnnxduYAu1bUego
         ZhtnPCCEHN+5r6FXAK7vnjVgUYACmAAPtivp5+GkwZgK23mGbUjFrhEXvtNOYPGK2EjB
         P5MoTpyLs0405KVIAz5XgDyBdV8JS54yQkWKfkGO9qmC1W6t3CFkfRchdGiQj4YW6gUC
         21sIlnvpqEBtYtOMC2KA545JNsQMsfakmRmgIw03j6PFAtdec4IRml13i5Fko7xF4SqU
         qsyMMSQ7FRSljhEpWug7X0o0apDWnW87uFeIkv222MvRFayqQ6IcYdbx94YT5/5xczXp
         zG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RIQHxnayIGS540Niq5Hrt/TIAmNLG1rVSg1z8VMAWfY=;
        b=fg5tpRYJjTTheMrBDYpbU9EZQhknuGo727XKHKa5c7HvMr2/GUYPAxpaMAEhSUmKTy
         yimqSNAx3IZQb7vBCzlwxjCN71UgMamxqZJAktQSHIUJ0W4Bl+Dn5qDKvcykeSpsXzbP
         vai+agboeGMmVpZHILfzH22xMa+qqGwpvVFRULHa7WdUh+3eZ3Sg71V+upylYdMGEUnw
         3xgzxCHTzTUfS8ZOS73GDVwS/r5xkEioWLo7YqZ4s9ZzjKf9H4sJ01rFhiWPTNlSCGaJ
         0zXfeLXT04sDlpAANTSgwAc9H/pW1kOK9RTQaX5NRByfQfjCQK2G2hxj2BCFT1dpXWRT
         1oxg==
X-Gm-Message-State: APjAAAWTJUG52bBr4Nfx3M7fLkGDpwpLGxs26D88oKufoc36x5qXzbHS
        OSr3KKYezHsfvfxR/6CU5op36my6YyE=
X-Google-Smtp-Source: APXvYqyCxFcfCqJvcZYixW6E2E3t2OTHEfj2XGSuwkSfarXDrTQVh0Y2MIgwPvvpChudY0dfvjE21A==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr9027414wre.283.1560763850411;
        Mon, 17 Jun 2019 02:30:50 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id o126sm7178709wmo.1.2019.06.17.02.30.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 02:30:49 -0700 (PDT)
Date:   Mon, 17 Jun 2019 10:30:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, linux-spi@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
Message-ID: <20190617093048.GD16364@dell>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com>
 <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 14 Jun 2019, Sergei Shtylyov wrote:
> On 06/12/2019 12:05 PM, Lee Jones wrote:
> 
> >> Add the MFD driver for Renesas RPC-IF which registers either the SPI or
> >> HyperFLash  device depending on the contents of the device tree subnode.
> >> It also provides the absract "back end" device APIs that can be used by
> >> the "front end" SPI/MTD drivers to talk to the real hardware.
> >>
> >> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
> >>
> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> [...]
> >> Index: mfd/drivers/mfd/rpc-if.c
> >> ===================================================================
> >> --- /dev/null
> >> +++ mfd/drivers/mfd/rpc-if.c
> >> @@ -0,0 +1,535 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Renesas RPC-IF MFD driver
> >> + *
> >> + * Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
> >> + * Copyright (C) 2019 Macronix International Co., Ltd.
> >> + * Copyright (C) 2019 Cogent Embedded, Inc.
> >> + */
> >> +
> >> +#include <linux/clk.h>
> >> +#include <linux/io.h>
> >> +#include <linux/mfd/core.h>
> >> +#include <linux/mfd/rpc-if.h>
> >> +#include <linux/module.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/of.h>
> >> +#include <linux/pm_runtime.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/reset.h>
> > 
> > Alphabetical.
> 
>   I thought they were all sorted them but one #include escaped! :-)
> 
> >> +#include <asm/unaligned.h>
> >> +
> >> +#define RPCIF_CMNCR		0x0000	// R/W
> > 
> > No C++ comments.
> 
>    Well, with the appearance of the SPDX IDs, we thought that //'s will become
> acceptable as well -- and indeed Mark Brown has requested consistent C++ comments
> following the SPDX line for my SPI "sub-driver"...
>    But anyway doesn't seem to be codified yet, so I'll have to fix that, grr... :-(

He means in the header comment only.  This does not open the flood
gates for C++ comments throughout the kernel.

> [...]
> >> +#define RPCIF_DIRMAP_SIZE	0x4000000
> > 
> > Can you shift this lot out to a header file please.
> 
>    You mean all register #defne's? Why? I'm not intending to use them outside
> this file.

Because its 10's of lines of cruft.

People won't want to wade through that to get to real functional C
code every time they open up this file.

You already have a header file, please use it.

> >> +void rpcif_enable_rpm(struct rpcif *rpc)
> >> +{
> >> +	pm_runtime_enable(rpc->dev);
> >> +}
> >> +EXPORT_SYMBOL(rpcif_enable_rpm);
> >> +
> >> +void rpcif_disable_rpm(struct rpcif *rpc)
> >> +{
> >> +	pm_runtime_disable(rpc->dev);
> >> +}
> >> +EXPORT_SYMBOL(rpcif_disable_rpm);
> > 
> > Where are you exporting these out to?
> 
>    The "sub-drivers" (SPI/HyperFlash-to-RPC translation drivers).
> 
> > Why are you seemingly unnecessarily abstracting out the pm_* API?
> 
>    With RPM being otherwise controlled by this driver, I thought that should be
> consistent.

Just use the pm_runtime_*() API directly.

> >> +void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
> >> +{
> >> +	pm_runtime_get_sync(rpc->dev);
> >> +
> >> +	/*
> >> +	 * NOTE: The 0x260 are undocumented bits, but they must be set.
> >> +	 *	 RPCIF_PHYCNT_STRTIM is strobe timing adjustment bit,
> >> +	 *	 0x0 : the delay is biggest,
> >> +	 *	 0x1 : the delay is 2nd biggest,
> >> +	 *	 On H3 ES1.x, the value should be 0, while on others,
> >> +	 *	 the value should be 6.
> >> +	 */
> >> +	regmap_write(rpc->regmap, RPCIF_PHYCNT,
> >> +		     RPCIF_PHYCNT_CAL | RPCIF_PHYCNT_STRTIM(6) |
> >> +		     RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);
> > 
> > At least #define it, even it it's not documented.
> 
>    Do you have an idea how to name such #define?

How did you find out that they must be set?

How did you find out the value?

What happens if they are not set?

> >> +	/*
> >> +	 * NOTE: The 0x1511144 are undocumented bits, but they must be set
> >> +	 *       for RPCIF_PHYOFFSET1.
> >> +	 *	 The 0x31 are undocumented bits, but they must be set
> >> +	 *	 for RPCIF_PHYOFFSET2.
> >> +	 */
> >> +	regmap_write(rpc->regmap, RPCIF_PHYOFFSET1,
> >> +		     RPCIF_PHYOFFSET1_DDRTMG(3) | 0x1511144);
> >> +	regmap_write(rpc->regmap, RPCIF_PHYOFFSET2, 0x31 |
> >> +		     RPCIF_PHYOFFSET2_OCTTMG(4));
> > 
> > No magic numbers.  Please #define them all.
> 
>    what about aming?

I'd be happy to help, but I need some more information (see above).

> [...]
> >> +static int wait_msg_xfer_end(struct rpcif *rpc)
> >> +{
> >> +	u32 sts;
> >> +
> >> +	return regmap_read_poll_timeout(rpc->regmap, RPCIF_CMNSR, sts,
> >> +					sts & RPCIF_CMNSR_TEND, 0,
> > 
> > Aren't you using sts undefined here?
> 
>    No, the macro reads 'sts' from the register first.

That's confusing and ugly.

Please re-write it to the code is clear and easy to read/maintain.

> [...]
> > Looking at all this code from here ...
> > 
> >> +void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
> >> +		   size_t *len)
> >> +{
> >> +	rpc->enable = 0;
> >> +	rpc->command = 0;
> >> +	rpc->xferlen = 0;
> >> +	rpc->address = 0;
> >> +	rpc->ddr = 0;
> >> +
> >> +	if (op->cmd.buswidth) {
> >> +		rpc->enable  |= RPCIF_SMENR_CDE |
> >> +				RPCIF_SMENR_CDB(ilog2(op->cmd.buswidth));
> >> +		rpc->command |= RPCIF_SMCMR_CMD(op->cmd.opcode);
> >> +		if (op->cmd.ddr)
> >> +			rpc->ddr |= RPCIF_SMDRENR_HYPE(0x5);
> >> +	}
> >> +	if (op->ocmd.buswidth) {
> >> +		rpc->enable  |= RPCIF_SMENR_OCDE |
> >> +				RPCIF_SMENR_OCDB(ilog2(op->ocmd.buswidth));
> >> +		rpc->command |= RPCIF_SMCMR_OCMD(op->ocmd.opcode);
> >> +	}
> >> +
> >> +	if (op->addr.buswidth) {
> >> +		rpc->enable |= RPCIF_SMENR_ADB(ilog2(op->addr.buswidth));
> >> +		if (op->addr.nbytes == 4)
> >> +			rpc->enable |= RPCIF_SMENR_ADE(0xf);
> >> +		else
> >> +			rpc->enable |= RPCIF_SMENR_ADE(0x7);
> >> +		if (op->addr.ddr)
> >> +			rpc->ddr |= RPCIF_SMDRENR_ADDRE;
> >> +
> >> +		if (offs && len)
> >> +			rpc->address = *offs;
> >> +		else
> >> +			rpc->address = op->addr.val;
> >> +	}
> >> +
> >> +	if (op->dummy.buswidth) {
> >> +		rpc->enable |= RPCIF_SMENR_DME;
> >> +		rpc->dummy   = RPCIF_SMDMCR_DMCYC(op->dummy.nbytes * 8 /
> >> +						  op->dummy.buswidth);
> >> +	}
> >> +
> >> +	if (op->option.buswidth) {
> >> +		rpc->enable |= RPCIF_SMENR_OPDE(
> >> +					rpcif_bits_set(op->option.nbytes)) |
> >> +			       RPCIF_SMENR_OPDB(ilog2(op->option.buswidth));
> >> +		if (op->option.ddr)
> >> +			rpc->ddr |= RPCIF_SMDRENR_OPDRE;
> >> +		rpc->option = op->option.val;
> >> +	}
> >> +
> >> +	if (op->data.buswidth || (offs && len)) {
> >> +		switch (op->data.dir) {
> >> +		case RPCIF_DATA_IN:
> >> +			rpc->smcr = RPCIF_SMCR_SPIRE;
> >> +			break;
> >> +		case RPCIF_DATA_OUT:
> >> +			rpc->smcr = RPCIF_SMCR_SPIWE;
> >> +			break;
> >> +		default:
> >> +			break;
> >> +		}
> >> +		if (op->data.ddr)
> >> +			rpc->ddr |= RPCIF_SMDRENR_SPIDRE;
> >> +
> >> +		if (offs && len) {
> >> +			rpc->enable |= RPCIF_SMENR_SPIDE(rpcif_bits_set(*len)) |
> >> +				       RPCIF_SMENR_SPIDB(
> >> +						ilog2(op->data.buswidth));
> >> +			rpc->xferlen = *len;
> >> +		} else {
> >> +			rpc->enable |=
> >> +				RPCIF_SMENR_SPIDE(
> >> +					rpcif_bits_set(op->data.nbytes)) |
> >> +				RPCIF_SMENR_SPIDB(ilog2(op->data.buswidth));
> >> +			rpc->xferlen = op->data.nbytes;
> >> +		}
> >> +	}
> >> +}
> >> +EXPORT_SYMBOL(rpcif_prepare);
> >> +
> >> +int rpcif_io_xfer(struct rpcif *rpc, const void *tx_buf, void *rx_buf)
> >> +{
> >> +	u32 smenr, smcr, data, pos = 0;
> >> +	int ret = 0;
> >> +
> >> +	pm_runtime_get_sync(rpc->dev);
> >> +
> >> +	regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD,
> >> +			   RPCIF_CMNCR_MD);
> >> +	regmap_write(rpc->regmap, RPCIF_SMCMR, rpc->command);
> >> +	regmap_write(rpc->regmap, RPCIF_SMDMCR, rpc->dummy);
> >> +	regmap_write(rpc->regmap, RPCIF_SMADR, rpc->address);
> >> +	regmap_write(rpc->regmap, RPCIF_SMDRENR, rpc->ddr);
> >> +	smenr = rpc->enable;
> >> +
> >> +	if (tx_buf) {
> >> +		while (pos < rpc->xferlen) {
> >> +			u32 nbytes = rpc->xferlen - pos;
> >> +
> >> +			regmap_write(rpc->regmap, RPCIF_SMWDR0,
> >> +				     get_unaligned((u32 *)(tx_buf + pos)));
> >> +
> >> +			smcr = rpc->smcr | RPCIF_SMCR_SPIE;
> >> +
> >> +			if (nbytes > 4) {
> >> +				nbytes = 4;
> >> +				smcr |= RPCIF_SMCR_SSLKP;
> >> +			}
> >> +
> >> +			regmap_write(rpc->regmap, RPCIF_SMENR, smenr);
> >> +			regmap_write(rpc->regmap, RPCIF_SMCR, smcr);
> >> +			ret = wait_msg_xfer_end(rpc);
> >> +			if (ret)
> >> +				goto err_out;
> >> +
> >> +			pos += nbytes;
> >> +			smenr = rpc->enable &
> >> +				~RPCIF_SMENR_CDE & ~RPCIF_SMENR_ADE(0xf);
> >> +		}
> >> +	} else if (rx_buf) {
> >> +		/*
> >> +		 * RPC-IF spoils the data for the commands without an address
> >> +		 * phase (like RDID) in the manual mode, so we'll have to work
> >> +		 * around this issue by using the external address space read
> >> +		 * mode instead.
> >> +		 */
> >> +		if (!(smenr & RPCIF_SMENR_ADE(0xf)) && rpc->dirmap) {
> >> +			regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
> >> +					   RPCIF_CMNCR_MD, 0);
> >> +			regmap_write(rpc->regmap, RPCIF_DRCR,
> >> +				     RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
> >> +			regmap_write(rpc->regmap, RPCIF_DREAR,
> >> +				     RPCIF_DREAR_EAC(1));
> >> +			regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
> >> +			regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
> >> +			regmap_write(rpc->regmap, RPCIF_DROPR, 0);
> >> +			regmap_write(rpc->regmap, RPCIF_DRENR,
> >> +				     smenr & ~RPCIF_SMENR_SPIDE(0xf));
> >> +			memcpy_fromio(rx_buf, rpc->dirmap, rpc->xferlen);
> >> +			regmap_write(rpc->regmap, RPCIF_DRCR, RPCIF_DRCR_RCF);
> >> +		} else {
> >> +			while (pos < rpc->xferlen) {
> >> +				u32 nbytes = rpc->xferlen - pos;
> >> +
> >> +				if (nbytes > 4)
> >> +					nbytes = 4;
> >> +
> >> +				regmap_write(rpc->regmap, RPCIF_SMENR, smenr);
> >> +				regmap_write(rpc->regmap, RPCIF_SMCR,
> >> +					     rpc->smcr	| RPCIF_SMCR_SPIE);
> >> +				ret = wait_msg_xfer_end(rpc);
> >> +				if (ret)
> >> +					goto err_out;
> >> +
> >> +				regmap_read(rpc->regmap, RPCIF_SMRDR0, &data);
> >> +				memcpy(rx_buf + pos, &data, nbytes);
> >> +				pos += nbytes;
> >> +
> >> +				regmap_write(rpc->regmap, RPCIF_SMADR,
> >> +					     rpc->address + pos);
> >> +			}
> >> +		}
> >> +	} else {
> >> +		regmap_write(rpc->regmap, RPCIF_SMENR, rpc->enable);
> >> +		regmap_write(rpc->regmap, RPCIF_SMCR,
> >> +			     rpc->smcr | RPCIF_SMCR_SPIE);
> >> +		ret = wait_msg_xfer_end(rpc);
> >> +		if (ret)
> >> +			goto err_out;
> >> +	}
> >> +
> >> +exit:
> >> +	pm_runtime_put(rpc->dev);
> >> +	return ret;
> >> +
> >> +err_out:
> >> +	ret = reset_control_reset(rpc->rstc);
> >> +	goto exit;
> >> +}
> >> +EXPORT_SYMBOL(rpcif_io_xfer);
> >> +
> >> +ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
> >> +{
> >> +	loff_t from = offs & (RPCIF_DIRMAP_SIZE - 1);
> >> +	size_t size = RPCIF_DIRMAP_SIZE - from;
> >> +	int rc;
> >> +
> >> +	if (len > size)
> >> +		len = size;
> >> +
> >> +	rc = pm_runtime_get_sync(rpc->dev);
> >> +
> >> +	regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD, 0);
> >> +	regmap_write(rpc->regmap, RPCIF_DRCR,
> >> +		     RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
> >> +
> >> +	regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
> >> +	regmap_write(rpc->regmap, RPCIF_DREAR,
> >> +		     RPCIF_DREAR_EAV(offs >> 25) | RPCIF_DREAR_EAC(1));
> >> +	regmap_write(rpc->regmap, RPCIF_DROPR, rpc->option);
> >> +	regmap_write(rpc->regmap, RPCIF_DRENR,
> >> +		     rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
> >> +	regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
> >> +	regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);
> >> +
> >> +	memcpy_fromio(buf, rpc->dirmap + from, len);
> >> +
> >> +	pm_runtime_put(rpc->dev);
> >> +
> >> +	return len;
> >> +}
> >> +EXPORT_SYMBOL(rpcif_dirmap_read);
> > 
> > ... to here.
> > 
> > Not sure what all this is, but it looks like it doesn't have anything
> 
>    This is an abstracted "back end" API for the "front end" MTD/SPI drivers.
> Only this code talks to real RPC-IF hardware. Probably needs some kernel-doc...

I suggest this needs moving out to a suitable subsystem.

Possibly MTD.

> > to do with MFD.  I suggest you move it to somewhere more appropriate.
> 
>    Like where?

MTD?

> >> +static const struct mfd_cell rpcif_hf_ctlr = {
> >> +	.name = "rpcif-hyperflash",
> >> +};
> >> +
> >> +static const struct mfd_cell rpcif_spi_ctlr = {
> >> +	.name = "rpcif-spi",
> >> +};
> > 
> > This looks like a very tenuous use of the MFD API.
> > 
> > I suggest that this isn't actually an MFD at all.
> 
>    The same hardware supports 2 different physical interfaces, hence
> the drivers have to comply to 2 different driver frameworks... sounded
> like MFD to me. :-)

Not to me.

This appears to be some kind of 'mode selector' for an MTD device.

Lots of drivers have multiple ways to control them - they are not all
MFDs.

> [...]
> >> +static int rpcif_probe(struct platform_device *pdev)
> >> +{
> >> +	struct device_node *flash;
> >> +	const struct mfd_cell *cell;
> >> +	struct resource *res;
> >> +	void __iomem *base;
> >> +	struct rpcif *rpc;
> >> +
> >> +	flash = of_get_next_child(pdev->dev.of_node, NULL);
> >> +	if (!flash) {
> >> +		dev_warn(&pdev->dev, "no flash node found\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	if (of_device_is_compatible(flash, "jedec,spi-nor")) {
> >> +		cell = &rpcif_spi_ctlr;
> >> +	} else if (of_device_is_compatible(flash, "cfi-flash")) {
> >> +		cell = &rpcif_hf_ctlr;
> >> +	} else {
> >> +		dev_warn(&pdev->dev, "unknown flash type\n");
> >> +		return -ENODEV;
> >> +	}
> > 
> > Why not let DT choose which device to probe?
> 
>    It's the DT that decides here. How else would you imagine that?
> It's the same hardware, just the different physical busses that it
> commands...

DT is not deciding here.  This driver is deciding based on the
information contained in the tables - very different thing.

Why not just let the OF framework probe the correct device i.e. let it
parse the 2 compatible strings and let it match the correct driver for
the device?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
