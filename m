Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83BD55FEBD
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiF2LhF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 07:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiF2LhD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 07:37:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251E4FD34;
        Wed, 29 Jun 2022 04:37:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A76A5619AF;
        Wed, 29 Jun 2022 11:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE976C34114;
        Wed, 29 Jun 2022 11:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656502622;
        bh=dSIdq7JC6ZEBfIR3l2QmQJOHZZDgsMua0zlvIzt80VI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IV64jujEl1lfHCsDBW591Z3BuiCMrIU1O+WBuUGXrYJCNxyJjoJttqABwpFMZ3Y81
         hFgcFrRiBEfZ79QE0+MzKYtiLyU0qTgQq5hm8iOxqNhI0IOxEnpjZV37yn/2P0qkME
         uwtMyolDR98EaqjZsUdOPDFMuxIgi+yYB9RCZy6SJ69jtsyHqDoLzDkmcxfqyCkMod
         ZonjXv/6q4AiNDqGREDG36d4clUnuH1uY0tbpFNnBJrFC66UeZVdoEj/X2L3fUVQvi
         QKQx/AyuetBLk+hSJnkXVLgBvo3+6z370tYOGoY6Mdr/h5byfIStAK6WjrqdadfPlZ
         4pl75ifwn9iwQ==
Date:   Wed, 29 Jun 2022 12:36:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] spi: s3c64xx: support custom value of internal
 clock divider
Message-ID: <Yrw5WKWq6sMEKBmn@sirena.org.uk>
References: <20220629102304.65712-1-chanho61.park@samsung.com>
 <CGME20220629102527epcas2p42e99f44d529d215623bd0e12a082d1dd@epcas2p4.samsung.com>
 <20220629102304.65712-3-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HAtCNg6OqyvUsmZi"
Content-Disposition: inline
In-Reply-To: <20220629102304.65712-3-chanho61.park@samsung.com>
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


--HAtCNg6OqyvUsmZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 29, 2022 at 07:23:02PM +0900, Chanho Park wrote:
> Modern exynos SoCs such as Exynos Auto v9 have different internal clock
> divider, for example "4". To support this internal value, this adds
> clk_div of the s3c64xx_spi_port_config and assign "2" as the default
> value to existing s3c64xx_spi_port_config.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--HAtCNg6OqyvUsmZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK8OVcACgkQJNaLcl1U
h9AXKQgAg14h9aGv1DqGvTWdAbzqKiPCrC+YB/liN+o0njPpCkRImRxdJePYOZMC
rneJPQfxB4/o+cchNoMZ1c9j18GOeg2eunlGA2PZ8T8ZLq7j8b0F0b4smTquLJiY
QmSR1kO/Ml+3dlG9Ct/iW2MMoWIEBVpl8jN/oHhr6PcHMAJ6xCTEIgap78HwV7XP
0IL+i0NfvKI7KzB6aXgQj+06JPfdoo29e8sn+skc2M2lQGJcnCHnPSMUjZKkOkB2
KNDO3Ur3bAh+CVdfpzgrcOaH5l7Y3tlGdfnrrlypYU5hcN4LGeich8y3m3ROYUfD
hefzVZwI+AGqT5gaimihDj27rxsyqQ==
=+CO7
-----END PGP SIGNATURE-----

--HAtCNg6OqyvUsmZi--
