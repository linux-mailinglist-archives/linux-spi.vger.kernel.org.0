Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7814124D6F6
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgHUOHw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Aug 2020 10:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgHUOHw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 21 Aug 2020 10:07:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83BD920FC3;
        Fri, 21 Aug 2020 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598018872;
        bh=5S7Q0YtgDvZUo0yS62VbE0j6lH4SUg1WKnhXg7RFPq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x0MInh6po3FH0n0ONzd1XGuWdv2JNbOv6vNnuDRwHpQPHp4I1ULit/obIRBWkVJu7
         j4DG2GTYigS9WN2mgER8jj6bJkPc7ks33Zy3Yjp/7IoF4Rx4qZVytbPW2S5W1SaSMP
         BDnM8MrHzFUbmAefFu96+xS4rLWh+tx8kGRvU8Gc=
Date:   Fri, 21 Aug 2020 15:07:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        tanveer <tanveer.alam@puresoftware.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200821140718.GH4870@sirena.org.uk>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline
In-Reply-To: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
X-Cookie: divorce, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 21, 2020 at 06:40:29PM +0530, kuldip dwivedi wrote:

> +static const struct acpi_device_id fsl_dspi_acpi_ids[] = {
> +	{ "NXP0005", .driver_data = (kernel_ulong_t)&devtype_data[LS2085A], },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, fsl_dspi_acpi_ids);

Does NXP know about this ID assignment from their namespace?  ACPI IDs
should be namespaced by whoever's assigning the ID to avoid collisions.

> -		ret = of_property_read_u32(np, "spi-num-chipselects", &cs_num);
> +		if (is_acpi_node(pdev->dev.fwnode))
> +			ret = device_property_read_u32(&pdev->dev,
> +					"spi-num-chipselects", &cs_num);
> +		else
> +			ret = of_property_read_u32(np,
> +					"spi-num-chipselects", &cs_num);

The whole point with the device property API is that it works with both
DT and ACPI without needing separate parsing, though in this case I'm
wondering why we'd need to specify this in an ACPI system at all?

> -		of_property_read_u32(np, "bus-num", &bus_num);
> +		if (is_acpi_node(pdev->dev.fwnode)) {
> +			ret = device_property_read_u32(&pdev->dev,
> +							"bus-num", &bus_num);

This is a bad idea for DT and I can't understand why you'd carry it over
for ACPI - why would an ACPI system ever care about this?  It's Linux
internal at the best of times.

It looks like you've done this by simply adding these device property
alternatives for every DT property.  This isn't how that API is intended
to be used and suggests that this isn't a thought through, idiomatic
ACPI binding.  I'd suggest looking at the Synquacer driver for an
example of how this would normally be done, I'd expect your ACPI code to
look very much like theirs.

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8/1RYACgkQJNaLcl1U
h9C9+Af+MCGnsfEPJEtAgPZcBq7cSu58Gt0lpZ+9KUZzKJFUtMU3et0nDcN9+eCV
V7FOFJdHyGjdUEt1GK+LgFEnJ6yO0TnrT8Vwk43iQDUwX08vpZme4LPeOJHHweGW
wW4CuCmaQ+j9P+vxG26NL6mv8dNQuD9W6jCYzgaqZC4mt3E2n0042lV1/l8LIEh1
qV6pYtCMOczmUlz1GdApeA0k3GXMwhUw0uEEr3x2Lp7jpY5PTlLW3xD0v8aBMbUy
vLMP9GrS51lysYYAvxnyeeAwgt07pYoWAYamjT7f0l7oZY+4ukMAt17IoKRVcK3C
PWSASnzkQf5xJOdjjeZ9GnD/Fi1NlA==
=ukfl
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--
