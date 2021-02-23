Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FF5322B93
	for <lists+linux-spi@lfdr.de>; Tue, 23 Feb 2021 14:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhBWNic (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Feb 2021 08:38:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232655AbhBWNic (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Feb 2021 08:38:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20D3464E21;
        Tue, 23 Feb 2021 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614087471;
        bh=TrmcXwd6Asf9iet05nKyNMTdpH2GzJ4UvZzgOYSjMGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIzBjlq/MqTnF/tBiKpAGOFBRjbzud57lq7alZ37pVMk1xm8WAcF5bs9aa4oXNFYe
         PRHCARvjrRNW18qx0Qk3iCC5B8u6tpcyP29JzfSW+Na7XgAicRxhEl5ckB1s4KNcLS
         ddDGifVV4RYerxMocnqGgUrByW4Xh+HkAEPQzJAcMEuw4Glr0WSJRv5iGQXHW4IQDM
         EMcPmCDXLbNEVg4kSuhBDmFDQWCnaTQRi9KhFHHumgXmAX4mWBjdJQYq7z5cDZ0wQR
         wiqDS/ud38ypfiOmOMhSNrPSp4Pi3f8Ca6aKoWOrW0KIu/hXBPyKzoJa75btXe9+63
         SPi/5hpBuay2A==
Date:   Tue, 23 Feb 2021 13:36:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        zhengxunli <zhengxunli@mxic.com.tw>, vigneshr@ti.com,
        juliensu@mxic.com.tw, ycllin@mxic.com.tw,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: macronix: add support for Macronix
 octaflash
Message-ID: <20210223133649.GD5116@sirena.org.uk>
References: <1612517808-10010-1-git-send-email-zhengxunli@mxic.com.tw>
 <1612517808-10010-2-git-send-email-zhengxunli@mxic.com.tw>
 <20210205104736.2771074c@xps13>
 <20210205133404.esqqeokhlp4askpq@ti.com>
 <20210223141344.7ad25831@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <20210223141344.7ad25831@xps13>
X-Cookie: Kilroe hic erat!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2021 at 02:13:44PM +0100, Miquel Raynal wrote:
> Pratyush Yadav <p.yadav@ti.com> wrote on Fri, 5 Feb 2021 19:04:04 +0530:

> > [0] Since SPI NOR has no way of knowing what speed the controller is=20
> > running at, assume the fastest speed the flash can run at.

> Ok, I am not entirely clear about what is available/not available from
> the SPI core.

> If this is true then I guess we can't do better with the current code
> base and this can be improved in the future if needed. So I'm fine with
> the current implementation.

For normal SPI operations you can set the speed (really, top speed) on a
per transfer basis.

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA1BPEACgkQJNaLcl1U
h9DrGQf+PfSnj4LMXv1cdILxA6rPcwpI8poO9ee+xTB1qoWn7L+NaYzwN/38IruP
NC9mAhUPDv55fTRU/aq1Bu1C4Eiv0IO+Z9XctxYFfdy+rdkX7jP97JQ6Ukj3GN9A
DUDnwZfYEydP6TEeqFqXKxC24J8msCAJ0oXUBfjV4NiOah2FvRCFa8Yszc/gXjvX
JUmHMmKRyPfy80OWcMzu6tdFl3xZeXpzYCQEZjIKhJtJgQ1ZdJC9y0eUE3+nls/m
mxXlnoj9WWrWQGjiEv8aPpQDIswvH9yMWFozIrirPNxkbNpcy9Jl+5mg5DGEVwyC
Yt/uy/i48Apw72riwaBkQ0LRvebuuA==
=fOpH
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
