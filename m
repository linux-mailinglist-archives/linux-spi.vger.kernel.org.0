Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7778DB3960
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2019 13:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbfIPLdE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Sep 2019 07:33:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33854 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731391AbfIPLdE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Sep 2019 07:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LxUk3ICU2QigVita2oqwjs0LsOQGEVQfpyN1oIo5cfA=; b=o/oGuFto71ZIld6CAbgo0xzC1
        3B8+qdsW+z/1cxXlVoCuQ/e+mFtw3oAUQz6hLAwBFuUXkdz9EcLby3gvE68N4QZM0rMZLBgpwHbH+
        zDxPxn/po3nrncJNtz+KnNMakNnjqxnrou1uzNUoih5GHju7clajutJ02EawNInj/Px+k=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9pFY-00041W-Mk; Mon, 16 Sep 2019 11:32:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id CCCAD2741A23; Mon, 16 Sep 2019 12:32:55 +0100 (BST)
Date:   Mon, 16 Sep 2019 12:32:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v1 2/2] spi: cadence-qspi: Add QSPI support for Intel LGM
 SoC
Message-ID: <20190916113255.GA4352@sirena.co.uk>
References: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190916073843.39618-3-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GlsaLUDw2IYctviq"
Content-Disposition: inline
In-Reply-To: <20190916073843.39618-3-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GlsaLUDw2IYctviq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2019 at 03:38:43PM +0800, Ramuthevar,Vadivel MuruganX wrote:

> Existing cadence drivers do not support SPI-NAND, it only supports to
> SPI-NOR and SPI devices. To state that is the driver for the same IP
> but due to different SPI flash memory(NAND) need to write from scratch.

What makes you say you need to write a separate driver?  It's perfectly
possible to support the normal and flash I/O mechanisms in a single
driver and as well as the maintainence issues obviously someone could
build a system with both flash and non-flash devices on the same SPI
controller.

--GlsaLUDw2IYctviq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1/cuYACgkQJNaLcl1U
h9BZEgf6A7cU/9Mcguk8zxT6d8uwEkFrWUSeIxR2aztdTbp5LhL6rUcO3xLsgkCU
dZ4JAbLPoGgs259OdM22+ZBgdzs5V8Bkz26IQCdOgkGfM3I4EzUjVbDuxyLS4DBx
MjkIMJESszbMzK5OpYQZHnPFixsF3h0KPqysktr58CeUPzfGAXVaIuVsmT0lSfHq
DaDjUL2Zn7j8rgpA2/EM1sMyPiF1qTav07LBJ8ih7Z92W14/mO9TlWypJdfsB2dX
aIpIemsrom83swwKBsCXHRU8sB6cbz35Sx3Mx0Z3lM6dhALcHdRE4xCiWwGIbpNT
EEb1sXnWRIKgHh0uV8e/AoiT5S4bjg==
=kev6
-----END PGP SIGNATURE-----

--GlsaLUDw2IYctviq--
