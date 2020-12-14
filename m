Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3002D9C93
	for <lists+linux-spi@lfdr.de>; Mon, 14 Dec 2020 17:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440284AbgLNQYM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Dec 2020 11:24:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440213AbgLNQYG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Dec 2020 11:24:06 -0500
Date:   Mon, 14 Dec 2020 16:23:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607963005;
        bh=AHdANBBLNTJw739m69nu1X9LxbPWyebOEdf8x8REzLI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1I79GixJahrYdFPYjFIKqA6vALsyqCralLCJyWM3v6O2BYsc1VFHeMksKIlOzQLU
         YhMKPRo+bElsRWMKtQ1OPne74/xQcD1lcX+VmsN4xJgKJlrK7TVJj3Vh+EezydIA9K
         KYOhdXt20eceahFYp0oXWXCH7VWCFkrTtYjI/4NQBuMccz89J0v/39AlBCcQnx7fVR
         exIwIVX83Eslw0S0KIdZDhLgOmBKnpW3LZMym1/AboPHHfSQ3CXybnaHAIkhwZwCOH
         cnJdQt61NdwWjRveDyv6Zb+bFqR0WKdaMXYgL5m9QdRa4/oDeA4ieR+Hv6culExWqn
         /zUfKSRFNqEsA==
From:   Mark Brown <broonie@kernel.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        lukas@wunner.de, bbrezillon@kernel.org, p.yadav@ti.com,
        tudor.ambarus@microchip.com, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/9] spi: spi-mem: Allow masters to transfer dummy
 cycles directly by hardware
Message-ID: <20201214162315.GA4880@sirena.org.uk>
References: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
 <1607721363-8879-6-git-send-email-skomatineni@nvidia.com>
 <20201212115715.31a8d755@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20201212115715.31a8d755@collabora.com>
X-Cookie: Everything you know is wrong!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 12, 2020 at 11:57:15AM +0100, Boris Brezillon wrote:
> Sowjanya Komatineni <skomatineni@nvidia.com> wrote:

> > This patch adds a flag SPI_MASTER_USES_HW_DUMMY_CYCLES for the controllers
> > that support transfer of dummy cycles by the hardware directly.

> Hm, not sure this is a good idea. I mean, if we expect regular SPI
> devices to use this feature, then why not, but if it's just for
> spi-mem, I'd recommend implementing a driver-specific exec_op() instead
> of using the default one.

I *have* seen other high speed devices which had padding bits in the
transfer (see regmap's pad_bits feature), I think that corresponds to
flash dummy bits but haven't checked that the hardware support lines up.
I'm not sure it's ever been seen as something that we particularly
needed to speed up with hardware offload though.

> If we go for those core changes, we should at least add a
> ctrl->max_dummy_cycles field so the core can fallback to regular writes
> when the number of dummy cycles in the spi_mem_op exceeds what the
> controller can do.

That seems sensible if there's a risk of controllers being too limited,
which knowing hardware seems likely.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/XkXIACgkQJNaLcl1U
h9CBsAf/XWrzX5DEizCXgE7T1DvfpDtH0jdGsooRqjRftlV5KVN61c4clryl717B
ix3GAXx57e3OO/JyWtBuKeLChLsyvDcz4CWnr8AMTmHcxYO1KTlqS9GEEs4EEFIO
lXBiuZ/9yb2/HJSdJTg0w+mudFvH3B2gsVDZ1C5Waupm+HdqPSP1xilOs1owTVpa
0fNhf99+NIryvBNeGI4vt9okktA+fnhh0u2VjSXQwyyw4woVVrp+Zv5cn1KSx7cX
DLP9ciLZBUUWoVX5Vh+IIL0k9un1kKBmAjtUgjdTGYyg0yPdJn+sEvHdnifN0wxP
Pywb4/N/I3lzBeJah5fx5DH0AZ+GyA==
=GioU
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
