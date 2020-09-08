Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98420261F16
	for <lists+linux-spi@lfdr.de>; Tue,  8 Sep 2020 21:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbgIHT65 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Sep 2020 15:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730431AbgIHPfj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F172723BE5;
        Tue,  8 Sep 2020 13:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599571408;
        bh=pUEfMpq/UYZC7azZMZ5kSA/t1DHYIvIV/tbSmdkMHt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F0S8l6qu0IET3EzvZa3BeHFC0eAm7E2aMFtOGtSg4MVL1uz8Bf2WvkYY7OEOJOI+g
         zeE2vL5jNPiS75krNhH/BAAmujRDEfwUzgv3ohTAR5HKdwMAWJxGwat9vAFf1wxe4X
         hSjqMSsMuTCoX1v0XkWWt2kLar5QEeFnSbqv1oqs=
Date:   Tue, 8 Sep 2020 14:22:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 02/11] spi: sprd: Simplify with dev_err_probe()
Message-ID: <20200908132244.GA48155@sirena.org.uk>
References: <20200901152713.18629-1-krzk@kernel.org>
 <20200901152713.18629-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20200901152713.18629-2-krzk@kernel.org>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2020 at 05:27:04PM +0200, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.

This doesn't apply against current code, please check and resend.

Applying: spi: sprd: Simplify with dev_err_probe()
Using index info to reconstruct a base tree...
M	drivers/spi/spi-sprd-adi.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/spi/spi-sprd-adi.c
CONFLICT (content): Merge conflict in drivers/spi/spi-sprd-adi.c

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9XhaMACgkQJNaLcl1U
h9BD+Qf/aECmurEbZzuMemn3QkE80q0VxXmiRjrG37cSIuZiDfm3np+BN4O6qef4
jaozUFazSi1o8PpDSZtZmUuUhXIxs1TnlfIiET/a770NsLAy1CiCZcV7oIY2KWQ8
5h51M2zOavV16MTiPa3BpaNJig5ZCrrltr+cVzP8GZ8ZlQRQJxS63yHkWPEvJ6jP
N7nQ1JidLKkucxQveOxuFd8fUEajsGwJboKYBcFWL10Ga6A5aZOwNb8/fsjiu8sx
KgGKvEZgoTfhhfGX5kg6s7ZWdCRLyyaSekjAXtY6ECQL6j4RHwGcx5sHqRUKR0pS
TnET69OatkEPU5lbOiMrQS1KC+ycBw==
=hY0h
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
