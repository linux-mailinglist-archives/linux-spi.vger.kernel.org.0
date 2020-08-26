Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B2D252B49
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 12:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgHZKUb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 06:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728161AbgHZKUa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 06:20:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B08352071E;
        Wed, 26 Aug 2020 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598437230;
        bh=I0i2q5/JqUekGhzJe594DvzcUM3i+my4rruJmCWxWeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvjqRbONInpcWqBDaQcpXLXdf7/ssIOhM++ISKq2qwrU7IDsH5HRQAfbJu8/hHbH7
         1YpZXrgRtxv53dgb6kD7MFF0tXw6gvqZYI7EjFmyjPi4eCgf7pSCOQFAbTrf1U+CFS
         OnQeDDI5a+yaKtSGiIIiyLc0w+g9ta82YCulmo74=
Date:   Wed, 26 Aug 2020 11:19:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200826101954.GD4965@sirena.org.uk>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk>
 <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf>
 <20200824112505.GD4676@sirena.org.uk>
 <VE1PR04MB6768E050B97AAA33501B6D6891540@VE1PR04MB6768.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6768E050B97AAA33501B6D6891540@VE1PR04MB6768.eurprd04.prod.outlook.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 08:19:41AM +0000, Qiang Zhao wrote:
> On Mon, Aug 24, 2020 at 19:25, Mark Brown <broonie@kernel.org> wrote:

> > Yes, it's a legacy from bad board file conversions and shouldn't be used at all.

> I saw a lot of driver assign spi_controller -> num_chipselect directly, should we do like that?

Yes, you should know the number of chip selects based on the controller.

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GN0kACgkQJNaLcl1U
h9CfaQf/cFN7Z+7Su3oU98AYqh3AS6StbT42NYYmfMw0bX/Ymf4mNxqFU4DR+fsU
hINOEiBo8SVc4p9GMRK7hSCqOuLFrViWewEPcnfr3D4VISJ7bLAAP8SjOGa5YgTZ
WDcXJ4STYGrR3dgxbMjyL/f1JKfMuMRYoTw2uc+uNZe4mnBIkfCGoocxdA2ZGGUc
Qx+MrNEDTmi1xNhMFhorO/uKKNsdNLKycljcdZ3swOHOs7L064bgeICJmnpK0n3Z
MRKyT+C3jvkcnojv55s9wI2xqcI2jtRioTAZkeZOfP+4bqqf1jCDs7xJkKMMRZwO
idSiTyw6bsDFEL/CwcKiU1yKpG10Uw==
=1dzn
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
