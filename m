Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1612C2E90CD
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 08:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbhADHQQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 02:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbhADHQP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 02:16:15 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BB5C061796
        for <linux-spi@vger.kernel.org>; Sun,  3 Jan 2021 23:15:35 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c12so15914526pfo.10
        for <linux-spi@vger.kernel.org>; Sun, 03 Jan 2021 23:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x5qtGC03cGR6fBZ/P7WwG5L1MqF0Nj6bOUHj8Uj+kHE=;
        b=OAaqSR5s9Ik5xFghIWI9hC6wEO4akfqQjR1AOd5DY6Xi6Mevb8NLfqSZDyR+1BWPVQ
         0nbaAvHDIACvQtTkVUUyk4W1NyB8M+CTEIC4YreClD/ms9PJv6vmduZftbG4+VxGdOh4
         M2KFQBwKG84Zx7cCdRv4veEdNPZJFPANKBuC2fDoeERuVv3Scp7X7O8hMrqZZS6srLBv
         4klE090qhDFDneRddwMkgzplBW/qRn/Ef8pTZMWvv0IWo+yNujZjEzfyoQ9ES/u+JKZk
         ZoZvpTEodAuDAUMYxGd05rAyu5Bd5sJ6rfBLxqikk+xkarbqtpsvSayBj5tVwYSPv/Z6
         emVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x5qtGC03cGR6fBZ/P7WwG5L1MqF0Nj6bOUHj8Uj+kHE=;
        b=Y09f1zmJMajdnVg0P9Zb7COzxPpwGkvLIUjVefcXjx1JYUTFaSC1znXrBUzYIXKGjj
         aHxrt79NujRTlhiPWTELqvwX8qI0vaM5PA40zbaxLymxVIrMeD5lv6/OFbu4elqnDfT4
         yxkvo8kT5Ogt7W1GPuhMCskoZgaYvxRBhZLKPUXBvBrJlERokCMdQsn7K7TiCptujk2S
         w1V+JEN169+pA9yNe5iuMlzUxiyzc31p+1wNz86J8Gn7X0McDicXBul8kS1g60qSqSiM
         2x4B4PG+2dpvQivROzwqxOFKuDY8SxcJvcHFgWLuR1KaIB2+Flj3WXkB8WhJozGHXpkO
         UZiA==
X-Gm-Message-State: AOAM530UOPhpGdKMomhVSGecwmh7tu3+ulrowSE4gQ+EQSy6npcsUPRg
        o/ks3OvblF6Z3cysQgNVa+xVRA==
X-Google-Smtp-Source: ABdhPJxGFwAV2SQtVU4VNuP02uvq/Pafhur3RgVz2v7E9ia11SPp2CuAR1+kuobkLcHSmIraN1mtOQ==
X-Received: by 2002:a65:4983:: with SMTP id r3mr71474424pgs.288.1609744534592;
        Sun, 03 Jan 2021 23:15:34 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id 22sm20354596pjw.19.2021.01.03.23.15.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 23:15:33 -0800 (PST)
Date:   Mon, 4 Jan 2021 12:45:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, digetx@gmail.com, thierry.reding@gmail.com,
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
Subject: Re: [PATCH 05/31] opp: Add devres wrapper for
 dev_pm_opp_register_notifier
Message-ID: <20210104071531.oyc64zgfot43gupv@vireshk-i7>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <20210101165507.19486-6-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210101165507.19486-6-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01-01-21, 16:54, Yangtao Li wrote:
> Add devres wrapper for dev_pm_opp_register_notifier() to simplify driver
> code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/opp/core.c     | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  6 ++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 6b83e373f0d8..ef3544f8cecd 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2599,6 +2599,44 @@ int dev_pm_opp_unregister_notifier(struct device *dev,
>  }
>  EXPORT_SYMBOL(dev_pm_opp_unregister_notifier);
>  
> +static void devm_pm_opp_notifier_release(struct device *dev, void *res)
> +{
> +	struct notifier_block *nb = *(struct notifier_block **)res;
> +
> +	WARN_ON(dev_pm_opp_unregister_notifier(dev, nb));
> +}
> +
> +/**
> + * devm_pm_opp_register_notifier() - Register OPP notifier for the device
> + * @dev:	Device for which notifier needs to be registered
> + * @nb:		Notifier block to be registered
> + *
> + * Return: 0 on success or a negative error value.
> + *
> + * The notifier will be unregistered after the device is destroyed.
> + */
> +int devm_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
> +{
> +	struct notifier_block **ptr;
> +	int ret;
> +
> +	ptr = devres_alloc(devm_pm_opp_notifier_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	ret = dev_pm_opp_register_notifier(dev, nb);
> +	if (ret) {
> +		devres_free(ptr);
> +		return ret;
> +	}
> +
> +	*ptr = nb;
> +	devres_add(dev, ptr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(devm_pm_opp_register_notifier);

I am not in favor of this patch, and it only has one user, which makes
it more unwanted.

-- 
viresh
