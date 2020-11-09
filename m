Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFD42AB8AA
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 13:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgKIMvd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 07:51:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbgKIMvc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 07:51:32 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF2020657;
        Mon,  9 Nov 2020 12:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604926285;
        bh=Bei45B1lXJhHW9eoNuI13U+f97K1W4Zn41krW3jveY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4FQ89bxQNkt5pc41PUHmso0qKRSgWcUz7/8ZFk+eWlXnAzUEdBPB9yedV7c9y2DK
         yar7WVDj/6tzsvBdG+nh7by2h8bWAGhXTV42Qe1NGvSRCYBL/oN3X3VVlYUQUMuhel
         HyHrInH6f+tVF7brZK3IqULe0QTfSx7R7lKr/kBM=
Date:   Mon, 9 Nov 2020 12:51:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 00/32] RISC-V Kendryte K210 support improvments
Message-ID: <20201109125111.GA6380@sirena.org.uk>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 07, 2020 at 05:13:48PM +0900, Damien Le Moal wrote:

> The first patch of this series is a fix of the device tree parsing code.
> Without this fix, a warning is generated when parsing Designware gpio
> controller nodes.

> The following 6 patches are fixes and improvements to the Designware SPI
> driver to enable support for the MMC-spi slot found on all K210 boards.

> Pathes 8 to 13 are various fixes for riscv arch code and riscv
> dependent devices. Of not here is patch 11 which fix system call
> execution in the no MMU case, and patch 13 which simplifies DTB builtin
> handling.

> The following patches 14 to 25 implement and document idevice tree
> mapping of several drivers for the K210 SoC: clock driver, reset
> controller and pin function management (pinctrl).

> Patches 26 to 31 update the existing K210 device tree and device new
> device tree files for several K210 based boards: the MAIX Bit,
> MAIXSUINO, MAIX Dock and MAIX Go boards from SiPeed and the KD233
> development board from Kendryte.

Please don't mix unrelated changes into a single series like this -
patch serieses this big are generally something to be avoided at the
best of times since they're a bit overwhelming in people's inboxes and
when unrelated changes are put in a single series it makes dependencies
between patches unclear which can hold things up.  It is better to send
the changes for each subsystem separately, it makes life easier all
round.

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+pOz4ACgkQJNaLcl1U
h9CEewf/d71EbjpYPiGmBNkn7r8dGy0+h6PgyHq7EGg+UJFjwHeWcI7BlgbNNsZt
RwiaM5PsMdGYvoflet8kQiuKiEh8E+cgmdMcb/vey4ge0Ay1WXmVg7Uqo4dFGKOn
wQUaomO+FwtYgXYV2G4bG4B9Ib4AsOqQn9VvhVl5lT/nPnH76Tj37FpNrMKBEjV7
IXBPp7kCwEOzPCJRRHGlos5b54D8XRYJg3YiAbJX087dS/vAva/DbwVZXTJeNDQ1
oKmgYnjdKHuE00Mhh224U/Km5GE00uOtFl91yTbAR56Nl0o+gMik42IBMq8NJXmn
tozkEgo+8a5912q/BqKHL87oPW1HeQ==
=lS0/
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
