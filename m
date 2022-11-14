Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB04627C52
	for <lists+linux-spi@lfdr.de>; Mon, 14 Nov 2022 12:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiKNL3w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Nov 2022 06:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbiKNL32 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Nov 2022 06:29:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0010C1E729
        for <linux-spi@vger.kernel.org>; Mon, 14 Nov 2022 03:29:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6401B80DF0
        for <linux-spi@vger.kernel.org>; Mon, 14 Nov 2022 11:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E690FC433D6;
        Mon, 14 Nov 2022 11:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668425351;
        bh=/eBpeRLjsRy5xqk5Ibl2ek7aBdDo5M5lowe4T7Kw5rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3msjfa48aEdi+3fJmkLBdJkmbO+nrkDjuxczb2M3PC8mIAbCPHPY041Hwe1O5Mg3
         8TqcxLZID9jTYKypQGRsinnmH+eJmjiDcnZUanteO+a6s981Cnzep1101Qa9MCo/O4
         OuRFw9C1KpQ9uKpdVPUKIWexUydEzxfSgAG5XTz2SDfmePh8mKUm1rI/5Fg4EDKuXv
         W3iyc+lvjg++lVakMFLnj5c3sqGcsc2c/IDbsgB4TiJ3TRRn7KFlubLlx3hWN0SxY9
         KG8kbSHMMfh6A+2xglaTQ04KZBR0OCaR1osZXqPgWd5Edno/uIZQqAoKxNuV4WEnI1
         qM2OVBqf8DB+Q==
Date:   Mon, 14 Nov 2022 11:29:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>, mkl@pengutronix.de,
        linux-spi@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling
 support"
Message-ID: <Y3ImhoSzY1PYMp+9@sirena.org.uk>
References: <20221111003032.82371-1-festevam@gmail.com>
 <20221111105028.7d605632@erd992>
 <CAOMZO5CH9S_RYpLNZbRxChzSVkkZTAd+qpxz1Ycj2UUPROTXpw@mail.gmail.com>
 <20221111135919.63daed2d@erd992>
 <1c70bfd1-38f6-3a30-9e36-a0f780f82571@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FjOt7iriXIdovbfP"
Content-Disposition: inline
In-Reply-To: <1c70bfd1-38f6-3a30-9e36-a0f780f82571@kontron.de>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--FjOt7iriXIdovbfP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 14, 2022 at 09:30:26AM +0100, Frieder Schrempf wrote:

> As far as I know Fabio also discovered that disabling SDMA also fixes
> the problem.

> I guess I will try to repeat some tests on latest master and see if
> there is anything that makes things work again without reducing the
> clock. If anyone has some more ideas of how to fix this properly, please
> let me know. If nothing else helps we could also reduce the SPI clock.

It sounds like the commit can stay and that everyone is happy
that the issue is that the the commit made things run faster and
exposed some other misconfiguration for these systems?

--FjOt7iriXIdovbfP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNyJoUACgkQJNaLcl1U
h9DHYQf/Sfe2mphwxX7MUOiimSbajV9txGkuFEjMIIHJnH6hmMUHDw62XAARLBOj
tih6ZEfPPms1jzbwMMPkpFN7HFLLTds5XM79mLcAr9jNO7tzMQ6WIGmSENTgKazP
H4wA9OkKgLpeQ0kSlTGugLiQD5hHq9E6yZoJ5lz+5oj+sOR9F0gjf7uXvzFDPbU2
GEJbekHVP0TtIT7NdDZZ0iIUpzIIORpLPFhQaL8NAkedI1e6lFTCZDfLZMFMoQlZ
shVDsglrEt3iKC9VWbSNgLT/kGWw8rXBjCVTxu9RYREk0fqt6xVLQY0efzfrMlhR
M5elnB96fF3m+bXR3ICjaqpUfabTWg==
=CDul
-----END PGP SIGNATURE-----

--FjOt7iriXIdovbfP--
