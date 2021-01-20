Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388EE2FD50F
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jan 2021 17:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391093AbhATQCV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jan 2021 11:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbhATQCH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jan 2021 11:02:07 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB3BC061575;
        Wed, 20 Jan 2021 08:01:26 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id j3so6978679ljb.9;
        Wed, 20 Jan 2021 08:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3vLouel+HcUHHsPlMzqt3dQ9xZtrUWZy628SJkSoWOA=;
        b=So3BD8K3remfQXHH4nf3lm2QXaIQO4LrSFWPfSDvDdczajiT1zZjM+X6Pyp7oVzACX
         DQUhSNJKGaVBpUrEqB2a/mHhoP+IRYbbfm6S1exUM7PYOdO46swf9U2vYc08fUMud/Om
         KNU09pGDtuJ5Vrzf8SK12hTxQWfkm/uNAwh3DapnBcYJxtZFkfX9+19cfAiUdqMhHp16
         Qh5kUbWPdBWb+x6KeA5VyA2mjFhWlxuF9ELdk4uBa2909R4NP4kq2b6Y9+Ktn17HGRJk
         Pd0gmvlCI6tzooR9HKEBx0LTif4oRiwF3FqvYNnvRW5pmoLQjfOeSrfixFQbqTUF4UZU
         rZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3vLouel+HcUHHsPlMzqt3dQ9xZtrUWZy628SJkSoWOA=;
        b=UTOeU5qYDz3R35LRrEBADg1p+452zxxkoAt4eGs1YhpPj762W8Hm+q8hTWwVwtV/ew
         r+QjyGc2e2mLbJeVP08doYs6hCrYmRaBR+ADw7OwTHpZ6ePij++pw/25cBSX7JGe5Hpd
         Kppmdy2Ldf3iFiaBNH+xpjqeCRbcOfJ9/SkcEbOEyNxgUVLTCtV91hgvTAN3vzh+UYrz
         7M4PgIa8KvK0ln+RMGDZlEUP+KDehr2sx1ikBpwedrd7GJjBiKZB0ws+3kiIkGxlb6Wo
         Ha757KxulQ8VEQRt2fE+lJPjoj1FNr9gAqtCzLrEf9a5KS4vTgqQKs8B6z1Y4D+ErAgQ
         wu+w==
X-Gm-Message-State: AOAM531tHcXA1f0pohs9aErPwznhhlvpz6cg8/TJtyKIerPY47QzHNQH
        aPk7mxrZWzPapOnM+NWwRxMli8ei9yE=
X-Google-Smtp-Source: ABdhPJxufcMcdT1icHlQjBl7jPyg+FoY9nCNToNRuMAX2IYS0ZUuPjE9ss2lk3IaPlt5ucol79aNfw==
X-Received: by 2002:a2e:a310:: with SMTP id l16mr4849551lje.142.1611158484855;
        Wed, 20 Jan 2021 08:01:24 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id i14sm234976lfo.189.2021.01.20.08.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 08:01:24 -0800 (PST)
Subject: Re: [PATCH 00/31] Introduce devm_pm_opp_* API
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6bd6730c-6f4e-df93-65cd-93fa4785a8d8@gmail.com>
Date:   Wed, 20 Jan 2021 19:01:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210101165507.19486-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

01.01.2021 19:54, Yangtao Li пишет:
> Hi,
> 
> This patchset add devm_pm_opp_set_clkname, devm_pm_opp_put_clkname,
> devm_pm_opp_set_regulators, devm_pm_opp_put_regulators,
> devm_pm_opp_set_supported_hw, devm_pm_opp_of_add_table and
> devm_pm_opp_register_notifier.

Hello Yangtao,

Thank you for your effort, looking forward to v2!
