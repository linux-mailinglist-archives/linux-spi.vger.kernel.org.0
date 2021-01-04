Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F58D2E9113
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 08:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbhADHb1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 02:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbhADHb1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 02:31:27 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF82C06179A
        for <linux-spi@vger.kernel.org>; Sun,  3 Jan 2021 23:30:06 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z12so9591368pjn.1
        for <linux-spi@vger.kernel.org>; Sun, 03 Jan 2021 23:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0t5BFoNfCkknbg9Gdfco98fDaInDYPXgN3k5AAnXZzo=;
        b=rzg4DbiwiKrMuaiMfr759ux4SEDoL1Vr9OAHwaaNfZcMNcU8EWYgeGFze7JnOoOWTn
         /jniZYDFfeiS2RbqPKuMC6PSqhrYneqeqIshefFgLpSxsaURGC6jqu4KfDCZOcvINjja
         sY0FYgq2LYD66HwUIPobDZK16A2fRR0Lfg5LUtM6iYlG6G/jN7Kr5o4VqB+d/VL1mTJa
         K7xAKvdzTPT0T8ri8f4zmfaZQ0OCq/ECkmbV+Pdhn1+anfC2ki0qWbsNjyZz5gU1JLlv
         cG0rUJWbVk/+nAf2xXb4IpYwHgU1hC9LZiLzomisGCIa+boFxA567vjzpn9i9Bw5LPMi
         QQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0t5BFoNfCkknbg9Gdfco98fDaInDYPXgN3k5AAnXZzo=;
        b=AmDmwIf39+jEQQfTXVo7K+lv22COGq3IrV6fA24M2tTGsbBB05yIWRpNrRfVg9Affq
         7wDADAbrGOpeKcdyfbwEs3g/uBYfoOwfwCYfcyUhasWJ9VTL3HZ2jfGElFPukHWi8tgW
         VovVZzRv2KtWUJDdZdWraNdV1DwijMQhgTaMAba2pqUyp8RV7ZmLWhunpzH6mbDKuKqB
         3FHPR9z8ewo2ZNCijLgOIG4clqVTUWih0Q9SijkwlfTydUTCQCPIQQzGYqKs0KK5/BBM
         033l0A3X0sXq/P/6Cq9eYncp7pHftfPfLCoKtanbv7ZPQuEW/X496eLzadHDHqlJ78VK
         0oww==
X-Gm-Message-State: AOAM5335s7Mdg2cJSzx+Sq9c2mwkKLG1zLTMHyYzy/jlApo8ZjrCzQNC
        aML4rtjsgi6FKdbeACUlRUiXwQ==
X-Google-Smtp-Source: ABdhPJzizEfwxxFAdfGobekyn+UNS6a0sd2O/TTd5ud8jGQA0K4MRZ+iCwg+4Fg+cnMfI+GJ3lFQhw==
X-Received: by 2002:a17:90a:b110:: with SMTP id z16mr28243007pjq.167.1609745405787;
        Sun, 03 Jan 2021 23:30:05 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id nm6sm19739846pjb.25.2021.01.03.23.30.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 23:30:05 -0800 (PST)
Date:   Mon, 4 Jan 2021 13:00:03 +0530
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
Subject: Re: [PATCH 26/31] PM / devfreq: tegra30: convert to use
 devm_pm_opp_* API
Message-ID: <20210104073003.5kx73zita7laxpmx@vireshk-i7>
References: <20210103035445.23696-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103035445.23696-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 03-01-21, 03:54, Yangtao Li wrote:
> Use devm_pm_opp_* API to simplify code, and remove opp_table
> from tegra_devfreq.

Patches starting this one didn't appear in the same thread and it is a
nightmare to apply these now. Please send everything properly next
time.

-- 
viresh
