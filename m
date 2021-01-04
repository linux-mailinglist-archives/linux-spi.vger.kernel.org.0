Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44D92E96A2
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 15:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbhADODO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 09:03:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbhADODN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Jan 2021 09:03:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD9FD221E5;
        Mon,  4 Jan 2021 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609768952;
        bh=7O9rySo7gpkGBGcZjW56xW7eV0Uk+H7xThUa0qWLzDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/zOmdXAq85M8tJ2IiEaNABfCT1npR2zl/t5YsxWwDsZXhuRU5H6qiPpRyZVo62aC
         9c6OnbAEp9cNsFq5HoJNyWd2t3jeJmgZincgUCdna0+TwYfZ8VAYqJjw1M39u8CRNO
         IRrxBMe7IAybeNtnDDhwyvX+kmZ5wWxU0FOSfdHJ05vb6n541syUtZ1k5MF9a1dRCI
         nnRTjlzY+wgmCl111uSOVDUbEGaHldeYtRBWRkGhH17HcUtOmWJmhNeW7+37GvQtMq
         VK7o4Wju5LjFBm5QAXXytwh1rN/19RNjNe1wgUz9INVwKUx0HsZ0/eb6VP27LO6gi9
         kWS6/ZtqOhQdA==
Date:   Mon, 4 Jan 2021 14:02:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, digetx@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yuq825@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robdclark@gmail.com, sean@poorly.run,
        robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, stanimir.varbanov@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        lukasz.luba@arm.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        rjw@rjwysocki.net, jcrouse@codeaurora.org, hoegsberg@google.com,
        eric@anholt.net, tzimmermann@suse.de,
        marijn.suijten@somainline.org, gustavoars@kernel.org,
        emil.velikov@collabora.com, jonathan@marek.ca,
        akhilpo@codeaurora.org, smasetty@codeaurora.org,
        airlied@redhat.com, masneyb@onstation.org, kalyan_t@codeaurora.org,
        tanmay@codeaurora.org, ddavenport@chromium.org,
        jsanka@codeaurora.org, rnayak@codeaurora.org,
        tongtiangen@huawei.com, miaoqinglang@huawei.com,
        khsieh@codeaurora.org, abhinavk@codeaurora.org,
        chandanu@codeaurora.org, groeck@chromium.org, varar@codeaurora.org,
        mka@chromium.org, harigovi@codeaurora.org,
        rikard.falkeborn@gmail.com, natechancellor@gmail.com,
        georgi.djakov@linaro.org, akashast@codeaurora.org,
        parashar@codeaurora.org, dianders@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 09/31] spi: spi-qcom-qspi: fix potential mem leak in
 spi_geni_probe()
Message-ID: <20210104140205.GD5645@sirena.org.uk>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <20210101165507.19486-10-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline
In-Reply-To: <20210101165507.19486-10-tiny.windzz@gmail.com>
X-Cookie: Stupidity is its own reward.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 01, 2021 at 04:54:45PM +0000, Yangtao Li wrote:
> Use devm_pm_opp_* API to simplify code, and we don't need
> to make opp_table glabal.

Acked-by: Mark brown <broonie@kernel.org>

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/zH9wACgkQJNaLcl1U
h9ABnAf8D9GWSbGll0wLN+abwwbCA4u4yPNtTRXQHQDVYsk5D7ApQVQwwIhyNvq5
js2y6K5nPeBr9r1BRF2z7H+VRvaMWLvlUK+4stYm+8W9f3DYNW64t9fwEBhJTxns
L6uYyziisTQS9dyaG2PfoGu20FbRtlUOlmovkH+4U5m4DEyBcceV5W6VbLpmqL+b
Sy4al8lmxI/g+yt+JaoidpG5zUVEMqYkfQYzafcANsoBz3D6Sb16huLkFohCwCMS
83MEnCvIs9aybc9Jae6D05gp1B92htOwfFKQPnNkLI6OEYKMwfwsEZYqM8bnUasx
Krd7vSYzjQKkG0P2IjKXw2LDZUytIA==
=Y1aS
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
