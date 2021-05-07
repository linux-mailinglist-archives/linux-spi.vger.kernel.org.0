Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1FB376846
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 17:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhEGPuD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 May 2021 11:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhEGPuC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 7 May 2021 11:50:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35869610E7;
        Fri,  7 May 2021 15:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620402542;
        bh=zo5ZaLSYcdR5moJLPq+dp/uSFCyN6+28ysDvX0t73as=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYH4zmKqXK7asr2NCrAehDy7TJy4roOiA59dsBYIB3Y1rS3DLCAPQ1EIfdXmJlmIG
         Lt31BDaF66DRiGb7F59boyJ6YvUqskTClejh8D9H+trDNsjE0g2pnHIwp9in4wZTvv
         TggzLHr2yvnEYtCjj+6IxiB2fL8ladoShAtn4iuUwgGcxZ2xFOszRLhGbKVl0s4Fdi
         F9Ld2SS6TAFQJr7WBBIyO0jBXXkcPIxN71xl5G1XF1YwdjrpT1zodVRK0QbSfb1uoT
         hooQlM3yoTtHQsb5WQI/PIsTGEmPPRwcKQ/pcsNuRwjfnOf/h8VWNC193S5rfTPCJy
         aG20rwLR+AOBg==
Date:   Fri, 7 May 2021 16:48:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 4/6] spi: spi-mem: reject partial cycle transfers in
 8D-8D-8D mode
Message-ID: <20210507154825.GE6383@sirena.org.uk>
References: <20210506191829.8271-1-p.yadav@ti.com>
 <20210506191829.8271-5-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <20210506191829.8271-5-p.yadav@ti.com>
X-Cookie: Postage will be paid by addressee.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 07, 2021 at 12:48:27AM +0530, Pratyush Yadav wrote:
> In 8D-8D-8D mode two bytes are transferred per cycle. So an odd number
> of bytes cannot be transferred because it would leave a residual half
> cycle at the end. Consider such a transfer invalid and reject it.

Reviwed-by: Mark Brown <broonie@kernel.org>

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCVYUgACgkQJNaLcl1U
h9D6iAf/X83wkW3EXwEG5bkyXGYvMLHjg2mUnr/2c7Sz3BjRF3mdrCLzBrI4He6j
ndjUdq1s6d+AHEc34fMt1bamADb8ZeIlb8UNoJn/RpyZdtDIpNjnBey1jEGBsKBA
a7gOkAiauV+IsanHu1ams3Ox8kcc3FLTsGF3DKc9RAo0HvjnWaxbdAG5Ygck+5GJ
IsbAlJ2PxbIDI4wQwwJxRzUUZpCbPkMAQmG9H2KhyVcLZPXDDyrz81+eLlwBvhlp
qJYYtL6RU5UNpMWEDMFPyMOHoKSNOihKZ4LUItsEMH91DYxcJDmbJncFy8Fh4hJg
ey6Urvm1TTwaQfCxkaIPjVimR84ODQ==
=nP+B
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
