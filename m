Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D130154677A
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jun 2022 15:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbiFJNlj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jun 2022 09:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbiFJNlj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Jun 2022 09:41:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF433A5D3
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 06:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3F038CE3606
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 13:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C411C34114;
        Fri, 10 Jun 2022 13:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654868494;
        bh=dEnDF1HNFjNXldYZ/p0EErWQeF7TYh0V0Uffx11psVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDoOUX7xz5edNPz9LsIJExSKbIUvfFcd8nXaE2QNQvoZlouyVby0tQ+eBj4JzxC1i
         al6krOpgiVFZPMHX0ek3c6uj4Y9qnACmnOjGZXTh8B9HWBjoZzRaVgKlxDT6vLMKCy
         9hIWTji5EKehDBz8raxsSCiQ5toZJDWq0EdEywjtG0Kx7yZBNWXXISy+umjgcTTuBL
         GRZEf/qvzElmMhK+YleXVH+8yeln7RKPKCirWsLWiH4lFep7v+rKjcCdk9P3k13FeB
         K3sQgA7SCqXSSoyjtdDWAYrZodVMavLFpA+RUSJGPBxRiGsNOeFDbbxyiEHSdvaCkv
         8tWttHEGvb1Hg==
Date:   Fri, 10 Jun 2022 14:41:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC] [PATCH 3/3] drivers: spi: spi.c: Don't use the message
 queue if possible in spi_sync
Message-ID: <YqNKCegdejr522lH@sirena.org.uk>
References: <20220525142928.2335378-1-david@protonic.nl>
 <20220525142928.2335378-4-david@protonic.nl>
 <20220525164603.57c98a0a@erd992>
 <Yp+ZX4XITW7bQtjn@sirena.org.uk>
 <20220608095409.2d8c46fb@erd992>
 <YqCIDNHjFP4p9xxs@sirena.org.uk>
 <20220609173421.437fe1c4@erd992>
 <YqIgXDZAHPAQ1Y4O@sirena.org.uk>
 <20220610092753.6e6c9e59@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cmWDPz9A+bAtb22j"
Content-Disposition: inline
In-Reply-To: <20220610092753.6e6c9e59@erd992>
X-Cookie: Teachers have class.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cmWDPz9A+bAtb22j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 10, 2022 at 09:27:53AM +0200, David Jander wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Jun 09, 2022 at 05:34:21PM +0200, David Jander wrote:

> > > Apparently some drivers tend to rely on the fact that master->cur_msg is not
> > > NULL and always points to the message being transferred.
> > > This could be a show-stopper to this patch set, if it cannot be solved.

> > That seems resolvable?  If we have two things actually handling a

> Ok, I first thought that this wouldn't be possible without taking the
> necessary spinlock, but looking a little closer, I think I understand now.
> One question to confirm I understand the code correctly:
> An SPI driver that implements its own transfer_one_message() is required to
> _always_ call spi_finalize_current_message() _before_ returning, right?

Yes, it should.

> If this is a guarantee and we take the io_mutex at the beginning of
> __spi_pump_messages(), then ctlr->cur_msg is only manipulated with the
> io_mutex held, and that would make it safe to be used in the sync path, which
> is also behind the io_mutex.
> Would appreciate if you could confirm this, just to be sure I understand the
> code correctly.

I think that should work.  If there's something missed it should be
possible to make things work that way.

> The fact that spi_finalize_current_message() is a separate API function, and
> not called directly from __spi_pump_messages() had me confused that it might
> be called in a different context (from IRQ thread or something like that)
> possibly after __spi_pump_messages() had already returned. But that doesn't
> make much sense... right?

It *can* be called from interrupt context, the driver can signal the
caller that the message completed without having to bounce up to the
message pump first which helps minimise context switching in the async
case, whatever was waiting for the message can get on with things
without us having to switch through the SPI thread.  However something
should still be in io_mutex when the completion happens at present.  A
brief audit of drivers suggests that this is not in fact reliably the
case though and we've got drivers that were never tested with any queued
transfers AFAICT.  I'll look at that.

Notionally the idea was that we'd be able to start the next transfer
directly from interrupt context on suitable hardware, however nothing I
had access to at the time I was working on this was actually capable of
doing that so I never implemented anything.

Actually, on that point - are you aware of any boards (ideally not
requiring some non-standard DT) that are readily and affordably
available and have useful CAN controllers?  I'm looking to improve my
test setup and they keep coming up.

--cmWDPz9A+bAtb22j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKjSgkACgkQJNaLcl1U
h9BBRAf+OzJ9xXbmt/PwjrWJ4jbinXtacej8j06mzWSrGlPBObXa0yJgoCNta8gY
nwtF7a/aPRRPJ3uObA2sod2rPwP1zz3Uo0VuiT0TScyqqT6ghZ0H4P3uRL7piMOi
ywKG20PTfuREk6D0b3zf+SU3Gcf+QOOXVM4JVycpj1VvzUAXsh4UaXPIpI2QnFYf
Vl6ufKlBwt6UBGYnwU/HuOONl5yzYYNkYBrYHTuRnfCOQvZIp5rsPkw80SkhBLd8
KJ6w8YmNO8J8LKz09dhOgAzE/BsfMl+rPSV2qwxSlcw8O4x2UEHCTKIUCNcSpQh7
aSn2xAmlaOvBr40tR3UKc4JKEmJkLQ==
=9Mmm
-----END PGP SIGNATURE-----

--cmWDPz9A+bAtb22j--
