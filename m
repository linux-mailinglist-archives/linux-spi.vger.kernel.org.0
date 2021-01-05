Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469672EAD37
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 15:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbhAEOQq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 09:16:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbhAEOQp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 Jan 2021 09:16:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87DFA22AAB;
        Tue,  5 Jan 2021 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609856165;
        bh=CLVMjissewD5ZdHzTYCaSNI7ZR8xFCiUY8G4oTJC+V8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5lPIZw0Y4PQa+oyffi7WVuBTNZIJYMbhOb0Xx+wZv3DqMSjDes4Fvm1TfTlOr9YI
         zTJTAO6G4SWFU0DL0XiFt5lbevHWdxg2kx/6uAh1XX+3zRR0rn5IxCbUwJpqg7//Hs
         z/SlKPtkx7xRwYx20L6JNvYrwSkVnvBdCu8q6bJ4BXkvhZOV19lwmMeqXvuwlSncGb
         O7Z9cdOZaM4aFeRVNTppg3vBFlkbSvhXIxblsyxB6qYYt6gILPfcYO/3+5+fIffX8/
         JKkKCeMq3Ulym3Erl4yVuK1LzjONq49nMI0qKIBbfLSZLweklMMhtmFtBqgNLqG0JB
         NM1G9qJJwVkzA==
Date:   Tue, 5 Jan 2021 14:15:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, yangtiezhu@loongson.cn,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] spi: LS7A: Add Loongson LS7A SPI controller
 driver support
Message-ID: <20210105141536.GD4487@sirena.org.uk>
References: <1609124381-9107-1-git-send-email-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <1609124381-9107-1-git-send-email-zhangqing@loongson.cn>
X-Cookie: I'm ANN LANDERS!!  I can SHOPLIFT!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 28, 2020 at 10:59:38AM +0800, Qing Zhang wrote:

> +	if (!!(spi->mode & SPI_CS_HIGH) == enable)
> +		ls7a_spi_write_reg(ls7a_spi, SFC_SOFTCS, (0x1 << spi->chip_select) | cs);
> +	else
> +		ls7a_spi_write_reg(ls7a_spi, SFC_SOFTCS, (0x11 << spi->chip_select) | cs);
> +}

The core will handle inverting the chip select for the driver when
SIP_CS_HIGH so doing it again here will cause bugs.  Just use the value
of enable directly.  Otherwise this looks good.

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/0dIcACgkQJNaLcl1U
h9CFWAf8Drd3eCKlYj8r2/7Zu+rzTEA+cCKsN1h5sKGJ2+iTvwEnRJQoEMUE0LTc
iFwyukIuELaVLbZRBfa2LkrMxxSG1gvkAFIEKRDTQ6SuWwSZeHNGNfZe0hv6hfhi
K2ES8w+MDmqHYU3kQ/cOAZw2IhqTYk3f9VYT63Zk37xEl4osSEDhNy3St0k/yK8N
4CW/xVqxR3wkjJnPWVvcLMlzlz6kf7Np4VXSMpXKXDuRXJ/hbucJR7HPr6WCe3ZG
9A5DZ5siMMQegDGi78pZ/J4m76GIjMDUzHQ2d9hCgObTovmqVAZdUOU70MTgJN8S
IAXXy5kaSjg8VQNZ7ObNzjvooudarg==
=2jt+
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
