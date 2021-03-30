Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D7A34EEF5
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 19:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhC3RG6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 13:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhC3RFH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 30 Mar 2021 13:05:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 039CC6196C;
        Tue, 30 Mar 2021 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617123906;
        bh=QPhwovPcrsJg7hlzphlimDuvLhq/FIeCSJnaDQzrOjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDqd9PhXVEzre+KMdx6WmgAtMne02eCaNEpn6ob96vMaGttqcg/+o11Ww1iyqRzr5
         WWLQP2ZKJhF1yEsJWv/wlS/isj4W4MGCkMO7RrmZU35+Lu9qRy3raHMqnROVUejpdL
         hruog23VLibhstXaB23OMn/+axX6LENLYNm6vOPbD65A6fAmdOnxMzWZ+zE2Ct4vjp
         78ELXv9Kqspnm8z7J/t4Cj18CELCtXMdzYHwxou5jEdqcscBQUMT1KnsUZ4+qMFG8D
         LXyQ3deU6rcavbyy4IBHWOy5lWLRVaxMAoEBtEbseYe5UC9WLYaNd1JMqFsMQtBdXA
         qLW7kRyZMKp2Q==
Date:   Tue, 30 Mar 2021 18:04:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: davinci: Simplify using devm_clk_get_prepared()
Message-ID: <20210330170454.GG4976@sirena.org.uk>
References: <20210301135053.1462168-1-u.kleine-koenig@pengutronix.de>
 <20210324201723.76299-1-u.kleine-koenig@pengutronix.de>
 <20210324202258.bossedmrhj35nyvc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
Content-Disposition: inline
In-Reply-To: <20210324202258.bossedmrhj35nyvc@pengutronix.de>
X-Cookie: Memory fault - where am I?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 24, 2021 at 09:22:58PM +0100, Uwe Kleine-K=F6nig wrote:

> oops, I got that wrong, this must be devm_clk_get_enabled, not
> devm_clk_get_prepared. So if the clk patches go in, please let me resend
> a fixed patch (or adapt yourself, whatever you prefer).

I'll look out for your resubmission.

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBjWjYACgkQJNaLcl1U
h9D4Hgf/RTdD38g2NTIIgbFmtGwZrK5fZoqoOpcEtMp8N9gT0XdUzIRq4LUCTFxI
WIjEcpFXmqpYn/8JPFTk9gJQjQO316EX5iHhC7IYtAfRMZYCyK+99x4xQajWuQA0
rkhohjJe7dMtQ6p7eBz2O/TtK06xEw+28Lv5o3TgHT4Ln8I0CRdnWHsOEAs7lxfS
PsaffrUYZH4zGzJ9w2ncfegn/i5UddL1BWfiy0l274OXwXM90BG0jz7SBn9joBlQ
pRrMr+svxdeS1ceyrOgz/1VNiAidKuu3TYvGHQ55mX7hqc0hW5gVU+eINXbEL9vh
O71UWm6a81FaKqt/F/HslTMOiOs89Q==
=OQMo
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
