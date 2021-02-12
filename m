Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B90F319F39
	for <lists+linux-spi@lfdr.de>; Fri, 12 Feb 2021 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhBLMyu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Feb 2021 07:54:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231157AbhBLMxz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Feb 2021 07:53:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E756B64E3D;
        Fri, 12 Feb 2021 12:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613134395;
        bh=VCJx0lwRP7/ayaI+l7U/bQLKw4DO20YRWTzkvFp0K7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hpC7QL6jT2mB4XRWKhADpkJe+y56iWYj8DVZGPgYAZS4Dvc0XgK+PPKOwTUE7iK8i
         ka1oBNXo8P6N0XQLfhMIAiP0tAfALvZfhAdKnq6mu40IxVArBXj2XAjtdGjmnB2JZq
         TBAXF63qeZLpmrnsIk3f5NmEP5EAwwr1Mb8eqYTL8Q17z/FCBO3kR9mdWUs8Ne8KwF
         NYHxIevaOl+5KPdFJUq49dpO5toVCSRuyRKIRI4J0KhrGt8IZ/OsXpfA2mEGlUJeTi
         Gh8wt/wEjmDX35+Chm8MwLrr94MVRbaaoAIQpwC8k+iBhEr0ABV/J1vx4nkDZ7LtIs
         5IJfRKdaqDEYA==
Date:   Fri, 12 Feb 2021 12:52:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Phil Elwell <phil@raspberrypi.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Skip zero-length transfers in
 spi_transfer_one_message()
Message-ID: <20210212125221.GD6057@sirena.org.uk>
References: <20210211180820.25757-1-nsaenzjulienne@suse.de>
 <20210212123118.GB6057@sirena.org.uk>
 <cd41a204107900c890b0234847fa0b62701f74cc.camel@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
In-Reply-To: <cd41a204107900c890b0234847fa0b62701f74cc.camel@suse.de>
X-Cookie: One size fits all.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 12, 2021 at 01:48:21PM +0100, Nicolas Saenz Julienne wrote:
> On Fri, 2021-02-12 at 12:31 +0000, Mark Brown wrote:
> > On Thu, Feb 11, 2021 at 07:08:20PM +0100, Nicolas Saenz Julienne wrote:

> > > -		if (xfer->tx_buf || xfer->rx_buf) {
> > > +		if ((xfer->tx_buf || xfer->rx_buf) && xfer->len) {

> > I think the issue here is more that some users were passing in buffers
> > with zero length transfers, the above check was already intended to
> > catch this case but was working on the assumption that if there was
> > nothing to transfer then no buffer would be provided.

> Fair enough, maybe it makes sense to move the check into __spi_validate() and
> propagate an error upwards?

No, I think it's fine - there's probably some sensible use case with
drivers reusing a statically allocated transfer/buffer set for multiple
operations and just tweaking the length as needed which seems a bit
weird but I can't think of a reason not to allow it.  Your patch is
currently queued, all being well it'll get tested & pushed out later
today.

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAmegQACgkQJNaLcl1U
h9A3mgf+LfhWDYBCt2tDRH4CJLx9uR90z5TVZ+yjLbTtT+Ybj8EQg3xGkKZt2WCc
lLMlIEBfWn26ufScsEanrofysJ+PQCH4uD9y5+hckM36BVbl29yvrnUAo41F9nw6
IHqGt7K5KSjr3F4rP2o0rWtVFtU1/AhvPvyAZMRbc4clxRzVNToCg1xQTEmgtysb
fDgY70NmLVKE8XVlD4TJXYaaICCXAsVBWdyilCEIM1fTLiREEL9ROmDDX8GyiPiw
ZJ1FYqv7kbtSENZzNpZWZ7dCRr8S0iRyT0CU2x8ZkyVKF7NM45BYh//mc3313IvX
WD+zTWzaBOyW+q0pq208nOTqCkbVFQ==
=iCJf
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
