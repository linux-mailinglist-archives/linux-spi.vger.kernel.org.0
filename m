Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61FD53F19B
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jun 2022 23:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiFFVWZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jun 2022 17:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiFFVWX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jun 2022 17:22:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF23BA5C
        for <linux-spi@vger.kernel.org>; Mon,  6 Jun 2022 14:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFB02B81BD2
        for <linux-spi@vger.kernel.org>; Mon,  6 Jun 2022 21:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC66C34119;
        Mon,  6 Jun 2022 21:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654550539;
        bh=ub6EGcUvASjzeNwLuZ7ab6V3ZBelEtwF8m0Uep1XdLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YGsoPAisGN5qOTOHr/wTXXObm8n17isp8R4lW2+ESpYA2SDTur6Qs1c3aBKeq7hnL
         woi9AU+s4xio4kno4jy/HoUH6KJnftRCrHDhJW/bEpdl9BW5vt+ODhVFNMAtj6/VlJ
         zELch55wjqxAvDnx+aoSDWWDs1/TCSvfQlDINYhaHk2c8oSs+steM8ujK4qd0giH2N
         pl30YaOZrkE4KH5W36gA701SVJ1iIDZ+IiC/mleNoMesPriXhyHJ09xMCuOercyJ8W
         4O+3C1B73ikNmm+WNHKNZe58ixhfcPImom0XgUiVqZmJCIA7Nf3hobV/bm/voAWPtc
         2cbamK8Lbyy+Q==
Date:   Mon, 6 Jun 2022 22:22:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jens Lindahl <jensctl@gmail.com>, linux-spi@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH] check if dma is active before attempting to terminate
Message-ID: <Yp5wBlOQfpTbUV/5@sirena.org.uk>
References: <20220603142340.42271-1-jensctl@gmail.com>
 <6dae1c9d-89be-e1e5-2ea6-d6dbb56b8343@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EW6z/slH+Bt7oN+e"
Content-Disposition: inline
In-Reply-To: <6dae1c9d-89be-e1e5-2ea6-d6dbb56b8343@gmail.com>
X-Cookie: Have an adequate day.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--EW6z/slH+Bt7oN+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2022 at 11:17:57PM +0200, Florian Fainelli wrote:
>=20
>=20
> On 6/3/2022 4:23 PM, Jens Lindahl wrote:
> > ---
> >   drivers/spi/spi-bcm2835.c | 12 ++++++++----
> >   1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> Your patch looks reasonable but is not properly formed:
>=20
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html

In particular:

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--EW6z/slH+Bt7oN+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKecAUACgkQJNaLcl1U
h9CQMwf5AYyqRPUWILWl9gwTdIiQUtIECNHut0oj0VTGpjRLRxnQjR88rUpdQwq8
8JOJK7rSPWwN11Tq11aM0smLfq93Wp4G3UnaYRsX/1UYRGkdzwRbyPuAL6iYbvM2
RN9BU4yKPIETxV87EeX6EPFWL3RKtjlqNs3NSAm9ty98gJJQXRMZvXmakSsTUCQQ
rnfCE2/y/ExXj3WYntAlO2Tp1iENzlAWfSgbfA7O0OtgQzCs1CvMk5nRCq3chxnb
ncgk+SQOHBoDcxRvMi1mA/jaIdDQxi9rn3/lTrXha7W2iQFXaQV9tJ9bS2HL7g1Z
wY/z6Zh5P/i+kLoLpoq0uIE/xMRB4g==
=wqOF
-----END PGP SIGNATURE-----

--EW6z/slH+Bt7oN+e--
