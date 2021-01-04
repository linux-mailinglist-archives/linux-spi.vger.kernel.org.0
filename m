Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C20C2E967E
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 15:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbhADN7t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 08:59:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbhADN7s (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Jan 2021 08:59:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F00220770;
        Mon,  4 Jan 2021 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609768747;
        bh=oAmb65NYH72MQStk3VaVbGlppJznbNt2cArcbsPTQcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHS8gGbh9dNUQe4WMvhK/m2XPS+6hdEkfpYdNdSAq5F5FoNaAgW4OBMLdogt4PlMZ
         0owqku0gRhayi6vNM2OwKxXh4BRxz3nZVLwlaZ+spR/7Kaz/eO91UxFD+Gjdm88bKM
         jhbtaXUe9H+xEf8aYkQk7np+nTDd+QSWF0mLzWEYykQxJrDUsjg8rSmePf4X6QdP4d
         DbPFJjV5rqsmmZx+7sd/m9xkeoRVwB+XCzQh7n76FixJZI2Y7qJwkzv34hDPfZoD2r
         c6JjG0u9Y4MIozR8Hz2zQTzUpbqGcFS6iPKmT+CL8SNTyBz3rbYmmqLY5MWtxtru3X
         cQiqUfTF80NuQ==
Date:   Mon, 4 Jan 2021 13:58:40 +0000
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
Subject: Re: [PATCH 08/31] spi: spi-qcom-qspi: fix potential mem leak in
 spi_geni_probe()
Message-ID: <20210104135840.GC5645@sirena.org.uk>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <20210101165507.19486-9-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <20210101165507.19486-9-tiny.windzz@gmail.com>
X-Cookie: Stupidity is its own reward.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 01, 2021 at 04:54:44PM +0000, Yangtao Li wrote:
> We should use dev_pm_opp_put_clkname() to free opp table each time
> dev_pm_opp_of_add_table() got error.

Acked-by: Mark Brown <broonie@kernel.org>

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/zHxAACgkQJNaLcl1U
h9AFlgf+L/LzmrwnlPEvAiV70bJdryKYNIVHhDTji4GNiw5bc3Fz7A6gxBdDd/Jn
1qI57uFUYX5WyZ7Avao2gi+jL5EWVJgldsdHEHrlzqSUgK2x9xrgSV9u4JquS45Q
seFNFtiOh4nAG2I+4V2JWPoQIRWTv4kXzhxOuwTRNZZuW6kHLzTJGUOtXpvSKWvp
hMqDoVpnnWcyf6WKVAQCPiA8X3YX+UsIiWNVv1RCwnc8s7/g4i3sXQYnvslK/7L6
vE8FX9MChPQrDewpSlZuH+TLRCMEki6IyGVTdeY+SbwrVQQNavBrAvEH4MGOefoh
qVdPCyIrmbbWYXhYjynDSBxCC9VgJQ==
=DvyL
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
