Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA741ABF74
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 13:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633739AbgDPLf5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 07:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633830AbgDPLfm (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Apr 2020 07:35:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E68E3221F9;
        Thu, 16 Apr 2020 11:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587036942;
        bh=1O074pBLqyTFD9k7wtMxYMKMEH2M6e1rlcL3gx4htII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wn0R9ybvpPtD+hJriLIIlK2HrDvwNZuYowM5oNOUaynHQWDpXcxjDvP8fjH0TYhHf
         ovqudIrkqGhQ93oRANM7b/OCeIHaVKFU/rkk6VHh0vWhrvkHhlHYUxg9JECoPNAYPn
         mzxHdrf9LEXOcIfgn/3yhViyun/b8AdzCdUYCF6w=
Date:   Thu, 16 Apr 2020 12:35:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clement Leger <cleger@kalray.eu>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: dw: remove cs_control and poll_mode members
 from chip_data
Message-ID: <20200416113539.GG5354@sirena.org.uk>
References: <20200416110823.22565-1-cleger@kalray.eu>
 <20200416110916.22633-1-cleger@kalray.eu>
 <20200416110916.22633-2-cleger@kalray.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline
In-Reply-To: <20200416110916.22633-2-cleger@kalray.eu>
X-Cookie: Tempt me with a spoon!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 16, 2020 at 01:09:16PM +0200, Clement Leger wrote:
> Since these members were initialized only with previous dw_spi_chip
> struct members and that there is no user anymore, remove them. Along
> this removal, remove code path which were using these members.

This means that your first patch will break the build, to keep things
bisectable please do some combination of moving this before the first
patch and squashing it into the first patch.

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6YQwsACgkQJNaLcl1U
h9A6uwf/TM+SknyZfv4czhh1vQN+MJ1nQdZrChLiBIqdfo9aNkryncc2MEnUL/J2
gjKN5DMzNaAuiMeZMQVlOLeCEwm0tkUP/1KFWTV2V+pPWrCSTZHYe7fgfk/XSg1X
Xq9R29E1/XCPnlfI6T2KjATZICins0nQrJnFDGM9xQCNsqJfMvw04dE8ZtQUE6Xr
fLuupPyBnn+kGSYQjbk6KJmDq8JK1hP46EZUDWCqjYL98GMsI0Y/Hmvg16MdI8iN
UZ7L6hNdu++XhmS2Yy4Szc/0dQ7chorIYGczEkLPp+p9raGTcHkAErlGBxumYNNP
llJoGFPjjjn43eEoaSxIyeE0yPlW6Q==
=4w+e
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
