Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5A83B8264
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 14:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhF3MuO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 08:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234455AbhF3MuO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Jun 2021 08:50:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 321C361407;
        Wed, 30 Jun 2021 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625057265;
        bh=QPV8542hqvi/OwEphtYbekIXENhvINNTu7tSe78dCTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tv4YkquJkwD8geGYuScthzACya8ezWwSlU/86Tmf5OT/u8EQpTYDRR9xH9v3dKkpg
         Gd9D2eo+5DaJ4FsLZZfnKnLThcWJpsFmPmYIV+RWDNHfobNr8NRpYg12D/BIjMs2eb
         jLbFlzlV7YvydrNtDhBZOeHIngXsWMlxlCt9vtAB18u8OGkFhcfQLCaa33xvvMMQFB
         +z5ae5D+mf7H6yOfEPV34X1x837VQfSJ07nTIQc/2LN3EI65NvrnrdxOuR6gUCmkx7
         renX6gvaPeI+N9uINiFijTx9b7MovQIsvEqs1cr1GYlnpOVx6e2uKuKOcf6/+IKcuc
         Y591bIh7XDeqA==
Date:   Wed, 30 Jun 2021 13:47:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Liang Liang <liang.liang@amd.com>
Subject: Re: [PATCH v3 3/3] spi:amd:Fix for compilation error for non X86
 platforms.
Message-ID: <20210630124717.GE5106@sirena.org.uk>
References: <20210630120425.606957-1-Nehal-Bakulchandra.shah@amd.com>
 <20210630120425.606957-4-Nehal-Bakulchandra.shah@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Content-Disposition: inline
In-Reply-To: <20210630120425.606957-4-Nehal-Bakulchandra.shah@amd.com>
X-Cookie: Use at own risk.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 30, 2021 at 05:34:25PM +0530, Nehal Bakulchandra Shah wrote:

> Update the KConfig with dependency for ACPI as driver is only
> supported for x86 platform. This fixes the compilation error
> reported by kernel test robot.

If one of the earlier patches in the series fails to build you need to
fix that patch so you don't break bisection or cause people to spend
time finding errors in the earlier patches you fix later.

In any case this doesn't do what the commit log says, ACPI is supported
on at least arm64 so if you genuinely need an x86 dependency ACPI isn't
going to cut it and COMPILE_TEST means the driver will still be built on
everything.  I don't recall anything from 0day that looked like it was
anything to do with dependencies though.

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDcZ9QACgkQJNaLcl1U
h9D59Af9HEnL7Te94Mpx/OU/nXS7AkV/WCGPPBuHzw/2TOro17grRKV7xfJze4KC
iYkvIseY0B8ewdFHcDBTuaJ1PTG4dG/m594wkVPbGKkwFi8LaAF6tnKvhscsg10H
Zll2yqmJ5NUJCUqCD4Y9WDESEw16RfQNX3h5uAnM3B32I7fVXAkTkSeO1jR4htFv
f23LtNO4yImzaCsERocYEOICRfigELnoH1vVUvmxuJlDM5Z9y41Ehnm9i/OEmqgh
0mFUkFmAW0WFRZj0oFXkzGvNbDy0N/USfAiH1Gmy5s0x1Dkufu3FHE4ZQzXWjiqN
tWjYrsEiYTYhL6sqVujmQ1OwZGrBcA==
=PUsU
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
