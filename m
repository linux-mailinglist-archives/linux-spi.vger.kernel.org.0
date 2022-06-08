Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3312542F37
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jun 2022 13:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbiFHL30 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jun 2022 07:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238031AbiFHL3Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jun 2022 07:29:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE6F27B38
        for <linux-spi@vger.kernel.org>; Wed,  8 Jun 2022 04:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79734B826CF
        for <linux-spi@vger.kernel.org>; Wed,  8 Jun 2022 11:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D6FC3411D;
        Wed,  8 Jun 2022 11:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654687761;
        bh=lwIeD33ShHABnZVGyL9lQCmXitxAaMIo8+M1NzttA/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePpFjVKalMmDcMf5JMt+Da+V0fcT1JXtlMQ4Tpi23jf8VhAfHEUBtSMQSflso4i65
         XGeDya0tYuTdNPl7qYS/nfM9lUTBe/dgtx2G4azl7KnC3HX9pY6AKkiVPGmfJ/y8r2
         VYor2uzKjHHmGYBRrHtHdlgrVRsG2cCngtecseNtQbGtps1a/yb0ppz5SshrAaEwCu
         qTktKOdm8059ezTmcTM3PxrppbUXzmo/VPYKaUUt+FIvctTxl5JL9Vzm5oGp58obrE
         oUrotCGHjYDEf1l57XWpfdP6yee8kyoBJVTbyBma14L2y8JM9yM1UyCu/L54DVl9IC
         +YVjIPTArZDQg==
Date:   Wed, 8 Jun 2022 12:29:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] [PATCH 3/3] drivers: spi: spi.c: Don't use the message
 queue if possible in spi_sync
Message-ID: <YqCIDNHjFP4p9xxs@sirena.org.uk>
References: <20220525142928.2335378-1-david@protonic.nl>
 <20220525142928.2335378-4-david@protonic.nl>
 <20220525164603.57c98a0a@erd992>
 <Yp+ZX4XITW7bQtjn@sirena.org.uk>
 <20220608095409.2d8c46fb@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SRpF9rrOhoFLKTEx"
Content-Disposition: inline
In-Reply-To: <20220608095409.2d8c46fb@erd992>
X-Cookie: My NOSE is NUMB!
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--SRpF9rrOhoFLKTEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 08, 2022 at 09:54:09AM +0200, David Jander wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > Moving idling (and all the was_busy stuff) within the io_mutex would
> > definitely resolve the issue, the async submission context is the only one
> > that really needs the spinlock and it doesn't care about idling.  I can't
> > think what you could do with the io_mutex when idling so it seems to
> > fit.

> Ok, so we could agree on a way to fix this particular issue: put the idling
> transition into the io_mutex. Thanks.

> Looking forward to read comments on the rest of the code, and the general idea
> of what I am trying to accomplish.

I think the rest of it is fine or at least I'm finding it difficult to
see anything beyond the concurrency issues.  I think we need to do an
audit to find any users that are doing a spi_sync() to complete a
sequence of spi_async() operations but I'm not aware of any and if it
delivers the performance benefits it's probably worth changing that
aspect of the driver API.

--SRpF9rrOhoFLKTEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKgiAwACgkQJNaLcl1U
h9Ce+wf/f9trDGpZqVrEKczrcb0nr83flVPJo+gPjBMJz/wZ/u0s8nLpWfgN3jb6
Ha6Va4+hNsxMqvWZJNsG46rGtQV1sfmWXn4Knr1M8q4BAqmQFdgiGipqY9K1k/3I
iaIqVcwIvCPm+8DV8RT6nEEsuGI4I2xeGDJxAs6Co5/IA62cVJ31WOr5n1dHVdnQ
B9EHYJRm25fkBjMayZfXGwshsbOvteStZs7xPapg5KRy8DBoznfetonthRzLu/xy
punJ997pIhqd3IFq7tOtH6aBgwHg9yKDswoVomuGcXvxG1CWI0wp42H/vq+S58t7
YEYcdGouP3sfIS9o069dq+VHQIQt4Q==
=XOr0
-----END PGP SIGNATURE-----

--SRpF9rrOhoFLKTEx--
