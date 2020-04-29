Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187281BD948
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 12:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgD2KQO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 06:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgD2KQO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Apr 2020 06:16:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CE8B2073E;
        Wed, 29 Apr 2020 10:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588155373;
        bh=q8i4eWL7WdqhySE9qkdDEO2oN95Vt5XxfTZCkIvXy+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdxDrRn1TW2KLfF4k9mgB5bV7cEq6S93WgiFK+Fo6ejC21q8pzgOg4aG1W6Bg3Rm/
         7p+T4uzWtcd/q4ffg78OTPECgkMa0fEkA+oGCVWGAI4YsIvNhjaxWbteD3WSLwA1wk
         M6uHTLt0iiysB63VMqcaj40xyIx85v0pd1ChIZJA=
Date:   Wed, 29 Apr 2020 11:16:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] spi: dw: Add support for Intel Keem Bay SPI
Message-ID: <20200429101611.GF4201@sirena.org.uk>
References: <20200422141142.25591-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200428141449.GV185537@smile.fi.intel.com>
 <20200428180720.GO5677@sirena.org.uk>
 <CAHp75Vf6OenGTz3Pvg9QQVEygK71E5j-2W-s+0G6dh=QDDfR2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Content-Disposition: inline
In-Reply-To: <CAHp75Vf6OenGTz3Pvg9QQVEygK71E5j-2W-s+0G6dh=QDDfR2Q@mail.gmail.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 29, 2020 at 01:14:48AM +0300, Andy Shevchenko wrote:
> On Tue, Apr 28, 2020 at 9:08 PM Mark Brown <broonie@kernel.org> wrote:

> > If there are problems with the DT binding conversion

> We don't know (yet) if there is any problem, that's why I'm asking Rob
> to have a look.

Yes, what I am saying is that in the event there are problems the
conversion should be split out and done separately.

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6pU+oACgkQJNaLcl1U
h9AuBAf/Q5h76n7Dg79KyanCi1jFT6YIpfbNPeqnl1BLqVoHg821tSkLLTxF1MID
uKVOjYxkMDAMqdVwWap7nY3IamnZNVIG4zJ90irC9QQCUfh8UxjzOV3+uQpOBdIQ
e8S2E/Mk3oRepFCmrX1jt9SQrTX7c3O2msmXgpAa5Oi9oYJIuEOJ3mmRPNP6VGLQ
79SXlAkBAVdNLRDgOKKZ1DhGFA2okxlhcn8oyT1QmW8ulgb+J+udq9VZHBX6g/dX
4Etu4kYlUFd+cg28el5vaDpoDpTsKs/UPjKo4lsFUK0BDD7hzmqF0jgFzA2jLKRc
sGknMHYQ5LvQsWWhjCYpLeuDpMBVAQ==
=0eWC
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
