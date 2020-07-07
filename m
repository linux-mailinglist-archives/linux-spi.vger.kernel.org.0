Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CD5216A2F
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jul 2020 12:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgGGKZQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jul 2020 06:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgGGKZQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 7 Jul 2020 06:25:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16F8B2065F;
        Tue,  7 Jul 2020 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594117515;
        bh=x8Uya2xh1YCWogN20NgLkkbgqS/sYwiJ6jSy3MfDvXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSAZvH64mMTr0fNzQDOOWUaATB881hysK9U7RbwUUpr3+2GmV1Ds+0x01qnYzUJKW
         m8QQauzR4U8SwGjV4zSGhCwO65yIUqPmriEVOrnD4gNvA16nb/yVRpT7BIWSBtNuQ+
         N44IRpT9brTGP8NEumE7fDpL5GkYMpzy1j00fk0s=
Date:   Tue, 7 Jul 2020 11:25:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Adrian Fiergolski <adrian.fiergolski@fastree3d.com>,
        Lukas Wunner <lukas@wunner.de>,
        kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] spi: Add the SPI daisy chain support.
Message-ID: <20200707102511.GE4870@sirena.org.uk>
References: <202007040833.xIqR5rAw%lkp@intel.com>
 <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
 <20200706161810.GB6176@sirena.org.uk>
 <CAMuHMdXK92qO8KB6ejc6LLmfFsy=dZY18vNJGh+CKRZBAov-JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXK92qO8KB6ejc6LLmfFsy=dZY18vNJGh+CKRZBAov-JA@mail.gmail.com>
X-Cookie: I hate dying.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 06, 2020 at 09:57:53PM +0200, Geert Uytterhoeven wrote:
> On Mon, Jul 6, 2020 at 6:18 PM Mark Brown <broonie@kernel.org> wrote:

> > It would really help to have an example of how a client device will use
> > this, right now it's a bit hard to follow.  Overall it feels like this
> > should be better abstracted, right now there's lots of ifdefs throughout
> > the code which make things unclear and also seem like they're going to
> > be fragile long term since realistically very few systems will be using
> > this.

> Can't the ifdefs be avoided by implementing this as a new SPI controller?
> I.e. the daisy chain driver will operate as a slave of the parent SPI
> controller,
> but will expose a new SPI bus to the daisy-chained slaves.

Yes, that might work.  I do worry about locking issues with having a SPI
controller connected via SPI but we mostly only lock at the controller
level so it's probably fine.  Not sure how this would perform either.

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8ETYYACgkQJNaLcl1U
h9A6pwf6AgK66piDA/pN9eIEeV4LfufhmBB4AbnM6CV2FRrhewqw4eCMUY+Kn5BQ
8KyYUKMDVrtWwo6Ro3cHXTX8/eb3fHDqalrJ47LC/zxSYdKLi1PqRmLw3oAuv6Ew
4v9KZdZjMAWxSVj71681UhbcF0pQHtUrB0AKbpL2IaFo4P8C9MTi3TcDy81o0tWj
1twoDrzpv6uSZ1HwYqQSQOwmiOEmBrungUCmVJpArBfM1uaXbuR5k7JgwSSPpmh0
ygp8agg1GrI4hZNf/R/MC3fftZgBhgAaKL8kMVN1v3U0Z1YnGNCMaA5rFxEUdiVi
xRD95iS6b1eBYIqNfz5c08qqEFBmjA==
=VSy3
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
