Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A255B44DA4D
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 17:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhKKQ15 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 11:27:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234057AbhKKQ15 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Nov 2021 11:27:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34D576124D;
        Thu, 11 Nov 2021 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636647907;
        bh=Kj16yNfhHFJEjceu4fTIk5nXb1yz+0FTGUj0PCGsGpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QgDELcQiyFQGct7OCeQWJwo0JTdz2AwmZJgokLph7qrR1xUzQiy+SIPr3J9FArQJC
         1Iy6RyIClYYQW0pNt6w248QP7WN48xT6oJ82723z/FI2iqV1zYExZuOSjylgNDZMp8
         ruC8/yk2PotT7ESyaF3m/hMKAtiAe3gvyVf4K5Vl1FP9Tzh4+pQzvQx1jp+a4nOaCZ
         uxcT0w1KbhksH8d7KB7oKm/FnEbApF53D+6CjrcabMBLmfoLB2blXHqyKCVnlayTBi
         v5x2OzVuEPbrHWg+UhEhNFTWcfnT3qCXurrTzDS+Voj0RTXO00GqDBLoQYkhE0+uZw
         MJ/BsVAqhwWhQ==
Date:   Thu, 11 Nov 2021 16:25:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        nandhini.srikandan@intel.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, rashmi.a@intel.com
Subject: Re: [PATCH v3 3/5] spi: dw: Add support for master mode selection
 for DWC SSI controller
Message-ID: <YY1D3tM4fg8h6mmj@sirena.org.uk>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-4-nandhini.srikandan@intel.com>
 <YY0lpZkIsJih+g2o@sirena.org.uk>
 <20211111145246.dj4gogl4rlbem6qc@mobilestation>
 <YY0zUjjVobtg85o6@sirena.org.uk>
 <20211111160627.fcgrvj2k7x3lwtkp@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AV3LzPoSWuGFOXTP"
Content-Disposition: inline
In-Reply-To: <20211111160627.fcgrvj2k7x3lwtkp@mobilestation>
X-Cookie: Teutonic:
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--AV3LzPoSWuGFOXTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 11, 2021 at 07:06:27PM +0300, Serge Semin wrote:
> On Thu, Nov 11, 2021 at 03:14:26PM +0000, Mark Brown wrote:

> > Given that people seem to frequently customise these IPs when
> > integrating them I wouldn't trust people not to have added some other
> > control into that reserved bit doing some magic stuff that's useful in
> > their system.

> In that case the corresponding platform code would have needed to have
> that peculiarity properly handled and not to use a generic compatibles
> like "snps,dwc-ssi-1.01a" or "snps,dw-apb-ssi", which are supposed to
> be utilized for the default IP-core configs only. For the sake of the
> code simplification I'd stick to setting that flag for each generic
> DWC SSI-compatible device. That will be also helpful for DWC SSIs
> which for some reason have the slave-mode enabled by default.

That's easier right up until the point where it explodes - I'd prefer to
be more conservative here.  Fixing things up after the fact gets painful
when people end up only finding the bug in released kernels, especially
if it's distro end users or similar rather than developers.

> Alternatively the driver could read the IP-core version from the
> DW_SPI_VERSION register, parse it (since it's in ASCII) and then use
> it in the conditional Master mode activation here. But that could have
> been a better solution in case if the older IP-cores would have used
> that bit for something special, while Nandhini claims it was reserved.
> So in this case I would stick with a simpler approach until we get to
> face any problem in this matter, especially seeing we already pocking
> the reserved bits of the CTRL0 register in this driver in the
> spi_hw_init() method when it comes to the DFS field width detection.

If the device has a version register checking that seems ideal - the
infrastructure will most likely be useful in future anyway.  A bit of a
shame that it's an ASCII string though.

--AV3LzPoSWuGFOXTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGNQ90ACgkQJNaLcl1U
h9DmvQf5AY9PFw5IVy4WN+B9MYaHh4+rlQJibwn43uFWSZkDXlGWhPWyp2OB5SmH
N00SM+7kz5/+XubpqnvpAPrEduhm6a4ZdoeOXn9rC31KBBthI07PbTTD8KUkE444
WpBFlimRio+bQSDe2yqf7J4d7UJbJqeVc4cfE3sEqP6xsyAP7LgMR2Q4WeM1xm8o
ht3tDasCB8vfRoKSFmPSn9vYMoq5WdOHgUYSihuQuHfAPnCUojBw/8HkhWHInK7h
q7Q1fHcGAiLvgzYkSUJzYIzNzT+Hpsif2StoxU25hfLalo9mPzF5YsuHI7qLiVDx
DwgFdiZ4ZQaBk6tQNaknZHEyOFLOtQ==
=EjKm
-----END PGP SIGNATURE-----

--AV3LzPoSWuGFOXTP--
