Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1979E1410BC
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2020 19:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAQSYU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jan 2020 13:24:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729252AbgAQSYT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Jan 2020 13:24:19 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C404206D5;
        Fri, 17 Jan 2020 18:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579285458;
        bh=Unt+nafP7Qqep3NX+AoYqjNBQr2Z3oLcX0vA4oFHUas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2cdPrlAA3Lqqp2RL/BJ7338PEXZWeq/hEckJ/ruf6Wnmq8ndU08a1aMRKS1VDYmT2
         kOuP3zy3s0A8VFqjypssRBFkv7agDt2wxflpVirVaMwjy5zDHwrWyCPMuKq2z6d76m
         WTIg5mQbT1QicvoRXz7TASuX0EC8/v7KdX3wArxM=
Date:   Fri, 17 Jan 2020 19:24:16 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/3] arm64: dts: sun50i: H6: Enable SPI controller
Message-ID: <20200117182416.5y57aa6nwulztcot@gilmour.lan>
References: <20200116231148.1490-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zxgtfc54oobnuhf2"
Content-Disposition: inline
In-Reply-To: <20200116231148.1490-1-andre.przywara@arm.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--zxgtfc54oobnuhf2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2020 at 11:11:45PM +0000, Andre Przywara wrote:
> Even though the SPI controller in the Allwinner H6 SoC is more advanced
> than in the previous generations (it supports 3-wire and 4-wire mode),
> the register set stays backwards-compatible. So we can use the existing
> driver to use the "normal" SPI mode, for instance to access the SPI
> flash soldered on the Pine H64 board.
>
> These two patches allow this by adding the SPI controller nodes to the
> DT. The compatible strings include an H6 specific name, so that any
> future 4-wire enhancements for instance would be automatically usable
> once the driver learns this new trick. For now we use the H3 fallback
> name to bind the current driver.
>
> This time I tested this actual branch  (on top of sunxi/dt-for-5.6),
> on a Pine H64, both the internal SPI flash as well with SPI flash
> connected to the other SPI controller available on the GPIO headers.
>
> As the SPI0-CS0 pin clashes with the eMMC CMD pin, we keep this
> node disabled by default, to avoid losing the eMMC if it probes last.
> People (or U-Boot) can enable it if needed.

Queued all three for 5.7, thanks!
Maxime

--zxgtfc54oobnuhf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXiH70AAKCRDj7w1vZxhR
xTmeAP49nHNJa9zeo1OlCPzyy2qZK3R+gWNkj4KPdU33ab/+rQEA85fkrRDtIImN
woli9GP6PWrVOowW3vnovD0xbmYbDgc=
=/XyN
-----END PGP SIGNATURE-----

--zxgtfc54oobnuhf2--
