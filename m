Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F4C3A1363
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 13:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbhFILuf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 07:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239507AbhFILt5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Jun 2021 07:49:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9D5961108;
        Wed,  9 Jun 2021 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623239283;
        bh=L0TaDiumV9g0cIteIcgFV0j4u4Kh80VYFpiyW9vBRQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3GbvmOpjfoGU/6X02DR5JX6hvIedBwigbJH4DPNd3RxI73jhsvmlKTbhj330ujVg
         MkQoQiCf+VlCj/IQGfkJBa2OWLchCy8AHrP1QwVIYkJ6lCBFduRyJc0EFX4RkxnW7T
         5cOAVjmHcsL6/p7UHZjX4Vd99wZbb01BEjFPO7df7hZZgWma4c0njSDGZ4xtCQUlWW
         7Df5KvMkOO2W5bc+qyNlxYNOSQ7kHmGqFkk1/a3mWd2BIwKjPadoo5PkOl9aD6IDGL
         dAAgr1dEGqbHZ70tTAxmDvr5fXFKw4A/m6l9HCoLsTKQSMc5RybHRyo3Z1RYtGTiIS
         kU0ltdsnuhLAg==
Date:   Wed, 9 Jun 2021 12:47:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv3 3/5] dt-bindings: misc: ge-achc: Convert to DT schema
 format
Message-ID: <20210609114747.GA19966@sirena.org.uk>
References: <20210528113346.37137-1-sebastian.reichel@collabora.com>
 <20210528113346.37137-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20210528113346.37137-4-sebastian.reichel@collabora.com>
X-Cookie: Don't I know you?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 28, 2021 at 01:33:45PM +0200, Sebastian Reichel wrote:

> -Required SPI properties:
> -
> -- reg : Should be address of the device chip select within
> -  the controller.

There is an existing binding...

> +  reg:
> +    minItems: 2
> +    maxItems: 2
> +    items:
> +      - description: Control interface
> +      - description: Firmware programming interface

...but this new one is incompatible with it.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDAqmIACgkQJNaLcl1U
h9BnSQf9E6uWlvT9txzp0eCNjIwGtxi15bHwfyQ4dQhGbb7CsFQJLzub+Wbk+LUT
F79SYf9G4QslbbSb3U2qPEJOZLH2Vki3dv/qccDBbi7wFRqs+lfTYuDcoENV0e/j
TOJgIdZxKSl+bAmtZunnFwj2rEOEE/iTiocEaBK1vCuosIRgb4D6KpG7wccD23hY
jwd6Tr8O84lFz0182zSN8p1yyBJ2kqa+oR+T8ijsFcWwQHFITxT++vX4iFfcrHao
O1rzeerLasTMOHz2gQwSHH7zdohOpHIoGSjc/2dISoVSr6jph5yhDikTn2Rpyxb2
lJwWmyNimO47h5zx7Qt2PkiQDcsDRQ==
=sL3/
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
