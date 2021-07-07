Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C03BED5C
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jul 2021 19:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhGGRur (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jul 2021 13:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhGGRur (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 7 Jul 2021 13:50:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61B1561CC8;
        Wed,  7 Jul 2021 17:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625680086;
        bh=NwW9hPZbo6WiaVKQyVLBNly7QG86j34upQqrPkM7lOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2Sijyod0DuXB32lTjytbHlzdmAzBRYmg1GW74O/g7kSdvSttqoNLZtfsEi833iiy
         V+6TOPW7dFk98dW8LTT5NYlGOVb0yhtM5K1A5huUc2OlYOCjC/tyHaz1fGpRTYoBjO
         62GdMD1lXp0mWtj9E5El1UqQz4dgPe18kgD3QVZf/zVPc7pziiNlb7+vQpKNbfi4Ph
         Le7PT52I+XonZ0/aNiYJFWO5iZygX/HFQYcLpNtaxgFKDyZtfAq289Gyq6Xpalr6Jz
         ps0qJKYaCXB+RnQfQ8pzdjkO5ZFEnR580PRR0D5HUl8tUE9crnwLC1FO0RAT2VzRty
         EEF/BNXp3O3PQ==
Date:   Wed, 7 Jul 2021 18:47:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     linux-spi@vger.kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        jbx6244@gmail.com, hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [RFC PATCH v11 02/10] spi: rockchip-sfc: add rockchip serial
 flash controller
Message-ID: <20210707174735.GL4394@sirena.org.uk>
References: <20210707090810.5717-1-jon.lin@rock-chips.com>
 <20210707090810.5717-3-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DheUW4aQn8WJk6WR"
Content-Disposition: inline
In-Reply-To: <20210707090810.5717-3-jon.lin@rock-chips.com>
X-Cookie: I will never lie to you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--DheUW4aQn8WJk6WR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 07, 2021 at 05:08:02PM +0800, Jon Lin wrote:

This looks pretty nice, a few small issues below but nothing major:

> +/* Maximum clock values from datasheet suggest keeping clock value under
> + * 150MHz. No minimum or average value is suggested, but the U-boot BSP driver
> + * has a minimum of 10MHz and a default of 80MHz which seems reasonable.
> + */

It's OK to just not specify a minimum if the hardware doesn't have one,
and AFAICT the driver doesn't actually use the default speed (the SPI
stack will generally try to go as fast as possible by default, the board
can configure the maximum speed and should be doing that if there's
issues).

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
> +	if (reg & SFC_RISR_DMA)
> +		complete(&sfc->cp);
> +
> +	return IRQ_HANDLED;
> +}

This will unconditionally ack any interrupt that is flagged, and doesn't
verify that there were any at all.  This won't work if the interrupt
ever gets shared and will mean that if something goes wrong and an
unexpected interrupt happens we'll at best just ignore it, at worst
we'll end up with a screaming interrupt constantly firing.  It'd be
better to at least return IRQ_NONE if we got anything unexpected (I
guess just if SFC_RISR_DMA isn't set, assuming there's nothing else
we're intentionally ignoring).

> +	master->mode_bits = SPI_TX_QUAD | SPI_TX_DUAL | SPI_RX_QUAD | SPI_RX_DUAL;

Should it also do SPI_HALF_DUPLEX?

> +	ret = devm_request_irq(dev, ret, rockchip_sfc_irq_handler,
> +			       0, pdev->name, sfc);
> +	if (ret) {
> +		dev_err(dev, "Failed to request irq\n");
> +
> +		return ret;
> +	}

Should we have a call to _irq_mask() before this to make sure that the
mask is set up correctly in the hardware, just in case?

--DheUW4aQn8WJk6WR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDl6LYACgkQJNaLcl1U
h9CYCgf/edFgXLelZ8xTZPdjXTqht/bm/19/3/7E8zPciE7D4Rg52/Q7aSkg8FQT
jeygndJe7ci6hOFa7wB4e7JEbeG68kEMKxMb0wum83t5yxaN3P3eorLQY38uOH6j
NrvCs4tfsdJZGUPqvCZrCB/LC3JrvWv/Mqt8X0QijX0gMxfbERz05TEgtkDiHnrs
iT+0XOmMrLMRNZUhwvT7kc99SuUi3f+XZ8O1PiDk5mYQmdhU2rl73p4XdS5xTixJ
lzkaj7IPNZ4TLqWKYvgZBr5qB6LPDdz+xO8aWv43Tfzi23IzcbBH5WEseHHmHd8u
fwzwyxWgxo6Wp9b+qiwS/MKug2MEow==
=oXL8
-----END PGP SIGNATURE-----

--DheUW4aQn8WJk6WR--
