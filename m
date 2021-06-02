Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEC5398F8B
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jun 2021 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhFBQFv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Jun 2021 12:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229881AbhFBQFu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Jun 2021 12:05:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 421D961603;
        Wed,  2 Jun 2021 16:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622649847;
        bh=UmxHIs8gIZ5iLjR/tIvHTVnBvwuZRE0DAEiCxwneDmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBaMjmfPVyy0CncM3ugyGNGN1GgnjvoXUOZa0YGlofZfcZMV3nLe99BdBK8UxFFVR
         Zq0goPPHKztTsxp/bfXsdCJxWVhXyanda9aQ1uPEp50gqLi4vs+ffgeOWho0IIdsod
         DqETZuujZFXs7EXRghWku9W+0b+7QrX5K0xBbxHkAZwIUe8IY+Le8crK2DgA4JvEqs
         nVHWUT29sLlZR54wNl1XJwo4Dre5KQckgtlodgwhxEbZDri4C1BgdwtI+boPEMTjBn
         fw7ihMEONjzfhskR3IueuI41ifrfxmVXbSLP+sDmRlyolBCn6/loefvYDmcax8amrr
         p9+9mrAzDjtiQ==
Date:   Wed, 2 Jun 2021 17:03:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-spi@vger.kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        jbx6244@gmail.com, hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v3 2/4] spi: rockchip-sfc: add rockchip serial flash
 controller driver
Message-ID: <20210602160357.GA4914@sirena.org.uk>
References: <20210601201021.4406-1-macroalpha82@gmail.com>
 <20210601201021.4406-3-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20210601201021.4406-3-macroalpha82@gmail.com>
X-Cookie: I have a TINY BOWL in my HEAD
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 01, 2021 at 03:10:19PM -0500, Chris Morgan wrote:

This looks mostly good, a few mostly minor comments below:

> @@ -0,0 +1,861 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Rockchip Serial Flash Controller Driver

Please make the entire comment a C++ one to make things look more
intentional.

> +static int rockchip_sfc_get_if_type(const struct spi_mem_op *op,
> +				    struct rockchip_sfc *sfc)
> +{
> +	if (op->data.buswidth == 2)
> +		return IF_TYPE_DUAL;
> +	else if (op->data.buswidth == 4)
> +		return IF_TYPE_QUAD;
> +	else if (op->data.buswidth == 1)
> +		return IF_TYPE_STD;
> +
> +	dev_err(sfc->dev, "unsupported SPI read mode\n");
> +
> +	return -EINVAL;
> +}

This would be more idiomatically implemented as a switch statement.

> +static int rockchip_sfc_wait_fifo_ready(struct rockchip_sfc *sfc, int wr, u32 timeout)
> +{
> +	unsigned long deadline = jiffies + timeout;
> +	int level;
> +
> +	while (!(level = rockchip_sfc_get_fifo_level(sfc, wr))) {
> +		if (time_after_eq(jiffies, deadline)) {
> +			dev_warn(sfc->dev, "%s fifo timeout\n", wr ? "write" : "read");
> +			return -ETIMEDOUT;
> +		}
> +		udelay(1);
> +	}
> +
> +	return level;

The use of the assignment in the while conditional makes it hard to tell
if this code is doing what was intended.

> +static int rockchip_sfc_write_fifo(struct rockchip_sfc *sfc, const u8 *buf, int len)
> +{
> +	u8 bytes = len & 0x3;
> +	u32 dwords;
> +	int tx_level;
> +	u32 write_words;
> +	u32 tmp = 0;
> +
> +	dwords = len >> 2;
> +	while (dwords) {
> +		tx_level = rockchip_sfc_wait_fifo_ready(sfc, SFC_CMD_DIR_WR, HZ);
> +		if (tx_level < 0)
> +			return tx_level;
> +		write_words = min_t(u32, tx_level, dwords);
> +		iowrite32_rep(sfc->regbase + SFC_DATA, buf, write_words);
> +		buf += write_words << 2;
> +		dwords -= write_words;
> +		}

Weird indentation on the } here.

> +	/* write the rest non word aligned bytes */
> +	if (bytes) {
> +		tx_level = rockchip_sfc_wait_fifo_ready(sfc, SFC_CMD_DIR_WR, HZ);

It's not the source buffer being aligned that's the issue here, it's the
buffer not being a multiple of word size.

> +static irqreturn_t rockchip_sfc_irq_handler(int irq, void *dev_id)
> +{
> +	struct rockchip_sfc *sfc = dev_id;
> +	u32 reg;
> +
> +	reg = readl(sfc->regbase + SFC_RISR);
> +
> +	/* Clear interrupt */
> +	writel_relaxed(reg, sfc->regbase + SFC_ICLR);
> +
> +	if (reg & SFC_RISR_TRAN_FINISH)
> +		complete(&sfc->cp);
> +
> +	return IRQ_HANDLED;
> +}

This will silently clear any unknown interrupt, and silently claim to
have handled an interrupt even if none happened (eg, due to shared IRQs)
- it would be better to only ack interrupts we handle and return
IRQ_NONE if we didn't handle any.

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC3q+wACgkQJNaLcl1U
h9DaZwf/TBAW5Mib787bZ5E3BsaVGC/10vofELuvEYHcGtG4gCwlvutonxRUEKzc
dJSlwxCCaA8oFIasCxs5CioPxVnO7VSmUra5XSOqBxgCmX+s/paa1GMB4Ej1fzAq
qLrC4eqdp5GOM83BYrQ6Hx2H1ruqBP13Boie+TLLARIrqwkt/85EL/AbIQWFNUyy
RIbHhyFcXj8CFB3k43GPmqXyNjXIhXJKxpE0NFicJ5YFcsMnFNpGFDzDmraiM9jm
r24CurvxVZCRVQw4qIt4B7KJJIsFRrDn1P1Y8FQpFyQhPD6v1I714tUl5byIP8eH
t//VBnR7kzk63aGmnx0NMMLSfp1YbQ==
=vM+9
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
