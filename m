Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35899319E76
	for <lists+linux-spi@lfdr.de>; Fri, 12 Feb 2021 13:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhBLMc4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Feb 2021 07:32:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231401AbhBLMcw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Feb 2021 07:32:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0CD964DEE;
        Fri, 12 Feb 2021 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613133132;
        bh=SwpDPlc1sS/6olGE5QWH+xrx1QzaQAKD+39i9frVaUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgW4xVuRDSAqphHjttIz0VyMlYQpp71InUo/xIDF7XENwTJe5XVikOFafVd0tzsRG
         3JdiZAAMi3MO/j3urLfnpz80QdJJGac9lpm0BwQ221ytGwfh55sgQbjwORXYOYdQEN
         mdC21wrxrIvYwpadfgPDrOgeHV8/q0WaHX1k5/HhqfGellC6gI37SNX2jAnz/4N6za
         L/blOOYExMdb1hSoN3vDJC0Q+bvzSOqUfRV3l9D1fDyL2mE/dYZt8nEp5xtvR1vk6/
         TmPFiZB6bEqWCVh6E3zeWJXKCmmtq32HJQxmcBS6WLOTyxgciHFu/rMlI+m0OmYEib
         W8/QGXz+fafZg==
Date:   Fri, 12 Feb 2021 12:31:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Phil Elwell <phil@raspberrypi.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Skip zero-length transfers in
 spi_transfer_one_message()
Message-ID: <20210212123118.GB6057@sirena.org.uk>
References: <20210211180820.25757-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <20210211180820.25757-1-nsaenzjulienne@suse.de>
X-Cookie: One size fits all.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 11, 2021 at 07:08:20PM +0100, Nicolas Saenz Julienne wrote:

> -		if (xfer->tx_buf || xfer->rx_buf) {
> +		if ((xfer->tx_buf || xfer->rx_buf) && xfer->len) {

I think the issue here is more that some users were passing in buffers
with zero length transfers, the above check was already intended to
catch this case but was working on the assumption that if there was
nothing to transfer then no buffer would be provided.

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAmdRUACgkQJNaLcl1U
h9ANBAf/ec1vXL9i3wJ+GOx2sxWeEvlBz0R3/jHeZSPQuSr92n0uuADcHjSOrB/E
g+MIX5xTBstY0r4pHyMkeehUo5RcRDhojfKCe488GLJgWtRjhcCnKK9jC//AFCxR
oOAdC5HhpK7z0nyXFEiaGqcXdGUQXzYELWLkwJ5XmV1axeWPLVYgILBSMZR8Lg7V
rOZaw8TCyx2f79mRQpWOyc6xz8w+NaklJzO788oa2+HMK0oIlKAzr60IwStNllo6
fnt/bttxjAflij1m/jZNwRW2COWAwg1UcMU7nGW1onMBLH8Kix8isv8MqCEoB/5P
CxOCgFp8K0cdX4nfmgpqhopJ1JUR4g==
=wz+s
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
