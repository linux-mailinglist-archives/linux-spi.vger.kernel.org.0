Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5D1FAB1C
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 10:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgFPI0w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 04:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgFPI0v (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 04:26:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3265E20739;
        Tue, 16 Jun 2020 08:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592296010;
        bh=zwfLiiOBJv9xd28/k4MWseO5mRe5jJl7Tlu1GcSaMnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w2c2Ybd7/S1rdMjRJx7tdDDHKFcteQHILKII8l5QRlwqqG7w4fzM1hdvsYjm0A4QV
         SomjjZpuxuPmquQs8zHLOXxAQzPX3D0RE+bgRvFZ0bROzLi133kvtMmZ267oKu32li
         aZgljVip8ixpLwQtburrAnyZ0HWuJsZDJ5Dc5gsU=
Date:   Tue, 16 Jun 2020 09:26:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "kdasu.kdev@gmail.com" <kdasu.kdev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] spi: bcm-qspi: Make multiple data blocks
 interrupt-driven
Message-ID: <20200616082648.GE4447@sirena.org.uk>
References: <20200615040557.2011-1-mark.tomlinson@alliedtelesis.co.nz>
 <20200615040557.2011-5-mark.tomlinson@alliedtelesis.co.nz>
 <20200615143233.GW4447@sirena.org.uk>
 <40bae0160c6e24c3d90d4935eb31cf3de64abc9e.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2+IiqX0tbFQDLF7Q"
Content-Disposition: inline
In-Reply-To: <40bae0160c6e24c3d90d4935eb31cf3de64abc9e.camel@alliedtelesis.co.nz>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--2+IiqX0tbFQDLF7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2020 at 03:07:17AM +0000, Mark Tomlinson wrote:
> On Mon, 2020-06-15 at 15:32 +0100, Mark Brown wrote:

> > Again was this done for a reason and if so do we understand why doing
> > this from interrupt context is safe - how long can the interrupts be
> > when stuffing the FIFO from interrupt context?

> As I'm porting a Broadcom patch, I'm hoping someone else can add
> something to this. From the history it appears there was a hard limit

If you didn't write this code then it should have at least one signoff
=66rom the original source, I can't do anything with this without signoffs
- please see Documentation/process/submitting-patches.rst for what this
is and why it's important.

> (no small chunks), and this was changed to doing it in chunks with
> patch 345309fa7c0c92, apparently to improve performance. I believe this
> change further improves performance, but as the patch arrived without
> any documentation, I'm not certain.

Have you tested the impact on performance?

--2+IiqX0tbFQDLF7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7ogkcACgkQJNaLcl1U
h9AeHgf+PeKNVWiTvF5IZERUnylT0z36L9JFKcSvYNtlJFeRKiQEMyF/l1OR2g+U
R0TQERq0rcUof2GoqP3L4RgsykGVprSexq8YdIXNe1Zelmjk1H1S9kj4MvxkPKG7
tCX8BRwOz61Lm7elp0aFbsCpYT2JmnpIYlDqiTehjeFJL4VBd11ZUDgv6disFTVA
/pkVx2HMscDeBxLRaPBNOZMQy9FElRRV4TNGBjfFxGx0po+5bEk0r+TDPABG4fyG
C6QxfPE7venVM5RrNjaljJRh30oBpTawrHo5UiTBefb7og9xBFal6rqpN0pygk79
kFB4dIG9bsuRH3dOtZBqEzYzn1Rdqw==
=5Rdi
-----END PGP SIGNATURE-----

--2+IiqX0tbFQDLF7Q--
