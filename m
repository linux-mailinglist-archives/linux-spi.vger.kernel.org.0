Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBBB36C7CF
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 16:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbhD0OgM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 10:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236173AbhD0OgM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Apr 2021 10:36:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62933613DA;
        Tue, 27 Apr 2021 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619534128;
        bh=cfK50gneOtZ45RbcE2sg4WO2BrtfJNagZby+Gpk6azY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8jAU6DPeMZOv/Pz6Ti06hC3MckYp36gIZ8DXlvBxhFq/KynD9ZaeinpD5fDjy13N
         goWxl1rPG5Jb8y697p3z0wempwTLfVJFdjB83X+sU9Q2CZTTpOtz9ASfUlblbCWPfE
         aQNMi26lgeo+atPWpYJosmxXy7EWBWChJ/GYEg0vT3o5aMXmmhSVftjRadqHJ25wKR
         07Iwu7RzvDXjbq7wC+GlO+XwdV8oUtg/at/URRrQ2Va0OTZd7Akq1QzkIyftiDx+EQ
         Zs75ZZbo8/NZFu9maNuJXeoXARoWKHZ+fbB9LrCokcEkSD/m4pnwhweewkkX0eYg1J
         pn9NLNjqUb9YQ==
Date:   Tue, 27 Apr 2021 15:34:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
Message-ID: <20210427143457.GI4605@sirena.org.uk>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <CAHp75VeiHsk15QoG3X-OV8V8jqzCNeKkif9V=cx4nvKVHaKbKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dMdWWqg3F2Dv/qfw"
Content-Disposition: inline
In-Reply-To: <CAHp75VeiHsk15QoG3X-OV8V8jqzCNeKkif9V=cx4nvKVHaKbKA@mail.gmail.com>
X-Cookie: Don't feed the bats tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dMdWWqg3F2Dv/qfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 27, 2021 at 02:46:02PM +0300, Andy Shevchenko wrote:

> Mark, are you accepting patches for v5.14 now, or should I resend
> after v5.13-rc1 is out?

> (I have few more in my queue :-)

Send them now if you like.

--dMdWWqg3F2Dv/qfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCIIREACgkQJNaLcl1U
h9Cpywf/QFmTIfBMRvWq/Nhv5gbnKzJOVq9gqwKB99JZQXRuDaSEjPcnA0NbeNDc
wDuI19G1taNfEjh0x6n/Yeft5Uh2fS5PC8ppM/I6ymzwWp03IeNn7Q/aE+7YUbR2
GngpYGWepEeuBQNPmZ9sB4CXV0+QfK9VXadc7bEtSXOm23jhYwJzNSkqsmxYHE4/
nG8yI1CX24a5LaB4cfyFxX42ozp1Xy89KQS7JdyeEkMIu59EB5SBUTSP22coCNpp
uJ10mKgiIhMHotG7gWkddqzHnNfzBZYXtRek1UhIOQz4H9lWTOYHBzEaZbgwKs5i
XocUnAmQNQmuGNY1NwovBFbrMOm7Ag==
=eyPN
-----END PGP SIGNATURE-----

--dMdWWqg3F2Dv/qfw--
