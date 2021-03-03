Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD0632C6DE
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349975AbhCDAaP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843004AbhCCKXq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Mar 2021 05:23:46 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C8DC06121E;
        Wed,  3 Mar 2021 00:31:43 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id v9so17989081lfa.1;
        Wed, 03 Mar 2021 00:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dA8KKHZiMQ0M1dMyQ+8WM+bKH9WXXF3VYD9qxoBSYVM=;
        b=Q2BL7+lc+ylMlu+ydH2KPz1PqTODp5OqgVZiHR9jqO4OZm50aqIxSjjmz78JiiooFH
         i7YC35lXSOUX9yg/ckanbCMcDnIlEnFIWaLOgdtj+UDXrH5hO9M8tW0d4lY0F73Zgtv0
         EP4JLr8ALm6ZBEyiThejlCrrfIVjY9pIOHj19FhIOTMenDf39h9gGiIWXvyNDLGkM5mo
         m/2nGyP009dWktprR8h6cgF5Vdo4NdkfBfb3BDPwDqJkwoi523txy9Y1R+1aHRYDxFMU
         pbUa9veKiX8fC3Qy7J68bxgQZFZPn42rhUh6PUmrP6NqhAMjEwXXM5pQ+2lI5jRGc3fG
         Miaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dA8KKHZiMQ0M1dMyQ+8WM+bKH9WXXF3VYD9qxoBSYVM=;
        b=f6ZSIMX8nAv5AFjL21Ejo5Bv3NJ3Rp8ijmSTbsKlQYt6Ekl94iKE9TQIHIFyeDf+eT
         4U32HV13v5mTABQ3WNlZOivEzWGS1py9zHDoZZ6zFdY3g3+sfbqcspgY/f8SK3sTER5N
         09uXG0t5uD2JUyWzIs0kA838rkFolPnrW+qjLsRR4EdvOGDZQ5dt0oiXEWGDRqNCc1vf
         6YIgnCjMyKJCssoimM7iGriqww+KbKAaP3idu40E9el3QnDkQ7mdUdKnvVq+pDFA2i35
         6uVUiZofGRHsrGdBUzcyXf31pXUoMJCHfRBq9hRRhjNCuNChYx9NHWqj2Ba6DxCP+7Ix
         0Bww==
X-Gm-Message-State: AOAM530n4Tohk0m88Dm8GcAfvRhgv+oALZsuZxkYrxBffq71r+aHyhk5
        D6rUONzoAxuMVY/19AH/6iXMbEuXb0s=
X-Google-Smtp-Source: ABdhPJyVYXtuCpQJixD14PrCS9E2RYkwzmpI6ancOTzzhejj1erUKOBHDXNJht8WUd/TI7wGU6pDCw==
X-Received: by 2002:a05:6512:110b:: with SMTP id l11mr15110220lfg.468.1614760301712;
        Wed, 03 Mar 2021 00:31:41 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id 192sm2767251ljj.95.2021.03.03.00.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 00:31:41 -0800 (PST)
Subject: Re: [PATCH 00/31] Introduce devm_pm_opp_* API
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com,
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
        parashar@codeaurora.org, dianders@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <6bd6730c-6f4e-df93-65cd-93fa4785a8d8@gmail.com>
 <c7a246a4-ab25-a193-f74a-98351780135e@gmail.com>
 <20210303040119.hpeybankxph4fyuj@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9e5edc16-abfa-632b-97e9-1367c24ef8bc@gmail.com>
Date:   Wed, 3 Mar 2021 11:31:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210303040119.hpeybankxph4fyuj@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

03.03.2021 07:01, Viresh Kumar пишет:
> On 02-03-21, 16:40, Dmitry Osipenko wrote:
>> 20.01.2021 19:01, Dmitry Osipenko пишет:
>>> 01.01.2021 19:54, Yangtao Li пишет:
>>>> Hi,
>>>>
>>>> This patchset add devm_pm_opp_set_clkname, devm_pm_opp_put_clkname,
>>>> devm_pm_opp_set_regulators, devm_pm_opp_put_regulators,
>>>> devm_pm_opp_set_supported_hw, devm_pm_opp_of_add_table and
>>>> devm_pm_opp_register_notifier.
>>>
>>> Hello Yangtao,
>>>
>>> Thank you for your effort, looking forward to v2!
>>
>> Yangtao, could you please let me know what is the status of this series?
>> Will you be able to make a v2 anytime soon?
> 
> Dmitry, if Yangtao doesn't reply back this week with a proposal, please go ahead
> and respin the patches yourself. Thanks.
> 

Alright!
