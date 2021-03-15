Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDBE33AA3A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Mar 2021 05:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCOEEI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Mar 2021 00:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhCOEDm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Mar 2021 00:03:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A50C061763
        for <linux-spi@vger.kernel.org>; Sun, 14 Mar 2021 21:03:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f8so1116781plg.10
        for <linux-spi@vger.kernel.org>; Sun, 14 Mar 2021 21:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c7OJnHCRmwFk8fofgO7P2TCmA9anENj2NKzvbROCVrw=;
        b=hqFTPqznnNTRx313WjH/Y3rQxyT1qRk2tsjcNVxk6Hrjol4OfsLVJAACk5S5GCeBIN
         DUPZ/2/BGxScEjnruZkDvsVu7pnsFXZ7N4zstn9qEl8Fgh/HQaGB5JV/pkl9Br3HoCOi
         i64U4nBnHPt+1Xi5F2gQwMxITwYJMb1Um+iYOQ6ojSR1WU9DezeWcNfnJiJ8w11ERSEr
         UChVNzm6vqvXvOO1iZ7xVRBakAg/WIocWyURqM6EHJjAujbHTyE6NgBKuUb+t/F7avLm
         rWQq2i6tEhG/s1AIiG+/WUpZhYbj36Vuiav5Pq8c+WaDHPXcR8LK3WT+pRJ2r6gMw6bd
         ep6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c7OJnHCRmwFk8fofgO7P2TCmA9anENj2NKzvbROCVrw=;
        b=YAputEI5EOnFlYF0o07bKcWrfnywr9JVOjJoObXVssg7neuMet7bLVLpSJhrqAX5n1
         +xIISGK016FrTxbCFpZ7mlmUorNiMIfZ4IcpHAwO1ID0uD5KRjora0Rod3PweqxB6b8k
         wowdECBh6CWfnxAHmmqggsuj4ZO0eHeF9uUguWOE8KBy0RRAENb19cBUuAbfCwDVVcYh
         RB10q9QQ9UB/hoqKoVp9nyuC+E+WGynuc0ba4+jFKKnosUOpg8jq58x2Oz3Kjf9EGrAV
         on415IWWsItja1jOpeNyWsqNc40zJV1LLBs/Mi/tj9rH1VVPE/BMTgKxltl4mp6v720z
         ging==
X-Gm-Message-State: AOAM533MN6iKrpnCSOT6Z868BVNCsW9QOUn3PAvG1R6ck+bSZnsi2z8G
        LBbuESfw2SIpry4PqfvXSamuEA==
X-Google-Smtp-Source: ABdhPJxRDau7gIDAmMsnWR7FCOk4vgRj39P8KqGrKbOykRijnyhWvAXlMXcpaXxZjPuzVl/GOTJ9CQ==
X-Received: by 2002:a17:902:7889:b029:e6:b9c3:bc0d with SMTP id q9-20020a1709027889b02900e6b9c3bc0dmr5992pll.23.1615781010271;
        Sun, 14 Mar 2021 21:03:30 -0700 (PDT)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id r23sm9182422pje.38.2021.03.14.21.03.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Mar 2021 21:03:29 -0700 (PDT)
Date:   Mon, 15 Mar 2021 09:33:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 11/15] drm/msm: Convert to use resource-managed OPP API
Message-ID: <20210315040327.qwn4rt75yqs5datl@vireshk-i7>
References: <20210314163408.22292-1-digetx@gmail.com>
 <20210314163408.22292-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314163408.22292-12-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 14-03-21, 19:34, Dmitry Osipenko wrote:
> From: Yangtao Li <tiny.windzz@gmail.com>
> 
> Use resource-managed OPP API to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   |  2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 11 +++------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h   |  2 --
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 23 +++++++------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h |  2 --
>  drivers/gpu/drm/msm/dp/dp_ctrl.c        | 30 +++++--------------------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h        |  1 -
>  drivers/gpu/drm/msm/dp/dp_display.c     |  5 +----
>  drivers/gpu/drm/msm/dsi/dsi_host.c      | 13 ++++-------
>  11 files changed, 25 insertions(+), 68 deletions(-)

This patch has some updates in linux-next, which I don't have. Please
get this merged with the drm tree over 5.13-rc1 later.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
