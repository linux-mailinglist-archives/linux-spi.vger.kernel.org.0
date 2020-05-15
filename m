Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6FB1D5600
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 18:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgEOQ13 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 12:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEOQ12 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 12:27:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF1B6206D8;
        Fri, 15 May 2020 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589560048;
        bh=ZgGDaC+Ol1y/kYtjFW3nXfg2X9TkyRF+k6GRjy63Iyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zXszGCqCPcV4lW+6U8WZ9D4M6L/OGY7hyDhYOLYcP+fnWA6uGxnKjGYAOk+x8P6UV
         NC4CIu9wERzqNRq3U14L6XWmbcK43CkopCHraY4mE4z2lhcDgv5d0Q9PPJRYpQP8ww
         D0aRH7dhIW7+pW8SPAlireWEP4iHa8BvHokAgC2g=
Date:   Fri, 15 May 2020 17:27:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/5] spi: Fix controller unregister order
Message-ID: <20200515162725.GG5066@sirena.org.uk>
References: <cover.1589557526.git.lukas@wunner.de>
 <8aaf9d44c153fe233b17bc2dec4eb679898d7e7b.1589557526.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Content-Disposition: inline
In-Reply-To: <8aaf9d44c153fe233b17bc2dec4eb679898d7e7b.1589557526.git.lukas@wunner.de>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 05:58:01PM +0200, Lukas Wunner wrote:

> However since commit ffbbdd21329f ("spi: create a message queueing
> infrastructure"), spi_destroy_queue() is executed before unbinding the
> slaves.  It sets ctlr->running = false, thereby preventing SPI bus
> access and causing unbinding of slave devices to fail.

Devices should basically never fail an unbind operation - if something
went seriously wrong there's basically nothing that can be done in terms
of error handling and keeping the device around isn't going to help.

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+wuwACgkQJNaLcl1U
h9Dr1gf+JPjuMMv9SnbM4EafRBvIbJbqzdo/MJJBSATGgOPeg2mzu4VcRmHA5p07
91DZyw5Ck2hAHWNhyOjjA5CHowwVdyPH+CmuBH3bB9irOhiyPuaFa5oqv3LIxyiw
vPKU8+6c9gH4S5LnRyiSsMFMvOYJqpEbKh4B4ApnDGSNl9fqAhuRwWtcios0cTlR
nspNCzN5JumLG/1SmqjaaLgXQwc4OJd7JIRvM3tnWtq/B/998Cy/s8Wm0MWpkviJ
dY42Rr3GgeOpvXL6N6DzEzPWAUO6Ku0U52mzcSWDk0mY9v/Y06emezO9DUaZNfJB
/ege/Gi1MCe+gfv7EnNVoBE7c/iHjg==
=O/Jr
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--
