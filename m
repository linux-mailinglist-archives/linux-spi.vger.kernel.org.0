Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857E8578263
	for <lists+linux-spi@lfdr.de>; Mon, 18 Jul 2022 14:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiGRMd5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 Jul 2022 08:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiGRMd5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 Jul 2022 08:33:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5EA5FF7;
        Mon, 18 Jul 2022 05:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 331F3B80F79;
        Mon, 18 Jul 2022 12:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4792DC341C0;
        Mon, 18 Jul 2022 12:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658147632;
        bh=pBFI2m2eAaRkulcEqTijxnzeyD+kWLx1e1S2e2czNuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sH7KNQASv8ORAY5dJA7waLOkPXM5+1GWn1U8qpFYmDk3AHB/wUsFK2H6eU9JQMfif
         rCixFcPidnwVcCPPiF51Vpfo2Pq1RgwY5b/Em97h3wHYtKVs/OLi/DY0IPDsYbb9Do
         I7VUd7rb5ELyNm1QaybSIn8ecHOrKFQrGQGQUqxpl0UPvh/CH+Ijp1MI/DtWykTvUk
         j+EZXyBOaiyzUpb8cScH6ttJgoKTBJZ+UaWlrQ4wKzLEIpb+SsxNaJCOQXnc1dCIZF
         kVcLQTMpGdfwoe/9jMCONP6tbZ7wdisGLZXoiJa6GveNFtAnSyOS1a14GY26BI3xFs
         KC+v8VA4GrH6Q==
Date:   Mon, 18 Jul 2022 13:33:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] spi: spi-rspi: Add force_dma variable to spi_ops
Message-ID: <YtVTK6Y9QRBuJPr9@sirena.org.uk>
References: <20220716153934.292311-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fKNm85Acx/utvWsU"
Content-Disposition: inline
In-Reply-To: <20220716153934.292311-1-biju.das.jz@bp.renesas.com>
X-Cookie: The greatest remedy for anger is delay.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--fKNm85Acx/utvWsU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 16, 2022 at 04:39:34PM +0100, Biju Das wrote:
> On RZ/G2L SoCs switching from DMA to interrupt mode, causes timeout
> issue as we are not getting Rx interrupt even though SPRF bit is set in
> the status register.
>=20
> But there is no issue if we don't switch between interrupt to DMA mode
> or vice versa.

So we need this for correctness until someone can figure out what goes
wrong :/

> Performance comparison between interrupt and DMA mode on RZ/Five SMARC
> platform connected to a display module shows that performance and
> CPU utilization is much better with DMA mode compared to interrupt mode
> (1->65 fps) and (98->8%).

How does that look for something doing lots of short transfers (like
register I/O for example), and what's the throughput like?  DMA probably
is the most sensible default even so since the impact of doing PIO for
large transfers tends to be so bad, you have to be doing a *lot* of
small I/O before it gets to be a problem whereas basically any large
transfer will notice PIO.

> This patch introduces a variable force_dma to avoid switching between
> DMA to interrupt mode for RZ platforms.

Not that it really matters but it's not a variable, it's a flag in the
device configuration.  I'm wondering if we might want a way to override
this at runtime in case someone does have an application that suffers
badly from being forced into DMA (eg, some IIO thing), that could be
done incrementally though.

--fKNm85Acx/utvWsU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLVUysACgkQJNaLcl1U
h9BC2wf9EeVH48TIA2zDA+JSZPmzmPVpozBTPwJ+ku7Gcpc5jwIVTj+uTxC9vjix
OoQVbdWk4mBfAlsS1YnYFx8Mr3SXP2YM2k8YTVmkddcCHoXbqmoPt+XakhtIg0it
4wZXAYl/N01b83QMnozgdcg0vPt3Jh7tFURgbgToYX0IuqHNfQ5Tnh2SS6JAURoC
C3f/NubwlSGqKYnHqiM87H9pjxRKVM0dhoq4CeS4VKDz1ITw71lHe4WD1+N6sG/6
uurZX+/3YCVbN47PYJdvcnLRLXa5WV1LHN67xYQyG0jxCP4wUzLIKDEpc1Dp3cVx
ARBOnsUswaMkB3gv7ZoF5sj3S9CF8Q==
=2TS2
-----END PGP SIGNATURE-----

--fKNm85Acx/utvWsU--
