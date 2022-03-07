Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0B24D0647
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 19:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244718AbiCGSVA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 13:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244714AbiCGSVA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 13:21:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7458D80919;
        Mon,  7 Mar 2022 10:20:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E161161328;
        Mon,  7 Mar 2022 18:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CC6C340E9;
        Mon,  7 Mar 2022 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646677204;
        bh=lc0UDq2jPXzv3xYuSUsZLe98+AhVycoZa43HbMrnwrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5GQvTj6tbi/1bnUO7KdaQl6lN29AALHS1yZFBdKFYowTuNOWFnbHmf6Q8+z3bXEd
         4XjOUhJlnga5stGZYDrqXCUCpUwxLMJp9PBtsyVy2mS1lF3OQ2eU3IIbJnPPhdj4ja
         o4bpaSPbyFT0Zkq1geE61Ccu+e2nXhGuQKVispPiRm0yiVyQYJrFGlJNCXomll94Fa
         mjHvJXgQVFPRSyyW6I2inmyJtrrdg+WNnkM8/q1nWj9u8c85QJriOMXEv6O0YH52kL
         HWLh/7kNrJA6utTrO1UQ2O7d90WCzYnDAg2hDEFzfW7X7cCTcO63+F8xUU7povddYr
         hlCwIuRgj+34w==
Date:   Mon, 7 Mar 2022 18:19:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] spi: Fix invalid sgs value
Message-ID: <YiZMz+jrYS9xUzx4@sirena.org.uk>
References: <20220307180116.8388-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdXPpM7nU=MZV=xJxZiOGyRGbgzuKxBR9EJsGJLWfD+Cbw@mail.gmail.com>
 <OS0PR01MB5922FECB366B55C75631BEA286089@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+ZpyKyXYgpU18bMZ"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922FECB366B55C75631BEA286089@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Cookie: Whatever became of eternal truth?
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--+ZpyKyXYgpU18bMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 07, 2022 at 06:17:23PM +0000, Biju Das wrote:

> > >         if (vmalloced_buf || kmap_buf) {
> > > -               desc_len = min_t(int, max_seg_size, PAGE_SIZE);
> > > +               desc_len = min_t(unsigned int, max_seg_size,
> > > + PAGE_SIZE);
> > >                 sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
> > >         } else if (virt_addr_valid(buf)) {
> > > -               desc_len = min_t(int, max_seg_size, ctlr->max_dma_len);
> > > +               desc_len = min_t(unsigned int, max_seg_size, (unsigned
> > > + int)ctlr->max_dma_len);

> > The cast of the last parameter is not needed.

> OK. I thought since last param is size_t, casting is required.
> OK will drop this.

In general unless you're getting a warning and are *very* clear on why
what's being done is valid casts should be avoided.

--+ZpyKyXYgpU18bMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmImTM4ACgkQJNaLcl1U
h9A56wf+N5v6NCG2s7C7j8Hz9MCTvP0NAL+wMzlGO+CuVVoaAhAn2oCDty0x6Tq2
a8FDbd2s4+wV4i7I6/P3pttxTnAVZCB0eEhMhKu2IIabQf218vZGNMU09Ktf9C3D
NTR69nyhpKgVRVEjuLW31sfPxhD/rZRyVg3r2r7zijJe9awqTSPH8R/fsK+PP5RJ
e5/yPyRMyflsdIKpha//ej636xGiA6b+tuDSUR6UwgWkXpI/29J59izvjbgp4aIO
746vDyOSzjZUc8TqOus3fk0y8edxWNioDe+/gp3xo3qV5iIYjJb+NDvvAKWQGilZ
UkP/oX8MKMcO7r2UgBqcKj0B+h9JDA==
=OMR/
-----END PGP SIGNATURE-----

--+ZpyKyXYgpU18bMZ--
