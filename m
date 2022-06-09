Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C451545205
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jun 2022 18:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbiFIQbc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jun 2022 12:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244063AbiFIQbb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jun 2022 12:31:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5E536A658
        for <linux-spi@vger.kernel.org>; Thu,  9 Jun 2022 09:31:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B7956113E
        for <linux-spi@vger.kernel.org>; Thu,  9 Jun 2022 16:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6395C34114;
        Thu,  9 Jun 2022 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654792288;
        bh=tVO6VEzqoUeJuflpDHYuBudhIBmayXrgLlweC8UNRFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/GpSdiQ1UnOX1EUkdlDMdHV8p4SOf8I2fzkwQIxffBwTqxRCqiL4mcmWpl8qXS7p
         Ya/wIU32jxQmfZLfzcaU3QGr8HsnSGJobkySyHgR3+zTmHlgEQ/Yxb17cPXp8f/YXj
         fCInXcmjKoaEMCKL6E2Sr5ygM6N9uLcGTNyC+Oiq0wuf8OE2lM545yjwsnNz5uQWi9
         sMUEfqdr+5GnSrszpSjO5NNwBocJGZ5ZQVN0ICIvVYaIcyBNPyiGosTKRgMw+Bo3xr
         LrMbThJl/kGF832NWFkLMV8ksCTMCq7Qu4HnRte2ChCN8IDWP3JXgjhHybQ2q72GFk
         0cp+tx+QltOhQ==
Date:   Thu, 9 Jun 2022 17:31:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC] [PATCH 3/3] drivers: spi: spi.c: Don't use the message
 queue if possible in spi_sync
Message-ID: <YqIgXDZAHPAQ1Y4O@sirena.org.uk>
References: <20220525142928.2335378-1-david@protonic.nl>
 <20220525142928.2335378-4-david@protonic.nl>
 <20220525164603.57c98a0a@erd992>
 <Yp+ZX4XITW7bQtjn@sirena.org.uk>
 <20220608095409.2d8c46fb@erd992>
 <YqCIDNHjFP4p9xxs@sirena.org.uk>
 <20220609173421.437fe1c4@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wi94CegXoQyVlfvV"
Content-Disposition: inline
In-Reply-To: <20220609173421.437fe1c4@erd992>
X-Cookie: Space is limited.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--wi94CegXoQyVlfvV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2022 at 05:34:21PM +0200, David Jander wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Jun 08, 2022 at 09:54:09AM +0200, David Jander wrote:
> > > Mark Brown <broonie@kernel.org> wrote: =20

> > I think the rest of it is fine or at least I'm finding it difficult to
> > see anything beyond the concurrency issues.  I think we need to do an
> > audit to find any users that are doing a spi_sync() to complete a
> > sequence of spi_async() operations but I'm not aware of any and if it
> > delivers the performance benefits it's probably worth changing that
> > aspect of the driver API.

> I just discovered a different issue (hit upon by Oleksij Rempel while
> assisting with testing):

> Apparently some drivers tend to rely on the fact that master->cur_msg is =
not
> NULL and always points to the message being transferred.
> This could be a show-stopper to this patch set, if it cannot be solved.
> I am currently analyzing the different cases, to see if and how they could
> eventually get fixed. The crux of the issue is the fact that there are two
> different API's towards the driver:

That seems resolvable?  If we have two things actually handling a
message at once then we're in for a bad time so we should be able to
arrange for cur_msg to be set in the sync path - the usage in the
message pump between popping off the queue and getting to actually
starting the transfer could be a local variable with the changes to the
sync path I think?

>  1. transfer_one(): This call does not provide a reference to the message=
 that
>  contains the transfers. So all information stored only in the underlying
>  spi_message are not accessible to the driver. Apparently some work around
>  this by accessing master->cur_msg.

>  2. transfer_one_message(): I suspect this is a newer API. It takes the
>  spi_message as argument, thus giving the driver access to all informatio=
n it
>  needs (like return status, and the complete list of transfers).

It's the other way around - transfer_one() is the result of providing a
transfer_one_message() which factors out more of the code given that a
huge proportion of drivers are for hardware which works at the transfer
level and doesn't understand messages, just as transfer_one_message()
and the message queue are factoring out code which was originally open
coded in drivers.

--wi94CegXoQyVlfvV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKiIFsACgkQJNaLcl1U
h9AzrAf+LEqEuOWgmlrA0DdnfKzTVgG98OpZ3UVoywuiVmQztfTYKxlLU3ZbUUy0
bEWR/qxDM1wjmC88qcEK8slOjrdxU4swKcxKzWAVfcjh1dgcrBlz3bajfN6xBDa+
OSp1wGp6mZyx6LV6W+5Olp7X8GtvhdbfA4dl/MrxRvUcQesSd3YK9QamdJmbqJTC
H/l1Fx9KaR5/XIA4GQsSB5ql2JOBHakawlQT85zg3F3vZ5G0Obt2T3mV7HWZ5O+u
9/gPCFR3lIwDBVlYAgfBMu1sesGbfCbZ2wy9f9FjepyXkTJcae6qkonSGcEv6DJF
60/7U0UkSNu8CBPBHr/DPGDiq0zCAA==
=VU6h
-----END PGP SIGNATURE-----

--wi94CegXoQyVlfvV--
