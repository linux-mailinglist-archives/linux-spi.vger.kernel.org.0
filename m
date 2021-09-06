Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86C2401A97
	for <lists+linux-spi@lfdr.de>; Mon,  6 Sep 2021 13:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbhIFLb5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Sep 2021 07:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240647AbhIFLbx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 6 Sep 2021 07:31:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF0FD61004;
        Mon,  6 Sep 2021 11:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630927849;
        bh=lQTbuZrQB/v9HsiFC3NABiHeRxn1QPmWdrk3cP93ln0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGPev+o7Ecl6g1vmSH/rVEKB2cvd+1/RpguH/deVOwaBWUgsvDcmQ28TIX6p716S5
         CtqaEhW/axlRh8j+FVe86vM11y0LwXkPw9sqdVGODfPQMmx9VJF7w1LyulqrUx7+1s
         2G/W7CjYhCqGisScK7ALSj3aeNTcUQItA6BvqhKXgdo9uMh2+THwjJyngIZvJr0Qg8
         /RT2ambfU3/JD1wSiIlbk2qyL4qW9mnw7cMmI+JmrcbKRp1YPbRojayGyvfmcmFNUQ
         J+UrmkFtZJbJaeWG3N2sCUQkGPTHry8j7FEXCR2XXwi6lEpp7T4L+ecBZnaq0vyz24
         kstdOka9/P/hQ==
Date:   Mon, 6 Sep 2021 12:30:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-spi@vger.kernel.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH] ptp: don't include ptp_clock_kernel.h in spi.h
Message-ID: <20210906113012.GA4309@sirena.org.uk>
References: <20210904013140.2377609-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20210904013140.2377609-1-kuba@kernel.org>
X-Cookie: I smell a RANCID CORN DOG!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 03, 2021 at 06:31:40PM -0700, Jakub Kicinski wrote:
> Commit b42faeee718c ("spi: Add a PTP system timestamp
> to the transfer structure") added an include of ptp_clock_kernel.h

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE1+8QACgkQJNaLcl1U
h9Bojwf+Kqmanc6s6IAH0+XB1OkQd31oy8XKnN/AaYuG443EW99nBrNI2UYBaiUu
n9dQHZUOY1L6SJZdgKA8yuN+aHA7xDsvwWyKj1MCrfruLq0Rkt1agUHBMtar30Oh
+NgxpTLRspF5cPvm8hAC3nkheQ5yELH5JMzvs+BmBEWtuSgMEz6BS5wJ1tg3X2z0
p49Hf9uvZbqckH4hoScI7X7IIzreFGkBTDnpaXZnjZf8kp6YRnXmInDiEGkv60BA
XvRk8f80OGou9up74wuF9gPwZeXSeMN3iON53mypkm9btn7jyFsvhqERmN7CE2j/
ZhFUMrZqD4k6nbstH4Fib55YFoIxLg==
=xCqQ
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
