Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AA2E9CA4
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 19:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbhADSFG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 13:05:06 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:40168 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbhADSFF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 13:05:05 -0500
Received: by mail-wr1-f43.google.com with SMTP id 91so33071951wrj.7;
        Mon, 04 Jan 2021 10:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8S8tewe09/62eDjPpJs3D9zBgFXWZxFQJnjRUdAAWOw=;
        b=fnk9U5fMY/KIYYdENtt8X9Dqns0IBfDe1H8wRZaCwTITz1aY2GikZiDaUaKk0T9C8V
         Gqb7LRNYaQC2yS0UMvmySQrE1gxLpp/gGG7lx+L8lrHO8qnJo8VObsPGE4Y49h/oIjGW
         wIMRsqdu5fZpBsX1/rA6J0OkEpcOQeAih9r9PtxjerPC+wAoindnMy2qsi5LPqprGgyA
         70Y6rty4qc/Dlsogq7rX/M7WZ6Qb4VA9TPEl1rd2T2PDwhRnMMQA7Bl/dA7wvADbjUbA
         GAscAEwNG9ZVjvprgOayc3cpe34q1FLnG+R8HIXUGowFYYYxU3wmUlUI5PXb988iqjNK
         I84w==
X-Gm-Message-State: AOAM530Ags4IudD/WYgPi6YwwctvsxTKepcZfdCgYZY181dgzfN7+K5r
        f0fNEKdPoGpraFVtsCTNEdU=
X-Google-Smtp-Source: ABdhPJxsweZqjcEuUey7yOzQqRsXiMdAFnIN0VPVz/rrVT7WWjb1mgbbACPLDub4i58vK3KdWgdMWQ==
X-Received: by 2002:a05:6000:ce:: with SMTP id q14mr79938608wrx.277.1609783462724;
        Mon, 04 Jan 2021 10:04:22 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id c4sm142108wmf.19.2021.01.04.10.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:04:21 -0800 (PST)
Date:   Mon, 4 Jan 2021 19:04:19 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        digetx@gmail.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        yuq825@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robdclark@gmail.com, sean@poorly.run, robh@kernel.org,
        tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, stanimir.varbanov@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        lukasz.luba@arm.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rjw@rjwysocki.net, jcrouse@codeaurora.org,
        hoegsberg@google.com, eric@anholt.net, tzimmermann@suse.de,
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
Subject: Re: [PATCH 23/31] memory: samsung: exynos5422-dmc: convert to use
 devm_pm_opp_* API
Message-ID: <20210104180419.GB26189@kozik-lap>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <20210101165507.19486-24-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210101165507.19486-24-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jan 01, 2021 at 04:54:59PM +0000, Yangtao Li wrote:
> Use devm_pm_opp_* API to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
