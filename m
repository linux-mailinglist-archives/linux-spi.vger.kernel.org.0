Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3182633FA2
	for <lists+linux-spi@lfdr.de>; Tue, 22 Nov 2022 15:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiKVO72 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Nov 2022 09:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiKVO7C (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Nov 2022 09:59:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06C445A25
        for <linux-spi@vger.kernel.org>; Tue, 22 Nov 2022 06:57:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6532361748
        for <linux-spi@vger.kernel.org>; Tue, 22 Nov 2022 14:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC577C433D6;
        Tue, 22 Nov 2022 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669129039;
        bh=E8HHsC1GfVxcXlYr0+NCNFmlNDN5+1Ti+fB7iekF9zQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GleX+G1oxehrd3MRSV32+0/es6/rGW0ZL3aU1QWpD8w8LV9GKxZEbYH8Lqx/UJT0q
         1icM1JTHWk5tZxdLBoW5UloTp1JJASGaonayd/M8VdD1LyN7K9nXn6lthrw1yaY9YJ
         zqh6abUr8Ey+tQyf/vI3u5rnfhwqSTkfiE2CyOWJUjzkgsuAgSbC0UZnRFa30HpM9h
         BHeVFxAsyFv//+DCND6RgRrmbn6o0DwVrLwzMUXipPQr7ASk7RE3AnGxr0Y29eE5jz
         HOD5nC3+gRDYgPH0juiTlKs45TdR+A47BMtEd9oAZRCv804oKKtwp+ZRUYsWZBEJi/
         Bii4LKq/fVBdQ==
Date:   Tue, 22 Nov 2022 14:57:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, "Gole, Dhruva" <d-gole@ti.com>
Subject: Re: [PATCH 0/4] spi: intel: Add support for SFDP opcode
Message-ID: <Y3zjS2vQle0w7tYE@sirena.org.uk>
References: <20221025064623.22808-1-mika.westerberg@linux.intel.com>
 <Y3zA/THfo2jBglKS@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qT5KNeojs5HgdUoQ"
Content-Disposition: inline
In-Reply-To: <Y3zA/THfo2jBglKS@black.fi.intel.com>
X-Cookie: That's what she said.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qT5KNeojs5HgdUoQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2022 at 02:30:53PM +0200, Mika Westerberg wrote:

> Any chance getting this queued for v6.2? Thanks!

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--qT5KNeojs5HgdUoQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN840oACgkQJNaLcl1U
h9CQ9Qf/QrUd+1hVaiWA+PWgmbAAFMA5tqIiKRzTGSDy6wZjOFVmcojirc0XV5y2
CMtiDXWggIYWz1GZqmHGw2IIL8UycEjiWyqZB29XYVyUKTnnpIfxTMvJc7Y61sWn
frvmaMf0cWDvvBzDXR3G2qMTIgkbSXvVNC7dF1Q2t0ggZ9nx4XeEaQ02jo4j5ldg
H1B1kvlkT0R/ENn7JXRRNVgJifcjFqkptDWXKS3CNT7Vq1gnIFPYrSAQJdkrNE4M
N9uiLHc4u2vqJT4CxgAcz087zca2YdLkM7L96S4Wq3hw20f2Lp2obWYYYgU07dux
bTofpj9qpyyiOJuH4sT/XVu1pnyJ5Q==
=GzJQ
-----END PGP SIGNATURE-----

--qT5KNeojs5HgdUoQ--
