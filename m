Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7629245EFE7
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 15:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377666AbhKZOdm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 09:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353906AbhKZObm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 09:31:42 -0500
X-Greylist: delayed 544 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Nov 2021 05:46:32 PST
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A8FC0613FB;
        Fri, 26 Nov 2021 05:46:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E1EF6228E;
        Fri, 26 Nov 2021 13:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE3CC93056;
        Fri, 26 Nov 2021 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637933844;
        bh=wmRpkJwoC1cyFGYIO+kPPQaZo8nlGwIQSJGcblGlXbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8h1jObK6rIUOSXx/thIsAk5LFusjEwq+UEptv2AdzEUNC1FE3EQtlKXF+DCB0aH8
         dmY11g0gPUJqFRbKv90SPGyQDhlHsm+FvCYuSroX/U1wXkmQhAalVB4dOEfyV0933W
         aCfx1XAymB9XB8x9tRkKTVf/V6wabXgJvgmIgfCQX84VwEpoU4E6qJcFDwjCCwaomm
         beDcznGrLYqmiJ62RHswrHW6uKWjOEz/Ca+VKZxJRkiDZLQ7QsLtJbjdqYueV08f09
         0dPaaF/I6DJfuTFnn3rO12aIaGsOgih6/n63Smvc8XnanG1vnp9hYas3laRxwdWWFL
         Toct/ksCkBNHw==
Date:   Fri, 26 Nov 2021 13:37:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 00/20] External ECC engines & Macronix support
Message-ID: <YaDjDhOhpHMdxiqA@sirena.org.uk>
References: <20211126113924.310459-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aWPUUvSEFHncPtMR"
Content-Disposition: inline
In-Reply-To: <20211126113924.310459-1-miquel.raynal@bootlin.com>
X-Cookie: You fill a much-needed gap.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--aWPUUvSEFHncPtMR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 26, 2021 at 12:39:04PM +0100, Miquel Raynal wrote:

> As a first example, Macronix ECC engine can be used as an
> external engine (takes the data, proceeds to the calculations, writes
> back the ECC bytes) or as a pipelined engine doing on-the-fly
> calculations (which is very common in the raw NAND world).

The SPI bits of this look fine (most of the smarts are in the MTD
code!), what's the plan for getting this merged?

--aWPUUvSEFHncPtMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGg4w0ACgkQJNaLcl1U
h9Cn+Af/Voj2W+6G7O2v0NYD8QDbEakNiY0wg5+Y2TRtpK6/td/VfoamnCvD6Eyx
YjS75XB3sAkV/UlEzfZLxaeMu8+6zaW0VCuCweXEv1V/19kMc4dLPgW61Q0Mu8Ma
D3vMoZEzPXvIpk7wGVuCBoZ8L7R1X3jhTX3au0XEdhRgW642bY5ryBS19BIvFwpI
XNdiJiVqJ9STtYQT8kXu49IRPfFfzlsd36f36mT6V3mXoh8b+Y3ofnrM66I7BVMJ
G70LrsAkF64YqU9kuD4ywVOsul5KofTUjaFprS53qUQEJvNF69iWoCYWOCv/uhNU
VEjZgMVgnTLJQ+Olsji6Ymo7ilbUeg==
=O5UE
-----END PGP SIGNATURE-----

--aWPUUvSEFHncPtMR--
