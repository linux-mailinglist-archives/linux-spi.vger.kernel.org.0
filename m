Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE33212A8BD
	for <lists+linux-spi@lfdr.de>; Wed, 25 Dec 2019 19:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfLYSBs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Dec 2019 13:01:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56930 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYSBr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Dec 2019 13:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bq+UAHBLC8Yr9R0oLnqOKgljdZDdLqNGM6yBAh/5KII=; b=G5VKURfpViKG43vYhpo+eMr1e
        Z5LBDMi61V+PSTSnYgw2bNDEb5B5aUFFK6mhH/oo4OYqVzhTReT5TK2Z0EEiOHlO8fmoy1wmkZKfE
        M9DG6tdAaLXtDLm1ttVb0dqM5SZndP1vi1/ueBizRHUALU7HOKhPjk42cb3dd8XIEZxvo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ikAyc-0001lO-HO; Wed, 25 Dec 2019 18:01:42 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 0D103D01A24; Wed, 25 Dec 2019 18:01:42 +0000 (GMT)
Date:   Wed, 25 Dec 2019 18:01:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 4/5] spi: uniphier: Add SPI_LOOP to the capabilities
Message-ID: <20191225180142.GD27497@sirena.org.uk>
References: <1577149107-30670-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1577149107-30670-5-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <1577149107-30670-5-git-send-email-hayashi.kunihiko@socionext.com>
X-Cookie: I have many CHARTS and DIAGRAMS..
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 24, 2019 at 09:58:26AM +0900, Kunihiko Hayashi wrote:
> Add SPI_LOOP to the capabilities to support loopback mode.

>  	master->min_speed_hz = DIV_ROUND_UP(clk_rate, SSI_MAX_CLK_DIVIDER);
> -	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
> +	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
> +			    SPI_LOOP;

I'd expect to see a matching change that configures the hardware
in loopback mode when the driver is in SPI_MODE?  There's nothing
in the existing driver.

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4DpAUACgkQJNaLcl1U
h9DGCwf8CErpoN6/aSizdxhROvbaxbMpt+6Wh6FxMDWHCl0b/S5wOEioBxEI6mnD
8xn4n0sNUZ9qnymFxuGoDrNN/qNl3UnJ9QyjxRCNg6fC6PI10I+SfzIZwe9BFDs5
RrDvozuG4OGgJbuE5BWHtaBTVP2afnzeFla+yszRxI7/j7Urg1Qlm7wUZjueXRd3
ifEjUTZNjmH3nx8+CV8WiiP0KFlzgQM/r0Gcjoj8NwW8UZj7Kepxg+XUs6vrOvwv
0i2iZwE/zFSKnDav0Whjjstv9HDwO17W1swi6bQbZanUkjzghYSLqdGOQm7vqB2r
aVLi2EgBy54qeK1Zg5zKZ56TK8PexQ==
=XK8L
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
