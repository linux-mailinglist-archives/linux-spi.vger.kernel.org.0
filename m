Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0775032B4F2
	for <lists+linux-spi@lfdr.de>; Wed,  3 Mar 2021 06:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhCCFgx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 00:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447518AbhCBNl1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Mar 2021 08:41:27 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C0CC061756;
        Tue,  2 Mar 2021 05:40:38 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id q25so11076955lfc.8;
        Tue, 02 Mar 2021 05:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sy2937whkD36NnxmnEnOHu/2WmMpJHhESVIp923Q2ms=;
        b=WR417b2TXL4XluWU3Q62QUJQT2KHPwbcPUhvSl9ZQVrVxjti1bnY0rVY28lskvQOQ9
         Wd4ONpWLQsrq2U9ZfDpZJ9FfQ0enFUDeq957Rh8PhHNklfHjRCfh4w3CGHcGpKedn3JL
         JU325/yJb/LyWrSRbGakExDJSSgUVg+qczoU+PFZZ2dZHklZkgt4nYBqwUHa/sX6A7Vq
         KcMVXJKg88SR6oBSveZT8yEuJBNqlxOaa9sbDxhpRkGsJXaBT3wgy8o8QOEuUJEnZHii
         cNSLUqZnaK/Zmp1Gtp5hNnFenxB8+j+e6Auapc+QBS0WcKBPGyzm5C2dO3+rub2odxvy
         Guzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sy2937whkD36NnxmnEnOHu/2WmMpJHhESVIp923Q2ms=;
        b=EhoMuAQ7DKnyEuzgvbgptxDcLLMmpunXnYHxlPxyQYlBX0OjfsollGtZPKjopFc4Lg
         40uNKjaP3JVWNk8+DhBnFwh+LBgGeIjsGt1KOGWWPQ6QdlGquhp9IGcyncV8+zJ9+2f5
         G8iTj7VRvZcK7Q2lH57ZD6t4xt7SuCdvGwj+LwntDW857ylrcIbL/0VPpgQHQjkEYJta
         5Lo7y4tW9K19X3AOCHs7IMsOarZG9apGXTnCmJi+bn106t5rMpMZinFyvug+/mNeArqF
         njguiz5NpnMpZqLrAVnYeMA/vQhlwJ7Ba2xQkbipd1eT1OAM52UoQc7J32a3skK9648c
         92eQ==
X-Gm-Message-State: AOAM531ECC0QCVft70Sjj/KRUzLAwuj20RwAe+0fj/VW89xsh5eOzvau
        65n4IeFIMCeoXganNFUiRbwUBmbuuUo=
X-Google-Smtp-Source: ABdhPJxRPWPVr1JuoC8bNRBtDqyUDprT1LYGiwQlldtoe/FBCoxaKt0EfpMAr+/aLHyNPv+Ih4vpaQ==
X-Received: by 2002:ac2:4ecd:: with SMTP id p13mr5165188lfr.421.1614692436754;
        Tue, 02 Mar 2021 05:40:36 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id 192sm2462749ljj.95.2021.03.02.05.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 05:40:36 -0800 (PST)
Subject: Re: [PATCH 00/31] Introduce devm_pm_opp_* API
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <6bd6730c-6f4e-df93-65cd-93fa4785a8d8@gmail.com>
Message-ID: <c7a246a4-ab25-a193-f74a-98351780135e@gmail.com>
Date:   Tue, 2 Mar 2021 16:40:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <6bd6730c-6f4e-df93-65cd-93fa4785a8d8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

20.01.2021 19:01, Dmitry Osipenko пишет:
> 01.01.2021 19:54, Yangtao Li пишет:
>> Hi,
>>
>> This patchset add devm_pm_opp_set_clkname, devm_pm_opp_put_clkname,
>> devm_pm_opp_set_regulators, devm_pm_opp_put_regulators,
>> devm_pm_opp_set_supported_hw, devm_pm_opp_of_add_table and
>> devm_pm_opp_register_notifier.
> 
> Hello Yangtao,
> 
> Thank you for your effort, looking forward to v2!

Yangtao, could you please let me know what is the status of this series?
Will you be able to make a v2 anytime soon?
