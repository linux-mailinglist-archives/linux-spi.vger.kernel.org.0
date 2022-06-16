Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0E354E577
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jun 2022 16:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377403AbiFPOzh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jun 2022 10:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243496AbiFPOzg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Jun 2022 10:55:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687022F00D
        for <linux-spi@vger.kernel.org>; Thu, 16 Jun 2022 07:55:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B44E660A6C
        for <linux-spi@vger.kernel.org>; Thu, 16 Jun 2022 14:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE55C3411C;
        Thu, 16 Jun 2022 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655391334;
        bh=zwYRROhngWS9rHOpouLF7/526UzE+YohodwpYilRB1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvXMPIo/aiQVxdlGwZPehLyCUb6W4rwTZA1yBAN7/o4iTkX9cB3mAeMfgC/j4AHUv
         FllN03EgmnX0fn2XmBxprznG/YR3WIR2WjoA0TDO+UDZGY3Ao+BejUA0AL0cIE0Yl2
         TWdB37gYKfYSfpnPgCAPrwAx4WIsBW/nqGHngfdZLZpfhpIM0CnBSvlinJ81qsPe+c
         lSm3+7TBOehGWlfHfcFFBIYDKmihh70o3RvmxGTQzTIDOMb4lX7/u5lgc6m2+FUmA5
         y3gU0pKeUKyj5uij2kT6TsTUbJY2eH/nticFILJwMZlAifVNVcdi/2c4wis499/W7M
         ZTBP1MwBDFRqA==
Date:   Thu, 16 Jun 2022 15:55:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC] [PATCH v2 00/11] Optimize spi_sync path
Message-ID: <YqtEYTgL+wJXp9QU@sirena.org.uk>
References: <20220615124634.3302867-1-david@protonic.nl>
 <YqsuhfN1I54J+1gw@sirena.org.uk>
 <20220616161323.7f1b9e84@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m4og/9J1NzX/5+2B"
Content-Disposition: inline
In-Reply-To: <20220616161323.7f1b9e84@erd992>
X-Cookie: Pass with care.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--m4og/9J1NzX/5+2B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 16, 2022 at 04:13:23PM +0200, David Jander wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Jun 15, 2022 at 02:46:23PM +0200, David Jander wrote:

> > I've given this a first pass and it looks sensible so far - I'll need to
> > give it a more thorough look but I'd expect it should be fine.  The
> > numbers certainly look good.

> The current patch set probably needs to get partly squashed, since there are a
> few patches that undo changes from a previous patch. I left them like this in
> order to hopefully make the step by step mutation more clear for review.

Yes, there's a bit of stuff.  I think it's based off your previous
proposed patch too?

> I had some doubts about patch 11, since it introduces 2 new members to struct
> spi_controller. I was trying to keep the pollution down, but I couldn't find a
> better way to do this optimization. Any suggestions? Maybe a better name/place
> for these flags?

Not really - I'm not too concerned about individual flags since we don't
have so many SPI controllers in a system, it's not like it's a per task
overhead or similar.

> Ideally this would get as much different hardware testing as possible before
> going further upstream. Do you have access to some platforms suitable for
> stressing SPI with multiple clients simultaneously? Known "problematic"
> controllers maybe?

Well, the fastest way to get it into a wide range of CI is for me to
apply it so people who test -next will start covering it...  I was going
to kick it into my test branch KernelCI once I've got it reviewed
properly which will get at least some boot testing on a bunch of
platforms.

For testing the main thing that'd be nice for testing would probably be
coverage of controllers that don't block in transfer_one_message() and
those that complete in interrupt context while blocking in there.

--m4og/9J1NzX/5+2B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKrRGAACgkQJNaLcl1U
h9DNCQf/Ul09PDqkZIV9xZfXykz/t7bFFbxV4mGUYnOSDqXdv6hZ5H3+07fODVD/
dV1xFzDDDIAIXR2AarSa3Pbi3T8ORA9fIEkyECYdgwHITBM2qpISNMfzfVNGSBoX
iivxQdJ85Wde/TdkiTHzdZAVKIbgC8S1K3B/U0y1Zire5n6gsW8YWQNb1kInltny
l8JIc28gUxFS/Ec/ueRLi5xpEyOk+3kilxO6veLn/OKvlLXLGkBFF6IsQs5OOuwt
VWiSttYcKWnxkNahiehy8YsD/X1NmJF+3dDA9Bho4e6wkGBec6P01WMtK4YZZ8Vg
LabAq4X7LG6dM/3wNRVKBRze7FDx9g==
=NifU
-----END PGP SIGNATURE-----

--m4og/9J1NzX/5+2B--
