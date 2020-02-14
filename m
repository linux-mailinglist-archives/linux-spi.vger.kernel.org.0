Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2A415D909
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2020 15:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgBNOIs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Feb 2020 09:08:48 -0500
Received: from foss.arm.com ([217.140.110.172]:33452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbgBNOIr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 14 Feb 2020 09:08:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0036B1FB;
        Fri, 14 Feb 2020 06:08:47 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7875C3F68F;
        Fri, 14 Feb 2020 06:08:46 -0800 (PST)
Date:   Fri, 14 Feb 2020 14:08:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        vigneshr@ti.com, mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v9 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
Message-ID: <20200214140844.GL4827@sirena.org.uk>
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200214114618.29704-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cy9Nn4fUvYST66Pl"
Content-Disposition: inline
In-Reply-To: <20200214114618.29704-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Cookie: Shipping not included.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cy9Nn4fUvYST66Pl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2020 at 07:46:17PM +0800, Ramuthevar,Vadivel MuruganX wrote:

> +  - compatible : should be one of the following:
> +        Generic default - "cdns,qspi-nor".
> +        For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
> +        For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
> +        For Intel LGM SoC - "intel,lgm-qspi", "cdns,qspi-nor".

There are already existing bindings for several of these compatibles,
we should not be adding a second binding for something which already has
a binding but rather continuing to use the same binding.  This is the
whole point of documenting a binding that's separate to the implementation.

--cy9Nn4fUvYST66Pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5GqewACgkQJNaLcl1U
h9DtBgf/by0nSMwRQT7XWPBJkgVJC41aPF/FnRROHTeX4+E/Wdd1YhmtwwI88q9Q
ys4i+8ZXPV4Nmh0M/L6iX/dgdITH+DGML2hnJijnqyIcAcDElu9QzOge9K+TcpcC
OVDMxxls194MmBJkbe6iRmC9PaPQAucCPHTVBSEzqOsSwLTrKv7ouBPVzvaF8qp7
jjqLoMGhoJa/Y0XcoOqTsAHkSDRldoDx8q8SBcYpraw4o3SkW3Pgvz8uCixh2w3n
f96xeZn42peC559j0dTk/ey1g2oJ6drHxF01G3rpDk9T7EJZogrQXJAJdYre5iIP
lFfsgWm4mmXgMF4nDNp70tZD8dRuog==
=vocF
-----END PGP SIGNATURE-----

--cy9Nn4fUvYST66Pl--
