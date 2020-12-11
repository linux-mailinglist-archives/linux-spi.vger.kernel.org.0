Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96132D7E29
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 19:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395279AbgLKSeS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 13:34:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391277AbgLKSeJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Dec 2020 13:34:09 -0500
Date:   Fri, 11 Dec 2020 18:33:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607711608;
        bh=OibTR0PAA39E07obh9yM311f9pvbiTTZNMXQ/YRmRAo=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=abGE1zDu8qOUj34r6/XsGN/Ssij59v6F0e1emxS7665euMEHfLDKAc6/tAdbNKxuJ
         svLl7dU9CLObR9R1beYDtQHU1s2XIKP7qgyisYdo/r0zFAbZ0a19zJ+LaINlEZ0CLB
         21JSoaLZ/JQWWQ/0aWhNyqZ/Vd1j5jJL1lYkaMtpZVFJevnPrEFSWsWv0UfcfeNEX8
         MT5pvRVaAP2HDHjcQD5vvBWkwn390cnOHCuwmie7bdmgMlnjKAhtjIN5lTBaG0NUn6
         Q/6MxxiLNPVgRqa40nLBukUoEu5q/DcijYS1jdaNAE9BnTjrdQQ9yuecHNa+fhckYs
         U5tHpNFdWl8JQ==
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        lukas@wunner.de, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH v2 5/9] spi: spi-mem: Allow masters to transfer dummy
 cycles directly by hardware
Message-ID: <20201211183320.GH4929@sirena.org.uk>
References: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
 <1607706088-1437-8-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fd5uyaI9j6xoeUBo"
Content-Disposition: inline
In-Reply-To: <1607706088-1437-8-git-send-email-skomatineni@nvidia.com>
X-Cookie: Nostalgia isn't what it used to be.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--fd5uyaI9j6xoeUBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2020 at 09:01:24AM -0800, Sowjanya Komatineni wrote:
> This patch adds a flag SPI_MASTER_USES_HW_DUMMY_CYCLES for the controllers
> that support transfer of dummy cycles by the hardware directly.
>=20
> For controller with this flag set, spi-mem driver will skip dummy bytes
> transfer in the spi message.
>=20
> Controller drivers can get the number of dummy cycles from spi_message.

Copying more people who've worked on spi-mem for their review - I've not
got such a good perspective on controller features.

> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/spi/spi-mem.c   | 18 +++++++++++-------
>  include/linux/spi/spi.h |  8 ++++++++
>  2 files changed, 19 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index f3a3f19..38a523b 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -350,13 +350,17 @@ int spi_mem_exec_op(struct spi_mem *mem, const stru=
ct spi_mem_op *op)
>  	}
> =20
>  	if (op->dummy.nbytes) {
> -		memset(tmpbuf + op->addr.nbytes + 1, 0xff, op->dummy.nbytes);
> -		xfers[xferpos].tx_buf =3D tmpbuf + op->addr.nbytes + 1;
> -		xfers[xferpos].len =3D op->dummy.nbytes;
> -		xfers[xferpos].tx_nbits =3D op->dummy.buswidth;
> -		spi_message_add_tail(&xfers[xferpos], &msg);
> -		xferpos++;
> -		totalxferlen +=3D op->dummy.nbytes;
> +		if (ctlr->flags & SPI_MASTER_USES_HW_DUMMY_CYCLES) {
> +			msg.dummy_cycles =3D (op->dummy.nbytes * 8) / op->dummy.buswidth;
> +		} else {
> +			memset(tmpbuf + op->addr.nbytes + 1, 0xff, op->dummy.nbytes);
> +			xfers[xferpos].tx_buf =3D tmpbuf + op->addr.nbytes + 1;
> +			xfers[xferpos].len =3D op->dummy.nbytes;
> +			xfers[xferpos].tx_nbits =3D op->dummy.buswidth;
> +			spi_message_add_tail(&xfers[xferpos], &msg);
> +			xferpos++;
> +			totalxferlen +=3D op->dummy.nbytes;
> +		}
>  	}
> =20
>  	if (op->data.nbytes) {
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index aa09fdc..2024149 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -512,6 +512,8 @@ struct spi_controller {
> =20
>  #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
> =20
> +#define SPI_MASTER_USES_HW_DUMMY_CYCLES	BIT(6)	/* HW dummy bytes transfe=
r */
> +
>  	/* flag indicating this is an SPI slave controller */
>  	bool			slave;
> =20
> @@ -1022,6 +1024,12 @@ struct spi_message {
>  	unsigned		actual_length;
>  	int			status;
> =20
> +	/*
> +	 * dummy cycles in the message transfer. This is used by the controller
> +	 * drivers supports transfer of dummy cycles directly by the hardware.
> +	 */
> +	u8			dummy_cycles;
> +
>  	/* for optional use by whatever driver currently owns the
>  	 * spi_message ...  between calls to spi_async and then later
>  	 * complete(), that's the spi_controller controller driver.
> --=20
> 2.7.4
>=20

--fd5uyaI9j6xoeUBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/Tu3AACgkQJNaLcl1U
h9DepQf/XODyzQ0UT45vCpfpru/rfrg5EoDLiG3Dv3KcNgf+JJ7AK8xYAdXIYklu
GEsr+UZrkclhK4cuRRsj0V+VkSKLdamCA49Qx2E2IbWkB22q2F8vrqfxBuDPbn0I
gBxDm79dB5PmoxIIRmYWTQejnAdIR5DEwmojdpRJvA8TCI5DW/7h7fie4dhUn69U
XFFqaflnNZl8SoAq7sMqOFnL2HGGSrdkFWujK7ewo16gKDVX4Qm92BoXdbmsnA8M
LJeiaVMzdY+3CFy/jpe1A3zm2gqlW61BchCsZpulQtFSQUrqq2bSNcD31saGnXOI
fLCzrpkWPxUzqZDX18TM1q0TcWCTVA==
=ETWq
-----END PGP SIGNATURE-----

--fd5uyaI9j6xoeUBo--
