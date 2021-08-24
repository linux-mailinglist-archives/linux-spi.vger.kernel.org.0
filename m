Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9702B3F6838
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 19:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242351AbhHXRlf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 13:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242624AbhHXRjd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 13:39:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4779B610C9;
        Tue, 24 Aug 2021 17:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629825406;
        bh=kn+XwzsVevnsYgage2fYiKaQAdypJdXXDutxJUgBKaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZLrNQJ1iEetXM6GBKMAocgKpBYBaoeqG/BEsyLHHCD4+94xqZ0L+If5trrPppTTL
         4FzvC3o3BKsV6f9lENaJA2d79QY0v8ezUrOuMBkRwp+9l1JZtBrVoOiTTttZdeOP9b
         e2AqhhxBOHjtti93T3X2Vzqr1Eq4iUzzQfU1+gg6mmoDrqcv0t2wUcYr+zxxBhOWuU
         3jPisWpfvK5jiEcdzx4DByclaUj817smieAnDimvH9l3BLLcTpOLd4fw3en/xkGHGl
         uvWjHepN2wL1HzBSnbVA7CRy87+zQxWa3JXxLDo7I7SAb1DuMYjAth014qMjaqHKaj
         UzqLO/qCjUEVw==
Date:   Tue, 24 Aug 2021 18:16:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 8/9] spi: amd: Refactor to overcome 70 bytes per CS
 limitation
Message-ID: <20210824171619.GK4393@sirena.org.uk>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
 <20210824104041.708945-9-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vk/v8fjDPiDepTtA"
Content-Disposition: inline
In-Reply-To: <20210824104041.708945-9-tanureal@opensource.cirrus.com>
X-Cookie: Sentient plasmoids are a gas.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--vk/v8fjDPiDepTtA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 24, 2021 at 11:40:40AM +0100, Lucas Tanure wrote:
> AMD SPI controller has 70 bytes for its FIFO and it has an
> automatic way of controlling it`s internal CS, which can
> only be activated during the time that the FIFO is being
> transfered.

> SPI_MASTER_HALF_DUPLEX here means that it can only read
> RX bytes after TX bytes were written, and RX+TX must be
> less than 70. If you write 4 bytes the first byte of read
> is in position 5 of the FIFO.
>=20
> All of that means that for devices that require an address
> for reads and writes, the 2 transfers must be put in the same
> FIFO so the CS can be hold for address and data, otherwise
> the data would lose it`s meaning.

This commit message is confusing, it's hard to tell what the refactoring
is.  It also doesn't seem at all joined up with the rest of the series
or the contents of the patch.  The rest of this series adds a new
interface which says that the controller is only capable of doing a
single transfer which means that the core should ensure that the
controller never sees a message with more than one transfer in it but
this patch appears to be attempting to parse multiple transfers and pack
them together due to controller limitations in some way.  That is never
going to do anything useful, if anything is paying attention to the flag
the controller will never see messages like that.  Indeed code that pays
attention to the flag and needs this is likely to refuse to work with
the hardware at all since the device is half duplex so anything that
needs messages mixing reads and writes just won't work at all.

It also looks like the code is adding support for a new revision of the
hardware which isn't mentioned anywhere in the commit message at all and
really should be, it should most likely be a separate commit.

As far as I can tell what you're trying to do here is better expressed
as saying that the controller has a limit on the maximum message size
then having the transfer_one_message() pack those down into whatever the
controller needs so it can send them without bouncing chip select.  The
new flag is not needed for this device and indeed looks like it will
actively work against what's needed to make the controller useful in
these applications.

Please also use normal apostrophies.

> +	amd_spi_set_tx_count(amd_spi, tx1_len + tx2_len);
> +	ret =3D amd_spi_execute_opcode(amd_spi);
> +
> +	return ret ? ret : tx1_len + 1 + tx2_len;

Please write normal conditional statements so people can read the code
more easily.

> +static const struct amd_spi_devtype_data spi_v1 =3D {
> +       .exec_op        =3D amd_spi_execute_opcode_v1,
> +       .set_op         =3D amd_spi_set_opcode_v1,
> +};
> +
> +static const struct amd_spi_devtype_data spi_v2 =3D {
> +       .version        =3D 1,

v2 sets the version to 1 and v1 doesn't set the version at all and the
only use of the version field AFAICT is that we should try to call
amd_spi_clear_chip() after a transfer.  This isn't entirely clear.  If
it's just a flag for the need to do that clear make it an explicit flag
for that.

--vk/v8fjDPiDepTtA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmElKWIACgkQJNaLcl1U
h9DwkAf/dcn31D3dwArT6L8leGiiqSooISv+bR8bCSNl/zMJaZMOP1dVQNDQsuKp
fhGWgt1WjGZK7mitS4gtBlvNLK39puap7QApUSZTyb466GR7sNuQVDEKdCekAXel
JMsOTlvduZ6X3BdNQ3dFl+67JxWk1Ho0ZReEh/NwzdpSN9wfB8PXiIcvBbwJkSsA
exAiu9txc0upjAxVQ460QSKmC3ODyNHtCjRYiYnvitF9V2SxqIXQfzXuSKWAFP8E
B4AD0y4XgXVJ3qK+xiNCXateaigtuADMgqeKSbuO/qysy7wUJQk5kQUQCXiSRPHD
2rSjs6U6RPeaAAK8RoeUZrEyjaNJ3w==
=Z3HA
-----END PGP SIGNATURE-----

--vk/v8fjDPiDepTtA--
