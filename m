Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5742E9C9D
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 19:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbhADSEb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 13:04:31 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33517 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbhADSEa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 13:04:30 -0500
Received: by mail-wr1-f51.google.com with SMTP id t30so33120348wrb.0;
        Mon, 04 Jan 2021 10:04:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h59iCiKuH4MXgrWgjRBSHuWSpOxsm5xD8Y4CubrF3xU=;
        b=O9Z7vxMRaKMI5t4T35bv5YGBkatCDU5eq6r98qh3QvpeHWzlSAfvYP2gdGrDnTdeX+
         9lFgK7c3VNoEmv3n0ooUqk/U/D//wbRrsJXgu/8hTYxbBT6jMKF2yD7oRNOYkIrred+Q
         A36TcezbQKk4ldEN+dINQfU1JnD8ruELUrhvrFMbrHBc7derBdzkFgqYLmy3BtozESqV
         FrYJR/DbD1nUP5Ci0TkvjufeoMcmg11E5E4KZqE8kJguHszQEotflCChxM97xswkECSV
         E+gqqo2wMwSHM0FkvYPrWsR+Qc9N6IKAUY5odPzhSPLQuiFFn0ECjTZW7KfMPAGot3Jg
         IJ6w==
X-Gm-Message-State: AOAM530djHhjb46cspfzZL3CaJe+iYSF6jgIPNXImY1JNTtHRPCpTaS1
        44cf+ZLNZ7z9omWXlgNTfzM=
X-Google-Smtp-Source: ABdhPJxrRN4zoC9ySCl3+E0igqJkr5f1LUevrs1pugc92rcCWGC8YwtDgiDHvDzkbPEnhGyP6UumfQ==
X-Received: by 2002:a5d:58fb:: with SMTP id f27mr71674294wrd.22.1609783427686;
        Mon, 04 Jan 2021 10:03:47 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id w8sm92329342wrl.91.2021.01.04.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:03:46 -0800 (PST)
Date:   Mon, 4 Jan 2021 19:03:43 +0100
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
Subject: Re: [PATCH 22/31] memory: samsung: exynos5422-dmc: fix return error
 in exynos5_init_freq_table
Message-ID: <20210104180343.GA26189@kozik-lap>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <20210101165507.19486-23-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210101165507.19486-23-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jan 01, 2021 at 04:54:58PM +0000, Yangtao Li wrote:
> We can't always return -EINVAL, let's fix it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

I see that the next patch depends on it so feel free to take it via PM
tree. Otherwise let me know.

Best regards,
Krzysztof
