Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F602AC5F2
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 21:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgKIU3Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 15:29:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:51648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbgKIU3Y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 15:29:24 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 323E020665;
        Mon,  9 Nov 2020 20:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604953763;
        bh=Rmn9ZkAaWXCOFOiXXcYPk0gblYpBbOJQA2lJtHBLpj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/fh7nU6/zuB6CR3SIkzV6nj9A3GMyjKWyjIEVHOmGtTTCHQrOiFfmI5D355sDcSS
         m+DHV5m8+ZT67oamgoDcyzy3pRMoAlJUfdqtaOsesrvkjI680BxSHPLspLF5OnG3pr
         WINxiGRlo3zBWDCQiGof11RFG8RRtgJkkpm/oew8=
Date:   Mon, 9 Nov 2020 20:29:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Sean Anderson <seanga2@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 03/32] spi: dw: Fix driving MOSI low while recieving
Message-ID: <20201109202909.GM6380@sirena.org.uk>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-4-damien.lemoal@wdc.com>
 <20201109132935.GB6380@sirena.org.uk>
 <c37ca9be-ea92-b07a-b600-d68de4f7bde5@gmail.com>
 <20201109141422.GD6380@sirena.org.uk>
 <20201109191909.wfuwpddng4rdn4ca@mobilestation>
 <5808c9b9-5955-4733-2c56-b93c627cb556@gmail.com>
 <20201109201744.zlxwur4p3ejbraup@mobilestation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Jdw4pA1x1k2W7MG"
Content-Disposition: inline
In-Reply-To: <20201109201744.zlxwur4p3ejbraup@mobilestation>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--9Jdw4pA1x1k2W7MG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2020 at 11:17:44PM +0300, Serge Semin wrote:
> On Mon, Nov 09, 2020 at 02:40:01PM -0500, Sean Anderson wrote:
> > On 11/9/20 2:19 PM, Serge Semin wrote:

> > > Getting back to the patch. In fact I don't really see how the
> > > Receive-only mode will help us with solving the problem noted in the
> > > patch log.

> > Shouldn't it put MOSI into High-Z like when the device is idle? The
> > issue is mainly that the idle state and RX state are different.

> AFAICS the manual doesn't say anything about High-Z, but only: "In
> receive-only mode, transmitted data are not valid. After the first
> write to the transmit FIFO, the same word is retransmitted for the
> duration of the transfer."

This is the sort of behaviour I would expect, and I'd expect that going
high Z could potentially cause electrical problems as the line won't be
being driven when it's been designed to be an output from the controller
so it's probably not desirable to do that.

--9Jdw4pA1x1k2W7MG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+pppQACgkQJNaLcl1U
h9CQXAf+MRf1ClMjYE+JjElpTuYREIF/+rT0noit74ukCGL6ljY9PQCfnr38Bj6Q
p86yadtF0NBIiIHgrcAYT13G6raDxNad5Et39feqb49hizl7LCLAB3z6mOK4+0wU
PLzwBdXnMcTj57E7a59cUewuk+rXNGBvQGCOjYlbBEMVBWmAQu7xfMXz7YB/34c8
1tXdtYuDIPAbt5jSTEvwOPWQI0QXxIrcnDLVA7sGjZGqgVSW4Kr+cRkdc4xSi5+x
jieX/6lHH1udyrNTQ7MQ9e1sOIMBw/t0dDaWcsKCHeuKn/+0EnI7rTon2oyHo9Zm
WIiNsFFUGWkIhT1JV0GsvqTheLXjWQ==
=bJgX
-----END PGP SIGNATURE-----

--9Jdw4pA1x1k2W7MG--
