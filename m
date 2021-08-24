Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F333A3F62CC
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhHXQid (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 12:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229569AbhHXQic (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 12:38:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD97B61183;
        Tue, 24 Aug 2021 16:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629823068;
        bh=RC5JfSL5nOcZNqkGzTnMKeVLN4ZfQfb/8m/ZftZEAeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgaYFHAAOn4KvajCOfDinC/dLSfIbKvQYbY1iCzRWEOLXJSMSSzr5Ng2BfTym9d70
         f+Cm02NDC4Js53Hf1kHmLMR4EYDv4/XCSM/WOWRUVXyqpbTCQskqGOiqTh/hshDff6
         Y2dMOeoqU6i1ChGLu2NXpTvyyZoJLLlT+hRS+HKRlh+4cUrRpXsjE9jKIyZGfDdecu
         h2WHaZQSzLwYn4P+Pr5j5TihClzDvyQYNirc2KUrdb56APS9xTZUDxUxVaZItYQHtm
         VryUkpEw/EPqV9r7eMinxEFWrVzMtW7RsnUk5slELgxoY0l1CkgkknfjIujkJYGDr0
         3r3ZqEntVbQGQ==
Date:   Tue, 24 Aug 2021 17:37:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 3/9] regmap: spi: SPI_CONTROLLER_CS_PER_TRANSFER affects
 max read/write
Message-ID: <20210824163721.GF4393@sirena.org.uk>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
 <20210824104041.708945-4-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline
In-Reply-To: <20210824104041.708945-4-tanureal@opensource.cirrus.com>
X-Cookie: Sentient plasmoids are a gas.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 24, 2021 at 11:40:35AM +0100, Lucas Tanure wrote:
> regmap-spi will split data and address between two transfers in the
> same message so use addr_affects_max_raw_rw to flag that the number
> bytes to read or write should be a little less (address + padding size),
> so that the SPI controller can merge the entire message into a single
> CS period

This should be handled by the SPI core, it's already relying on being
able to do multiple transfers to handle message size limits and in any
case this is a super standard thing to do so many clients would require
special code.  The core should transparently coalesce things where it
can, or error out if it can't, like it currently does when splitting
transfers up.

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmElIEAACgkQJNaLcl1U
h9DTPQf8CYdydZ7wzOHjzlarw1sdpufTuPBx4Cmf0C6wRjay69Kxu6Qyrv82biVt
9zfAm3OJ3LqAwJcEJw1BsynYYr9Le0HZb4FtI7vzfyA5/4sXt7MBl5nK/bgYRfNB
03VPoEaROX3LedGvbjkeiFoA0v3HM7/B17G9naKDRhTkgI8nDUu9EqEUJd1EinoQ
hgGEPCmNiISoOdXBAHEDAb4ZXzfme3wvoZndbQyO2YEHoUhAhZnENmeetp9j8LN2
C6A+lTTjjKtiHWYJ0rKQdBB47e+T8c4/Pll4UFIIxToajFOsWarIjWBgQ/iG4jGz
dXoiodfXn4y9+vbfYRrM6S3tlPzghg==
=ERg9
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
