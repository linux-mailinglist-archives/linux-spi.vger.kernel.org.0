Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B5E2CD0BE
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 09:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgLCIDv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 03:03:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgLCIDv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 3 Dec 2020 03:03:51 -0500
Date:   Thu, 3 Dec 2020 08:02:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606982590;
        bh=3WNTeY4jXrQb/zwGcpPko0lS4saBdyJwWL+052R9QOY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEwo2wDaiWy1mWXQlH/jLj+TSFEXeYaexFq7JPUPexGbTD8ZFcD3QKpyLPnSJf8yI
         y8PEegg3NvchptSE8npvhoYR7/TvL2cyuVc++Vkw/OhrB9PZLVTXOSS1vUVM/jtCOC
         Jo2eT+yHPFDBxGHJtgq0vbM4I1NzWj7oBJN10VENUi5UJUo909teEfrpR3+ybRrEWZ
         VjnzV2/Ub4WP1Iuaguo759y5B9975bmbpY3CDuRGixABOAxbz1vszBYTCBg8IvVzBW
         oa3uUM9DgWqzjXGVE94qXlXnR5IxZKtiggeEzaEtXa67wMti+vGEMYhwCEWJKY5VDH
         7Jd3Yy38EzI9w==
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Maxim Kochetkov <fido_max@inbox.ru>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-dspi: Use max_native_cs instead of
 num_chipselect to set SPI_MCR
Message-ID: <20201203080240.GA4700@sirena.org.uk>
References: <20201201085916.63543-1-fido_max@inbox.ru>
 <160683107678.35139.1439064414776102118.b4-ty@kernel.org>
 <e19002f8-a8a8-6201-6680-ef0b586c6367@inbox.ru>
 <20201202142220.GE5560@sirena.org.uk>
 <20201202235534.ksbpj6wfp7vkkwm2@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20201202235534.ksbpj6wfp7vkkwm2@skbuf>
X-Cookie: Sacred cows make great hamburgers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 03, 2020 at 01:55:34AM +0200, Vladimir Oltean wrote:
> On Wed, Dec 02, 2020 at 02:22:20PM +0000, Mark Brown wrote:

> > If the patch isn't actually applied then yes.

> Do you frequently send out emails that you've applied a patch and then
> not apply it?

There was an issue the other day where b4 had a bug which caused it to
send out mails for everything it had in its database, including things
I'd downloaded to test but not applied for whatever reason.

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/Im58ACgkQJNaLcl1U
h9DdBAf/Sg7ClD4AUrPDo4819Z0oEpBqfxr8doNZK0ApaZH7GQ+z7U4SsVWXfX9K
uxAsfjHxeVHxR+1XrRXZxXH3zrAGjrr8O8LrPDjDPGmjTdF/xliwCnTuvXuOi+RI
buKmy6MMhZqqSHW7OSNdKbeiF8w2VljYiH1Ru9SI7LeiO/+6oIwRRKRGn4vX+SbD
ven8DqwaSnpgG8MpckmL9osM0Xq8zUNpDHzARb0T6KfTsZvUxkSFnzJzrG6ccbX0
+5G+5WfIHlkxKR41pGgm3in/5l0SruIG59eRq+vIn5JZ3aWKPbojvRYNFbaau869
uJ7+5tNehqvPSXcE8R9TehXPtMfm3g==
=pl6Q
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
