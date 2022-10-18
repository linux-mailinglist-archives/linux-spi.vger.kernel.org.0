Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF07602C42
	for <lists+linux-spi@lfdr.de>; Tue, 18 Oct 2022 14:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiJRM7S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Oct 2022 08:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiJRM7R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Oct 2022 08:59:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86165C511D
        for <linux-spi@vger.kernel.org>; Tue, 18 Oct 2022 05:59:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41CFCB81EDA
        for <linux-spi@vger.kernel.org>; Tue, 18 Oct 2022 12:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C2BC433B5;
        Tue, 18 Oct 2022 12:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666097954;
        bh=109qq1tubfFjNFpjoLU6amj+t3xzSQAqLuBRqvsltdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3DberEXzd1UcedDPxBO9i1bGqfzkWJ7oU0Nxp6HejHzl2jBpH9I9v78l+WInvuBK
         kNBdXKAAFLCQYEkd69weZ7697dD3KyimiyYql8PNxVhL9+bEaHO52OAt7oc8QPFZN8
         Qaf0wp85cP3kKwIj5Y+B4tU623H7cKSBzbtMMAGrCV3OFKBXtG95Z1qLs31K2VAawa
         QegMu7y4Nok6IfEabYYlD5XEBoPIlCWxp5p+4Fv1418JQdkKzUd8e1pZBqxs1ELgyZ
         ALic1w4qkdJ1PHs8dlSnszT9NzLlSW63YMFW322SlIU00UbbWlqU09bQcEV09MyJVM
         pMa9d+p8IhPLQ==
Date:   Tue, 18 Oct 2022 13:59:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chris Lesiak <chris.lesiak@licor.com>
Cc:     linux-spi@vger.kernel.org, mkl@pengutronix.de,
        s.hauer@pengutronix.de
Subject: Re: [PATCH v2] spi: spi-imx: mx51 support for more than 4 gpio chip
 selects
Message-ID: <Y06jHXWW6UfZ1YjS@sirena.org.uk>
References: <Y01BSOOv+KZ6ndMl@sirena.org.uk>
 <20221017135403.1384999-1-chris.lesiak@licor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JBw4Yk+ViRuUnRkn"
Content-Disposition: inline
In-Reply-To: <20221017135403.1384999-1-chris.lesiak@licor.com>
X-Cookie: And on the eighth day, we bulldozed it.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--JBw4Yk+ViRuUnRkn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 17, 2022 at 08:54:03AM -0500, Chris Lesiak wrote:
> The MX51_ECSPI_CTRL and MX51_ECSPI_CONFIG registers have bit fields
> that only support the four hardware chip select channels.  If we are
> using a gpio to support chip_select > 3, we need to be careful not to
> write outside the bit fields.  Probably the biggest issue is the
> 2-bit CHANNEL_SELECT field of MX51_ECSPI_CTRL overflowing into the
> BURST_LENGTH field.  That will likely cause a DMA TX timeout.

This still doesn't apply against current code, please check and resend:

Applying: spi: spi-imx: mx51 support for more than 4 gpio chip selects
Using index info to reconstruct a base tree...
error: patch failed: drivers/spi/spi-imx.c:253
error: drivers/spi/spi-imx.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Patch failed at 0001 spi: spi-imx: mx51 support for more than 4 gpio chip selects

--JBw4Yk+ViRuUnRkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNOox0ACgkQJNaLcl1U
h9Aqlgf/XmW0JPyXZUXFwR3UXtacxMrA+8Sn4J6Wp0vusQhqxmRZc+ZfOez/6ylc
kkmnpKatwIBGgfJ2G0rFu7VqEVTzhHjaueTqyANsriHA7SpxXaxrp9dn2dUjC+Ia
3xoe9BnwIqX+Lb0lS1l7xOO6gO7f4i3iesQhvGw2tESCpp3ZoNXfHSRwZxBJasQt
mrGjQbYne//kgYfrEhD7q6cMXy8WQDKBoOEv3TYCKCRc/+epNJQTpNprSG5gjnzm
sC7FNgrrGlm8PX9lRj31Al3z3zNSscN/Iv628D9rclAULFG7OQnBRFvNi1GAVSrt
Kj0QVACNeZgWtcuF97Eoe5GyhI53aQ==
=kinf
-----END PGP SIGNATURE-----

--JBw4Yk+ViRuUnRkn--
