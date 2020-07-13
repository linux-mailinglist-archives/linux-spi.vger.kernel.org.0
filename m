Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2B421D9D6
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jul 2020 17:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgGMPLS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jul 2020 11:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbgGMPLR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 13 Jul 2020 11:11:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C14FB2065D;
        Mon, 13 Jul 2020 15:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594653077;
        bh=0EhSuGg4L9oUr5UZiJemFXBgmy5gboy4zP9hfDDvMyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRlk2CCWSV6skQKVYGnd+p5UPIMSicwh16rBhWneAhoN97A0BKGdK1UBRG7807adq
         krBEfqc5VZovU6iZunotJOWc687DJ48U4/xD0I8kKwfNkW5go37qkuIyv4FrsMmVoS
         ttM4lyknAk+KtcbYA76cLLkjV1Lx2b642x2las8g=
Date:   Mon, 13 Jul 2020 16:11:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
Message-ID: <20200713151108.GB4420@sirena.org.uk>
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
 <20200702142511.GF4483@sirena.org.uk>
 <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
 <20200702150725.GI4483@sirena.org.uk>
 <479d566a-213f-4e33-8ac7-7637ae88e31c@kontron.de>
 <a5b88ad9-3884-1d9c-c4ad-057266f84261@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <a5b88ad9-3884-1d9c-c4ad-057266f84261@kontron.de>
X-Cookie: Fast, cheap, good: pick two.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 13, 2020 at 03:19:52PM +0200, Frieder Schrempf wrote:

> I would have expected that there is some kind of existing userspace API to
> load an overlay manually, but it seems like there isn't!?

> So what's the reasoning behind this? How can I solve this in a
> mainline-compliant way, meaning without either keeping downstream patches to
> bind spidev to my device or writing and maintaining code that does the
> overlay loading?

Basically the reasoning is that nobody's done it rather than any grand
design not to do it.  There's some issues for more complex connectors
present on multiple boards with mapping the same connector onto multiple
boards where a resource on the connector might be provided by different
things on the base board so it's not quite as trivial for them as it
should be.

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8MeYsACgkQJNaLcl1U
h9AKgAf/RVJtgNv6Z3fUhzq82kWwWm9uKsWRdDtx1vCBgF122XEZOiwgIIFoEZiP
3Z74idl9I1ProBlKc78WdeBc0wUHMP+ZPuX9U3Ur2oN0slkEInIADrZtRhv2Yzl/
pHD84omYE8gdfOPzh39Gp0PMWEEaK4gQ5RjNeSnjMDMrScAXMBmPJfDu05s+udBM
9shL0iZNl+TKxeoNCvuZLok9rkZvYCMoadLJKcXsmbmnerOCIojd2oQxJ8yeHFg8
KRoWiLk6cuHXcM/h+GFZBi16fuwA09jg1p9GfNDT+22n0WljTv/Cedxe70oQFgZU
BSErXQy68GPSfs7P/WV0Uuk3q6l1iQ==
=B3S0
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
