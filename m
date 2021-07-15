Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA33CA29B
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 18:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhGOQpN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 12:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233179AbhGOQpN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Jul 2021 12:45:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5915F613C7;
        Thu, 15 Jul 2021 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626367339;
        bh=OSCJzfXQGA+YDCBz4k6NI4Wz/foAucQOhPRZx0QmPvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYg8LIH1LSYEYk9U2bYBFYieR/HtJMamAaRpOa4VlW6s0maPdvQF/Q81q15KRYdcf
         il5tc3SLAmxMWU1Zwh99kpDEPJHRQEUkAPgkFDTrRLwvZZLLDoZid51DA3pleSnMgR
         KHNhjHS2MLAsz7TGHkLJyHt5yifuIlQFiR7wywcYu05giVS0JBLjeNf++651W+YyTA
         cqjk98WdcGRXIbxN1odR2kTCb2QrLZbLewWpETLVj2gOW/HgBWvHozuoE6q6gNe12E
         E1+gdJom/fNM2+vaEIOy/hA7d1DgMEnla2QbCir+v9OnKWCjyBMSngKStEhKfpWYge
         tAmBqw4GVHNGw==
Date:   Thu, 15 Jul 2021 17:41:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] spi: cadence-quadspi: Disable Auto-HW polling
Message-ID: <20210715164142.GB27092@sirena.org.uk>
References: <20210713125743.1540-1-a-nandan@ti.com>
 <20210713125743.1540-2-a-nandan@ti.com>
 <20210713182550.GG4098@sirena.org.uk>
 <f1947183-81d2-3519-d25f-71d93f59e434@ti.com>
 <20210714162805.GE4719@sirena.org.uk>
 <dfa38823-b63f-1807-6141-682930de2f3a@ti.com>
 <1cebc261-e0aa-572a-8083-1e3ec0d09195@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <1cebc261-e0aa-572a-8083-1e3ec0d09195@ti.com>
X-Cookie: The world is not octal despite DEC.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 15, 2021 at 09:57:51PM +0530, Apurva Nandan wrote:

> Now, whether the poll instruction should have an address phase or not
> depends on the connected flash chip, which the controller wouldn't be
> aware of as it only takes in a spimem op from the flash cores for execution.

...

> More to this, not just address phase but any kind of variation in the
> read register operation would result in polling failure.

That seems like something that should be fixed since it means that no
controller will be able to support a feature like this - it needs to get
enough information passed to it to allow it to poll correctly.

> Any SPI operation that is going underneath the visibility of flash core
> can can problems. I agree offloading the status polling process to
> controller HW is beneficial but on the other hand it restricts the flash
> on having a fixed type of polling operation. This would reduce the
> number of flash devices it will support (out of the box).
> What should be the right way out for this situation?

One idea would be to have something that takes both the operation itself
and the operation that's used to poll for status (with expected result),
the controller can then check the poll operation and either tell the
core it's not supported or go ahead and do the polling.  Or simpler just
a separate poll operation which is fully specified enough.

Not actually looked at the code to see how tasteful that is though...

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDwZUUACgkQJNaLcl1U
h9CR8wf9HFBUJpyZ9REhkBSs3yZmc22r6CesOEcEeQ6HB3q7uYeuhjZhNoHxb2N9
ZeX1Ipz7anyQu9vYnObDIAKIJG/ir7mwjBHlrb3eiZXBbdWIIdxuM9r/C+kuYxYO
isCC1pD/EkVIq9/cKjEWCX40jfAYUf2OcHFdiklk2zakGwp15JWJz5DrRm3fwOiw
sS3Kg10/OxBBWGVzRN7YcHPNfNMKI9/+RlItI31gFJp5pPWUeb00lFMBSgPrT8R4
4P6qwpwxOCJ76tDMsixyB/SivVpZ1bKQ75ulgfcMUR2SgFTwJjTPGDMT/v4wpCjE
3+pth9xq9Kg6rQNdZ/L6rGGGZYZ7Vw==
=SyFR
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
