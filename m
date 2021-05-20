Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537C538B619
	for <lists+linux-spi@lfdr.de>; Thu, 20 May 2021 20:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhETSfV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 May 2021 14:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233857AbhETSfT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 May 2021 14:35:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76780611AE;
        Thu, 20 May 2021 18:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621535637;
        bh=NMGesVtPQnY/FQJ7V9cpTdNOJfWW9YVR9/m3Tj3KVW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9DRU5zjc35Fx+EIojoqAGs/cPymC7vlHHGNikd4n4kC7zD6U5pu2mM7qcZ8lLipQ
         2hsooLMbHwK9xCLriZvkkrq7jv/X0Kg9qeyzitXsmNW3m5hhi++GLTF9/PjMUZEDuk
         7NUHo1m4B3lbnDIaQsCHkBC/ewXANNchbt5+C+mSGuzyXjmP0l9DCX5Mca8V1VhqOS
         HLKxTmRbZsP43NnYtxwHWLlEkHRQpGomslDw95sT67UInPlPvxPywVrfGs4W3VEmF5
         m3UzvwXZh1rrNBp3+PnTqEWm0Ww/e+mJ335NS5LZxdPXi+eLXTH0QFtObHaqGVMI2O
         CfEl1uD8r1kYw==
Date:   Thu, 20 May 2021 19:33:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Liang Liang <liang.liang@amd.com>
Subject: Re: [PATCH] spi:amd: Add support for latest platform
Message-ID: <20210520183352.GE3962@sirena.org.uk>
References: <20210520133946.2263172-1-Nehal-Bakulchandra.shah@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Content-Disposition: inline
In-Reply-To: <20210520133946.2263172-1-Nehal-Bakulchandra.shah@amd.com>
X-Cookie: Offer void where prohibited by law.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 20, 2021 at 07:09:46PM +0530, Nehal Bakulchandra Shah wrote:

> *Support for latest platform
> *Hardware Fifo has 72 bytes limitation so fix for the larger data size.

These two things sound like they should be separate patches, and it
looks like there are some other changes mixed in here which aren't
called out in the changelog.  This should be a patch series with one
change per patch, that makes things much easier to review.

>  	while (spi_busy) {
> -		usleep_range(10, 20);
> +		usleep_range(10, 40);

Why change the delay?  This looks like a separate patch.

>  	return 0;
> @@ -146,9 +180,14 @@ static void amd_spi_execute_opcode(struct spi_master=
 *master)
>  {
>  	struct amd_spi *amd_spi =3D spi_master_get_devdata(master);
> =20
> +	amd_spi_busy_wait(amd_spi);
>  	/* Set ExecuteOpCode bit in the CTRL0 register */

A blank line after the busy wait, and it'd be good to have a comment
saying why there's a busy wait before actually doing the operation since
this looks quite odd.

> @@ -241,7 +325,8 @@ static int amd_spi_master_transfer(struct spi_master =
*master,
>  	 * program the controller.
>  	 */
>  	amd_spi_fifo_xfer(amd_spi, master, msg);
> -
> +	if (amd_spi->devtype_data->version)
> +		amd_spi_clear_chip(master);

Does this disable the chip select?  Should there be a separate set_cs()
operation?

>  	amd_spi =3D spi_master_get_devdata(master);
> -	amd_spi->io_remap_addr =3D devm_platform_ioremap_resource(pdev, 0);
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	amd_spi->io_remap_addr =3D devm_ioremap_resource(&pdev->dev, res);
> +

res is never referenced so it's not clear why this change is being made?

>  	/* Initialize the spi_master fields */
>  	master->bus_num =3D 0;
>  	master->num_chipselect =3D 4;
>  	master->mode_bits =3D 0;
> -	master->flags =3D SPI_MASTER_HALF_DUPLEX;
>  	master->setup =3D amd_spi_master_setup;
>  	master->transfer_one_message =3D amd_spi_master_transfer;

I'm not seeing a change anywhere that looks like it adds full duplex
support for the v1 hardware (or v2 for that matter) and this isn't
called out in the changelog.

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCmq5AACgkQJNaLcl1U
h9D+UAf4uppXruMhqwdp5uEqIkfYy/+WtyrHf+FXHv7GfXIkWWAUIxlPm3ka53Lq
j3NxlYjqGd+NteFMXP3Y1nsI7VirtVUb/Olj7y6LJbEYX+FI85K1Kc/jQ7UIJXQB
Kxzf1s/DNMl0hmQEPOJd6AfRYpzl9HsLzJDmMGJRlBi7rrisiOXFDwrIACCz498Z
WZ4ARK+gU7rHK27Ryn1ZBmtFG3ahl2ksSlxflKqBJ3rFHoWhh4Xhj3OCvXC6xs6g
vD+Bjy4aODtTAE+rmsq8ReDqhpQd0OP2TmBou+EMp/iIcOValyhNqlGgehB7w6Lr
+ABrg+bvn5RfLfTZyCVdMtIjUnIQ
=EvC4
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
