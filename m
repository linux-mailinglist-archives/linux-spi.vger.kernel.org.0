Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52BC1EF5CB
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 12:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgFEKwp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 06:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgFEKwp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Jun 2020 06:52:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EC742067B;
        Fri,  5 Jun 2020 10:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591354364;
        bh=XeO7tDwju/KKDj9cqR21WNubY9Btw3JqGz5Uwz9OKbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qe1KvqeoJ3GrXMBQtdvkR44KDnjq5QKYn/VkETjh2pBcVx3ZDQGOGTARRoku3uwLi
         6LBFG2SquriXQ72zOOFCUuEAKpxBeOHmb6PimnlerU7in2u8Ye3UqEa+6FtQY+N9st
         TeEXUeHueqXJCRLpRNCxWK0yCG0yKubP6sMjgSzU=
Date:   Fri, 5 Jun 2020 11:52:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>, lukas@wunner.de,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200605105242.GD5413@sirena.org.uk>
References: <20200604212819.715-1-f.fainelli@gmail.com>
 <f728f55fe6266718b5041b6f3b1864a673991129.camel@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <f728f55fe6266718b5041b6f3b1864a673991129.camel@suse.de>
X-Cookie: Air is water with holes in it.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2020 at 10:46:57AM +0200, Nicolas Saenz Julienne wrote:

> > -static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
> > +static inline irqreturn_t bcm2835_spi_interrupt_common(struct spi_controller
> > *ctlr,
> > +						       u32 cs)

> Keep in mind the new 100 character limit.

That's more about stopping people doing awful contortions to shut
checkpatch up than saying that it's a particularly good idea to lengthen
lines.

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7aI/kACgkQJNaLcl1U
h9BVmQf/W9KSnmOIyYg8dG9v7/Nw5sW+8xZrwv7u3lUTml6tEdkKhOHIetp1TWoR
QSQkErpuKwkAquozYTfN67RuBNaHMOQLYKCLlqXiX7ZLXdZrLJOczzClOy71/Cn4
bTPXoYID265sBbycA3+v/fXd9ZtjXs8a2hhnl3XJLTpVJCgGcfz8guY9gxfLvxIN
gYwHRQO6m7/QvpCZSW8TjeFJfbsYbgLTv8QVSD49zG9y7PkZsdZ5BH4Qq8JU/Qw8
KBJIlMPBi30TKFmIz5ZF0jyEDizUKoI1GLESuBkugr7Vy2xvOGBsgh3XT+YnBJWY
xtaHN3xC6DFvqASDSztVTnCOsNSmvg==
=wEcm
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
