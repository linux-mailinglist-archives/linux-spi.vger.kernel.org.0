Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AFA2B43CC
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 13:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgKPMd3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 07:33:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbgKPMd3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Nov 2020 07:33:29 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D40F206D8;
        Mon, 16 Nov 2020 12:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605530008;
        bh=e8/VTfxGQssIIRXhK6YulGsoXbXfiFst8cUFK7vjU8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HK/xfacL/GMIV0YAt9cDrec21A34c5vySwI9RcUqj7oFfzxkBbesVh2yJD42BnUKW
         yvlCVbi4XvbBl76BWOa2TPlaKJiLzAEcszOlkxZ0mbleSFVFZhVr0A/iuzr/b9gSLq
         nErgIli9Roz6jNOXhbQnySH+Re4illiEb3dVjFSI=
Date:   Mon, 16 Nov 2020 12:33:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "seanga2@gmail.com" <seanga2@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 04/32] spi: dw: Introduce polling device tree property
Message-ID: <20201116123309.GA4739@sirena.org.uk>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-5-damien.lemoal@wdc.com>
 <20201109195913.itgfj2ga5y7sr6zx@mobilestation>
 <58943f7988706497040cac6f6108336286e9d15f.camel@wdc.com>
 <20201115160146.efxcdjhm7f2nmivo@mobilestation>
 <BL0PR04MB65149D8B62167C11B26E0EA7E7E30@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <BL0PR04MB65149D8B62167C11B26E0EA7E7E30@BL0PR04MB6514.namprd04.prod.outlook.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 16, 2020 at 07:47:47AM +0000, Damien Le Moal wrote:
> On 2020/11/16 1:02, Serge Semin wrote:

> > Moreover I've just taken alook at the MMC SPI driver. Turns out it
> > has already been fixed to send ones to the MMC port when it's
> > required. So If you still experience the MOSI-level problem
> > then that fix might have been done incorrect at some extent...

> OK. Thanks for the info. I need to rebase on the latest SPI tree then. However,
> scripts/get_maintainer.pl does not mention any. Where is that hosted ?

You can read MAINTAINERS directly if there's some bug with
get_maintainer:

SPI SUBSYSTEM
M:      Mark Brown <broonie@kernel.org>
L:      linux-spi@vger.kernel.org
S:      Maintained
Q:      http://patchwork.kernel.org/project/spi-devel-general/list/
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
F:      Documentation/devicetree/bindings/spi/
F:      Documentation/spi/
F:      drivers/spi/
F:      include/linux/spi/
F:      include/uapi/linux/spi/
F:      tools/spi/

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+ycYQACgkQJNaLcl1U
h9A3cAf/e+CAnK183KkMz2xKprNRhYUu248F8nYK4ZUjoj587uL6DnxlO0M67f9Y
cTaFO94jtUHWLwVX2na0qY1WBg7ygPDm9SUyEIj4yXq7+rvvqhZSGKe+FXD40Lkw
sWZgW4XNMu0mdH3TXxWVJpZFUS2qqnP6+YKMAAgMTGpBpW7XKnogBdNIdL4dWf5Y
79h9HGcvlGAneWyttFhS3/Q3izYLrtQ2u8TbslgiXSMRF8uIPsr/Kt3tgPss83Zc
95k7yc0jPiU1FeRfrGrXSFqH5FL8vZ/DjuDn//GBm0BV1MwX77KTym7DHvhVtsjC
viCA2ZSWKBZDxPp7Byv4ovbJL2LaWg==
=xuTA
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
