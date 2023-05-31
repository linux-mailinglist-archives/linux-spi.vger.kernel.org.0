Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BE4717DF0
	for <lists+linux-spi@lfdr.de>; Wed, 31 May 2023 13:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjEaLYi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 May 2023 07:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEaLYi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 31 May 2023 07:24:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF93D9
        for <linux-spi@vger.kernel.org>; Wed, 31 May 2023 04:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF24162F8F
        for <linux-spi@vger.kernel.org>; Wed, 31 May 2023 11:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481BDC433EF;
        Wed, 31 May 2023 11:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685532276;
        bh=XBCpoBDVBfkS10vvP300z3rXcXrvJjeLSpM/nAC3P9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pDUEWxB5IFDX1T2wzmMEgcGRuVF0yRdUtWeOHCXnFjcdcbSCH0gLrp3lOifQpWkLI
         IKGHAXfAmjg1u+m0UZ+dEYhpj5t9G7cGpsQhKI8xdlNqF6PbFj7d8TwNeivuhKIDIZ
         yUjFIylnhPbsxQYwIr3CHnH41wYHOMvoYd36ytRxyoFgBBL9FWpdjJQx9mgVmIwwhk
         /xv+nAR+L5ychtqFgcIMRr9cds11wSt20JyTaPyRLwjUnYygkUc2S6eXYfIs1h7kVS
         JJCG+whujzk/hhV0G+QKP/use8V9CHZCtQ5eV9sDIlnutF8JyCclaKd8SFZteLQh99
         1sobn2x2MrB8w==
Date:   Wed, 31 May 2023 12:24:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-spi@vger.kernel.org, fancer.lancer@gmail.com,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Jude Onyenegecha <jude.onyenegecha@codethink.co.uk>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: Re: [PATCH] spi: dw: announce driver probe
Message-ID: <da679474-5fd1-4fbc-8e22-7fe0a153ee0b@sirena.org.uk>
References: <20230531110339.321387-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Sia31dGu99zrCUkC"
Content-Disposition: inline
In-Reply-To: <20230531110339.321387-1-ben.dooks@codethink.co.uk>
X-Cookie: Will Rogers never met you.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Sia31dGu99zrCUkC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 31, 2023 at 12:03:39PM +0100, Ben Dooks wrote:

> It is useful to know the driver probed, so print some basic
> info when it does, such as the spi bus name, irq, etc.

No, we don't want every driver spamming the logs at probe - apart from
anything else this slows down boot.  There's already some standard
logging from the driver core that can be turned on if needed for debug
purposes.  If there's things being enumerated from the hardware it can
be useful to record those but that's chip revisions and so on rather
than things like interrupt numbers.

--Sia31dGu99zrCUkC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR3Lm4ACgkQJNaLcl1U
h9Ax6Qf+P2H7Jk+lDc8c7KDm4KE30bQ9IOZsY/9kQYrBK/F35KsKW4tiPqUGx6Cu
Wc0XwiGMfjLIb5+z79OpxJAU9Vi9X1BYNa100cuLb5IkGglc8ISpFzZa4brtoI3y
cHZ+xLFnaOau/3ZbRNe3c7Y+6qhTjeNwD4v3dyxDcpmE5qJ6gu+pKTYaPOB9P8L1
zO6F+cmMiPX1STNGhyaR1OsDDtd1mztG9UYzEXfhAdywrzXFL31bBCvG/BaFrR9z
fLufSCsEQYd+RsGfIz//H3rLkYo+94TNmj2z7xh3ycKqdi1EdQulN15bJ166DtWe
rsZCssnt8BAQ3y8DqCiZiOu0wAkvJg==
=x0yL
-----END PGP SIGNATURE-----

--Sia31dGu99zrCUkC--
