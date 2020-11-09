Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E822AC132
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 17:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgKIQqA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 11:46:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgKIQqA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 11:46:00 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8992E2074F;
        Mon,  9 Nov 2020 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604940360;
        bh=Hc1kUA8u+G3SRCoMavf4BNrfi7w15jVZjdFjmr6NKhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jz1yGbLmYqLVDaBDD5wfYnkDkVR9A33JWI1LY91jZJ7j4fGmATeOam5nwB1bcjD+Z
         LoeO5DbCmPHvqpdpTTFvKSKqXi3RGT6Uo5dAi5PYcQ702IdUjdw4awZ91O/XNwME2t
         6ZGvHa6wu9XovDgmpvYhoN1OIg4EyQ9byx3ELLkI=
Date:   Mon, 9 Nov 2020 16:45:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Sean Anderson <seanga2@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 03/32] spi: dw: Fix driving MOSI low while recieving
Message-ID: <20201109164546.GG6380@sirena.org.uk>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-4-damien.lemoal@wdc.com>
 <20201109132935.GB6380@sirena.org.uk>
 <c37ca9be-ea92-b07a-b600-d68de4f7bde5@gmail.com>
 <20201109141422.GD6380@sirena.org.uk>
 <20201109144808.mvttq2f6st7xd7sm@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
Content-Disposition: inline
In-Reply-To: <20201109144808.mvttq2f6st7xd7sm@mobilestation>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2020 at 05:48:08PM +0300, Serge Semin wrote:
> On Mon, Nov 09, 2020 at 02:14:22PM +0000, Mark Brown wrote:
> > On Mon, Nov 09, 2020 at 08:47:10AM -0500, Sean Anderson wrote:

> > > There is a recieve-only mode, but it is not used by this driver. Perhaps
> > > it should be.

> > I'd expect it'd perform better, especially on systems that are
> > apparently struggling for CPU bandwidth like yours seems to.

> Well, it might seem a good idea to use that mode, but there are multiple problems
> you may get in implementing it.

> First of all the Receive-only mode is having a limited number bytes to receive
> at once. It's just 64KB. So in order to implement it you'd need to split the
> bigger transfers up, and feed the DMA engine with smaller chunks one-by-one.

That at least is handlable, even if it's only by falling back to
transmitting when the data grows over 64K.

> Secondly the Receive-only mode will make the DW SSI controller to constantly receive
> the data from the SPI bus and to put it into the Rx FIFO. So your DMA engine will
> have to keep up with extracting the data from there on time, otherwise you'll
> end up with Rx FIFO overflow error eventually. The problem will be actual for the
> DMA engines/system buses, which are slower than the SPI bus speed, second for the
> DMA engines with no hardware accelerated LLP traversal support (like on our DWC DMA
> controller). The second problem can be also fixed by splitting the transfers up as
> it has been already implemented in the spi-dw-dma.c. But the first problem can't be
> fixed, but just workarounded by limiting the SPI bus frequency so the DMA engine
> would keep up with incoming data traffic.

I'd have expected that a single duplex mode would lessen the pressure on
at least the system bus - that's the main advantage, and might help the
DMA controllers as well depending on why they might be struggling.  From
the comments in the code there's issues on some systems with TX and RX
running at different rates which would go away in single duplex cases if
nothing else.  But yeah, it's not going to just fix everything.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+pcjkACgkQJNaLcl1U
h9CTEAf+LO8XubB/p+WOZdoLkRQLzS9jVKMHXs0H0rC1r9p2z2zyenxdNF7lwWrQ
XvvSKHF3gVb+aZVaAqFaFz0kGL0TMKkd+vu6Q38Ueb+MD7KUOXNF7ckSZ1ASv+td
Y4YLdX/ISBO5KcXCMZ8McdKtan2wu+X/Qx5uv3vTyG8O+RJKct+Kr65xux7yE2I6
WqEPl/0tY3GcRBsdWxzaoLxorPgyBfprsj8jIGukk0+6QZtMo7ovGZlqPXBVd9Ma
xMMw6AGys9Wq2+HNi/iRoimYhNEqQ5jFOIweOluVNhWaQ1+2ULmMKRqOmBuykYN2
vILe13vdCLSb3PBUF7SPgNbUpdQEpQ==
=vWha
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--
