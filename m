Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5E62FD4A6
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jan 2021 16:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389360AbhATPyq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jan 2021 10:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390562AbhATPx3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jan 2021 10:53:29 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FE4C061575;
        Wed, 20 Jan 2021 07:52:49 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o17so34757590lfg.4;
        Wed, 20 Jan 2021 07:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/KIgJpukkTUseLKOL+nfTNs+iHfOcLiaf/sA4jMSc7o=;
        b=b2NLVokQPZCUuJAyv3kiWNUb/D7/YvKoWfUJcCHR1heKGaiZjLpcSwBstX7Q3YX8MD
         0VSL3nGarP20z1Z7t1EQA7XA2H4vpXyhlGms2qwFGmlN5vFPCkNOEwhXvgcl2dX2OHl0
         Fk8lwe7s8eUZ2wwS5RMH6/mUWuXSRNmTjNvQCAwK5Dd3NdzmkpZHt4llHrw8Ni5khkmn
         myMjJRhAiEUeq/sHdT1yh60NnMmGAROPatvIjJ8mP6HQeV19cvk6YGXY87IpFAtncwaV
         v00shKKr9e/yxCXAB3jbsK18rnr4dn0SL3OuJ8SyDsoqZnywmH2zxXJFRB0YEqFQqi04
         OP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/KIgJpukkTUseLKOL+nfTNs+iHfOcLiaf/sA4jMSc7o=;
        b=nbGUUFMp2tvkeX6XBsXTytoIiQPoz2eDIbHMmu4obTt01NoNLbaj2f9zx3wVyrCp4j
         XIEjmjHhN6R1F1fnjSKUn9LIH2fe1HWXJOARadqqsVIByKni7NkJOPdLj+5chmh06SoZ
         6TH9b14hriqgE1+ThonVV1NND8L1OGT9qf8dXWsrbFRjvgVWZ0Hv2ANhdQP7Pp0rUInH
         DdyJhS2vnOcnkWMdS4WMk+TAwt6OmI0ezULfIAVj4iUL3FbjIeIkwceqBm8ZxGEFnVmy
         1k1exhCfw1zlHcU/HC6vF73fyQJL7udqR/YCzWTZyBsWL6xCKgckEZ+apslDjtXdNUTt
         jDZQ==
X-Gm-Message-State: AOAM5338hi7aA1pHPOm9dFhgTGZXp4CKCcQIfKiU3dvNwEKhL+T6Bgjo
        K/NSxyBc5oPD2aA5LNiSlbJh8+WQmjY=
X-Google-Smtp-Source: ABdhPJz54jp4p6N7ro9OB4UGTlGLwMbj9w9A1NhmVFwuW25RiB7kgYemoqd4C3nN1Esa+ddCNU5GUA==
X-Received: by 2002:a19:ac45:: with SMTP id r5mr4942869lfc.305.1611157967504;
        Wed, 20 Jan 2021 07:52:47 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id b4sm74228ljp.53.2021.01.20.07.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:52:46 -0800 (PST)
Subject: Re: [PATCH 02/31] opp: Add devres wrapper for
 dev_pm_opp_set_regulators and dev_pm_opp_put_regulators
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
 <20210101165507.19486-3-tiny.windzz@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <43c251a2-430a-040c-4152-94cf10c884e0@gmail.com>
Date:   Wed, 20 Jan 2021 18:52:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210101165507.19486-3-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

01.01.2021 19:54, Yangtao Li пишет:
> Add devres wrapper for dev_pm_opp_set_regulators()
> dev_pm_opp_put_regulators () to simplify driver code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/opp/core.c     | 50 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  9 ++++++++
>  2 files changed, 59 insertions(+)

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
