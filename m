Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61615523A8
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jun 2022 20:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245152AbiFTSPZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jun 2022 14:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245223AbiFTSPV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Jun 2022 14:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD681A82B
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 11:15:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 212BC61585
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 18:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED79C3411B;
        Mon, 20 Jun 2022 18:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655748918;
        bh=nHPRuBJVm1NN8+PKV1oN3tIAyPq1vRwRDQrBQCaTiBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZHicdX3zDcqfk5N+DVE1Me3UVmvWYNzz/NBR4Ij2z7uvG43GLjqhH5rRACguNAF/
         h5h/uxPX/ovNuE8VZ8w70n8UdRi1GcMp5QMH8St3zHCLECRaXRMf+xGXF07CVdJXoz
         JBM97GFNkDE0p6tTjsOv7gCzfwGJ9vTt/Mxobd1x6c07vIAZHQHRpxBxZZ3fk398cK
         dA+KhS7D1hvYg/huKXmndPsC2Newe69LarjGZY+Y0WWeVDxKTJ3902Zda5KsY3zkz4
         eBXnwpldh68oZzkGjxkoLoG4Hr+S4JC0teUtH7VSR5s6y5VoxDOwvDNTG0D0ivCopF
         dwKkBr8zjLY6A==
Date:   Mon, 20 Jun 2022 19:15:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-spi@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC] [PATCH v2 00/11] Optimize spi_sync path
Message-ID: <YrC5MX4osVCET0la@sirena.org.uk>
References: <20220615124634.3302867-1-david@protonic.nl>
 <20220615133113.ylwenlzpkv2na25z@pengutronix.de>
 <20220615161356.21bf749d@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0uZxdYTON9ZWqaUk"
Content-Disposition: inline
In-Reply-To: <20220615161356.21bf749d@erd992>
X-Cookie: Good day to avoid cops.  Crawl to work.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--0uZxdYTON9ZWqaUk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 15, 2022 at 04:13:56PM +0200, David Jander wrote:
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> > Which git branch to use as the base?

> Sorry, forgot to mention: spi for-next:
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git

> This is because it relies on previous patches that have been applied there.

It looks like something changed underneath the series unfortunately -
I'm getting failures applying even the first patch.  Can you rebase
please?  It looks good to start trying to throw at CI, ideally we'd get
more on list review but most of the active work recently has been around
the MTD stuff which is all about trying to use hardware offload for
flash operations and therefore should be minimally affected by the
actual SPI data path.

--0uZxdYTON9ZWqaUk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKwuTAACgkQJNaLcl1U
h9Bf6Af/egYDC70MCnKfXA9upDTz3iSTU8cxQTu/lDEpBsbj8ap/hR77rGnOweXD
eghHaoq/XdksUMacTl3+6E89u6OyrqGdRf3A01EgTJ7nHcEyhbDGacLzAdo+DhqW
TBiulnb3hCq63kQLBBxYxFofeah2hF795PKY7qy+pcbj79H5zOrLoq96JXdruIs7
Alt095WqyWOlx44BhGI7Kdhmv9JHlgZVu8W1jgLQ3GRJXBgmo9kd6QiQ5J5rNKlu
z7JtuXaBrVbzvDWtUSPHsZT9QvQlRLvH8waATwgY5JXTreHoYwmqs27wEotJzEyQ
rZNf8LxaZFQnXmqTvOeZbDun8Z9o4w==
=Z40R
-----END PGP SIGNATURE-----

--0uZxdYTON9ZWqaUk--
