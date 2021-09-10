Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD9B407027
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 19:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhIJRDw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 13:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhIJRDw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 10 Sep 2021 13:03:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DB14611BF;
        Fri, 10 Sep 2021 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631293360;
        bh=ygMY/rpl7zbgwltGfP0Q+0+ywzolP8RKDEZuD61NVXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DS6W0X2kFqdydZYG4mQxh3PMhHPZwtMSbJhMmFB0N7zWQZN41rt4dUS94vjDuU5/e
         UjIoj4uhbKRfJKKHP8cDc1hS5lwhqpwSlnBeDu0Vv8Ym8qkyI6nnCOIkht92g5LoOf
         ru1JzbQuymHlQJ8dixhrK4Q4+8G3/uNO/rzT6P9/U3fiGIGVjAUmTCyXWTEdqXahb8
         fjAyJr7jHI/ylw++3iHPnH/21sqhOcDq9gfxHF98aN4glMJ7Q2aWHEBre8Ii9czb++
         sLr1TfQpSlVlyiV7/TIzCoSlNVENqfuA9bzz7aFquu1/X615ob4U5Umirzf7Ph4Jkr
         fg+GIry/mg9/A==
Date:   Fri, 10 Sep 2021 18:02:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: dt-bindings: xilinx: Drop type reference on *-bits
 properties
Message-ID: <20210910170202.GG4474@sirena.org.uk>
References: <20210910165945.2852999-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Content-Disposition: inline
In-Reply-To: <20210910165945.2852999-1-robh@kernel.org>
X-Cookie: You are standing on my toes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 10, 2021 at 11:59:45AM -0500, Rob Herring wrote:
> Properties with standard unit suffixes such as '-bits' don't need a
> type.

Acked-by: Mark Brown <broonie@kernel.org>

--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE7j4kACgkQJNaLcl1U
h9Afbwf8Dr2bcR5QwswyQk1bp5WikO9FsJ8Hj4LQoaLPIV/bGhBq4p7sBmHelxAP
VYoRJBIm/HJQIKj9b2fMMN3SNRGw9ZnMwzQxnAgL0sCFWPDHfg3+ZuOLKUZ0FzC5
VAtSMvSBJD3ovMQzXA7dY6I+BQjJSQT9EjDxMwRALdmNd4vgWnXb24cxDdNP0qKX
A13GbO001pR3KjyRo+FzegvwrYzFFJGDYEJ2bKG9alK7WX7AYlP8i07AhgnzYUta
Y/m3oBmzS3HngD56x2pzCXsqy4QUGJ7P1dAS1msrWkBAu+D1YGc4HDxayZFPkLKy
HjpzT7KEEqTUEhCCRtm8RXRS2F757g==
=tCVy
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--
