Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C642C4A1
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 17:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhJMPQB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 11:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhJMPQA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 11:16:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07E6E6112D;
        Wed, 13 Oct 2021 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634138037;
        bh=jXEjCQ9GP5WHEHcqrHbhspO5YUVhZplNlVhS8sy9Lzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XpS5Xg6Vx+UP1oXKCWFL3THSryz90MTMKxTRARY6xHSmUE2locTh/5upu7UeVy3Kt
         2SjNc2qeMXU9AvE6YzumlP/weWnKQ/fezGz90W3st9Jjm3yqkXJAPUEzCsMMyaJnD1
         Rd2eSHP7K92OJwqUgeEBcetC/nB6X8k1zNHX8CHKbGsAmeiA2qATqqnf5bsO40NI6k
         if2ReofH1yOFzq9SshOP0hE9Swl3uAyZKI9Oyp9MRvEBM52qFZWtv+ZlPLjqXe4nLH
         y/LVggddGF8aU6pkCjjDlo/ojDPF7inLzCEnqrK9W6y23fhKoi1Zho3zJlieZvC6lK
         Q3ywaYyH4dXqg==
Date:   Wed, 13 Oct 2021 16:13:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 13/20] mtd: dataflash: Warn about failure to
 unregister mtd device
Message-ID: <YWb3sjwS2FBsLHzL@sirena.org.uk>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
 <20211012153945.2651412-14-u.kleine-koenig@pengutronix.de>
 <20211013144429.65b294e5@xps13>
 <20211013140835.olo2dxdno6zlom7n@pengutronix.de>
 <20211013163357.41c7471d@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9MC6GlOh61zZ2aFG"
Content-Disposition: inline
In-Reply-To: <20211013163357.41c7471d@xps13>
X-Cookie: Where do you think you're going today?
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--9MC6GlOh61zZ2aFG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2021 at 04:33:57PM +0200, Miquel Raynal wrote:
> > On Wed, Oct 13, 2021 at 02:44:29PM +0200, Miquel Raynal wrote:

> > My (German) knowledge about the English Grammar claims that independent
> > of how you spell SPI, it must be "an" because when I say it, it's
> > [=C9=9Bspi:a=C9=AA] (unless you call it [spa=C9=AA]?)

> I (personally) pronounce it [spa=C9=AA] with my French background and it
> looks wrong to my eyes to use "an" before SPI because of that, but this
> is biased and possibly wrong as well so please keep it your way, it's
> fine.

I'd say a here too but really don't care too much, I hadn't noticed.

--9MC6GlOh61zZ2aFG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFm97IACgkQJNaLcl1U
h9D3oAf/TK7RMgsjwiupY4yI4pFAx2nOZ49AJm1rXlXuce/vB8g2nUzu/wSjiQ2P
Sk6GO55MacBvHfV2bqAO0eC3R2u5r8lUqNaPxox8XYch1g7fCSr96ctl3IudvQvU
tq6VirXogCT6DOY6/iHdXR0+zZpcoh0pDvhbpDxnk8VpKFl0Z9VgP/OLPnkriGQW
mNolEk2UP/n1ZWQj9NY4jnZQRWSBorT3hrKbINLMG4DkFqUlNqU3rh0o22aB5cpB
cZn3ncZmj7sBrsg4vXIzdacClRgt6Kh2PXbO1AzF0WAePF5AZ0nmSOIBg7KONbHz
zpLVgnpm8xD/bEOHSo3A9WvppUYAKA==
=ngOE
-----END PGP SIGNATURE-----

--9MC6GlOh61zZ2aFG--
