Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CB96AF5BA
	for <lists+linux-spi@lfdr.de>; Tue,  7 Mar 2023 20:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjCGTdX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Mar 2023 14:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjCGTdA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Mar 2023 14:33:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCC6BCB8C
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 11:19:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C05EB817C2
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 19:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977C3C433D2;
        Tue,  7 Mar 2023 19:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678216747;
        bh=3BnTZOB2UKioBHR+Xep+S/ugI9/5DjLacOs/PCpVCyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTL7peyYS4o3T0NoaUS2KdVKACzWgux3K9u+wPvA3vMa8DC2XTI1HgAr+fOYy3U7X
         wbIJ7jr8w7uxJgm5Y7YXnWXCTRPLb0jVpxBkvGm5d6ZguAuivlxeg4PzUjim+DY6Te
         fpnYt8tIzJlwOxKoR3bs4lQaD79vst/jOtpTlpsJN+MN7veeehwLWeL3xKl2cd/bep
         JxEO4kz1RnymsdHNKjH7mo+xP7bXVHV5j7tZp73RJ38F6LB7/ZWYy76prFCwwNL+Ow
         UZTa2hKCm17E+VB+WkziDMidCcsnvHoF4GlHdP/YW+Pjv6HnBk0kF10yLnFAjU5ARJ
         +xwCKg2hjHqtw==
Date:   Tue, 7 Mar 2023 19:19:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: Looking for a solution for CPM FSL SPI driver that swaps 16 bits
 words
Message-ID: <84d3426c-47fe-44e9-ad04-be120fbbcd03@sirena.org.uk>
References: <764971c9-fe57-160c-d073-a519934da767@csgroup.eu>
 <8fd7715b-1dba-4cdd-916d-8c9dce004031@sirena.org.uk>
 <e21b9465-664e-bdf8-71ec-b7818c04c171@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vzhrMJ/uEof/jnR5"
Content-Disposition: inline
In-Reply-To: <e21b9465-664e-bdf8-71ec-b7818c04c171@csgroup.eu>
X-Cookie: A rolling stone gathers momentum.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--vzhrMJ/uEof/jnR5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2023 at 07:01:54PM +0000, Christophe Leroy wrote:

> What about a new flag at SPI device registration to tell the SPI=20
> subsystem that this SPI device driver wants "raw/native 16 bits" data=20
> being sent as-is, that my loader would set in order to tell the=20
> controler "I have prepared the data, send it in your native 16 bits=20
> order mode" ?
> And for all devices not setting that flags, the controller would=20
> fallback to 8 bits mode.

Oh, so the issue is that your controller is *not* swapping data?  In
that case if 16 bit transfers are more efficient and a buffer formatted
for 8 bit transfers is already in the correct format then why not just
tell the controller to use 16 bit words where possible?  Nothing outside
the controller cares about anything other than the memory and wire
formats, if the controller correctly performs an 8 bit transfer when
programmed for 16 bit words and it's faster then just do that.  That
will work a lot better in general, drivers just sending a byte stream
aren't going to (and shouldn't) ask for anything other than 8 bit words.

Word size configuration should only be used by a client driver when it
wants things rewriting.

--vzhrMJ/uEof/jnR5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQHjiYACgkQJNaLcl1U
h9D8eAf/W92Ywy8TDuMbBF/GNSNP2JMll8Y+Ga953QhLGUkleg63HnbiY/hHeRMT
JtVCILIFrDmieDNsjRvA6xyYrfcoDxhNglPakVQUdi3dO6tCxFbPJ72vMKFgHLdb
JqA4uBzU07s+9xF5E/mERal5dstcJlqQNQ06E1UJnxL1f/ldE/KDtBCSDCkLYoca
3kGrxKoCgTag3fOEJRaL7pxwKemAGjWRc71NBbks+G7O/mPS5xKwfnqcptpFSaEb
vsSLhxrpeNEgvfJjFzmR2z8/doBpWWZam8/34nPFf+tG4TC3oBocrjkwpuS3YgFK
8KGeQK25mRguwZjdH+0OrY6kDh9AIQ==
=gebh
-----END PGP SIGNATURE-----

--vzhrMJ/uEof/jnR5--
