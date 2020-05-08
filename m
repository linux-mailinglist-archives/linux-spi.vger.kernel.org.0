Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768761CB660
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 19:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgEHRxx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 13:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgEHRxx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 13:53:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80D0B21582;
        Fri,  8 May 2020 17:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588960433;
        bh=Mf9YIX9seHuKR93Yab643q2cVaLURMwAj0uaQu5emzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CqhCorGrx/A0ACnX3azbJyBTQTTLcHR/kWY2TMS/7VhSQrNeqX6fBeX4sNp5VVSvQ
         +r/a8EYWpL1nWHMqs4rAcTSgdomr3amYNmt8m71wJ9kB6LO6HHli9Xb1CQO4Q8v86t
         l2L0K4aBBZxrid8H+NeOjv0fw01waBKqJ6gvKiVw=
Date:   Fri, 8 May 2020 18:53:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] spi: spi-amd: Remove spi_master_put in
 amd_spi_remove()
Message-ID: <20200508175350.GA3011@sirena.org.uk>
References: <20200507115550.139457-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20200507115550.139457-1-weiyongjun1@huawei.com>
X-Cookie: I just had a NOSE JOB!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2020 at 11:55:50AM +0000, Wei Yongjun wrote:
> The call to spi_master_put() in amd_spi_remove() is redundant and
> may causes user after free since the master have been freed by
> spi_unregister_master(), so remove it.

This doesn't apply against current code, please check and resend (there
were quite a few issues that got fixed).

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61nK0ACgkQJNaLcl1U
h9APGQgAg5Mu75hZSXDbUWOiVnemr3EA0Rq6XsrwDrZd7UUq9wXkFGqfk70MEeWj
gqcdLS68iTMFeIQ1ph1516b7cuYmMZBGU/lH22bOyYoveTpKto6QNsz3KX6G+2dC
BktSNvldIjJ2VKFtZWziAYv3QDbDCgTSskrUf+u/qNfm/oo114RO1cYbCsr6CLFZ
c0JRUNdM0MIMcjrkKz8lb81jO+bs9t1aizdgbbZvteHVF6bV6mGtLHDvxfXRu/QT
tOQMKjIUj4H3R45mDIfIevFcMEAoo9wB7ZDUkUuNoDiR7h7++ETjUTbWnEojOx+Q
FjR+eFGJMYLBh3m4QAbTssVZC72xjA==
=MHHd
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
