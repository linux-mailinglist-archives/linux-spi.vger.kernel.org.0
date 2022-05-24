Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4442D5331D9
	for <lists+linux-spi@lfdr.de>; Tue, 24 May 2022 21:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbiEXTq1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 May 2022 15:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiEXTq0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 May 2022 15:46:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A5CBE0E
        for <linux-spi@vger.kernel.org>; Tue, 24 May 2022 12:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51FDEB81B9A
        for <linux-spi@vger.kernel.org>; Tue, 24 May 2022 19:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B5AC34100;
        Tue, 24 May 2022 19:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653421581;
        bh=vZjwxDXRbOaabbp3NSWjYD3m2GheWZ6EL9FTdfpwsl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eT5hbHNdlbv+FcwSBHFOUTVzvhnOQBGIeUoZ7DMAWSeuHlHgQ1aBdlmMd+Oe+Ba9R
         M6vlLGZN6LDOotlbMiTEUWXGTNWslnvni1X3ZZj3RirgVPFDvECvu9gMrWtqlKVatS
         tdGcSSH68OGhBveMWxdV3bIV0/jSkdm+23Vjf2+MkoHj+WDxKvu6713D3TLVMnkmeq
         gZJz8vMARJ4ZkKERfDSANhf6A3XHp4HzJVnJbtN1ltxB29dLrYSXiucjCEPsot0YDu
         PfJ7v+wTYC2DLw64rATgwXawhaR8F9x/WMYtE92KcexaZ7Vti2nbSIxhtzraP+6Ok7
         +OnvU27WPx3lw==
Date:   Tue, 24 May 2022 20:46:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <Yo02CLxDoCPYYZD5@sirena.org.uk>
References: <YoONngxX/jdTjSOH@sirena.org.uk>
 <20220517150906.09a16a47@erd992>
 <YoOmn1k6yEtJofe5@sirena.org.uk>
 <20220517171626.51d50e74@erd992>
 <YoPm0qDaMEogH8n2@sirena.org.uk>
 <20220519101238.516c5f9e@erd992>
 <YoeyIG+RGpRBm9Cc@sirena.org.uk>
 <20220523164832.4d9a0bb8@erd992>
 <20220523145935.eve4kzthaquecxnm@pengutronix.de>
 <20220524133048.62053868@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4xR/pYPZbAKIJz9k"
Content-Disposition: inline
In-Reply-To: <20220524133048.62053868@erd992>
X-Cookie: A man's best friend is his dogma.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--4xR/pYPZbAKIJz9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 24, 2022 at 01:30:48PM +0200, David Jander wrote:

> > But that turned out be not working properly:
> >
> > | https://lore.kernel.org/all/f86eaebb-0359-13be-f4a2-4f2b8832252e@nvid=
ia.com/

> Ah, thanks for sharing. Added Martin to CC here.

> I have been struggling with this too. There are definitely dragons somewh=
ere.
> I have tried to do tear-down in the same context if possible, similar to =
this:

There's a potential issue there with ending up spending noticable extra
time turning the controller on and off, how costly that is might be
variable.

> I have not yet discovered exactly why. In the occasions the code didn't h=
it
> the race, it seemed to have a notable performance impact though, so remov=
ing
> this context switch may be worth the effort.

Or come up with a mechanism for ensuring we only switch to do the
cleanup when we're not otherwise busy.

> From what I understand of this, bus_lock_mutex is used to serialize spi_s=
ync
> calls for this bus, so there cannot be any concurrency from different thr=
eads
> doing spi_sync() calls to the same bus. This means, that if spi_sync was =
the
> only path in existence, bus_lock_mutex would suffice, and all the other

The bus lock is there because some devices have an unfortunate need to
do multiple SPI transfers with no other devices able to generate any
traffic on the bus in between.  It seems that even more sadly some of
the users are using it to protect against multiple calls into
themselves so we can't just do the simple thing and turn the bus locks
into noops if there's only one client on the bus.  However it *is* quite
rarely used so I'm thinking that what we could do is default to not
having it and then arrange to create it on first use, or just update
the clients to do something during initialisation to cause it to be
created.  That way only controllers with an affected client would pay
the cost.

I don't *think* it's otherwise needed but would need to go through and
verify that.

> spinlocks and mutexes could go. Big win. But the async path is what
> complicates everything. So I have been thinking... what if we could make =
the
> sync and the async case two separate paths, with two separate message que=
ues?
> In fact the sync path doesn't even need a queue really, since it will just
> handle one message beginning to end, and not return until the message is =
done.
> It doesn't need the worker thread either AFAICS. Or am I missing somethin=
g?
> In the end, both paths would converge at the io_mutex. I am tempted to try
> this route. Any thoughts?

The sync path like you say doesn't exactly need a queue itself, it's
partly looking at the queue so it can fall back to pushing work through
the thread in the case that the controller is busy (hopefully opening up
opportunities for us to minimise the latency between completing whatever
is going on already and starting the next message) and partly about
pushing the work idling the hardware into the thread so that it's
deferred a bit and we're less likely to end up spending time bouncing
the controller on and off if there's a sequence of synchronous
operations going on.  That second bit doesn't need us to actually look
at the queue though, we just need to kick the thread so it gets run at
some point and sees that the queue is empty.

Again I need to think this through properly but we can probably arrange
things so that=20

>         --> __spi_sync()
>             --> bus_lock_spinlock
>                 --> queue_lock
>                     --> list_add_tail()
>             --> __spi_pump_messages() (also entered here from WQ)
>                 --> queue_lock
>                     --> list_first_entry()

the work we do under the first queue_lock here gets shuffled into
__spin_pump_messages() (possibly replace in_kthread with passing in a
message?  Would need comments.).  That'd mean we'd at least only be
taking the queue lock once.

The other potential issue with eliminating the queue entirely would be
if there's clients which are mixing async and sync operations but
expecting them to complete in order (eg, start a bunch of async stuff
then do a sync operation at the end rather than have a custom
wait/completion).

--4xR/pYPZbAKIJz9k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKNNgcACgkQJNaLcl1U
h9DJfwf8Du5FLHYgCWVVAbsEmgmpsjW17tUv79xX4PW25P9VOYAhFi3SYTSdIxx1
xeQzmyaY+Qcib5r4t/oCBOyf4ns8aAiVMz4CAqKfoy+2Un/gsUafPzUriYABeh7I
p66Ehz71MpHYkmhLsuX3ewkjrhbwYD06Er/TEjCKNG5WJao7zJY7yJuGWni7EYQW
6rWMOlJGq2Jk7A5beR8LJmjUTZofHyhO9HDdukrF2XRORup5xhoyuK/RR0x1+QFY
GFSN64DKizgDyAU4BfWFbyy7IN3Xe6xZO32+rFj5q8U+vKTqTA25AaqD9sEWkaEa
PmdGYakKm2IuUTWw4oASS8PyyFqtCw==
=AhUr
-----END PGP SIGNATURE-----

--4xR/pYPZbAKIJz9k--
