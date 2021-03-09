Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C45D332590
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 13:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhCIMh0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 07:37:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230140AbhCIMhM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Mar 2021 07:37:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A627165272;
        Tue,  9 Mar 2021 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615293432;
        bh=mruvFKZBvCYrEJiGtVUC6A1pI2TNU9dGDRBfJmF933E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YA95Mav+ou0vbpC5EDZqdK4j8osZOAeEFLNJvirHsPEiblzGYGamJPf+AwUWyyPzt
         vZfzspanjCKktSOAsyVpm0FYuJGSpLXZ0Pe0RqBPyb2lG1Vadn3okPwLMhynotcjau
         WL5Gf8gF3Qk2SJ9qUTv+tEL1oc95BRoonZXgpxSz//bRdIXt/nyBplUW783pihE+tv
         jEvy0xpolH0gBcLh3eel/zNThxH+ZnR3cdnO+R2au2i4d/VB1lGDfr1FyXasCZeIm4
         DqvUqmzDr+vuw3SXHA4A+uwIQo+kTOxBttz8TlYrxOOFTnZHJ2QZI9GxPBanNDp2Q1
         Oe8IoVLo/1FVg==
Date:   Tue, 9 Mar 2021 12:36:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: Re: [PATCH] dt-bindings: spi: Convert NXP flexspi to json schema
Message-ID: <20210309123601.GA4878@sirena.org.uk>
References: <20210309103528.3538910-1-kuldeep.singh@nxp.com>
 <DB6PR0402MB275834FAF7CEF44AB7F342B2E0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB275834FAF7CEF44AB7F342B2E0929@DB6PR0402MB2758.eurprd04.prod.outlook.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 09, 2021 at 11:41:50AM +0000, Kuldeep Singh wrote:
> + Mark (Forgot to add him previously)

...

> I was not sure with which tree this patch will go through.
> Currently, I have rebased this on top of tree(git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git, branch: for-next)

Binding patches generally go through the subsystem tree so please send
the patch to me.

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBHa7AACgkQJNaLcl1U
h9AmRQf+I75/5nY3XFdUzjldnH/ak4vuJJDxyK5n1OjfodnIYXZRnofrZrv+1WNC
OWmuqB7SvWXFd6zus811PcggxS29YXXF0Xei0Yze8ST7tYegZ0t49klXg1gzSxmt
IBjy0EBAJfOY2s5rH4FWoeW2x/ttRBNRfu4rZQKNr/QblPAe3N7CNdhZhPcXQ3c7
vGWcgpmJUg5q0whA8tPOx85Wp5mAmJLTMQxtfN/7VAnmvzz7qFZXyZVx8PDsMGnt
9w3psbRDKP7kEp8tAJcZAYWXUzbHarpquIAXyj644yJf41LPF2D52vQhga8joIv9
C/SazhUd5xl+BnXII94ixbDq7WnnbQ==
=8uCH
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
