Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B44A2FD51D
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jan 2021 17:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391303AbhATQKK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jan 2021 11:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732159AbhATPzb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jan 2021 10:55:31 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA91FC061575;
        Wed, 20 Jan 2021 07:54:50 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o13so34780856lfr.3;
        Wed, 20 Jan 2021 07:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OraQS0v0Xv5zg7vQaDViOmDICo3Sb7euJyZv9aOaJu8=;
        b=VsvXik7hw5Hl3crun670kcR75wLYFasYTGj7q+1s/NO8wZ5r/tDe5fojKQMoNSQWkS
         aMQAYbRM5GPqs2f8j7Y1mhjlCBqiYJtgxsmi6IyMj+53tNfe7VleKdz1mHUyGb853dsE
         njfONOWRODOxWuzePpWXBtsa+p2FJrq/O4T54gWr5NNYovu6KNFNz4WswCMdb+idfG6U
         g5xIGPzuMp9OeebLCuTvjPWV9vhiOS7CdX0IleSzuo3vRC5dwwq+8FCLSDTcDO9/48IF
         EggAYURVgxOMRFCO2fiU+qag7XnLDo0puFyPuc9SahICXYBvHriLpO7KxR7rLSKKAY+U
         vJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OraQS0v0Xv5zg7vQaDViOmDICo3Sb7euJyZv9aOaJu8=;
        b=W4DNobYdXik9/eJOyMVMprGXEG2b9MQ3Db/KFBnrYpZrHGEpQtRgKj2Mv+gRaszpoj
         wPNH6w/K2MOSQ512g+BF0yCJYH1sqRXZl3Cb3noRLtBlWKWaLNdotiE9naW68Cl/Nb+m
         4aUZU16eQXsf2bHowO/5EjY/maTU51EO85XLWh3eXBkSH09riqnAm4mvVJNchLPlHlGh
         /mT/S7P8AiGVW1xyFc5mcoeFWm1VwncXkE03deDLotB+ub+Di673K2d2h8Q2Qg/iN7pu
         Ve3HlC9jCze/dweFGKPVqc1lP4VNfsCZTnVpq8p48up1YECMZtlwzC98dtJFF55xpAXP
         2C8w==
X-Gm-Message-State: AOAM531njnrY3rcW/U0nC+6Efx68tdXN2HYwXID+/Lt4zMWnzDB9Blrm
        6Vt2Qlk4AT/XZQO77X0bZ/7P0oguJ1s=
X-Google-Smtp-Source: ABdhPJxixdZxCteA3EdzQ5S+lWMiRpU31hXGhGOFWP/JeX4pGWhmpG53pDtKr8KAUPnR39Mxv9geQQ==
X-Received: by 2002:a05:6512:3ea:: with SMTP id n10mr4495148lfq.535.1611158089273;
        Wed, 20 Jan 2021 07:54:49 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id 127sm267842ljf.132.2021.01.20.07.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:54:48 -0800 (PST)
Subject: Re: [PATCH 04/31] opp: Add devres wrapper for dev_pm_opp_of_add_table
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
 <20210101165507.19486-5-tiny.windzz@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7fde8c7f-8dcc-c085-33e1-35c9db5e1003@gmail.com>
Date:   Wed, 20 Jan 2021 18:54:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210101165507.19486-5-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

01.01.2021 19:54, Yangtao Li пишет:
> Add devres wrapper for dev_pm_opp_of_add_table() to simplify driver
> code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/opp/of.c       | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  6 ++++++
>  2 files changed, 42 insertions(+)

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
