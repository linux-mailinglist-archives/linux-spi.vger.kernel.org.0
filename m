Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1152AA6B
	for <lists+linux-spi@lfdr.de>; Tue, 17 May 2022 20:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbiEQSSB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 May 2022 14:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiEQSSA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 May 2022 14:18:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A21C506EA
        for <linux-spi@vger.kernel.org>; Tue, 17 May 2022 11:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDC8D6152A
        for <linux-spi@vger.kernel.org>; Tue, 17 May 2022 18:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50997C385B8;
        Tue, 17 May 2022 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652811478;
        bh=tOx6DnCZqEr+cuUS9nNKdlblUW/gMkJ1CZKULb6l3Wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzsiwTJLO7msXZB4/c11qDiCH2CaIc0W+OboCtezjLG+rnJ+yslOtZeQLTTV/AM8Q
         6ZPHmgO3OdmJPGmpxXEnfcziJ5GXONub1So8ZyqqYF76I594+YJaek3HFwQ/g3xDBt
         oXF89AReDMHQeeF2MY8lsM67q/jQcRXHr9hniCCWwbZNn/fwsCBb7vdOY6m7XeI8XR
         nm2HVA/ty13e551YJ4YCtD1U1gJ37dTR/yhMHJuBUIP3TlApMmM5a2Ks9qp0rZ5QvV
         bzoSSXRID8uVk06uihtU8VEbHozOPSyucWoBN6NhwpFO0qbTZVFxK/2UgwBHvmB/K5
         bRT3bGV5bsPrw==
Date:   Tue, 17 May 2022 19:17:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <YoPm0qDaMEogH8n2@sirena.org.uk>
References: <Yn1wE4TLyXCIm9GF@sirena.org.uk>
 <20220513144645.2d16475c@erd992>
 <Yn6zU3mdgaSNy4Hc@sirena.org.uk>
 <20220516162851.fhczlq4qfqhu6jht@pengutronix.de>
 <YoKN/lqrgKJbVBVq@sirena.org.uk>
 <20220517122439.744cf30c@erd992>
 <YoONngxX/jdTjSOH@sirena.org.uk>
 <20220517150906.09a16a47@erd992>
 <YoOmn1k6yEtJofe5@sirena.org.uk>
 <20220517171626.51d50e74@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GmxkPEcevblijayb"
Content-Disposition: inline
In-Reply-To: <20220517171626.51d50e74@erd992>
X-Cookie: Fats Loves Madelyn.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GmxkPEcevblijayb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 17, 2022 at 05:16:26PM +0200, David Jander wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > I think the worst case would be mixing latency sensitive and throughput
> > sensitive devices, or possibly tasks on a device.  As you say there's an
> > element of system design here.

> Sure. I have combined NOR-flash chips on the same SPI bus with an MCP2515=
 CAN
> controller in the past. But I knew that the NOR-flash chip would only eve=
r be
> accessed during a firmware update or from the bootloader. Never together =
with
> CAN communication. If I did, I would have lost CAN messages guaranteed. So
> you can have compromises. I (as HW designer) in this case would never exp=
ect
> the kernel to try to make this work concurrently, and IMHO we (as
> kernel developers) shouldn't try in such extreme cases either.

Part of the worry here is if we manage to do something that plays badly
with tools like real time scheduling that allows people to manage this
stuff, causing problems for something that otherwise works fine.

> > OK, no - I'm proposing actually putting the message onto the hardware
> > from interrupt context.

> Nice! I like that idea. Do you want to somehow extend spi_async() to do t=
his
> transparently? So we just need to introduce a second function
> ("spi_async_await()" ?) which would wait for completion and collect the RX
> buffer?

We shouldn't need a new API to wait for the async operation to complete,
hopefully the existing one is fine.

> To sum up all possible patches you would accept if I understood correctly:

>  1. Make the stats/accounting code be NOP with a sysfs or similar toggle.

Or otherwise make it unobtrusive (eg, with similar techniques to those
used by the networking API).

>  2. Enable the re-use of messages with once in lifetime prepare/map/valid=
ate.
>=20
>  3. Introduce spi_async_await() (or similar), to wait for completion of an
>  async message.
>=20
>  4. Enable SPI drivers to tell the core (spi.c) under which conditions it=
 can
>  fire a message asynchronously without the need for the worker queue and
>  implement support for those cases. Conditions involve max. transfer size=
, CS
>  non-sleep access, etc... but it should probably be up to the SPI driver =
to
>  decide I guess (ctlr->can_send_uninterruptible(msg)).
>=20
> Do I miss something?

That's roughly it, plus a general push to optimise the hot path.

> Minor concern about 4. above: Hopefully the decision can be made very qui=
ckly
> (i.e. without trying and failing). Maybe this decision result can be cach=
ed in
> the struct spi_message, so it can be re-used (see point 2)? Maybe as part=
 of
> prepare or validate?

Yes, we need to do this at validation time to play with the reuse I
think.

> I feel confident that these 4 modifications will have enough of a perform=
ance
> impact if fully exploited by the MCP2518FD driver, that overhead will no
> longer be a concern.

Just the small matter of implementing them then :/

--GmxkPEcevblijayb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKD5tEACgkQJNaLcl1U
h9ASMAf9Fa3Jo7xS4FWOpoJE0tn00Ussn6LhjnSZ5bIzdWyjH5tFgLV2fAADfxdi
cbeehVGWfzzNyKlyiyNbBRCmEGA1HhMBSsTl79j7Mrk8EPHKGudpof2OfqZfIf16
pVHDeI+qhDyXXUZ6FDDlyF+wp8dpucSKQRsNzGrrprWPXz5bByA2yA42QpQso06+
flr/a/zT4FmMtOwN6nzV7K1fndg6HAhBM+tF/HIqhUWwbyOWyLj0tM6AqS0WoTHx
//KFSi7mQZldaEVZ9u96yqcD/rVS8IEAY6N7PEYb2RIySCWQ+E19JmOA/HVrQL5p
nkRKTiqxZMqiBpRzGGZ0bL1pVNyNOQ==
=YQaW
-----END PGP SIGNATURE-----

--GmxkPEcevblijayb--
