Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6A5358365
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 14:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhDHMim (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 08:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231420AbhDHMil (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 08:38:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5AA261179;
        Thu,  8 Apr 2021 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617885510;
        bh=gI7IQRVG/KjeWjtFz9xAONjp1agRGcNgXg+fjKKuvb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2Og5f+hYv3mMI0NeZRXkjb+OOjv5r7Qb9I+ssY9vp5fUeJSttguhq2kWJYQJli9o
         bCfu2ZQ/sJhYUxpe2u5JZgoalFf0uYsHnTkZ9owV8sa01Q8rtN59TB9PD7XiyFa9xm
         8M/0Sf92f0DFekI70JByVHdLbt+A5jhpV1yiqraBKe1Li5OmTtVmnpE+faUIBAb5k8
         SCVqmMCnHvpZgO29oIC6Tt5HjcZmxIHAWbraOn87Gj91HVGNPsLkBXbAEDF+Qyx85d
         DlcBHYMRRCW5DwGoigJcmkqN+x0w6b7U1lOxerwlGyIa525OZPp1qS29Uw94aWov/o
         IfEf6u16Izv4Q==
Date:   Thu, 8 Apr 2021 13:38:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: Default configuration for CS-to-SCK/SCK-to-CS delays
Message-ID: <20210408123812.GB4516@sirena.org.uk>
References: <20210408094548.o4uj6jzlcrnnacb4@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20210408094548.o4uj6jzlcrnnacb4@skbuf>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 08, 2021 at 12:45:48PM +0300, Vladimir Oltean wrote:

> that there is any universal formula. Hence the question: is there any
> default configuration that the driver can perform in order to avoid
> having to put it in device tree?

Something broadly proportional to the clock rate/peroid for the bus is
probably going to work most of the time.

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBu+TMACgkQJNaLcl1U
h9AzUwf+MbBrhRQyN+7n03z01X6oCMdNeMLv+ZZfyZN2LjfCutfUItRJFPq/P2Zc
uYT84IZAkSnpcFzwKmpMqARFY1TaVyE4kXMyvqOAy+6aoIbKpMZB927Q6jZoLqfz
d092qor9Wrp3tIgjUwO/ghP3+uoKjBnwY9DgpLABHIyONYx+eHr2BAUDNlJZXzRV
Pp2OHmFrLs4CZuRp6FWwjFGthmnHGJVc7IiECO7cCOgFEEZQQl9yOAYsVu++wOxr
wIE5u9spxcsZ7SG3RRXnJjh1Q38g7EXsNCclJaruJ0CNZlOoPhck5QLv0CAyW0cw
2lou0XMpXZz5GMlAFINj+UK/xWUyzg==
=ytDx
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
