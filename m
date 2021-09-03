Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0B63FFE17
	for <lists+linux-spi@lfdr.de>; Fri,  3 Sep 2021 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349025AbhICKUM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Sep 2021 06:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234262AbhICKUK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 3 Sep 2021 06:20:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECD8260F42;
        Fri,  3 Sep 2021 10:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630664350;
        bh=6luTq7e/gR3qVGMTHfn1KXrVL40WQTwM4lI/qO5d+jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QnTB8MelMxrhCFXOp7WPxdaQLoaENJdHsrsL4B2CC/5WPsrAFh2kW7K9MtCw2bx19
         AqlMGSCaszXExdVO3LK3+UQ+20csKffzazNuDtJlJb3X8p7VrpqkntEHNDWwk1Biiu
         H07zwKBuQTC57DvjSTl0uVeNzzes2bInEwMgsYw9GBFeVDvPd8JJUnma8CUEmIBfPk
         6Yx4mn+AM3012u+Sci8P/43h7pchd5SzCL9oqwIsJo3/gxBUSTaNCnvaa33zitLz3K
         gyEKDqlbkZqn/fgdnxU2X5W+RTlSGj6IRiZ/8bkP9Qs7LQ26vmfvgMDytmh6pzOwEz
         SoKZLGQTga4cw==
Date:   Fri, 3 Sep 2021 11:18:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Parshuram Raju Thombare <pthombar@cadence.com>
Cc:     "lukas@wunner.de" <lukas@wunner.de>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: Re: [PATCH v3 2/2] spi: cadence: add support for Cadence XSPI
 controller
Message-ID: <20210903101837.GA4932@sirena.org.uk>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
 <1630499858-20456-1-git-send-email-pthombar@cadence.com>
 <20210902143947.GC11164@sirena.org.uk>
 <CY4PR07MB27577F9A6DBF3F4985B014ACC1CF9@CY4PR07MB2757.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <CY4PR07MB27577F9A6DBF3F4985B014ACC1CF9@CY4PR07MB2757.namprd07.prod.outlook.com>
X-Cookie: Darth Vader sleeps with a Teddywookie.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 03, 2021 at 08:10:38AM +0000, Parshuram Raju Thombare wrote:

> >> +	master->mode_bits = SPI_3WIRE | SPI_TX_DUAL  | SPI_TX_QUAD  |
> >> +		SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL
> >|
> >> +		SPI_MODE_0  | SPI_MODE_3;

> >I don't see any handling of these in the code?

> This is just to declare controller's capability, so that spi_setup() can modify
> spi->mode according to the capability of attached device.

In order for this to work I would expect there to be code in the driver
which configures the controller into the specified mode.

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEx9nwACgkQJNaLcl1U
h9ANwwf9GQT/fFI93cvXG99OAiBBenPxeG+GJqck6BoH5Ybw5wEoFCM1XIm/uvDd
pflf/NXz2OpVFsH/4UhqKDayAOa/6iytSIzvfojXRrsVF/CA05SdKoWZUT00ClNw
PSe/CgeSNXTj6cY3C3t0/paEY/TCNGKw5HuA5HUm8xyMB/6/3WFXzC2SOyVmeqVS
zl0xCXvVFtO828RaGd5hREtBRI+LSoD8MdCoXetHNJwpoTGiEoHjBDlfBJLw5NIB
4gZctwspMZ3ZXzp8lFinMFRcZlsgENiXaHfbAA0CUQEHpbUPSCUeRNTXix5PE/PQ
uavf3AV7X9gamPcvHBiYfqzJy0ybsQ==
=yecK
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
