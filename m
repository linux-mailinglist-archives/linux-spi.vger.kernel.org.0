Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA9A1F989C
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 15:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgFONbx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 09:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729875AbgFONbx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 09:31:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A741E2071A;
        Mon, 15 Jun 2020 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592227913;
        bh=DNx2FOJBhMQcsxpwss5JX13KZQpzmknMo4MZDCRvaTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kWg1QPUT203sfVo4cN0dkBf3ax/CI8eZwCZTRDjv+wBMzPFsXVK/qN+vc/jXfeuxV
         soK+NrRQU6lXqwR+TMgW9IGnmXFT8GRM7tSbRgBZMHbWxq/LN2GPgL77E1OKGmLG2m
         kGqrWXANrPxWp+T2/JYhHIl9CgrcdSX/qqFFzzQ8=
Date:   Mon, 15 Jun 2020 14:31:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     kdasu.kdev@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 3/5] spi: bcm-qspi: Do not split transfers into small
 chunks
Message-ID: <20200615133150.GT4447@sirena.org.uk>
References: <20200615040557.2011-1-mark.tomlinson@alliedtelesis.co.nz>
 <20200615040557.2011-4-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TJ9V72hR/LoebVea"
Content-Disposition: inline
In-Reply-To: <20200615040557.2011-4-mark.tomlinson@alliedtelesis.co.nz>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--TJ9V72hR/LoebVea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2020 at 04:05:55PM +1200, Mark Tomlinson wrote:
> Instead of splitting transfers into smaller parts, just perform the
> operation that the higher level asked for.

I don't understand this change - presumably there was some reason for
splitting the transfers into smaller chunks (issues keeping up with
FIFOs or something)?  How is whatever that reason is handled?

--TJ9V72hR/LoebVea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7neEUACgkQJNaLcl1U
h9DAPwf/f7MYucU1Yu2itPj+OWXklfxkXLzGLvoujwfjGfJolzFqbslCSlcHKkUH
vNVdnlwNWIEufuxlgQevTuaE20sZKDKhS2eS9aaieODpt0bknbj/La/q3otQiNW7
5MdSPhOO0N+Gq2W3zX1e+biaTuS4KOEVDla6QOfrJ0VuUgKOxDP9Jdp96oOKypt5
rA5RamnnjaUM4i2i2VUBqOzIBWQdASrSaTOMA1o640swXH+1gqAlcjJrV40Ijczr
5C3s4txzOWJ7kCsdy9knZWkW/KEnMY3lj/c73A8LhkDzdtiozC2QScWoHIz0vvxT
yoNf/pBUq9d3jRcpqbP6KTf+NzijWA==
=ikNT
-----END PGP SIGNATURE-----

--TJ9V72hR/LoebVea--
