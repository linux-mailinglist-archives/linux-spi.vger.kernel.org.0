Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAB92E79D0
	for <lists+linux-spi@lfdr.de>; Wed, 30 Dec 2020 14:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgL3NxA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Dec 2020 08:53:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbgL3Nw7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Dec 2020 08:52:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2D0920791;
        Wed, 30 Dec 2020 13:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609336339;
        bh=A8KDxk2J7yDBfz+5AzQj8eYVlMtcX4Tp2Ks9wdanxjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOk5fuT/SZohpcmYMIoLDKexl84L1uiwodTWrcIQs8Y5iuNlHrYkt4ptFLtTtplsr
         yprYZUWFUPVRGv0ibQw3SLBeHD9BhmDnCHXx5Ab6eo+PYFgV08zRSsCUEynvqiQddj
         cFUbzeSSGvQ7UPpOCUwCizyGx4ccXoYNjtRRnv7hKNMS9fv74lWAJWHAKXN4qA04m5
         hjhIq4CgTFe0okfbtqywsxYvvEPWkj1i5DQJYt7a5QRUF5S8J6OMqwhmWGGGvpwBr3
         RNEZNHVNtxW7Sif3zjRKvWsFxYVMikE7HqJGC5KwM/LVOY/N4QnbZl/XXJwy+3nmqY
         28P3Uu23IDUMA==
Date:   Wed, 30 Dec 2020 13:51:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/2] dt-bindings: spi: Realtek RTL838x/RTL839x
 SPI controller
Message-ID: <20201230135156.GF4428@sirena.org.uk>
References: <20201229231904.2558916-1-bert@biot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Content-Disposition: inline
In-Reply-To: <20201229231904.2558916-1-bert@biot.com>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 30, 2020 at 12:19:03AM +0100, Bert Vermeulen wrote:

> +properties:
> +  compatible:
> +    const: realtek,spi

It is possibled Realtek might make other SPI controllers, there should
be some more specific name such as a compatible for each SoC that the
controller appears in or an IP name if one is known.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/shfsACgkQJNaLcl1U
h9B4mwf/SDei1d9DKPMjGfTGoqYmyuzwYLFOr3ddZgUv7qoN3PvV0AIXoJNBSR4h
Ajwh5t8bopJIo4sqplupw22PcIT7jzIejn7XgQdr9ctYPZSeaBt/3smJainNvDit
K/in9Os6lvPa6YGLeDPYFlrZK59W2Fx2ApIYY2a8luq2Y8CLH6TzJbuYj3ps72eZ
MtQW1Bv6VMg1F6wCUd7jgDP6ppLrIss671KSGxlCMk36UiRYNJdH2TDB3o89LhT1
tfuC3n/kCS+DIfTb82B3nQxSKb2dijnd53a0S9/hqr2sLuYBhQm2b5ZqB+H3wmeM
dfYORicJLznhGIZZOgpbIETvMTRKxA==
=UBK0
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
