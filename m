Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848F044D806
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 15:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhKKOTE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 09:19:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233863AbhKKOS7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Nov 2021 09:18:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E31861179;
        Thu, 11 Nov 2021 14:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636640170;
        bh=P/cgPht51capsY2dgopdPL2n154YnylfyauvmKPuFjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=npqBj2F/gMTkNq/IGlwvxMHmpMqfi/2TdzYvWSJdPTP+EsDS6viv1wQbJkM8t1JT5
         27B7O0X7OcUb8K5lffAtLWvfmE8U/0qYlOFOcnimDjsF5AgtcKIkmpj2KoQwCUGLXi
         yM5khfny4vG/3iZ88FRqoV1PpGDgFuBDiwRmev9Y+sQl5ixIfunw13wYDzRm5cohAK
         c11bqHUSB5jcg4Zij6/vxYePJ6wROrFBuwG/sCqN7lmK6XGFKkZ941tXOn6GVIrqHj
         CdAUub8hCViTMpUNcgPT+gnhTZE/VBnDBUXOyrqVwYtxni8K0GerLS0DRm/bGpj5nh
         V0cwOj7ca/d4A==
Date:   Thu, 11 Nov 2021 14:16:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     nandhini.srikandan@intel.com
Cc:     fancer.lancer@gmail.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, rashmi.a@intel.com
Subject: Re: [PATCH v3 3/5] spi: dw: Add support for master mode selection
 for DWC SSI controller
Message-ID: <YY0lpZkIsJih+g2o@sirena.org.uk>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-4-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qSvA2DvqoPBjehSL"
Content-Disposition: inline
In-Reply-To: <20211111065201.10249-4-nandhini.srikandan@intel.com>
X-Cookie: Teutonic:
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qSvA2DvqoPBjehSL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 11, 2021 at 02:51:59PM +0800, nandhini.srikandan@intel.com wrote:

> Add support to select the controller mode as master mode by setting
> Bit 31 of CTRLR0 register. This feature is supported for controller
> versions above v1.02.

Clearly older versions of the controller can also run in this mode...

> -		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> -			cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
> +		/* CTRLR0[31] MST */
> +		cr0 |= DWC_SSI_CTRLR0_MST;

This makes the configuration unconditional, it's not gated by controller
version checks or any kind of quirk any more meaning that if anything
interprets that bit differently things might break.  If this is really
required to put the controller in master mode it seems that either the
1.02 version is not widespread or this is generally the hardware
default.

--qSvA2DvqoPBjehSL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGNJaQACgkQJNaLcl1U
h9DFnQf/frlvzd67TD+A5vGVsfzedq/NoP5b2R3dHNvBMDnNdLbX2S+tOrZQKKHD
CWc7si2qHOdrvzXBepGSlz2n0mPcXeQ6xD7tAZCpRw12eMDBTIUP0KsZOCfb+lwk
xzw8ZPlQsqyWM5B09yyJgX0kc991LxLgBHmt4PFCEAx2XZpPrSWGlxlHnRCG1GpQ
NrEhTUV4GQlbVRwcEBoiqkjXIvdQ+BsPiwb+eOsbd+gqmz5fuKPMOs2D3w9dgA/u
zouWhMYCrCHByKw5X/q9rJHjYylSTKCAQX8o1bgYy9PfFOcX45F4QzKzKEdJUfKp
xThqFJmhmc/cHw16AiaedQPl9IWvnw==
=T3Uv
-----END PGP SIGNATURE-----

--qSvA2DvqoPBjehSL--
