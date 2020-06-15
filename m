Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47E91FA1F7
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 22:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgFOUsm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 16:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729692AbgFOUsm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 16:48:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC1F62074D;
        Mon, 15 Jun 2020 20:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592254121;
        bh=wo+re6s2YDnW0mUOtFNK3Gv5qenkYP/Ioxp0Ii0ipxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9bF2WuOC/XYQjJ1bZnbdmypv0LffpNr8hVmWkop5+13+AmcUErcAInWJ68Yn0qqg
         xtfvmizZti3ycCopliDMI17OZbSkRMUkSGMBnkVExAHB7yEsFK9F5pxuZkDjfgVgt6
         5GYlONQY7SQWv8T1RjbBgJ+yyfD0DetFOD9sboPY=
Date:   Mon, 15 Jun 2020 21:48:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lukas Wunner <lukas@wunner.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200615204838.GD4447@sirena.org.uk>
References: <20200604212819.715-1-f.fainelli@gmail.com>
 <142d48ae-2725-1368-3e11-658449662371@arm.com>
 <20200605132037.GF5413@sirena.org.uk>
 <2e371a32-fb52-03a2-82e4-5733d9f139cc@arm.com>
 <06342e88-e130-ad7a-9f97-94f09156f868@arm.com>
 <d3fe8b56-83ef-8ef0-bb05-11c7cb2419f8@gmail.com>
 <a6f158e3-af51-01d9-331c-4bc8b6847abb@arm.com>
 <20200608114148.4bau4mdcvwgf25ut@wunner.de>
 <3d4fd3f9-9bde-90a8-bef5-9fc97cc9b363@arm.com>
 <2e4a6c4b-857f-1000-e7fd-327b0800fb97@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+Xnt6BZa+I2KmHWw"
Content-Disposition: inline
In-Reply-To: <2e4a6c4b-857f-1000-e7fd-327b0800fb97@gmail.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+Xnt6BZa+I2KmHWw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2020 at 12:42:50PM -0700, Florian Fainelli wrote:

> Or how about this: we slightly re-structure the interrupt handler such
> that all possible interrupt conditions are explicitly handled and
> terminate with a return IRQ_HANDLED, and those which are not, including
> in the case of a "spurious" (because the interrupt was triggered for
> another SPI controller instance), then we finish the function with
> IRQ_NONE. This would not impact the performance for the BCM2835/36/37
> which would still have a single controller/single interrupt line to handle.

That seems sensible - it's generally a good way to structure interrupt
handlers.  It's almost there already.

--+Xnt6BZa+I2KmHWw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7n3qYACgkQJNaLcl1U
h9DisAf6A5UOQQuqIInhodRjyyOGfjW8rSDr/5WD85MI8WAWlgspNB+6CifvPJk+
+/yjv693s/Qlzec/Yg+M92TBor94AU3VWYiT1re9UoFIu35WAPSCL1A4E6imwUxs
cYJgHI0eE3L2muigphjbBlhUufPTRm2BDAFaHZhGTuJvRfCbbfPZdV555Fxa3r6w
GVdrs5U40M3TsJ4Wy/ht3mcnF5jRc3OvpsLAIMeVadzsNzG80GNbCn8RYaKPnUPD
OjxdMc4lA3HhZRqiYvUjUEmG4U0MXSb1DoC+8/tr/rfj6yOn+su94phT6RXF3plY
CObjpS476p9DJlmYVYA54/uj06NWpg==
=1R8u
-----END PGP SIGNATURE-----

--+Xnt6BZa+I2KmHWw--
