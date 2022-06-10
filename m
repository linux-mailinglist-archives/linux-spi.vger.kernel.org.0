Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2CE54663D
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jun 2022 14:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbiFJMEr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jun 2022 08:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243556AbiFJMEq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Jun 2022 08:04:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5553EB97
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 05:04:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07D056216D
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 12:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B73DC34114;
        Fri, 10 Jun 2022 12:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654862684;
        bh=Y7U05lDA8BRgzCDC/Tmj1GEdicb87DiN3T0aBgPmwE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NI9tynBf3FiwPQbJrhwd2bfGp/1vw7iRkNSF/OxeHNVuGSZ3OObIIO98rsftOQGi2
         hCeUjoM+HM2DyqsiNxCLheR4JKGxJhyg7F8m14Z+Q6J/pt82P6NZi418drYs1JwW+O
         TN/+CSf8y5AUI2WVdCROYrQMp+JNHmRYsqtAMKHDpyIxt7IaZxbNFVXCZ4Wm+Rhuby
         ykQLhHIywt4MrVxLUG86oALYhgmmUqlNj/piEb+8iU/clJyBNzBXoC6TvnXfE5x+4r
         ZbmGaadUcIYWuKQRtpg915adYImB6TXevN/H8+sAamhh+4fdunhxZQ8vMnGfY30QoA
         UD8jUXil9jW9A==
Date:   Fri, 10 Jun 2022 13:04:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Chiu <andy.chiu@sifive.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        Greentime Hu <greentime.hu@sifive.com>
Subject: Re: [PATCH next 1/1] spi: sifive: add PM callbacks to support
 suspend/resume
Message-ID: <YqMzV/kXeHso3QW+@sirena.org.uk>
References: <20220610074459.3261383-1-andy.chiu@sifive.com>
 <20220610074459.3261383-2-andy.chiu@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="padlAlf46HdwYK6i"
Content-Disposition: inline
In-Reply-To: <20220610074459.3261383-2-andy.chiu@sifive.com>
X-Cookie: Teachers have class.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--padlAlf46HdwYK6i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 10, 2022 at 03:44:59PM +0800, Andy Chiu wrote:

> +static int sifive_spi_suspend(struct device *dev)
> +{
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	struct sifive_spi *spi = spi_master_get_devdata(master);
> +	int ret;
> +
> +	ret = spi_master_suspend(master);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable all the interrupts just in case */
> +	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
> +
> +	clk_disable_unprepare(spi->clk);

Seems like the clock managemnet could usefully be done as runtime PM
too?  In any case, that can be done as an incremental change.

--padlAlf46HdwYK6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKjM1YACgkQJNaLcl1U
h9CpAgf+ICpsIexQGWxgh/zE1CZJy/k0JC6GLWHRVLjR6HBCGcB/HzaZ3uspueEP
HfglvPUC2qXkO45fodYPfXMb1ByQtDXnQPBBwLZVKNUD+BLD0jlQogYK6PynhTj+
XA4+1FZG0hsfy/68yPu5eM+5GpcHsQkxXYWryRIznz4IiX0S8vY4hoxnbTYGHiFy
N3PJG3eRrmOolV1Oh6oqXt14UqXPgb5QBee6U8Cd/MJaQdu98Pvez02kvVRlEloc
YLrpxLscFWt/W36RHr5+hpCYh6r98hgsSKNjxgIyRnYrFChvWri1SC8J53GvuzFK
TalUGA+3s+6cPsTUJhqbC9wShj+fZw==
=sTjx
-----END PGP SIGNATURE-----

--padlAlf46HdwYK6i--
