Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE5A1EE476
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 14:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFDMcX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jun 2020 08:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgFDMcX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 4 Jun 2020 08:32:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC694206C3;
        Thu,  4 Jun 2020 12:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591273942;
        bh=xWvRXmDlWSNdWVDBwDzr3j3iEGNG5BOdPZkKa/+g8wQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7bbgp1vHatyxhUVtAxPu9EoLuN7WVqTP2JjvTmEzE0mV5+lJsvUC4hBACN+XF2Ry
         Kyngo8Xbi1YaXMjyWu+jBNrdyhzdtYcupKufGhWaO2XK7ctZDCRR/bbf65IP8D6cXI
         +FO9zESvm9SMdgNoRVUcCyutLJQj+Hx72HxTyCQA=
Date:   Thu, 4 Jun 2020 13:32:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
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
        Martin Sperl <kernel@martin.sperl.org>, lukas@wunner.de
Subject: Re: [PATCH 3/3] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200604123220.GD6644@sirena.org.uk>
References: <20200604034655.15930-1-f.fainelli@gmail.com>
 <20200604034655.15930-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <20200604034655.15930-4-f.fainelli@gmail.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2020 at 08:46:55PM -0700, Florian Fainelli wrote:
> The SPI controller found in the BCM2711 and BCM7211 SoCs is instantiated
> 5 times, with all instances sharing the same interrupt line. We
> specifically match the two compatible strings here to determine whether
> it is necessary to request the interrupt with the IRQF_SHARED flag and
> to use an appropriate interrupt handler capable of returning IRQ_NONE.

> For the BCM2835 case which is deemed performance critical, there is no
> overhead since a dedicated handler that does not assume sharing is used.

This feels hacky - it's essentially using the compatible string to set a
boolean flag which isn't really about the IP but rather the platform
integration.  It might cause problems if we do end up having to quirk
this version of the IP for some other reason.  I'm also looking at the
code and wondering if the overhead of checking to see if the interrupt
is flagged is really that severe, it's just a check to see if a bit is
set in a register which we already read so should be a couple of
instructions (which disassembly seems to confirm).  It *is* overhead so
there's some value in it, I'm just surprised that it's such a hot path
especially with a reasonably deep FIFO like this device has.

I guess ideally genirq would provide a way to figure out if an interrupt
is actually shared in the present system, and better yet we'd have a way
for drivers to say they aren't using the interrupt ATM, but that might
be more effort than it's really worth.  If this is needed and there's no
better way of figuring out if the interrupt is really shared then I'd
suggest a boolean flag rather than a compatible string, it's still a
hack but it's less likely to store up trouble for the future.

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Y6dMACgkQJNaLcl1U
h9B7+wf9EOoVWdQtyWRHYDMiu4CbKwoDecBQAiwkL1NNap2tZFZU13Shxm6HyUp9
MyFJEmzQ8SEk2fDsXPI3oyhRHoNa18WnQkKeYoksHZOW1k2rIsNy1VFcLncQnZ1q
QWZX729ld8uBLy6Yhch8253bO7kmE9eqF3epeRJv7QWgaDrEpynYjIFbVeUOLfTV
pDkxR/SUr32j/oEkNQp7xVpNsmTgpWQ4WbR74qeKVsZEJjF/KoiPSLXcPgXXpUHR
j84dYhNyzykqbirfWmnDCHXoa35wYw2U0sQmNJCNdzRhqb1lAjoQGUP48BKR+PNm
WWM2KQ5SihLXu+2wiULmjdYHTCsSUA==
=pDpx
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
