Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE6A303263
	for <lists+linux-spi@lfdr.de>; Tue, 26 Jan 2021 04:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbhAYNEQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Jan 2021 08:04:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbhAYNEE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 Jan 2021 08:04:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2270122525;
        Mon, 25 Jan 2021 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611579803;
        bh=uFf5gx7Zdz1puW9C8td0+AgyP27di2Lipd6E/uIVRTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9UPGDsdpRQdi6KUpICA5lyhneCmtK/JJbLSWC0hKKN/YE4cgj/hGCMuUyIpqq80O
         ohRg+SOZMlX9n30Xz0xsygNVlnlcX4olxF5AcTD5iNQbycYYcdYCR/byWFn4gbf6Va
         KTxsDpY0p2gFoMMkxLagCHjknxUiXg4L44HyUT7CQgag+rgn/bDUUTS2pOrN806CWL
         GZvBPi1iVizdxDZX5RYeFvnk+BsW+me5KINnynvYdNKMKa3xMlMe79QU4VaPCcL3Ve
         Wo5C9awTjjfEUeoQUW+xxlisxXk2F6rjRn6IAfZfvMkkDz3+Rcp1WobICFK39MC57+
         fT1VAOGkBGONg==
Date:   Mon, 25 Jan 2021 13:02:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     corentin noel <corentin.noel56@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-au1550: pr_err instead of printk
Message-ID: <20210125130241.GA12316@sirena.org.uk>
References: <20210123030344.15999-1-corentin.noel56@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20210123030344.15999-1-corentin.noel56@gmail.com>
X-Cookie: byob, v:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 23, 2021 at 04:03:44AM +0100, corentin noel wrote:
> Signed-off-by: corentin noel <corentin.noel56@gmail.com>

This doesn't apply against current code, please check and resend.  It
should apply against my tree which already has your previous patches
including the one which=20

>  		if (!ddma_memid)
> -			printk(KERN_ERR "au1550-spi: cannot add memory"
> -					"dbdma device\n");
> +			pr_err("au1550-spi: cannot add memory dbdma device\n");

merged this onto a single line.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAOwXEACgkQJNaLcl1U
h9CJiggAhRlEWiOOBrU34fOLxbYlZsTPMLAfBcPSDJ79XNeZurmkj0+2cceEmvbd
603O1RA9/sqivsxJir5VtPNk3q2iHhVhy0L2WE6UQbqwGPn2JO3z7SE+4wt1GhLT
z/qO2KyfNqm3iIQ54laI69oyrF6QbxfIucl+cIw3ALuOA25D1W54/AV8GBDIqfl4
hQLGLsw0ehFWvVq2WdNwEY594AESU9X4Pfe1mBaRnnzn6lVh3Jom9B9N5ICJHqLp
03bxc7XOQ8vobDmzrm926I1uKUM+zUeVCecr7DGV+1stjVQFXnkHiHVbFck+862z
YIpu9u7TgZpKEWDag6Ae4sSHgTvzrg==
=qaqC
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
