Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759E82F6295
	for <lists+linux-spi@lfdr.de>; Thu, 14 Jan 2021 15:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbhANOAV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Jan 2021 09:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbhANOAU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Jan 2021 09:00:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83AA123A69;
        Thu, 14 Jan 2021 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610632780;
        bh=ladoP6+LmH3OTLqx40cXlLNjDwqMk+v5QZwHRlHcYHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MS2p0kePgx1mItBQV8PxP9zm4Rnw2L2Xxk/El67hV9Vi+315U5V7diGBJwg8b7BN5
         iSK4UmtGJFl6amo5/6t+q2BaLGWNMsqhUBTZevtK4j7TRCcvt8lS5rcKboq2tP99dK
         e8asBdVB5kJVmvKsk7Ky5qWtUZG+HwuDiXlwRTOqJBtnLYg2iSroSnsVfWyohxaauQ
         hmD5v1B36dJFqur3QcKpCornGufYDgx9LY3fy5KXxYZd7NjkL4lJ2jQPhD62nCLEAz
         vA31LD5zSHLLDP24y7U18dWC1AnsCjaWze1PkuZB0RPOHeN1f+6IvNz6pOnZnj0lUq
         r24FRwrefZGMw==
Date:   Thu, 14 Jan 2021 13:59:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: SPI not working on 5.10 and 5.11, bisected to 766c6b63aa04
 ("spi: fix client driver breakages when using GPIO descriptors")
Message-ID: <20210114135906.GF4854@sirena.org.uk>
References: <dc5d8d35-31aa-b36d-72b0-17c8a7c13061@csgroup.eu>
 <20210113123345.GD4641@sirena.org.uk>
 <9400d900-f315-815f-a358-16ed4963da6c@csgroup.eu>
 <20210114115958.GB4854@sirena.org.uk>
 <006d1594-8eec-3aad-1651-919071e89f3b@csgroup.eu>
 <20210114132258.GD4854@sirena.org.uk>
 <adbf508d-ed5a-e06a-4a59-98df0229d7b4@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Content-Disposition: inline
In-Reply-To: <adbf508d-ed5a-e06a-4a59-98df0229d7b4@csgroup.eu>
X-Cookie: You have taken yourself too seriously.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2021 at 02:42:26PM +0100, Christophe Leroy wrote:
> Le 14/01/2021 =E0 14:22, Mark Brown a =E9crit=A0:

> > For GPIO chipselects you should really fix the driver to just hand the
> > GPIO off to the core rather than trying to implement this itself, that
> > will avoid driver specific differences like this.

> IIUC, it is not trivial as it requires implementing transfer_one() instead
> of the existing transfer_one_message() in the driver. Am I right ?

Yes, that's a good idea in general though.  It should normally be pretty
simple since the conversion is mostly just deleting code doing things
which will be handled by the core.

> What's the difference/benefit of transfer_one() compared to the existing =
transfer_one_message() ?

It factors out all the handling of chip selects, including per-transfer
chip select inversion and so on, and also factors out all the handling
of in-message delays.  If nothing else it reduces the amount of
duplicated code that might require maintainance can have issues with
misaligned expectations from the core or client drivers.

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAATikACgkQJNaLcl1U
h9BW6Af+Pw9Y1WvW7FDLeDR69lK5Jq9X67HuG7iEoAFDhmj/Q6Jb4DzPkSeG1LRs
YRbcTBvXoPs2vVAU3bisyy4MmTmnhW5BtlkigV2NTXPKi3qzRu5YjhxEjPAmgeJ9
RZhHco4yXMm7dP7g7EPvlb3VqjBH+ARZRnT5SN870EkDnQV6aEBR9YRHbQmKsabV
VkU2uvRlXIdpJ9FKBbDcV0jWKqJdVphdBhEKhr9mWKxG5FBQ05iGyJdDL0c2zr5x
oBubtYUiq/yd41w96NV4/4O9h9DmTDxiQ1QM8kW6mbgU4JykUhq5qr6ua3G0pRLC
/9vXvRuBpx6IbHr7IM1p2oasKi1WsA==
=nlRk
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
