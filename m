Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21A5165CDF
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2020 12:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgBTLkw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Feb 2020 06:40:52 -0500
Received: from foss.arm.com ([217.140.110.172]:41048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgBTLkv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 Feb 2020 06:40:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3AA630E;
        Thu, 20 Feb 2020 03:40:50 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 785883F6CF;
        Thu, 20 Feb 2020 03:40:50 -0800 (PST)
Date:   Thu, 20 Feb 2020 11:40:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Konrad Kociolek <konrad@cadence.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Add Cadence XSPI driver
Message-ID: <20200220114048.GA3926@sirena.org.uk>
References: <20200128124212.12298-1-konrad@cadence.com>
 <20200210191620.GE14166@sirena.org.uk>
 <20200220082354.GA15619@global.cadence.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20200220082354.GA15619@global.cadence.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 09:23:56AM +0100, Konrad Kociolek wrote:
> The 02/10/2020 19:16, Mark Brown wrote:

> > >  # Add new SPI master controllers in alphabetical order above this line

> > Please keep Kconfig and Makefile alphabetically sorted as the comment in
> > the context from the diff says.  :/

> What I see is Kconfig is first and Makefile is second file in diff,
> according to:
>  drivers/spi/Kconfig            |  11 +
>  drivers/spi/Makefile           |   1 +
> Is that wrong?

Please keep the *contents* of the files Kconfig and Makefile
alphabetically sorted as the comment in the context from the diff says.

> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id cdns_xspi_of_match[] = {
> > > +	{
> > > +		.compatible = "cdns,xspi-nor-fpga",
> > > +	},

> > Why -fpga?

> This is because this driver was tested only on FPGA board.
> This driver was not tested for ASIC version as PHY
> initialization algorithm is differ.

So there will need to be a separate compatible for any silicon
integrations?  Will that always be the same for all silicon integrations
or should we have properties for the PHY type?

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5OcD4ACgkQJNaLcl1U
h9DjWwf+Kw59oWOq88WN/+Io2xu9qfSpF63ViQuy5f1M3hFbAlGWYEyUoHWkucac
8fPxVqV+5XC3FtIABoU6DYGYoTLnXul0Q6aPE0RCmCPxiRUHl8h6ZNOgNT6WeKXV
TcETE1T7JepwhjT+FL2Lu/ydw4whC1m+CJ6H7grD7gHLktS0Ks64Wi2279R9COwq
chvI0lHmjsrcnsnqUVngI+ZFRbuF4rKIlzzehUuyOcNEEu64+ZW4NgzC99VbyWpp
GDUMIg3UEcWIAjylC8gwLVHFp/SuX/NK5Odp41Fc4079kxhBz1sgYKn5ty8YyRYc
YhOuT0n1aVA03Ph5WddcvDF5P9gIjQ==
=RQrs
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
