Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959A21EE306
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 13:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFDLN2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jun 2020 07:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgFDLN2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 4 Jun 2020 07:13:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3429A206A2;
        Thu,  4 Jun 2020 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591269207;
        bh=Nbi1Vwcd5pL6Yj4orLCRo0b8veuEtH1O87IQWqOBnuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QgWPc37BTO8K8KgGK1UajZ4b1MCZp4/zWB7ShZWgSgr3nnMQE0L8sIsE/S0nbnzO9
         lrtYt89a2iu+JABD68eS4UqgsyTh/wUvkBWpj0b++mqrOOKdpoabFEnSaaEV4A8b0+
         t0TNMpIQtA+hTVfAFtQJ+iUK8E4prnVk+GlFKm1o=
Date:   Thu, 4 Jun 2020 12:13:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH 2/3] ARM: dts: bcm2711: Update SPI nodes compatible
 strings
Message-ID: <20200604111325.GC6644@sirena.org.uk>
References: <20200604034655.15930-1-f.fainelli@gmail.com>
 <20200604034655.15930-3-f.fainelli@gmail.com>
 <20200604042038.jzolu6k7q3d6bsvq@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <20200604042038.jzolu6k7q3d6bsvq@wunner.de>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2020 at 06:20:38AM +0200, Lukas Wunner wrote:
> On Wed, Jun 03, 2020 at 08:46:54PM -0700, Florian Fainelli wrote:
> > The BCM2711 SoC features 5 SPI controllers which all share the same
> > interrupt line, the SPI driver needs to support interrupt sharing,
> > therefore use the chip specific compatible string to help with that.

> You're saying above that the 5 controllers all share the interrupt
> but below you're only changing the compatible string of 4 controllers.

> So I assume spi0 still has its own interrupt and only the additional
> 4 controllers present on the BCM2711/BCM7211 share their interrupt?

Regardless of what's going on with the interrupts the compatible string
should reflect the IP version so unless for some reason someone taped
out two different versions of the IP it seems odd that the compatible
strings would vary within a given SoC.

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Y11QACgkQJNaLcl1U
h9BJoQf9E2n8uWIZEAGBfspqHbovoYPVluN+kh7+8y5BKxaA1Wz41xV3hGzU3Wzl
gEH2zebNk9eIG8IUALFCgrMLhlRBwBVV5D4LB5dVMvuwNWDeJOUs3cgBVuI8cd83
+avoXuMxBVRfhlC6JnUGrqHFPwpdBrcmfOK51jkDqZfoLdlm/ICsnWQBJPsfYTE1
iunoxY5P1vldrejYbghjoIn5OgtfDDV52cH68De5WX9srhWs8pwI+ZyXNmwuHt7d
FStC87OY8PDFPkpoF3wpmfF2BQPpzbn/b//Hyco7fg+NUJ+hMFNynSn+tcp5fgYB
R1ryNcVXhixXytOvVz7v7fBb8AtCxw==
=gHMp
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
