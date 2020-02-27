Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3095C1723C3
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 17:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgB0Qo2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 11:44:28 -0500
Received: from foss.arm.com ([217.140.110.172]:54650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbgB0Qo2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 27 Feb 2020 11:44:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C6DD1FB;
        Thu, 27 Feb 2020 08:44:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6EA63F7B4;
        Thu, 27 Feb 2020 08:44:26 -0800 (PST)
Date:   Thu, 27 Feb 2020 16:44:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Sekhar Nori <nsekhar@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR
 capability
Message-ID: <20200227164425.GF4062@sirena.org.uk>
References: <20200226093703.19765-1-p.yadav@ti.com>
 <20200226093703.19765-2-p.yadav@ti.com>
 <20200227171147.32cc6fcf@collabora.com>
 <20200227162842.GE4062@sirena.org.uk>
 <CAMuHMdWMCDzQm0tjpybJZyHy4imbC9NqRXP5d4C0xgxQx-Pf8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWMCDzQm0tjpybJZyHy4imbC9NqRXP5d4C0xgxQx-Pf8g@mail.gmail.com>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 05:40:31PM +0100, Geert Uytterhoeven wrote:
> On Thu, Feb 27, 2020 at 5:28 PM Mark Brown <broonie@kernel.org> wrote:

> > It's what we do for other properties, and if this is anything like the
> > other things adding extra wiring you can't assume that the ability to
> > use the feature for TX implies RX.

> Double Transfer Rate uses the same wire.

But is it still on either the TX or RX signals?

> But as you sample at both the rising and the falling edges of the clock, this
> makes the cpha setting meaningless for such transfers, I think ;-)

Might affect what the first bit is possibly?

> However, as the future may bring us QDR, perhaps this should not be a
> boolean flag, but an integer value?
> Cfr. spi-tx-bus-width vs. the original spi-tx-dual/spi-tx-quad proposal.

> What would be a good name (as we only need one)? spi-data-phases?

Sounds reasonable, apart from the increasingly vague connection with
something that's recognizably SPI :P

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5X8egACgkQJNaLcl1U
h9BzNQf+NjXmaGigWO8AYKixlBbcKDms48SbjmC3B/TKWN72uzEK1Ir+m0zbDH/k
3rRhBD0UEIitRKr7B3yHGk5dJY0A3yZuSqsmXm6EW05qo65DwU2595xG4Q7lAk35
enegdQQEG9axlL02UaRgms5zlb7znVK/DqAqzjLB6NUv4AjBs8OJVK2RCLwXhvx3
c1W2kmWHZ5i9EXY21cCmQytqMlkJnOnHfYLoafYvVeqLFS1ddty4GNFsXdY+F14Z
EpXoakYtdKqZyX5SFRw6ymAZUU/O6qPiyv6ipnpOfu/pFazvJ+NByzx8FDy6bUEt
uOZ2YaN/cmD3HqhSb6dp4iTXWLLzzQ==
=jCkC
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
