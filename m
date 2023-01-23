Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2E267782B
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jan 2023 11:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjAWKC5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Jan 2023 05:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjAWKCy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Jan 2023 05:02:54 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99630DBC6
        for <linux-spi@vger.kernel.org>; Mon, 23 Jan 2023 02:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=sPXz8ILkuNW7JxM+rtnU3ULl8uxG
        rZh0i9hUWESFozM=; b=DqL/uTMP4akbAGIMMkK8JO3NnSldysOWuEEfpEMlNKmT
        tcwS3Q9jNBOQoMM+0VU7tK+vQO+zTpxT8G00TpdBRGzwghQyvjqkWqmdN9lhNJFS
        mSh8Frz+Klp5ofTJTpbGVsKWnk0dUdjYkAbSrJvKQK4c9H+p48TCg33T+NVmZVY=
Received: (qmail 2155226 invoked from network); 23 Jan 2023 11:02:32 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Jan 2023 11:02:32 +0100
X-UD-Smtp-Session: l3s3148p1@WLFof+vy8tUujnvx
Date:   Mon, 23 Jan 2023 11:02:32 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] spi: sh-msiof: drop support for R-Car H3 ES1.[01]
Message-ID: <Y85bONoZzfTf2fXw@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20230123075833.50925-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdX072wWj=h48oVe47bkaw144HmMeq2bNbiE+ZUMhz56eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i3XFi4enk7dTbB9j"
Content-Disposition: inline
In-Reply-To: <CAMuHMdX072wWj=h48oVe47bkaw144HmMeq2bNbiE+ZUMhz56eA@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--i3XFi4enk7dTbB9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I don't think adding more soc_device_match() calls is the proper way to
> handle this...
> What about adding a single check to drivers/soc/renesas/renesas-soc.c,
> removing r8a77950*dts*, and removing all R-Car H3 ES1.x matches from
> all drivers?

Can be argued. My take was like keep the existing ES1 support which is
not in the way and disable the rest. But if you want to get rid of it
entirely, that is cleaner, of course. A tad more work removing the
existing quirks, but well...


--i3XFi4enk7dTbB9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPOWzQACgkQFA3kzBSg
KbZfqBAAiaAex5Xo58YHMxMSLnnUTwMewd5L+e9Wi+Ge4L5lhB2Khtlat7j9QO5O
2GCMGtB7y/x51dhf2+mMLYi/DyhpEPpc8hNB+FJ3w0ywQElRTq/0teuyr7gwBKNl
HCnzJ+9XQzUImf+VqnmkvA0npWxC3XcOJv6flSjjN6GTMK2EsKwLt1lTfDaNIPmF
X8HotNpqbCV/jB9DchqocrTObhsL4WarjtcipRByWNOvEtD5o7YslGkABUKlhwIz
1/fd5KHW0cR6s8ZxicKBGZ6FwX5jeEH76nuYSG33VHOZe9KZVTQuD7OAB6fnk4rP
Stm+z+noHHq7PKUEu6iv6vK9d9Kh9UhK2TryKNjcwkLerYhcyxuwiy2119NPUxeC
0j21TTWzwZ0Cr5O37TFfwbpe7MYQbamYkKImq1j9HOM1aFJ2ugYKTOIgN06LJik7
rTxHTOGFLaofmArNKmfpKeaKir51m7/9eR2YyzUair5Myy9NInHuvT98MBD2IEiV
TCcwJsIsckxc8JKZUF1dkfD66hKufCm8JA7enr77nUsW370DETH/Nmwb0DZ8QuPA
Vp9zTvBgxzslJBx1/Ki56r0fRhJv6D0dooJmEAwZmBkriGC3of/HBzSU46nIZWJa
81viPssuqJPtUhgQexDkpF7f+TtclX1EotcrQVQ3wMCJcUzxDY0=
=QDlr
-----END PGP SIGNATURE-----

--i3XFi4enk7dTbB9j--
