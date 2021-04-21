Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383AB366EB7
	for <lists+linux-spi@lfdr.de>; Wed, 21 Apr 2021 17:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243769AbhDUPGL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Apr 2021 11:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243121AbhDUPGK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Apr 2021 11:06:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E61FB6144D;
        Wed, 21 Apr 2021 15:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619017537;
        bh=nfD4SW2pUDpqbkiRD2gBMWPIOHPXr915NNTI0fU3FB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMe1oWvbaNQXPNMnRswTPL9c4Q5r5c9WqA6dTL7xczH6iTditPo0VP2ln/xiCzlvY
         Bhu4RTFI5xQY8Wcdj2leqiNkfnCakGQbzn59F5/E4idO1bpFWONlZN4dgHM7rs5kmT
         PyHTue3M2b1Bh49IP4LcZQdfkuwrBW741EZsmUzuwAnJi7VWtpllpkdiEMrKIYGHj3
         S7ozaYL6amLmvnZF155TdA4fQPj3bwWNSuGTvmhnspcmrv94eafvKbu7ew9EcY7FPg
         232NoPiZql6lFrMpzneeyITYJBO2o/cjbdjpWuhgQJtn+YWpvVHTK0T+m1uh+2q96x
         nKwsA1NW67Sgg==
Date:   Wed, 21 Apr 2021 16:05:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: stm32-qspi: fix debug format string
Message-ID: <20210421150510.GA36785@sirena.org.uk>
References: <20210421140653.3964725-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20210421140653.3964725-1-arnd@kernel.org>
X-Cookie: Tell me what to think!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 21, 2021 at 04:06:48PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Printing size_t needs a special %zd format modifier to avoid a
> warning like:

This doesn't apply against current code, please check and resend.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCAPyUACgkQJNaLcl1U
h9Coogf/R7NTfXnqSMK+6GxbfAfEwF48TROZhMO5m95NKkXRByuOSq/2QIWrEVP7
FdOwLifiRbZ/re3cDx36ZFesHYsfeAea56rPkL/q8ntwu5a10A/GNYSEym+A0H0h
+IenL6VFoWm6yCL/rFAb02kpbz9NFx0WpTT/SK2heCKHb8CH/eIYtXmzALicrBvj
MCwhCuMVtpm9dBU3IR0jU7M9S0vtqZMNXyB4mNoqKkC9hFLA7vdqmK4m3Oaui0Yi
e5N7Q/rB+N6+iPIzjOJJL57h/9s2/4rinmBOJXcVg6jSn/MsZSdBHssSSz/tTKpV
3zg4lAvtiX7hiVXjElq77+SxD7/dgA==
=8/No
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
