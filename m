Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE126B558
	for <lists+linux-spi@lfdr.de>; Wed, 16 Sep 2020 01:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbgIOXmc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Sep 2020 19:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgIOOei (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 15 Sep 2020 10:34:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14387206A1;
        Tue, 15 Sep 2020 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600178937;
        bh=gAOSKZKoFZcb8CSPjIhGpjP7jdl2VsRtqv9wSkkVAqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kHB4Z0m8Iw9kMOxrrsoZCMv7W6q5h6kgEdn3K3a5tBamH6jW8n/rBya39fwdUpgzM
         xwBZdgc5T9Kis/BMTvnU206XgGJa1XBu0s7va423lb7KLL4d0L4XjduDX7/vSOyEjC
         n3xqT4n4ukHN2PcZ0ue56RQYuF5ZerrjpAC91eq8=
Date:   Tue, 15 Sep 2020 15:08:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] spi: bcm2835: mark polling_limit_us as static
Message-ID: <20200915140808.GA4913@sirena.org.uk>
References: <20200915132311.1112865-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20200915132311.1112865-1-mkl@pengutronix.de>
X-Cookie: Linux is obsolete
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2020 at 03:23:11PM +0200, Marc Kleine-Budde wrote:
> This patch marks the global variable "polling_limit_us" as static.

Thanks but I applied a patch for this yesterday.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9gysMACgkQJNaLcl1U
h9CrnQf+IkqMUKRJmlqObHMXL6SUay/wRAZt08eufp6R8ICzpSm6VMN/ldtZs0y+
+33xXpEdMdWuW/Kif8c8LN4LM4ixoR2z5DIopZJvsi5yV4AJ6S2Cox4l3D6ysdpy
wiWu7wp4WSunZ52IbwJHwqwu9UOkZlYx376FicmsGb07TFz2TEywafF58cDraSWS
uz5QUBve18zSExbf5EAf5WeKLVXBeg3xdsVxW/dcpt8GfPRGcFzcei1tNy7GUY9R
Ti3r7KojfIvQKF4qV+ruPh/YA+6tN4/DeA65pYLohL0lmxqGJC3LSJAmLiM6pp4I
MF/iKyQM/FLmJWZd3i0PIwl+YXpjnw==
=MgLv
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
