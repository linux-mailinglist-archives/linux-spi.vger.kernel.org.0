Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E27F2CD2D9
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 10:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgLCJsv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 04:48:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbgLCJsu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 3 Dec 2020 04:48:50 -0500
Date:   Thu, 3 Dec 2020 09:47:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606988889;
        bh=5X99CjF/w6FuCzH9ST9VSYb0yNBNDgAFDj6aEVF7hRE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=aROK9D3oy/hXocbzQlxP1a9VxjKCwjp/rA+Azd9Jw16exRpgg5LyekFUUki7Nwy7o
         Ajlr9geQHGbW0V0AOHJBExkMQnyr2DGGVEnkCSI+tlsy6z79sAz9QRmgaldF9iRxuN
         JIn/A3HobTBLeGCpiPRcsPjOwp1Q27FV70dlUtx3BfU02hXJflgjnErfNZDu9pncGZ
         8SzUeszP5AgPLA0U8QCzJpV+jm6V/IFc1YY8RG59R/qlhJ46dZJqdQiLF8/4E2ODB2
         cbQ2dYorXPvmgcIsSPPujZZWmRYVtU4tvQAd3eMOhHcDInfnLWs9eDbrggoutcN0/k
         VAjvo2k1EiD9g==
From:   Mark Brown <broonie@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH v3 2/3] spi: Add SPI_NO_TX/RX support
Message-ID: <20201203094739.GB4700@sirena.org.uk>
References: <20201127130834.136348-1-alexandru.ardelean@analog.com>
 <20201127130834.136348-2-alexandru.ardelean@analog.com>
 <CAHp75Vcd4t=RqC31S-b1PXMtd=8sypSLhTrSgRD9hbpSqOphoQ@mail.gmail.com>
 <CAHp75VctXhpyBVB7Zw+SB5LiGcj6r850x+ehL7u2H0R4=y5rVw@mail.gmail.com>
 <CY4PR03MB29661063937AD783F6B2A010F9F20@CY4PR03MB2966.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <CY4PR03MB29661063937AD783F6B2A010F9F20@CY4PR03MB2966.namprd03.prod.outlook.com>
X-Cookie: Sacred cows make great hamburgers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 03, 2020 at 08:20:57AM +0000, Ardelean, Alexandru wrote:

> > > > @@ -43,5 +43,7 @@
> > > >  #define        SPI_TX_OCTAL            0x2000          /* transmit with 8 wires */
> > > >  #define        SPI_RX_OCTAL            0x4000          /* receive with 8 wires */
> > > >  #define        SPI_3WIRE_HIZ           0x8000          /* high impedance turnaround
> > */
> > > > +#define        SPI_NO_TX               0x10000         /* no transmit wire */
> > > > +#define        SPI_NO_RX               0x20000         /* no receive wire */

> > > Is it really material for uAPI?
> > > Perhaps we may have something like
> > > SPI_MODE_USER_MASK in uAPI and
> > > in internal headers

> Hmm, in a way this could make sense for some SPIDEVs as well, to set these flags and get an error if they try to TX with the NO_TX flag set.
> Not really sure about this.
> Initially I mechanically added these here as an inertia to the previous patch which is just unifying the headers.

> Any other opinions? Thoughts?
> Mark?

spidev is hacky at the best of times...  It *is* probably better to only
have the usefully mainpulable modes exposed in uapi and then define the
rest internally though.

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/ItDoACgkQJNaLcl1U
h9Ckwgf/VrYn5fwTeqHxZl9gZCMMNNATL4F7b+ly/CACve6HcvslrstmDsD7tOoV
+wKtnrhgYWzqwHpNzk1ts5IBZSq37RDXbbvylJ/DfWLQLelRYR5ZLrWyThtXnCHP
uBqM/YppX3AqWLfIAcwObA+QHzLhoxvVOIeMx2cOJrbYZN/5vg/BwvIucZ5aSAvU
Tv+0HRVGTKG7Ul4CJKnxthqjjr2R3xu+oscuTymdibWSU0yYslpIicdkn13179ZK
wDzRNXVmaJUPMn5vBSfgHh/GFe9P7287bhf5FksmN2HMkD8p9ZjCrUNDt4g4oVKg
GJPCc7X4m35E6fZch0J4YViffIvvAA==
=SB4J
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
