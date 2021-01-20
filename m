Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4EA2FD572
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jan 2021 17:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391274AbhATQUk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jan 2021 11:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbhATPyA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jan 2021 10:54:00 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E386C061757;
        Wed, 20 Jan 2021 07:53:20 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id f17so26614029ljg.12;
        Wed, 20 Jan 2021 07:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lE0By9BdqcLq0DFuPQl1N1WFBOvj2HiI4v8fCey86OI=;
        b=O8YbneSc0EPrK+x+ACTtxER1MN0M1XBi9LAGKH0nJM/5YJ1U79U/haRbmcrTpw14Ng
         lBaEFHTJj6uIY63LJCsu0OOLazGC+3p3cBzv4s5khXMYyJCLeRJM3f/UJi7Rf3bv7HNz
         k0aqDb53e+mRms17Zo1upTYQlWehrToOd/0vHZ7fRfi1mE9K/82zL3j5wsS+Se83qP/e
         xJAYfHeMu3zMp0M4hy//z7iIh2UPaY0XFSze5PIVkL8fgXJw/hKGhv8n54eHuLqO+3jk
         XMsUhVHZrUptWva+QjeF42vhw1p0cSAIbp9cNnBd1rO1Ez8jfoRVI+SaUV/sESqO5CFJ
         xJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lE0By9BdqcLq0DFuPQl1N1WFBOvj2HiI4v8fCey86OI=;
        b=G/qkOJG89j1/4D02sop5zAUjwYix+kQpe0eYSS+LTFmocrxl2HAAf5BTWfvu8pqhvX
         MpXeubbdZbmk2lLcDtJC+M4ojSza5cfrYmkLZzFnRm4KUyiL3+dtCrAt5hm6hnQS7UXd
         wfaRTjq667VzvGq49YB4EBZLaVPhP3uwevjN0Je/R+5K+zF3h4xDAH7k+VwTbQIALG9l
         1LTteBXqZJ1TJjVBtIh52Tq1T3SXSk2eistEvmj2ptkZvNb3L3knhpA/kSJ2tmJt14bt
         aSmV5VB2qYu1DZfCQSoJbzVDrWkYf8aifIH7pTe0YhcZAD43DiOlOGLElaXmaezF4LTv
         fbyQ==
X-Gm-Message-State: AOAM5309kl+IeJfedEDaTEsY/ZKmku/vEnr12aRXYmHmSrBLuMcN8k7G
        2pXBYCNptFfNy3Z0Gvn7M6Np+u01T4A=
X-Google-Smtp-Source: ABdhPJyBy+9sQjBpII9U0Ep8TbQz3BXDkf0PkENZMYoEspvmyYtpJD0VWDKPNhL7YKEOT6kR2w2cOw==
X-Received: by 2002:a2e:a366:: with SMTP id i6mr4945023ljn.427.1611157998525;
        Wed, 20 Jan 2021 07:53:18 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id w13sm188387ljw.115.2021.01.20.07.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:53:17 -0800 (PST)
Subject: Re: [PATCH 03/31] opp: Add devres wrapper for
 dev_pm_opp_set_supported_hw
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
 <20210101165507.19486-4-tiny.windzz@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fc9a1f79-639c-4384-c324-87249ac576fd@gmail.com>
Date:   Wed, 20 Jan 2021 18:53:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210101165507.19486-4-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

01.01.2021 19:54, Yangtao Li пишет:
> Add devres wrapper for dev_pm_opp_set_supported_hw() to simplify driver
> code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/opp/core.c     | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  8 ++++++++
>  2 files changed, 46 insertions(+)

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
