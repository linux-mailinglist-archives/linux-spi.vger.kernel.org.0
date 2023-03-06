Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAA96ABF6D
	for <lists+linux-spi@lfdr.de>; Mon,  6 Mar 2023 13:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCFM0Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Mar 2023 07:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCFM0W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Mar 2023 07:26:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21452A6EA
        for <linux-spi@vger.kernel.org>; Mon,  6 Mar 2023 04:26:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BAFFB80DA7
        for <linux-spi@vger.kernel.org>; Mon,  6 Mar 2023 12:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E27C433D2;
        Mon,  6 Mar 2023 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678105578;
        bh=rCij6iQW5StPJzdkzuIXddK0MM553LKkEmflAxlJQlA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NXORN5S9KOPOuP3FDGlmyA2JU9kU/o6IDKpC99wriNmprB48ABzQ4KXSS+2N5dOuc
         n1vfpLutOTHwF8ZmHcGA0ruS7ozDy6rSDaNBEhvcFhhIryw3BNgZGR9uHfJlu5GNvN
         08qM9CtM+gLfVcJtCTximkn9JBeyu/JUge7goBgdeM7YGIXC+bgPyosi0xvS1Z0qTf
         nwgJnLC5KhHgBd8xey23I0JgxfnxB5xXOrQSFKWjLkYs0wowS7hKJJZFb+qCwLcjJK
         WD5X78VM+n6QaoVgwQQmEX9BEBm6n8I4zvFcwQaiTEENUW1qgx+bfuuYMyN6ga6gAz
         OyVSf//red5xw==
Date:   Mon, 6 Mar 2023 12:26:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, kernel@pengutronix.de,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 09/87] spi: bcm2835: Convert to platform remove callback
 returning void
Message-ID: <6099369f-33fe-435c-a3fc-3a972f586b1b@sirena.org.uk>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-10-u.kleine-koenig@pengutronix.de>
 <20230306070426.v47fvxf6qncwekyv@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z2r0shcsZdgvW/MF"
Content-Disposition: inline
In-Reply-To: <20230306070426.v47fvxf6qncwekyv@pengutronix.de>
X-Cookie: teamwork, n.:
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Z2r0shcsZdgvW/MF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 08:04:26AM +0100, Uwe Kleine-K=F6nig wrote:

> squashed into the original commit. (I had that uncommitted in my tree
> while doing my build tests :-\)

> @broonie: how should we proceed here? Is your tree already public and
> you need a proper patch to fix this?

I was just going to drop the commit since it also failed my CI for the
same reason, please send a new replacement.

Please don't add random characters to my name, for whatever reason it's
like you're misspelling it.

--Z2r0shcsZdgvW/MF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQF2+MACgkQJNaLcl1U
h9DbgQf+L3IbEfHxnrNJ70gfuGdSiR5UaGs1aW4F+5teKOE99KikrDWbNSvYhU9Y
8h6KBsH60Y5uNZqQ1/krc91TbuL/ByTZMgLoBw7dZl/CQEdiYGSf97oJOaMn5sLN
Yds85+yELu9ZT7cV9oiLhhnBkNF9V7hss2iijSQUqgmDDvvkUaVrZFXBiQcHaOaM
0E+Vc9pPnOA1mJttDsZzSv97IZFWijXqAsbnJjJ2UX6Q0dwzP5MdHy0w5H1ZCDO7
0k+Z8Mt6uWziZBRuiQaDdZfciVNQ1AVzNEKYltirMHMQek6HrgfLbxH4Kx3TOUSa
co+2Cwu3jmY/Ex3QjdaB7aBGIXvOqg==
=62p6
-----END PGP SIGNATURE-----

--Z2r0shcsZdgvW/MF--
