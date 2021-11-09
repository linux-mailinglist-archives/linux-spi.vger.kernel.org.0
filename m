Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800C644AFD6
	for <lists+linux-spi@lfdr.de>; Tue,  9 Nov 2021 15:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhKIPAq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Nov 2021 10:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhKIPAp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Nov 2021 10:00:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43B7261051;
        Tue,  9 Nov 2021 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636469879;
        bh=yPprtFKKDaP1/9INKU0zC02lWKKZCZYnStSzZ+e7B8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojlkNy4hNKmqMuq4Evfpqth0SwV2D14+g2u1yyDlOz1t4CceFxmW+peMjPnyTnRu4
         gaXSE+MWjFQDb6Y7WdaiPNe79f322amGdjAeiPbJZYHRbEsgNsg8eUuuwnHqpzS+Rv
         osVH0H0HcUslGPpLnZRIcF1m7fcAYWb11qfzNOCs0t6IdigYQU6PdCdj57S2l0atx7
         Wx0LBGfBf3LFFkdsLGjSbOcPAj4H1OWv9OOeuclYcxlJeGal9ZAdo3/897SA6PlcmB
         8WVH8cSPAZ1M2To7Sw2HijqGlnNCrWCTUKqrR81HRa7eZOdxGqFuEexmddxhHfT5mC
         dgH5DKqURdiCw==
Date:   Tue, 9 Nov 2021 14:57:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "LH.Kuo" <lhjeff911@gmail.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dvorkin@tibbo.com,
        qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: Re: [PATCH v2 2/2] devicetree bindings SPI Add bindings doc for
 Sunplus SP7021
Message-ID: <YYqMcrEhVWxe5By/@sirena.org.uk>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-3-git-send-email-lh.kuo@sunplus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RvUUipud4crt1Nc7"
Content-Disposition: inline
In-Reply-To: <1636448488-14158-3-git-send-email-lh.kuo@sunplus.com>
X-Cookie: Elevators smell different to midgets.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--RvUUipud4crt1Nc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 09, 2021 at 05:01:28PM +0800, LH.Kuo wrote:
> Add devicetree bindings SPI Add bindings doc for Sunplus SP7021

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> +  reg:
> +    items:
> +      - description: Base address and length of the SPI master registers
> +      - description: Base address and length of the SPI slave registers
> +
> +  reg-names:
> +    items:
> +      - const: spi_master
> +      - const: spi_slave

What exactly is the physical overlap between the two controllers - is it
just the pinmux?

--RvUUipud4crt1Nc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGKjHEACgkQJNaLcl1U
h9C03Af/TEyg4F3Vx7hVD1JXwcXqnhGQo8QH8ogYDPKz2gVuPSW4Av4ZYp6Papx6
z9HDW/rxzVKsD5SJ1NUNs+QwRPoLs3HcwkuwHAtfLAzkQLBYifxXB+3YXDSEhHWY
MbeTows+bhcDqzzDnCaMnekZ3QsJj08uame0fm8f/c9ctZbQuOH+kUM4FjgLOvUG
BS2AO2DcJVpt4QzblFu731/Xmbs8Zrd2phroEaQO4zQVzwlEB4jUdt9DTQoQ7jTa
sc09MFiqWTvLF5AnS8GzkoEvVsgEtITThspuJOy6b34z9j0DN0GOzJAiEpWH0SFI
3PvbRpvTDJUCmy7d2O1GuFGaGqpxYw==
=RykT
-----END PGP SIGNATURE-----

--RvUUipud4crt1Nc7--
