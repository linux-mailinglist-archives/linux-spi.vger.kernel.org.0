Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996311C544C
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 13:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgEELXn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 07:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbgEELXn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 May 2020 07:23:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0613F206B9;
        Tue,  5 May 2020 11:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588677822;
        bh=DL0zScj/vD4HUZu7ZjuIWMlO3dmCiCLSWm3gS0fslLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HaKjKh8DwRfQ7dxTSVgpGyrStgSwSos6CFY6S1GHOHDBkTFVjlznmIGuhUWcaOzEo
         U79svTYKdnSvgXqGglGyIhnzG8sInZdEzByTh1bb5uS2R7TZDkV4L1HFl4GJfSR3fe
         XXlNKJm8aqX1vLSak2cztJ+pg2943mhflAfSU55M=
Date:   Tue, 5 May 2020 12:23:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, robh@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hauke@hauke-m.de,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH 1/4] spi: lantiq: Synchronize interrupt handlers and
 transfers
Message-ID: <20200505112339.GC5377@sirena.org.uk>
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
 <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
 <310ca761-e7ae-1192-99fd-a1960697806b@gmail.com>
 <46f31699-e781-ae33-3ee5-d51e6940ee43@linux.intel.com>
 <20200429121310.GH4201@sirena.org.uk>
 <28f6511e-fe85-a834-1652-fd70def9ca88@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline
In-Reply-To: <28f6511e-fe85-a834-1652-fd70def9ca88@linux.intel.com>
X-Cookie: Poverty begins at home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2020 at 06:15:47PM +0800, Dilip Kota wrote:
> On 4/29/2020 8:13 PM, Mark Brown wrote:

> > > Workqueue has a higher chances of causing SPI transfers timedout.
> > because...?

> I just tried to get the history of removing workqueue in SPI driver, on
> GRX500 (earlier chipset of LGM) the SPI transfers got timedout with
> workqueues during regression testing. Once changed to threaded IRQs
> transfers are working successfully.

That doesn't really explain why though, it just explains what.

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6xTLsACgkQJNaLcl1U
h9DHMgf/aPi4uTtAR1hPXyPWjXGRdm0fnyj1tmL2P9wXWRg+T2JLycn95DS7eO7b
hHsOVqARDBWCpBM+4dviis0DTExD1TaiuLp12Tl0qYwdPBUKBVlodYNYW22za9wV
nB8lscg3UieLHMMJXZ70lBNpWAsxuCblKUy+VF5naMU3BIoTho/vY4tTnk8XAdYR
a/H3cZbpv/TclAdnvdOfv8ZALLD5k8Cc5QF+GENIf1i8c5dGTs+9Zfakj5HhznPy
hdbUQX7jnGMXnQvqenytxJG33PCSlfj5+3u2Y3DBU/G814PEdDqu2iuwt26PEf6F
oOab46YmB8iPycZrWW+DNLDTyZ8csQ==
=+ami
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
