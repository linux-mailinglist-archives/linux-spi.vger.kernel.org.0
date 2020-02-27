Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCD9172242
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 16:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgB0P3J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 10:29:09 -0500
Received: from foss.arm.com ([217.140.110.172]:53696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgB0P3J (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 27 Feb 2020 10:29:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA1AD30E;
        Thu, 27 Feb 2020 07:29:08 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FF083F7B4;
        Thu, 27 Feb 2020 07:29:08 -0800 (PST)
Date:   Thu, 27 Feb 2020 15:29:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, kdasu.kdev@gmail.com
Subject: Re: [PATCH] spi: spi-bcm-qspi: Use new structure for SPI transfer
 delays
Message-ID: <20200227152906.GD4062@sirena.org.uk>
References: <20200227141050.10969-1-sergiu.cuciurean@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline
In-Reply-To: <20200227141050.10969-1-sergiu.cuciurean@analog.com>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 04:10:50PM +0200, Sergiu Cuciurean wrote:

>  	if (qt->byte >= qt->trans->len) {
>  		/* we're at the end of the spi_transfer */
>  		/* in TX mode, need to pause for a delay or CS change */
> -		if (qt->trans->delay_usecs &&
> +		if (qt->trans->delay.value &&
> +		    (qt->trans->delay.unit == SPI_DELAY_UNIT_USECS) &&

It doesn't seem ideal that if the delay ends up specified in a unit over
microseconds that we end up just ignoring the delay entirely.  This
probably needs fixing in the core though, for example allowing the
driver to say what range of delays it can actually implement.

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5X4EEACgkQJNaLcl1U
h9AuKQf/VwDsH35+efmI58edDRHc3b1P9SXWdUTz+6yZOMfKofhGJlhnhkoHheqt
kfVUG2SxvNDzDpmoZLW5KscTW0WcY3Le/15dLQoXpbRyshvNOiP7y4K/GJrlHCr/
fic/79xluk+5b+abPXyARC/wjaVN2lNgl1dPVuvXvIN7Regl45EbWX53gFPybxiF
lIQkR0ZA64jgUsDMF+ogiqW05kE6/rWo4OkMgqKKvkIAHeFoxSFmpxUxQYXDencr
w8tCW4F86F5FifuAhHOmXv95ZvuIaG8Lyu9MCOOI+EBUj062yM3D0FXbWkdy+umU
qKF0F3Y/cCMHZdzA4LIri/M8lk23VA==
=qSJi
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
