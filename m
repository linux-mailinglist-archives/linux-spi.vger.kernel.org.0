Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A645414CA
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jun 2022 22:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359367AbiFGUWU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jun 2022 16:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376277AbiFGUVX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jun 2022 16:21:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CB91D5003
        for <linux-spi@vger.kernel.org>; Tue,  7 Jun 2022 11:31:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 969B260DDA
        for <linux-spi@vger.kernel.org>; Tue,  7 Jun 2022 18:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1C7C385A2;
        Tue,  7 Jun 2022 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654626660;
        bh=RDFo9eWQm26fRAJChJpzZZ8J2U7ZYqlKI/miL/sv/ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQ67BFKaWIfxPXTdc6koeGHT13fMnMyqUemhwKKrgBjB4H8q2dE/q2wqKvSGQ4tJA
         3JXu4wrr1tQLrTnZzEZYNtQNtfjNOfIfV220KIMFE0+CAGleu5t7r1NWcxfaDohl8L
         3gJdqhna1MiE2M68KpU93chCBg//SpcNzO+ZwvasIfNqrRNrLSGgWWTA8xMmvuIrAQ
         76AGtSQoX5iH5e4tXS4hWkpvgxcTwstyaQfwAu3P80hBz3haN67ZjP4SdJwRBsNzml
         /KhADeeTKZhRfRQU7O3Nd64Cm/1/Owb02U/pXtfDnSFt4YCAbE/KJIKB0Oyf6aYAkJ
         CjlkdcizUn9xg==
Date:   Tue, 7 Jun 2022 19:30:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] [PATCH 3/3] drivers: spi: spi.c: Don't use the message
 queue if possible in spi_sync
Message-ID: <Yp+ZX4XITW7bQtjn@sirena.org.uk>
References: <20220525142928.2335378-1-david@protonic.nl>
 <20220525142928.2335378-4-david@protonic.nl>
 <20220525164603.57c98a0a@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W57iizh/FGCnvrfL"
Content-Disposition: inline
In-Reply-To: <20220525164603.57c98a0a@erd992>
X-Cookie: Where's SANDY DUNCAN?
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--W57iizh/FGCnvrfL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 25, 2022 at 04:46:03PM +0200, David Jander wrote:
> David Jander <david@protonic.nl> wrote:

> > +static void __spi_transfer_message_noqueue(struct spi_controller *ctlr, struct spi_message *msg)
> > +{
> > +	bool was_busy;
> > +	int ret;
> > +
> > +	mutex_lock(&ctlr->io_mutex);
> > +
> > +	/* If another context is idling the device then wait */
> > +	while (ctlr->idling) {
> > +		printk(KERN_INFO "spi sync message processing: controller is idling!\n");
> > +		usleep_range(10000, 11000);
> > +	}

> This is dead ugly of course, and it needs to be removed. Not yet sure how,
> hence the RFC. Maybe the idle -> not busy transition can be included inside
> the io_mutex? That way this while will never be hit and can be removed...

I'm not sure it's even quite right from a safety point of view - idling
is protected by queue_lock but this now only takes io_mutex.  Moving
idling (and all the was_busy stuff) within the io_mutex would definitely
resolve the issue, the async submission context is the only one that
really needs the spinlock and it doesn't care about idling.  I can't
think what you could do with the io_mutex when idling so it seems to
fit.

--W57iizh/FGCnvrfL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKfmV4ACgkQJNaLcl1U
h9CFlwf+Nn/MS4du0jwtfEcjCUEWC2tk0GpFoUCoPsUtCLcGrrFc7dV/2sRCGYhi
sG3gnomYnjTf6FofVQHwIjaozBVVqQVWY1Q0Dtti1GF3fh3eCCAJgs/C2IErjeB8
ULj/v276TzZ3SoTdaTUDhksHnuK4Bxsu8akc2vH8GBZ1+nGhxNVVbDct6ilUDB4j
aDwx3tXTrwE4fHEkl4ggT/AHDeB2A10yLkogvHWVrdVl+1hxpU5MBALgYDtlbU8U
eGYPx5CEiMzghSBPGnSeLwQ0QgmwiF1K+JF1Sbu1gn3tn6Bg+orF3DwskzIrn/yS
oveXPXde9E9W87VKI1Xv/om3+dFIZg==
=XU8W
-----END PGP SIGNATURE-----

--W57iizh/FGCnvrfL--
