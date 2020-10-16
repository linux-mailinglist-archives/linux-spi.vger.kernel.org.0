Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4C32909BF
	for <lists+linux-spi@lfdr.de>; Fri, 16 Oct 2020 18:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410267AbgJPQd1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Oct 2020 12:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408718AbgJPQd1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Oct 2020 12:33:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A532320829;
        Fri, 16 Oct 2020 16:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602866007;
        bh=u46vp5B1uwzNW0JBMl2fGW4TXHe2IaVrLlXw6hGjEVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EARcUo2/+3Kkn0bnoTfu6mtSthjhpEJ87uidMjq6vETgPO4BEPqjy+43uedsrET6Y
         mTCBFcTgNlasKNJv+U/OLTts0AghFy1iDGtPAM1z32L9xMJgTnj1FD6B366AOqP6m8
         RyWUDStatecR7gfRXHbMmm3JEVzPF9FGRyj5RAUk=
Date:   Fri, 16 Oct 2020 17:33:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        miquel.raynal@bootlin.com, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, richard@nod.at, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v1 4/6] spi: cadence-quadspi: Add QSPI support for Intel
 LGM SoC
Message-ID: <20201016163318.GI5274@sirena.org.uk>
References: <20201016093138.28871-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201016093138.28871-5-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lqaZmxkhekPBfBzr"
Content-Disposition: inline
In-Reply-To: <20201016093138.28871-5-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Cookie: Pournelle must die!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--lqaZmxkhekPBfBzr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2020 at 05:31:36PM +0800, Ramuthevar,Vadivel MuruganX wrote:

> +	depends on OF && (ARM || ARM64 || X86 || COMPILE_TEST)

> +	{
> +		.compatible = "intel,lgm-qspi",
> +	},

This is an x86 SoC (or SoC series) - is it really going to use DT for
the firmware interfaces?  It's not specifically a problem, just
surprising to see something other than ACPI.  Or is the intention to use
PRP0001?  There's a new comaptible here which wasn't really the use case
for PRP0001.  Like I say not really a problem, just curious.

--lqaZmxkhekPBfBzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+Jy00ACgkQJNaLcl1U
h9Bq8wf/eT9A/EcP5eME3WAszgCqlKMUJ8CrSp67m0XtbQP4LhkACvP3aeM0ir5A
HYTfoTWqPB7xZdY9lAc3YavBGQLqhFStHMunKkxVQmGR1R5/Tqs0PBfhzlsg9TES
fB2UxQzrU1bWnV5ElyCHioHkWCwgk2vBdi6PuZ2ZMDal3eX9i11sh70OlVpOm7O+
/HQdX8CM3+OZFOsmhRtjPo17TY2808W41IW7jF+5vCMZ/V2Xty7BgLdd4q2bZOLI
h2RFMddJDFpxOkcQJnoU8snriFMJLAcDjF0J9sgpRVj0gizAZ+geR1w48VhzNVKP
sMsp97jcpwXvv3UWUO8cXF4gnxRvvg==
=RVw+
-----END PGP SIGNATURE-----

--lqaZmxkhekPBfBzr--
