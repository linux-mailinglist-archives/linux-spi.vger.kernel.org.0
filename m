Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB385329A6
	for <lists+linux-spi@lfdr.de>; Tue, 24 May 2022 13:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiEXLqc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 May 2022 07:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbiEXLqS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 May 2022 07:46:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5FD62CF
        for <linux-spi@vger.kernel.org>; Tue, 24 May 2022 04:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6956614F1
        for <linux-spi@vger.kernel.org>; Tue, 24 May 2022 11:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CCAC385AA;
        Tue, 24 May 2022 11:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653392775;
        bh=YzN1II/NsmAvSRlcpenCy/NP+lY0RWiIPYkK8F18tQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltq162pEDs2KzPyOgimZNI59pWVC5FSaGWBbSioIeqohITXOBinwEEFsZTKglGS/Z
         02DwnWaPs6/4IgWm8Uhp4d4r3QOQk0Sd72NFwt4iB+axBxxybzPSbfYKFK/uf5f/xt
         mZZelHj7if/lpHRuHljjNPP+DNf0WHhq0Qnkr3f0x3kaFuxaTUPFHPOFrKJhVCZAqG
         K8BMBq7Dsn1C+X7XDSDDhqvF4+zcv2Wb3POZd7OxSBgLNAv2HTmrWndtQ4+6PRY8kx
         kf2v3P+jeOm0mqV153DKigl5a49Dzjs7BeTTF+xq/HnbGJ9QtrhAwb51JbxBiOxoAo
         Y9rL87FZD+NmA==
Date:   Tue, 24 May 2022 12:46:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-spi@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] drivers: spi: spi.c: Convert statistics to per-cpu
 u64_stats_t
Message-ID: <YozFgptOEr09+NMi@sirena.org.uk>
References: <20220523142009.2218738-1-david@protonic.nl>
 <YoukjLDGvz5kN5fp@lunn.ch>
 <20220524082506.0aa4fde6@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aWPVS3UpML6HbbIW"
Content-Disposition: inline
In-Reply-To: <20220524082506.0aa4fde6@erd992>
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


--aWPVS3UpML6HbbIW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 24, 2022 at 08:25:06AM +0200, David Jander wrote:
> Andrew Lunn <andrew@lunn.ch> wrote:
> > On Mon, May 23, 2022 at 04:20:09PM +0200, David Jander wrote:

> > >  	.attr =3D { .name =3D file, .mode =3D 0444 },				\ =20

> > Not a criticism of this patch, but this is the old way to do this. It
> > is better to use DEVICE_ATTR_RO(), but that is a bigger rework.

> I suppose it is better to do this in a separate patch? @Mark, should I le=
ave
> it as is, or do you require a "modernization" for this first?

I'd do it as a followup to this patch, that's just a random cleanup.

--aWPVS3UpML6HbbIW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKMxYEACgkQJNaLcl1U
h9CJUQf9H5lHqahB//Y4DjQiTBsJuJ5qbs905Pce23OfLElAnIqPq4seUR/0MSh6
f0OyQWRDvYsRo6oJHS4ErHAa9FeyiML9JcQjYIe5gSC75Z3XBeDuNYIWzlHmJD0t
ZwdhmvHyPLoKE28f1185bBSfeD1WrF2jf3r+CTQm+8qrrmNSEhs3G9fuYWbivwvg
vHqUU/+OYwQbSar4Sf+l7cnFetq1++3+/4KCCt42DQ1xQ9WrUBv1j5TM7HP1NznM
TZGAke3EIxk6WwZY3D+In09FggRAENA1OCvPVj/FkfOscFC63QTZTCB7PO8emSiF
cH5Kf5aF2OIfPkF70SYe5/aQjECyOQ==
=9W4V
-----END PGP SIGNATURE-----

--aWPVS3UpML6HbbIW--
