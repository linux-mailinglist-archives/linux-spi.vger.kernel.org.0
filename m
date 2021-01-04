Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50CA2E96C2
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 15:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbhADOGO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 09:06:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:42728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbhADOGO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Jan 2021 09:06:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E752D207BC;
        Mon,  4 Jan 2021 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609769132;
        bh=79TsA1bA8DKt3n7SY5XnXtm3knysfw0cfWKMLdkrzAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHN9zNRZrzzhE+ofXqwGY3v8yznfietvgJMSpIw+/Hb+3GY0GuhJL7mLLW9bt9kcZ
         PxcqgpZD5FhAKNG8I5jGEXGBvLQpBmco8xGjMnaIc4EebNiLVje0BlJWOj45JL0/PB
         vxtEJY5OhIuVTA6E/Lui4XNWCjztT9yf7D3//WPmqcmmDQBgRTjNFYUHE+LDDdYS2G
         vDbXQowhqqzHV+4MYe0UswMc695n3mCySu0MBMSim5Ss3EsWmxmlkITnnS4eNLG3ZK
         qcONCWIJbRc577IYCOT74XxUKKbK+estp/16xd1zq3Gyj1t5BuDxRAMQebZh9HQ2Px
         ydgmSJ/nP9dUA==
Date:   Mon, 4 Jan 2021 14:05:06 +0000
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
Subject: Re: [PATCH 14/31] spi: spi-qcom-qspi: convert to use devm_pm_opp_*
 API
Message-ID: <20210104140506.GF5645@sirena.org.uk>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <20210101165507.19486-15-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline
In-Reply-To: <20210101165507.19486-15-tiny.windzz@gmail.com>
X-Cookie: Stupidity is its own reward.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 01, 2021 at 04:54:50PM +0000, Yangtao Li wrote:
> Use devm_pm_opp_* API to simplify code, and remove opp_table
> from qcom_qspi.

Acked-by: Mark Brown <broonie@kernel.org>

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/zIJEACgkQJNaLcl1U
h9DFeQf+IHePH8ftvRUXVVunMDt5ucIZpHjc+KGKU8AM3jyZ+Xyy7jpftefB54+O
D0zp7MZ5qmBT4HlKD4cibZcvesuW18PPYrUMXVV3H8MuTBZMfvl+XDsWm0NvMjE+
mG+w8bSqPUM9Mjo5wa7UN8bbEjHzNtPZt0lUNfN+k0NGXJ3XhN5WtH3eGXQAPaIn
o5aKfPOue5R/hIy2XhK9W7VLqa8NwnhL7tCfYme/Eto/F4ygM/JVeTwdMOeKe3Gi
SeDV7n7fe5oPecANOGYXE6gdO2c7oAcJl36gxh2rjpz/yGyCykjmHBxU/YdSV3Jk
T8oGZSZjqmlT+HfPp7aRXPMXmf3ncQ==
=ApdX
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
