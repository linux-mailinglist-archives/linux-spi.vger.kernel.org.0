Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A34201233
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 17:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392373AbgFSPt4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 11:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393352AbgFSPY4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Jun 2020 11:24:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71F8921548;
        Fri, 19 Jun 2020 15:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580296;
        bh=6pPLNDKrv87+k5VZCfUwfgvITyVDXp59nu5bggC7DSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0LXG7tjc3yMZvuWQC1p1ELsD27zR8uIFDp4g/nc0CmHbJIVDA7/ZqbtQ81NsMOiy
         khHUDLUAFgqnABslRmG9tOL5GZNWXeiz1PayM28TYYaro2T5asGiYUmSvoNNGRFpSC
         HpHSx7C2x0V2ki9zUkruCChYxiQ1l4eUP+VutIpI=
Date:   Fri, 19 Jun 2020 16:24:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 7/5] spi: spi-geni-qcom: Don't set {tx,rx}_rem_bytes
 unnecessarily
Message-ID: <20200619152453.GA14534@sirena.org.uk>
References: <20200618150626.237027-1-dianders@chromium.org>
 <20200618233959.160032-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20200618233959.160032-2-swboyd@chromium.org>
X-Cookie: Haste makes waste.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2020 at 04:39:59PM -0700, Stephen Boyd wrote:
> We only need to test for these counters being non-zero when we see the
> end of a transfer. If we're doing a CS change then they will already be
> zero.  This implies that we don't need to set these to 0 if we're

This doesn't apply against current code, please check and resend.

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7s2MUACgkQJNaLcl1U
h9COLwf/UgIzQy5TqFeLGYEW3Dxe5xoNJ2xLB4Aqxg24VEFRSXijOkY6yl3pbGuM
6vN+VuJzSHBXfR9d+fVvd4khHUCqUnk/O0+FDLhIdiTrIGVEA9AdNo+Uu+0CIEmg
EG19GZ/YRTyl1XeFjSkuUCIgJJZGXQu+K7MeKOTh0PK3Q2qg4HW3/vWUke/NL/Nh
RDgeUu1Vdk/xHnsijd9uFwF5XsZKOIuSr1cuRpcDU8Jju/L9Hrx7tw7XeLg+Cs6v
rPj8mQXY/n7OOnHefMyF8DeD17tjSc5kHKcsTWUxOWz++QWSg1r8HlJfml+BRQnz
VXP96l1zd8xqQuOPiyUu484kzwz4fw==
=2CLH
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
