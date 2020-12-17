Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE442DD677
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 18:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgLQRnr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 12:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgLQRnq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Dec 2020 12:43:46 -0500
Date:   Thu, 17 Dec 2020 17:42:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608226985;
        bh=ki+piBQ3QIGhu/Q2d6mwqQe2K57wMWPfXarqxSlcy8c=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDJcEuwm5sXOrvLZF6RCP1BGdqZ7Plj62CGrNmHTBaDGBlgMsb6osMAOolnXoDNuh
         rwKi1EVPwwaRQPh/lOBmStsEoxRD5K+DbKbEnDBiBcjtRqFoa+etBVgAJq1X2K+Etq
         d0Y5S2qPtyNIahEdOF5wKxBDTXoWm7K5BgFKKXUkFYchPkbo18Y7ozSA5OItmfouRL
         7O/pIcK1XdUU664wnrofIuul61sYe04+xid9BSm6XfqPGVW6e5CE6pWKA2jubRZapk
         IVwsR6WMtDUWVVKBWXFdAx5WAjL1eRGA+CW/JAwsKK2QcbFYBVhB1QVOy5sdjP7nkw
         SFoEnfwrDOqYw==
From:   Mark Brown <broonie@kernel.org>
To:     kostap@marvell.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mw@semihalf.com, jaz@semihalf.com,
        nadavh@marvell.com, bpeled@marvell.com, stefanc@marvell.com
Subject: Re: [PATCH v2 2/2] spi: orion: enable support for switching CS every
 transferred byte
Message-ID: <20201217174252.GH4708@sirena.org.uk>
References: <20201217170933.10717-1-kostap@marvell.com>
 <20201217170933.10717-3-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mYYhpFXgKVw71fwr"
Content-Disposition: inline
In-Reply-To: <20201217170933.10717-3-kostap@marvell.com>
X-Cookie: I'll eat ANYTHING that's BRIGHT BLUE!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--mYYhpFXgKVw71fwr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 17, 2020 at 07:09:32PM +0200, kostap@marvell.com wrote:

> +++ b/drivers/spi/spi-orion.c
> @@ -369,8 +369,15 @@ orion_spi_write_read_8bit(struct spi_device *spi,
>  {

This is only supporting SPI_CS_WORD for 8 bit operations but the driver
also supports 16 bit words, it should at least report an error if
there's an attempt to use SPI_CS_WORD for 16 bit transfers.  It also
looks like this won't work on systems where direct access is supported
since those use a separate I/O path, that can be fixed by just adding an
additional check when deciding to go down that path.

The driver should also pay attention to SPI_CS_HIGH if it's going to try
to control chip select by hand as it does, which is generally frowned
upon.  TBH I'm wondering if it might not be better to just rely on the
core support for implementing SPI_CS_WORD on controllers that can't do
it in hardware - it *is* much higher overhead since it needs to split
the transfers up but it depends how performance critical and frequent
access to such devices is likely to be.

--mYYhpFXgKVw71fwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/bmJwACgkQJNaLcl1U
h9BwQgf/fGtDRQJbHSGqpGBtm7M/anY/tH0WDne1H4PQarBPKc0SYdvonJJlE1J8
v8Oa0ZLh03PbGU6NY7uv/E3FMy7sTEqDTSfdoYm+HiwH4kNwGcESlbiJzncADIjz
WqzycI1s4QPsUt86HL8tIoCysrEy5fLQ25T9ghqGu4By8sgTfpTlCHiXLNWvCbu1
b0tcWBuFDLDiY8D5rHThX+uok+DB72+44mubJM9wNZSQ3dxUEaOjTB2QdFdqwiw7
55m8FqzdzxqkocE6LPLum7EglHtVaHlTWQjVTYiOpm8gbio9nOfSab2Ss7mAc9Y7
VZ5ZebrzoJaytrLfznN6rIvP6pP0jA==
=hgj4
-----END PGP SIGNATURE-----

--mYYhpFXgKVw71fwr--
