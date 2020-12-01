Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7882CA966
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 18:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgLARSh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 12:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgLARSg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Dec 2020 12:18:36 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E61E206E0;
        Tue,  1 Dec 2020 17:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606843076;
        bh=vUkiFQoX0qUZWqEs1DFnikAC99TYHcD6oGjwLUyqkKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKP0sp/TPAiwmyrrUJ6HNR3lkG80YJBypFKjN+TqboBJgKZkrlgTjOY+L1KVo8K47
         7fKLpSZfyL7dJZ35MIuNVRVwRJcS+HmwPrbPjDerb0mg50a68fOX2PwCVTdz9R7o0E
         kEkJBou5D7wBL98nDHjN6YMhojhMMZHBG3DboeDs=
Date:   Tue, 1 Dec 2020 17:17:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH for-5.10] spi: npcm-fiu: Don't leak SPI master in probe
 error path
Message-ID: <20201201171726.GN5239@sirena.org.uk>
References: <73adc6ba84a4f968f2e1499a776e5c928fbdde56.1605512876.git.lukas@wunner.de>
 <a420c23a363a3bc9aa684c6e790c32a8af106d17.1605512876.git.lukas@wunner.de>
 <160683107676.35139.5898255579541696458.b4-ty@kernel.org>
 <20201201143027.GA23044@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uMPAU7A2Er6+wvsD"
Content-Disposition: inline
In-Reply-To: <20201201143027.GA23044@wunner.de>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--uMPAU7A2Er6+wvsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2020 at 03:30:27PM +0100, Lukas Wunner wrote:
> On Tue, Dec 01, 2020 at 01:57:56PM +0000, Mark Brown wrote:

> > [1/1] spi: npcm-fiu: Don't leak SPI master in probe error path
> >       (no commit info)

> This patch is already in Linus' tree.
> (You applied it to spi.git on Nov 17.)

Yes, b4 had a bug which caused it to generate notification e-mails
for things it didn't find in git (as you can see from the "no commit
info" bit).  BTW it would be really helpful if you could resend this
stuff in some more normal fashion (either independently or as a numbered
thread), it's really breaking my workflow.

--uMPAU7A2Er6+wvsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/GeqYACgkQJNaLcl1U
h9DjVwf/WXtImo9xeZWrsJe/Wo/IkiQ1nktBjDmf0UxeVx6rslZJxjTRQx//Nhee
xaV3c31M+D8D0jZ50eRKu/qyXQC0iBYFm96jonqu7+n7771quosofnuDMbAW6mcz
7mN8h3vKo70w+B092Ueffo/87c5Muhj/azw4uczGoB+bUU81Zaq5B64RHDsmWGdT
hP2XpN+CsuSvu8lLeH8Gu3e8qzRLS+NuLe7crlP9/I2wDIP2dkdXfSoOwTs+oJMh
mU10xPdSCF0V9gXPcvCijKcpjUJWINR4N9bBtPOS7yDopo2aPtzixh4O89Iidojg
+WiZTOdlberY9pvMyeW+OjAFqIX5XQ==
=/bzV
-----END PGP SIGNATURE-----

--uMPAU7A2Er6+wvsD--
