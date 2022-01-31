Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8604A4A3C
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 16:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiAaPQV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 10:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiAaPQU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 10:16:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5892DC061714
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 07:16:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2611CB82B3B
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 15:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA86C340E8;
        Mon, 31 Jan 2022 15:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643642178;
        bh=zcH+Of4aTE+nokk5ZwSSo+DaIXQeqj/HWLsPzmZiGxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nd0cC/iR9+dnSJv68xVhTHyUeitPZFh/BHeW5QG6/98IAAF7othTki0o+/PPWVod0
         EP4+nGVNTMnef719AmizoV91nNyTMfJQBf51y5FDLkn+1ZlMVIdfkSi35WhUcLIUnp
         rJ9Je1jDMJLQmc+dDqAVs8d0BFU29q+27f6hKwcEdGl4DkMm5ih0NQYE9N9AXiI9Ef
         4BfTALDIIAz4d9H/33VYP/QbrzoXGLYoRIGS5XCKf8HRbL3l/RaJb6dVpcfWYAqifc
         oSue8w4a/ulQfOOj1U/h3ZvkC/qE1ntO9r/6KM2sm3MRrX2f62CXB2EJiR5QwNuwYY
         DWtLV20ug5XGA==
Date:   Mon, 31 Jan 2022 15:16:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] spi: st-ssc4: Covert to use GPIO descriptors
Message-ID: <Yff9PerPmpM9hyND@sirena.org.uk>
References: <20220125011047.495828-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1OcVIgecaatKOEzt"
Content-Disposition: inline
In-Reply-To: <20220125011047.495828-1-linus.walleij@linaro.org>
X-Cookie: I am two with nature.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--1OcVIgecaatKOEzt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 25, 2022 at 02:10:47AM +0100, Linus Walleij wrote:
> This switches the ST SSC SPI controller to use GPIO
> descriptors from the core instead of GPIO numbers.
> It is already using the core parsing of GPIO numbers
> so the switch is pretty straight-forward.

This breaks an x86 allmodconfig build:

/mnt/kernel/drivers/spi/spi-st-ssc4.c: In function 'spi_st_setup':
/mnt/kernel/drivers/spi/spi-st-ssc4.c:180:6: error: unused variable 'ret' [-Werror=unused-variable]
  180 |  int ret;
      |      ^~~

--1OcVIgecaatKOEzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH3/TwACgkQJNaLcl1U
h9AypAf9ExhJqKjs6U2z/1hJ90nHfLzp9SN90bAnZhWcPnZDnRtLynQRpfMrzA7u
Q4OP0NYYm3hICFAsEZn/C2xACQ7KoeOliGP+vv7S/Jzsuq1rWyMXY58Iur4F80wq
yv/OmbyGTLtz03TyOMB7kaxQN25pXDmlK3At+oluVRIJ/rxydvFdxAxvPeTftWwz
1llvuNYvRsLituFEDElwY05HHbuibv2KwF3YLjmg2O6N8jLmA8AXdf+RP1h2w3b/
eA36GhRgOT0xpkxvyF+5uurHqy9JfapNd1xVF0kJjdgM3KeioBfvqXXjBUIfXopV
vVGlKMmPu23nSVzo0zwiV0j9G4nMKg==
=bvhI
-----END PGP SIGNATURE-----

--1OcVIgecaatKOEzt--
