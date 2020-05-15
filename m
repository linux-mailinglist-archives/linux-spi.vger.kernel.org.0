Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89561D58B9
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 20:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEOSMW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 14:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEOSMW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 May 2020 14:12:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1757720657;
        Fri, 15 May 2020 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589566341;
        bh=73OlL8aAHw/qHS2fhCK5bC0tPIfPWjo8BAd8n2Rsg9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZq+4m+MbmcsUOmuWiIVeaZON/FBTdHa1RnObTVIaWt6Rmq3Wv/kSMsA7Vvk3KNbJ
         UQOmt6xDMmB4mzUjJzwQL3WBA6KSWnmVV5zrUR1ah5riGqHwJYFFDM0KVQFjcCC0iU
         Ne1sOeXJWpel+EDgkO2zlleExbBA9zZm5tiK3/8s=
Date:   Fri, 15 May 2020 19:12:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] spi: dw: Clear DMAC register when done or stopped
Message-ID: <20200515181219.GN5066@sirena.org.uk>
References: <20200515174856.1406-1-Sergey.Semin@baikalelectronics.ru>
 <20200515175100.GL5066@sirena.org.uk>
 <20200515175420.qgejailgnzswxtdz@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i6vqABX3nJKXLk01"
Content-Disposition: inline
In-Reply-To: <20200515175420.qgejailgnzswxtdz@mobilestation>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--i6vqABX3nJKXLk01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 08:54:20PM +0300, Serge Semin wrote:
> On Fri, May 15, 2020 at 06:51:00PM +0100, Mark Brown wrote:
> > On Fri, May 15, 2020 at 08:48:54PM +0300, Serge Semin wrote:

> > > Acked-by: Mark Brown <broonie@kernel.org>

> > I didn't ack this but Andy did (or at least the for-5.8 version)?

> Andy said he needs Fixes field to get his RB tag. You said:
> "This and patch 4 look good ..." Normally this means to get Acked-by.

Unless someone explicitly gives you a tag for something you shouldn't
usually assume that one applies, especially with maintainers giving acks
on their own trees since that has process meaning - it's saying that the
maintainer is OK with it being applied to some other tree which is
something it's worth being careful about.

On the other hand if someone says "if you do X you can add tag Y" and
you do X then you can generally add the tag if you do Y.

--i6vqABX3nJKXLk01
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+24IACgkQJNaLcl1U
h9AKRAf9FsLiuXXPimqzs6k+kUCNB8ERlZ4CxGz8nUE7UOpRTNEsyRIyynHZv1Lp
e7wbn+UswCncBf5PYsdMdJUa2UVf0QdQNJYRlorJJjH2vwqC5P0jkURrkLwDX/tP
w0lRYJYDNGxsGq2Zqqhl60mfC2+HkJ0SBoAPyFQQP4VKzaRwZu1F4FHtR/VoZpnn
2mdbGO4m+8bydtXRhybs/7vzdS4Wtpd+G10xfJhqztuJc0YdapJ7eRJ29UDzVfT7
l4Wd/gNrqFNHtKF4P9ihO346Chcu42RzmkpCVQt37sdhJ7q/y6JmHst5rrtOCC17
VGe1HTV3eC8Jfn9BZLom8+vvewHLRw==
=yXEI
-----END PGP SIGNATURE-----

--i6vqABX3nJKXLk01--
