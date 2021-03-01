Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B1C328B40
	for <lists+linux-spi@lfdr.de>; Mon,  1 Mar 2021 19:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbhCASbf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Mar 2021 13:31:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234847AbhCAS3G (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 13:29:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00B6B651A7;
        Mon,  1 Mar 2021 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614618737;
        bh=si2eQjMtWG04yWgbRVI1ZmXrgQt/Qz7SnMI2Vx2sclo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TRyUOqnIYoOkLEdIZXY6n+mfmvhH+iTo7CrtOF+ZcPgwnX1jIvD1pwfrsHDCaKBDd
         OzJ1rhzg8FQ/vdEqpe/n2x4ds1AhZvm9EXB/2XBN3Ldbeh/3u/W0r/LQs6Oe/ab2DJ
         lwKzntubGHiOHtFnx6jxDuJIlUSZ1BjKFfkV6wpTCxFgjs07SrD9BLrLvbwcm0UULL
         LVNtjOEINjvQcZiEzwMBv7Jr3ARAZP0IP1i1HhqayUARKPX4FKRafpfRkSktwDalDG
         0Pcwxhl/F2zAfhel0RzcLc+ZirGdOYBtKNhP+ghxV2S4jdebTeA+fFgmSD9QV0D9Dl
         JkShhsckrG5aQ==
Date:   Mon, 1 Mar 2021 17:11:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>, Han Xu <han.xu@nxp.com>
Subject: Re: [EXT] Re: [PATCH 2/3] spi: spi-nxp-fspi: Add driver support for
 imx8dxl
Message-ID: <20210301171111.GE4628@sirena.org.uk>
References: <20210301103230.1816168-1-kuldeep.singh@nxp.com>
 <20210301103230.1816168-3-kuldeep.singh@nxp.com>
 <20210301132539.GB4628@sirena.org.uk>
 <DB6PR0402MB2758C61D8320CD0A88DC3B38E09A9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB2758C61D8320CD0A88DC3B38E09A9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 01, 2021 at 04:39:18PM +0000, Kuldeep Singh wrote:

> > That's a DT binding YAML conversion patch, why would there be a
> > dependency on it?

> I have converted bindings to yaml version in the patch and also added imx8dxl compatible along-with the conversion. Please see the difference in compatible entries from txt to yaml conversion[1].
> Kindly let me know do I need to submit different patch for adding new compatible or ok to include in the conversion patch itself?

Your YAML binding conversion should have been a standalone patch only
doing that conversion, the new compatible should have been split out and
gone first - each patch should only do one thing as covered in
submitting-patches.rst.  As things stand the changelog for the
conversion is misleading since it doesn't mention the new compatible.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA9IC4ACgkQJNaLcl1U
h9BVzgf/fcNTSGu3TmIuLXEmc8xKQhoS/wyKHEbL3A4BQsrfb4t1xIeNIF06Juba
05R5g6zAnzjPtXVNQ33pNJIrGJVfDWHk0wiWfp5T5pDVvk22/Whyz7+N5xa40dMN
omTFCyCKUC1DrvzMkZssOjmAQGTlXpId0N3yUx0WOVWnvgHj9y7fRA9LCGK9Dlve
yMKQZctAOAdh6W/hBDZvANC4qeoRQh3O4iUSoPo4ht6v7oDQoeTp+Dp32yclpdhP
9OpqLIi0fYuX1KaDl/9eVG/buR4NJPVWxKIE4jOd165hLdzf8chjUr2OZFDNBGA4
frXAJ2nZtoVXBFgdAP4fgfNtr6FChw==
=WlwW
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
