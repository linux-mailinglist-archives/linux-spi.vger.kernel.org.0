Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15672E96AD
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 15:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbhADODd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 09:03:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:42146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbhADODc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Jan 2021 09:03:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E55CD22241;
        Mon,  4 Jan 2021 14:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609768971;
        bh=cjvypTeXkdOG/wGebkbRyr2S77+u7rAr75FfrW0xa3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bm5aX9+92ww4jyTAcgiQK/3InHngR3u7Bf4Fyww8v2yTKG2kO3xTJLW/ZxA2X4l+w
         LIqonA7x3lYVlyxMEDjl+xIIRrNrrxJgoPyGHDdNqJULwde/tiXeT8tBOUcVdsnjpl
         BqsCVaImc9h2SDyEARthIdw2QC/WbLqMHwHo3Lv/vDa4xEdkmEO2Ow+EBbTvOjUCRg
         OTSIezonhyS241uJ4Nh8sfUfxiVhUdgVJ+lVoVxGKpiPiibdHqsUt6rwE7oxiFOnG0
         RTMQaO/WGUyigZgdtaupm74hL/9Mv6ZXMq5X9ql1Zphrx+BytBYOYOL9rZjpsBjCT0
         vF6DKOEp3CZeg==
Date:   Mon, 4 Jan 2021 14:02:25 +0000
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
Subject: Re: [PATCH 13/31] spi: spi-qcom-qspi: fix potential mem leak in
 qcom_qspi_probe()
Message-ID: <20210104140225.GE5645@sirena.org.uk>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <20210101165507.19486-14-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
In-Reply-To: <20210101165507.19486-14-tiny.windzz@gmail.com>
X-Cookie: Stupidity is its own reward.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 01, 2021 at 04:54:49PM +0000, Yangtao Li wrote:
> We should use dev_pm_opp_put_clkname() to free opp table each time
> dev_pm_opp_of_add_table() got error.

Acked-by: Mark Brown <broonie@kernel.org>

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/zH/AACgkQJNaLcl1U
h9D/CQf/WT78Nop+3p+ORGoE4mDvVT5d8AmHOyLMsyM0nJeGHW0T18/rtZQUAmNl
GEjHrJ2z0iZaV9JLLk1ifDvgRhTVQi1WHJRhtrJSGdj9NxTs19Q9M3aKHMxCGXw4
maMVT2zyD7ym/wkY7JQDno+lQv890JF1AmQdZAYGW1x/wuVDbSonhUXXFKZPXe9/
3Y8Ak9eawLXB0td0Sy/Qc40jojaeTr3beKYkMYskRqkARl+JRC4geB+mJD2GNplb
OEK5pHfrqSLG7czW4m6iP2BdeYKMJbAycIRYoi8DBzUs7ttd7gZHOdDq94nGY76m
S1IHnh+QgsXcCfp7pkE/486jjH0ylg==
=G6ph
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
