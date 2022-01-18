Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF06492C86
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 18:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbiARRhN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 12:37:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54396 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiARRhN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 12:37:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2E35614C1;
        Tue, 18 Jan 2022 17:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6990C340E0;
        Tue, 18 Jan 2022 17:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642527432;
        bh=x1BLHPxcoVZSC5nVm+cwZQtQDuWBtux2vZRrX8aTsEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=guH7+VjWDKlCkIXn4z+FtjuwJid4/+Ubp11QEcHCXJ62gz1Pi2F6k3HqU+6m1Wpe4
         yIjgMV7NJncSeZSpOg8P06rFyedIB5iN5i1NCtguk3+t0GxOW6Arz2GPdenW939D+Z
         w/gDaCj3cJvvgI0YqxR0sv/Am0zIXsHNBUQ+2h71D6s1drT3w3mTKDJABHvjmUPJXD
         0sBdyyhgL4br4fwnIhZheTTTNNqOqsfpT+NoGQhjBmbBWBXhWlbjruPY8LZmHDF/9x
         oiIbVV4Lzuhl5fEmWP0Mw7Rz+anIhR5oD7oXH9zf/j8BClwmD+niHpkTPD74yUDbnz
         XaDVOk9NIJ8mQ==
Date:   Tue, 18 Jan 2022 17:37:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH 3/3 v2] spi: s3c64xx: Convert to use GPIO descriptors
Message-ID: <Yeb6w+fkD566wwVQ@sirena.org.uk>
References: <20220118110928.120640-1-linus.walleij@linaro.org>
 <20220118110928.120640-3-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a9u+smHLJFfrHG9A"
Content-Disposition: inline
In-Reply-To: <20220118110928.120640-3-linus.walleij@linaro.org>
X-Cookie: Do YOU have redeeming social value?
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--a9u+smHLJFfrHG9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 18, 2022 at 12:09:28PM +0100, Linus Walleij wrote:

> @@ -655,6 +653,9 @@ static int s3c64xx_spi_prepare_message(struct spi_mas=
ter *master,
>  	struct spi_device *spi =3D msg->spi;
>  	struct s3c64xx_spi_csinfo *cs =3D spi->controller_data;
> =20
> +	if (!cs)
> +		return 0;
> +
>  	/* Configure feedback delay */
>  	writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
> =20

If you do revise this that should probably just be a guard on
configuring feedback delay rather than aborting out of the entire
function since otherwise this isn't extensible if anything else gets
added to the function.

--a9u+smHLJFfrHG9A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHm+sIACgkQJNaLcl1U
h9BeGwf/Q2fr3dj6bkE2UhoXDm2yn0IG0b9XeavY3qEb8lC6qoas3KjN9aMGSaOF
EwPHYy+oP6zleC899R23A360PMVv8L8FV8LbqiWPiHMKAbzG4TkHlMHkdRypMtaN
hGjy1oG58yMyiVgdF8CDERVwbcSamOgrkEGSD4isOqYI/mFlJBiY5NM7uKF6UvkA
JR9NLsgAYfW+V5hqrW/4zTgbA0KRHEoBZ1yTxNzSaoKo1qrHXc+Yr2f0Hzafej5i
i13k4NGv8p5O+xN3Pxa/GVeFkzRueyhVEmyibq9gWFOkeEIxmJThzhZJ4AyiFZ7c
QrW+STHy1Kz1I93PP4NZTEGpHFK6+Q==
=2Frz
-----END PGP SIGNATURE-----

--a9u+smHLJFfrHG9A--
