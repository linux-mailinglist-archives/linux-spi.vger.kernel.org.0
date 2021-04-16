Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7333624A7
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 17:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhDPPzN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 11:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237711AbhDPPyy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 11:54:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5F6F611C2;
        Fri, 16 Apr 2021 15:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618588469;
        bh=qVul+pcyK7pXA2HSzZJ7bbbkwXCm9MgrT0PomlCg88A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRN/xSPSsj7R2eG3FFYur68kS1ZFL0p+eIhpexEYqfSRlPLf+1VHoII0diWf+SHL8
         q4iMUxqAPxlu2+9CMD0pZBjAwJLlFjkakjGsAKoO81n70Tj34zKTRAXNq1L/OaxKKj
         UFNGJ7MAm2pXlTBmWhAxCH5yrA7NW5xghHgpRADCUYMGDnhhgsw+xNqDyCYWpXo7QN
         wPQEDSu0/SqpxX9KnbS/OzUXq3cV8cYqCI76hLkduIaTeQ7kb3avhagDlTaH1RRu80
         +7uLqoVaUv2ArrKEYTlrcNodaTA70pcaWTTcZbbpB+q3T1hfZ6+2lPxYExjfm6ltYi
         RRYQo7D3veHAQ==
Date:   Fri, 16 Apr 2021 16:54:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joe Burmeister <joe.burmeister@devtank.co.uk>
Cc:     linux-spi@vger.kernel.org
Subject: Re: Multi driver SPI chip select count unenforced.
Message-ID: <20210416155405.GF5560@sirena.org.uk>
References: <6a6c9d49-9064-4bbe-0330-87f92623d669@devtank.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline
In-Reply-To: <6a6c9d49-9064-4bbe-0330-87f92623d669@devtank.co.uk>
X-Cookie: Snow Day -- stay home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 16, 2021 at 11:55:45AM +0100, Joe Burmeister wrote:

> I think I've stubbled into an issue with some SPI drivers.

Like Lukas says you need to copy the maintainers of those drivers.

> Even if the driver did enforce its limit, the returned status could be ignored.
> Patch for that also attached.

See submitting-patches.rst for how to submit a patch to the kernel,
Lukas flagged up most of the issues here.

> So question is, what is the fix. Currently num_chipselect is not only not enforced
> but changed to what is in the device tree by_spi_get_gpio_numbers and
> spi_get_gpio_descs. Some drivers may not really have a limit anyway.

It's really driver specific if it needs or uses the property so any
issues should be at the driver level.  Ideally the property should be
completely redundant, we can figure out how many chip selects we need to
handle based on knowing what devices are connected and what the
controller is but the binding was standardised ages ago.

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB5sxwACgkQJNaLcl1U
h9D78Af/dB0l23DTxE/6dbFBB3dIqKJ9AWkZi+FLonj5aManfXoG3BYa9ECPaBtm
d8QyUZ8pbG9e6UR0SjrUvTMxVKuXEW0DkoZ0j7jE/7GdwjhXW88Z5n9wc5d5qh8n
r9OZE5gusBTGYMsiX1ib1aPLNUpKlrNNvnOOfX8RbNUbkx+YrOAlvdT7NvlV2Hoq
ceqyXd3bjtFtZgtogAlloa2SQTBChCW5JfDo++tIfvgtMfnR5FipO7IWg3yREk+/
meLve0JUIoB98oi8wSccHv9VZhwVpJoLjbxqKbxeQHESNV+RRYz/B/lJ65++Nu4V
z7i6lIen9QTKIeO7B+OdccAfGxaMnA==
=9wh/
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
