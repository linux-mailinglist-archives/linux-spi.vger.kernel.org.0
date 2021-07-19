Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3193CE0D1
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346879AbhGSPST (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 11:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346345AbhGSPOj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Jul 2021 11:14:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13FC7611C1;
        Mon, 19 Jul 2021 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626710053;
        bh=wBNl15JDcb32KRp5NcjdPqdB3z6LzOh2NvgPZc6cQUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ha8cp6qy2jRkeFfAQiDQ+asQfjb4ulMgYbLWEOEDAQ9Aeav/NXPuZqDzmseS51fHz
         KJaCGDwvxvyq+QZlOkvsO2Uc+PT4GT8VP+rCIsTfUlOIL9b0tAYCA+cAmS+FF9S6Nr
         m4dAtes7nv474MNFMAtBaUsoHyVQ1EFFotmyeJNAysgPHvJJiMujBGSlrjLghAlo8v
         cgNBR2BNO9zIMeG04+q0/bwLN8XHDa80dCksFvWkxQOkY+Mv+QrZ+W+y9OIBJxxSfG
         6NuROhsXhsbSXLWMjOy3uWnO0c9pPuiEXWV+JPP7Y/k8dhZUDS6A5hCP/C91F0XdCd
         gKcepPLT6Zoeg==
Date:   Mon, 19 Jul 2021 16:54:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        openbmc@lists.ozlabs.org, joel@jms.id.au
Subject: Re: [PATCH 2/2] dt-bindings: fsi: Remove ibm,fsi2spi-restricted
 compatible
Message-ID: <20210719155409.GC4174@sirena.org.uk>
References: <20210716133915.14697-1-eajames@linux.ibm.com>
 <20210716133915.14697-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <20210716133915.14697-3-eajames@linux.ibm.com>
X-Cookie: You will be divorced within a year.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 16, 2021 at 08:39:15AM -0500, Eddie James wrote:
> Remove this compatible string from the FSI SPI controller
> documentation, since the security restrictions have been
> universally applied to the controllers.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD1oCAACgkQJNaLcl1U
h9DuKAf+JHPyP00LM+3t98okt5Ptg93ccuvO0QY1wOrfajtPVpMHY30M7mq1YfeD
YI/8MU5XG62tUIiyDCGvjnmQofcTv0+gi6kKNamKOyjhsMch7QgcUGZTYT0L0UHa
HaQScfqfxyqSu5ehwlhPlssY1AzS3d8J+vU+xWza3WkmVRgR327TmUAwEfNZv3gZ
ouxU1INvRExzsDEMntFkTccVui2g0om1YCdZfd2euqVnwd01DBnTdPHjM2r4gpaH
xaFhktPIxhn13X/9k3OJbjs5lFD8vdUUr8HNEEFViPdv4M7HXcHxk/g+YYxVZ0fO
KSMVR/dQa2TuDz40EgOSlFuaJDlrEw==
=6L6H
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
