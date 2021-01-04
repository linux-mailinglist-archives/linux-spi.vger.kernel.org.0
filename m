Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD702E9CC4
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 19:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbhADSHP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 13:07:15 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41187 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbhADSHO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 13:07:14 -0500
Received: by mail-wr1-f44.google.com with SMTP id a12so33074408wrv.8;
        Mon, 04 Jan 2021 10:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y4OzI0Gift9qAQwCOItPNRXBZiGMCN5H3dDmQ5W7k7k=;
        b=CgzAg9+XozTRG4MiPHLtQzwqgZrL1SkCQU5SRe5E1IHQRraIV7bV3q16J08PL0cvW0
         c4lML543wRu1MtxdFenwLAZKgT/gOiCTSOOoyr5KUmxb1vDRiS/uI8wfAALeCyOlRNCB
         ZKtOiET2YK7EQQ4LDdQB92hEXuH5lzHWXD3LU3ltpjPqQ8lZDDdJAQbSzxQZd+YOePXk
         uz/+LvKtQvx0GJoPE7Qx22UccXIu6tGW3ZE/jSr7hAIbRSCrSwI1Im3EEFu1kDiC5O+R
         +c/G41qMAZ5+8UHHOtDBIQIw5m4LbJYe5tfBCMQyIYC4lMEC6KxIxaEStf7bgu8iueFP
         kNdA==
X-Gm-Message-State: AOAM531XWbht+J3JGjN1UMFXDvL1mZ3khq1wQ+H4MQjhxV2LFJHEMAAa
        VRdpWfTCSaVth84p7xcWOgg=
X-Google-Smtp-Source: ABdhPJwSJr+8sc9s0gJbtsMMAxXbPISgkriOlKIqFLVyMTanzET3gDdnClIP2ae3HciFRhbuw7YS/g==
X-Received: by 2002:adf:9e47:: with SMTP id v7mr44312549wre.185.1609783591011;
        Mon, 04 Jan 2021 10:06:31 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b7sm86189365wrv.47.2021.01.04.10.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:06:29 -0800 (PST)
Date:   Mon, 4 Jan 2021 19:06:27 +0100
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
Subject: Re: [PATCH 25/31] memory: tegra30: convert to use devm_pm_opp_* API
Message-ID: <20210104180627.GA27043@kozik-lap>
References: <20210103035415.23600-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210103035415.23600-1-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Jan 03, 2021 at 03:54:15AM +0000, Yangtao Li wrote:
> Use devm_pm_opp_* API to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/memory/tegra/tegra30-emc.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
