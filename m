Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273F5311603
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 23:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhBEWr7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 17:47:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhBENbO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Feb 2021 08:31:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C37164F6C;
        Fri,  5 Feb 2021 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612531832;
        bh=8/S6dC/Cyik2IWPqPhmn7AbHJFdhxexop0d79CYhEaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZDo8YhqUJAJClF4NCrCvU51d0X/24FNmGuc0WrS7hydeqAjgKGxWXl9Q7DDS+azbK
         h7jMc1pTK0KpZMBFmCqkALv4BP3/Ecj5DZcuFDbqSTuKtxKMJWNGyIbzVn0SkQigD8
         gp9T1MyYldNhUKKOBseQ98FqH4SjtWD3WrI+djoINV/+FQeKBVXL/BeQoi2mEWDGXL
         jBvN7GQQaI1D4Gwm8xOIYoBJg379wlh+R78xtQZa53ceASYjbpc1bnSJBzHwNEbv43
         OwGAh1/ZTYcMWaYXqPGG2mUXDQZHnzkWWgDzKjxzJxyYt53lCpp+x0axXfe2HRxfCY
         j56FQMdzg+Qyg==
Date:   Fri, 5 Feb 2021 13:29:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     amelie.delaunay@foss.st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@foss.st.com
Subject: Re: [PATCH 1/8] spi: stm32: properly handle 0 byte transfer
Message-ID: <20210205132942.GA4720@sirena.org.uk>
References: <1612523342-10466-1-git-send-email-alain.volmat@foss.st.com>
 <1612523342-10466-2-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <1612523342-10466-2-git-send-email-alain.volmat@foss.st.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 05, 2021 at 12:08:55PM +0100, Alain Volmat wrote:
> On 0 byte transfer request, return straight from the
> xfer function after finalizing the transfer.

> +	if (transfer->len == 0) {
> +		spi_finalize_current_transfer(master);
> +		return 0;

The driver only needs to finalize the transfer if it returned a value
greater than 0, returning 0 indicates that the transfer is already done.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAdSEUACgkQJNaLcl1U
h9DG6gf+Pkz5r4YOP6ld6ZsZdM/LuqTjO92jsCER31Xl2O8S1A2Tgfj1La0v40tE
2GBWz1gdoIam2hxKE3HYTIqB/952V5ETUMekujRNnFQq4mRn1oxaaD8z85LWqAxB
OUDkBLLVch560M5MUfZxYMydbd+DbZrbR4K1XE/oTB+Sn79XNQtKrClK6ytHjnbW
XDtHWh+zlm12jj5qm160n0takkQaEYkAdYxE8C5imuRhk+OXsgrqoYOLTehde0hp
nBkaLiBVsup7XbOMmbpkH1hEKk9GEwmn46Q3S9TnkUYblsdAaGYGRtA/m0XEy2nA
QFJBlfHf6+dAAXVb4YaWxPp/Q8S5QA==
=ad7+
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
