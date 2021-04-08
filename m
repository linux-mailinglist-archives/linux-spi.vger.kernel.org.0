Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B95358508
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 15:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhDHNoR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 09:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230467AbhDHNoQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 09:44:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29FAF61041;
        Thu,  8 Apr 2021 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617889445;
        bh=+0nlg2lxYHP/+WmaERtnHRADuls/CQxYMRQaiEsLuyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srsGv4QDJ2YXtQ3dk+ip8ynfU9TQwj+XOJO0yeP1q/LRRrCala/MD5cB0so0Dzit5
         GwDZ8HxCNp7deVknSUTaAw6CEeR47cirXBLZ9xM3SUwoNi4hvAG/K3o5hntkoic/UH
         mfFlGsnPmaL33yk12y6Ecbu6luRfD0CS2kPX7exYxogrR6ob5CO4KZOCSwYXxAeTMC
         DvtAo+aWbwRfmJByuWya175fC5dTY/agHSNyTTZCg87JLWUj/r6Ku6v/gCvF6DGakR
         /P8JxrWlRNAI4q4lzmeRJIR6etcUMlpNQrYtpi3jvbycoDqqzee+6uNImojZBJ1mDb
         tv7hgzrr2IZ/g==
Date:   Thu, 8 Apr 2021 14:43:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: imx: add a check for speed_hz before calculating
 the clock
Message-ID: <20210408134347.GE4516@sirena.org.uk>
References: <20210408103347.244313-1-xiaoning.wang@nxp.com>
 <20210408103347.244313-2-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Content-Disposition: inline
In-Reply-To: <20210408103347.244313-2-xiaoning.wang@nxp.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 08, 2021 at 06:33:47PM +0800, Clark Wang wrote:
> When some drivers use spi to send data, spi_transfer->speed_hz is
> not assigned. If spidev->max_speed_hz is not assigned as well, it
> will cause an error in configuring the clock.

> Add a check for these two values before configuring the clock. An
> error will be returned when they are not assigned.

For the case where the transfer speed is not set __spi_validate() will
take the controller's maximum speed so the controller should just be
able to unconditionally use the transfer's speed.  Your issue is
therefore that the controllers are sometimes not setting a maximum
speed which this doesn't seem to fix AFAICT?  I'd expect the driver to
be able to work one out based on the input clock.

>  struct spi_imx_devtype_data {
>  	void (*intctrl)(struct spi_imx_data *, int);
>  	int (*prepare_message)(struct spi_imx_data *, struct spi_message *);
> -	int (*prepare_transfer)(struct spi_imx_data *, struct spi_device *,
> -				struct spi_transfer *);
> +	int (*prepare_transfer)(struct spi_imx_data *, struct spi_device *);
>  	void (*trigger)(struct spi_imx_data *);
>  	int (*rx_available)(struct spi_imx_data *);
>  	void (*reset)(struct spi_imx_data *);

This seems to be a fairly big and surprising refactoring for the
described change.  It's quite hard to tie the change to the changelog.

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBvCJIACgkQJNaLcl1U
h9CADAf/XsYEv65PROf5zL0d1q8Q96nubfrHJIDDSDpsrbRMWbKAwEGxTBGWBT2F
3+xODJnXIhu/V5sXJ/dkh8Q8nfNaxdY/aRQE6lkX29Iu6midNb1gG2xb6M/D4ztz
KfaCiJpVwjs5iHpo6rLMwo/oAi7bFCfw2UFFSVbP4VZVkTqvZNJJL/RtSN2czbJa
69FAma1YVxRQF37b2WDFN18gm7XYyyF6WXU/f2qNRerh8qm6LfupTqKljtpsuzf8
AO6ottepa2ttjKxtb6/cHuLLHWym0ip0Rq1KGj5Jtcrkma/H/zH1859VJaicXKW9
1g0Si9UTTT1LjADlzAz4YhhjsRdEKg==
=kJw/
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--
