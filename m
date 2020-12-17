Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF7A2DD218
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 14:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgLQNZ5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 08:25:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgLQNZ5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Dec 2020 08:25:57 -0500
Date:   Thu, 17 Dec 2020 13:25:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608211516;
        bh=2BHOLfyP5LiOUzsGqn1+c3ME/USjr95Zwlnxezf0yF0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=U33sfdR49eAYe/BvQBNAdks32r9DG+Aq5lrEduhCr5+XKzb+MlHSelMVl1Jq20dGY
         eR/bMmJf/NNBNhyJ3l+fMgDGneeWJL8koAejipEtW27p/LM2TltjyX3bWanspchtnf
         yqiUuOIJbTSQPSRqzORf2oXl7RaF0zs64qSVbsC8NKjj/XHoZuxEQTRgcPjdZz4aan
         M3i/5sCI52TVF1iUFxYtBAeaLlGPiPpwBfzBrUW2Tt8BP4cDv3pk4czuVIS4dI8yHv
         nAX8omH12a3PvwsnTy08mAudzHMsdn0mwwUz6QOK0Hlp+OYJlkvTa8rbwdtjFbIKsA
         7TWUyWn/uPpkA==
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        msavaliy@qti.qualcomm.com, akashast@codeaurora.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 3/4] spi: spi-geni-qcom: Don't try to set CS if an
 xfer is pending
Message-ID: <20201217132503.GC4708@sirena.org.uk>
References: <20201216144114.v2.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
 <20201216144114.v2.3.I07afdedcc49655c5d26880f8df9170aac5792378@changeid>
 <160817911850.1580929.16402785505110078436@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <160817911850.1580929.16402785505110078436@swboyd.mtv.corp.google.com>
X-Cookie: I'll eat ANYTHING that's BRIGHT BLUE!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2020 at 08:25:18PM -0800, Stephen Boyd wrote:

> >         spin_lock_irq(&mas->lock);
> > +       if (mas->cur_xfer) {
>=20
> How is it possible that cs change happens when cur_xfer is non-NULL?

We will set the initial chip select state during controller setup.

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/bXC4ACgkQJNaLcl1U
h9BXbQf9GaJeTaO0e+0+/C2K9+1Y12kX+iDWcxv7W9slPCtYipRnE+z6xs34/s+u
qjbTJ4CAWGRLCbSkLeVQOjKzYh4tR939DRAeqDZ2ah4avupleKDrB5BFdDA5GLDw
Sp4QX+gLDybnHmNOLWn9JrXYtRTpsjNIngHCS73WClVrzlpUQaocz4KHJRQnxsdM
uzzgdy4cAzcr7FDXAMSIY4cZV9u1fi4eeH8ULdY8oqCFqToERfrLcjtfFj3+Df7L
f9ZnTmPhWdu82x43cIuC7J1r4vvLR8lZBIpJNoLXcPx0SvznAonQU+wDhyIc0irn
AbxfHR4jpONu8R+PncW2hwJJlNDgHg==
=CKmO
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
