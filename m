Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525391F9A3F
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 16:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgFOOcg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 10:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgFOOcg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 10:32:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 608AB20739;
        Mon, 15 Jun 2020 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592231555;
        bh=oxFQsraJAlM4VsLwbEklHGK6FLGzuPOSbKJqHy/ovIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zz+DFcdzp2Qqpeb/LsXUG3XumXxI/N5Mxja/7jAL+He4QPO347KUFJLdimIo0MQlC
         iOe/L5Y8LpyADDvWrYvzF61PEMRuar69mbBKPXppsOcs70ge5wrL7w0tRat3ntKNqc
         amMVp7U5gCVzIX4eUs+/RfCh3F8o4XGm9H2d3v9Y=
Date:   Mon, 15 Jun 2020 15:32:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     kdasu.kdev@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 4/5] spi: bcm-qspi: Make multiple data blocks
 interrupt-driven
Message-ID: <20200615143233.GW4447@sirena.org.uk>
References: <20200615040557.2011-1-mark.tomlinson@alliedtelesis.co.nz>
 <20200615040557.2011-5-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f4arffV+Mc+T1KhS"
Content-Disposition: inline
In-Reply-To: <20200615040557.2011-5-mark.tomlinson@alliedtelesis.co.nz>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--f4arffV+Mc+T1KhS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 04:05:56PM +1200, Mark Tomlinson wrote:

> When needing to send/receive data in small chunks, make this interrupt
> driven rather than waiting for a completion event for each small section
> of data.

Again was this done for a reason and if so do we understand why doing
this from interrupt context is safe - how long can the interrupts be
when stuffing the FIFO from interrupt context?

> @@ -731,12 +733,14 @@ static inline u16 read_rxram_slot_u16(struct bcm_qs=
pi *qspi, int slot)
>  		((bcm_qspi_read(qspi, MSPI, msb_offset) & 0xff) << 8);
>  }
> =20
> -static void read_from_hw(struct bcm_qspi *qspi, int slots)
> +static void read_from_hw(struct bcm_qspi *qspi)
>  {

Things might be clearer if this refactoring were split out into a
separate patch.

> @@ -960,24 +966,21 @@ static int bcm_qspi_transfer_one(struct spi_master =
*master,
>  				 struct spi_transfer *trans)
>  {
>  	struct bcm_qspi *qspi =3D spi_master_get_devdata(master);
> -	int slots;
> -	unsigned long timeo =3D msecs_to_jiffies(100);
> +	unsigned long timeo =3D msecs_to_jiffies(1000);

That's a randomly chosen value - if we're now doing the entire transfer
then we should be trying to estimate the length of time the transfer
will take, for a very large transfer on a slow bus it's possible that
even a second won't be enough.

> -		complete(&qspi->mspi_done);
> +
> +		read_from_hw(qspi);
> +
> +		if (qspi->trans_pos.trans) {
> +			write_to_hw(qspi);
> +		} else {
> +			complete(&qspi->mspi_done);
> +			spi_finalize_current_transfer(qspi->master);
> +		}
> +

This is adding a spi_finalize_current_transfer() which we didn't have
before, and still leaving us doing cleanup work in the driver in another
thread.  This is confused, the driver should only need to finalize the
transfer explicitly if it returned a timeout from transfer_one() but
nothing's changed there.

--f4arffV+Mc+T1KhS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7nhoAACgkQJNaLcl1U
h9BbTQf/S/rXBNb0g+HDHgihuanPriLK57T6YafzoPoTCnRC2N0NZow/KuAdCdY2
eoCi4qBSJZqpyw0nkRk3R6IDDZkSIuqz8s9ISyHVLODrpPU1kxjj/51fVhvTKe8v
9jwNktpZzSMZN/2HZt8+pso+qNngUmLtwoXJkiRJ3elklXzxrSWgJwugVAknQ/uQ
b8vh6daQXIvFJ7X+pTJu77WwLCbrHAD5kkNSSTZ5teePPi6Ukeoqn56nj03uHR1d
blo9vStJ/UoZeBhuzCHkjQTKTJUYk4CMLBeA7fLsdDEYjTiTqUPZpJoxZE85mwcS
kw+PkAn8jCozIinMqp6GpA57lhIRdg==
=Yyad
-----END PGP SIGNATURE-----

--f4arffV+Mc+T1KhS--
