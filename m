Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A712FD50D
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jan 2021 17:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390998AbhATQCT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jan 2021 11:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391211AbhATQBE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jan 2021 11:01:04 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C5FC061575;
        Wed, 20 Jan 2021 08:00:23 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id q8so3172464lfm.10;
        Wed, 20 Jan 2021 08:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6pR6fg/vKnYn4hcu/THLeviR1hmHEHC9vnXYnmcjF/Q=;
        b=abtLr1uy/58LoLQJLzYbf0L+o2zJbLuT/uYCyd48HpLF2JAhOx0hrfWwOfIcXeXTgE
         9HOfUHGHmtSumGGVFBAuddWJ/pQvwtaaVjlR8LOgYJgvOr0axxti6ZdEumKE2Pdt5BDV
         FdhlVFIlj6sF2mxWlGuxZfNjGlGpgOG+qnZ8Et4+3QqTh7tvZ5Ct1Xh1dbAdXTf2umqX
         8x4F+Ku4eBtZ7uQ6IoiGOouZ5VCOxgk5/J7a8NInuLXOSX16zmC+Z7HYRrj5QDJifKoe
         cNs1iMgtdoOFx+imchuo2kJ4HyYbPQwyxvWWVEV3zFd+tqiJgOtPAD/z2arSBt5IR3Cd
         InCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6pR6fg/vKnYn4hcu/THLeviR1hmHEHC9vnXYnmcjF/Q=;
        b=RjbihLs+ibnaGKRrtYsjPcyjTXNDV7TTEnrV4jv84GzBkhRCsf6C4+9ml9v9Ij1aiQ
         cI+S5b/gQeCFcPYKEPyle9eSkE0VAcnHeGGChLKUt+QgIhfZ7MvGUFrB4p/L3/nenipY
         WjQjso/bCG0pLaERjWTQoymZkrAwkW9MqeQhYfMg0ZAjQ9Soy+r34Gb+AnVTBYDxJjRs
         M8V5I3+CdZudBI/QbdyJQ4vXynJC/jCmDOQSHy54jFcUm9VJAYbQTbkqn+YdcrMN2kNr
         7utFUyomsaV2R11NuP+OLVmfxhZpCQqDJxTGo4F0d2Sd5HZMrctP0FYAMssiHnhLArbQ
         JpXQ==
X-Gm-Message-State: AOAM5328VRFpEImjdkhWz/tdhNBxlx2bY1/ImzfpKcMKILrUtjsm7HLB
        sIFCN0EiJ3ybcJaz+VAdQTB6EjiP2aI=
X-Google-Smtp-Source: ABdhPJx4ryhDhUccrXGgvid3ZVbrnrbevGoNExSyx1pGmnWuOH6PWddYTRxvkvma6v12P7EIGAI0ZA==
X-Received: by 2002:ac2:58f2:: with SMTP id v18mr4396795lfo.623.1611158422110;
        Wed, 20 Jan 2021 08:00:22 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id 76sm233715lfh.163.2021.01.20.08.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 08:00:21 -0800 (PST)
Subject: Re: [PATCH 24/31] memory: tegra20: convert to use devm_pm_opp_* API
To:     Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com, krzk@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yuq825@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robdclark@gmail.com, sean@poorly.run,
        robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
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
        parashar@codeaurora.org, dianders@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <20210101165507.19486-25-tiny.windzz@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b9f19bb2-c225-b64d-a995-1f84926bd18b@gmail.com>
Date:   Wed, 20 Jan 2021 19:00:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210101165507.19486-25-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

01.01.2021 19:55, Yangtao Li пишет:
> Use devm_pm_opp_* API to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)

There are also tegra30-emc.c and tegra124-emc.c with a similar OPP code.

But could we please not touch these memory drivers? I already have a
prepared patch which replaces all the tegra_emc_opp_table_init() with a
single common helper that will use devm_opp_* helpers.
