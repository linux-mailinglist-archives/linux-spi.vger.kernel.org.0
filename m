Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153623D3B6B
	for <lists+linux-spi@lfdr.de>; Fri, 23 Jul 2021 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhGWNLe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Jul 2021 09:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233552AbhGWNLe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 23 Jul 2021 09:11:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 535F260EE2;
        Fri, 23 Jul 2021 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627048327;
        bh=jFk+0LMES7S6Ja8o2wsbPLKGH7j8TpUeerYAYihrE5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAgesXjxnCrHQFC63+0zu1QAnLMUb/krMXzvhoUXFpw/hG/JnsJBmsrsYBv15zVWw
         lDw+h+lom1f7KghsRfKm1UaoKqdoDOzwtMQypaJO+wfyrt62D+4kFST1838j47HWZx
         qOITCI0JMt9qS35PfGfGKGQbs2lBYRHjzC5W5Rdc23BJmLBub8UXazhRhUCQrsXkuF
         MPsNW10Xvax40ERdt4FFhEeeubP+z3DlE3d+7dEYnll8ftGeI5qVRj0X64d5soll5u
         euA+ofLq32pIPgsslGmcK7NRJUP28V+rvZX/Gs7E6CUk8Fq3ZWo0IfXflyC5xNLHFN
         iGnih1/AzMueQ==
Date:   Fri, 23 Jul 2021 14:52:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-arm-kernel@lists.infradead.org,
        Leilk Liu <leilk.liu@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Hess <peter.hess@ph-home.de>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: mediatek: fix fifo rx mode
Message-ID: <20210723135201.GC5221@sirena.org.uk>
References: <20210706121609.680534-1-linux@fw-web.de>
 <162608669457.4543.2374973099687363958.b4-ty@kernel.org>
 <363C87CD-F0C6-4A46-877C-86E07D14787D@public-files.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
In-Reply-To: <363C87CD-F0C6-4A46-877C-86E07D14787D@public-files.de>
X-Cookie: Integrity has no need for rules.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 23, 2021 at 03:46:02PM +0200, Frank Wunderlich wrote:

> Can we add stable-tag i've missed to fix older kernel versions or
> inform greg to add patch to at least 5.4/5.10?

Let the stable people know once it's in mainline (IIRC it is already) -
there's a good chance they'll pick it up anyway based on the commit log.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD6yYAACgkQJNaLcl1U
h9BS2wf9EAlL6oZ0DzmB1nfQW4jRM0cEjg0EP36GEgjC8qJ2a8SfLfNK5I4foIKf
NHqPAvnsWm1hNqFqT717/B3qkrIGD2xhp6RAkzb94IKJID4WA5KCazzjUr/AYHz5
rv2aaM/2qwq0F0vZAPP5d9Q7UqYmqceX9D9T/PBmVSwq6uyhd1lWngh+QR70HYB1
n6XFqMkkujk/fXP5iWD9OUbI6EKaC4tclkJ/W8k/UvsffcKXM6NUzukrf4Mhl+uu
kTYYkuwsNymyAySnUmze07H0P4aLCYefYMtIpXW2fp7GkioLH0smBUL7GKLV43Eo
VSKbXqA+zjeKCooVhDXA+wlFBzOrCA==
=oWDi
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
