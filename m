Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DEC5602D6
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 16:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiF2OeL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 10:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiF2OeJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 10:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035171FCC0
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 07:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 996A061E61
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 14:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287EFC34114;
        Wed, 29 Jun 2022 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656513248;
        bh=Pf+Bei/tEyBe4TJ0ZyJJhcL7rNuHVdpyGByZWZL7VK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=navrvwZnK/zXHllIgUba/gz1oTFHo85ocWRBCaW4k2aRZ2taF3mZtIp8gSP/sio9X
         5EqrGyjyCKI7cY7NBgQ6ACvwvHndo2WNA8V4DM4IBSGhOnLGLJBvb7riaey/F7xKE7
         S2JceUr/kZt8vRlvYDYQ5pFVJhjROyXZCy2+2gDLJlWX7dFNQantmZ9Roy7jvh5xrz
         7O+dSNy+ZoEXJTZPqZumWD78jlCFZAQespn6GR82eqgmN1e4vxoDlM4Kk1qnUO6XEr
         9ym1WoFEGjDjWxnm4Ekn9pd4uGfI4MlE0DQ+HjCdLeAsWXSaMblCA5s5rTiNUBf8JJ
         vd/L/N2U88YZg==
Date:   Wed, 29 Jun 2022 15:34:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/3] spi: spi.c: Remove redundant else block
Message-ID: <Yrxi2+UkiM1T7Au4@sirena.org.uk>
References: <20220629142519.3985486-1-david@protonic.nl>
 <20220629142519.3985486-4-david@protonic.nl>
 <20220629162857.7cadc15e@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BFnJ4/+rUN12R/C6"
Content-Disposition: inline
In-Reply-To: <20220629162857.7cadc15e@erd992>
X-Cookie: Booths for two or more.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--BFnJ4/+rUN12R/C6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 29, 2022 at 04:28:57PM +0200, David Jander wrote:
> David Jander <david@protonic.nl> wrote:

> > +	WRITE_ONCE(ctlr->cur_msg_need_completion, true);
> > +	smp_mb(); /* See spi_finalize_current_message()... */

> Argh. Just noticed that this comment fix slipped into the wrong patch.
> Do I need to re-submit, or is this acceptable?

It's fine, leave it unless you need to resend for some other reason.

--BFnJ4/+rUN12R/C6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK8YtsACgkQJNaLcl1U
h9C7cwf+NPuggYJetJE6AVPQi3AF064j5Tj+cpR8/Im4HB3UIi8ti3e+/9Sl+VEb
JRgO4L+hJhwnh1v9ps2F9rtxM92ar/x3OaUm5eDfFU/efcKo4BNabvrW2V6Ct4GB
fRLsV1g39pODv6XZ5wQeLfPUDC0s7YphI6gqOPUgCHzqGhArLv8ETrUx+zi1lo6H
agjjvcf2wc0Ol7r3pckc5EzMDF8AhVDDRuGBa92yjYuiCJlJKvCn7hBPQ67jvMjZ
np0Kd51vJ0AwehdXHEpKeT7yZIjIRcm2nI69FpTvh3PXfYGOQUA8SCkJOt3VU6Ix
O7AwusX3Xn7u6gB5n4yetXu4FzlsKQ==
=XA8L
-----END PGP SIGNATURE-----

--BFnJ4/+rUN12R/C6--
