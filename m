Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CDB218DCB
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 19:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgGHRCn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 13:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgGHRCn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Jul 2020 13:02:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE1762078D;
        Wed,  8 Jul 2020 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594227762;
        bh=tcQEpvfKXYviEYwZH0mvCarafvIgmX4RQCzp4S4dXEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSkMogadsUklt9G7aiuiDAwf4BMfSqpeNShgUb7qd1Ko0H7KZQjkzfRrerYxS6SLM
         sw7izinKrm8hAwSoT97v0+URzoki85TLyeAsXgaZx1jcpGU5rI8gm6JaC1NxJSJn/S
         j5Pw7ZGMbXl7LsyjQgCyV8e/0Vjzrngt0duu2yZQ=
Date:   Wed, 8 Jul 2020 18:02:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        ctheegal@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Avoid clock setting if not needed
Message-ID: <20200708170237.GY4655@sirena.org.uk>
References: <20200702004509.2333554-1-dianders@chromium.org>
 <20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid>
 <20200707120812.GA22129@sirena.org.uk>
 <CAD=FV=U5RHh_QuZ1tv9V5JtcsrhRONSa_CerYwUFsHhDOhEqdA@mail.gmail.com>
 <20200708100110.GB4655@sirena.org.uk>
 <CAD=FV=UFFN+FQhvs1Cdh7jWBRMzDvfHNiC43M_ZqiVqnWf+Y+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="reSNjdE3Iylkp4B8"
Content-Disposition: inline
In-Reply-To: <CAD=FV=UFFN+FQhvs1Cdh7jWBRMzDvfHNiC43M_ZqiVqnWf+Y+g@mail.gmail.com>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--reSNjdE3Iylkp4B8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2020 at 08:22:05AM -0700, Doug Anderson wrote:

> Since the rest haven't landed, it would be nice to just land them in
> the Qualcomm tree.

I guess.

> I think there's still more work to make the Geni SPI driver more
> optimized, but I don't think it'll be as urgent as those patches and I
> feel like any more major work could wait a cycle.

It feels like there's more than what's already landed in flight at the
minute, though some of that might just be the multiple rounds of reviews
there were for the bandwidth stuff.

--reSNjdE3Iylkp4B8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8F/CwACgkQJNaLcl1U
h9BemQf+JIvcscVf3YMT0+iP6NxdT0RynD3DndnbkYXWTEnEZxPOYD85pGqBY5dW
JRWAakqd8G6RJ0sVOrPH4hzxxLuove4MHEebr6kXxUnY3nvio6DyPz40pOu8ekw8
eLhIUgs8Em5ZxCpc72Tz2XJhOwtt8WlxNhG1qmlaDaQ48LMH6kC3h+Nl6460B2bb
JF7D8w+lvhrDO/PHsZt2BAsMF9QH6demYc7EyhQBE/dCmm1mCXzPrLonXC4+3aRi
1V1ci374Tx4KhgVjYuzrhLFNsW7tr2PwoZiMcch1UlJUJ7f8sgEmu8QA444Nh4fv
toKcswg0ytpd1q1r6x2pF1FVpnuXow==
=Mmu2
-----END PGP SIGNATURE-----

--reSNjdE3Iylkp4B8--
