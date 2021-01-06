Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB0F2EC31A
	for <lists+linux-spi@lfdr.de>; Wed,  6 Jan 2021 19:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbhAFSS3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Jan 2021 13:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAFSS2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 6 Jan 2021 13:18:28 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDC1C061575;
        Wed,  6 Jan 2021 10:17:48 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b26so8604119lff.9;
        Wed, 06 Jan 2021 10:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HYWLWTmJNILkmHihZoZqMnAVOHO5Z+JPD1TRn5rR9L8=;
        b=GYiaiaGEtT4BPqTlK0KXvA/lu341yArrXOfwIqhkoVUJgJS2obaAQT2iqcnRMLlEj2
         86dYKLxag/6o7FFGTh1Vt5TIkPdSdG+zPtevOxa7j54gud87De0pnPPNNbmeyzFcKIe1
         4YIh5yiiCYo2x6drTLogG5BS1FtgZ7nId5Q/AwMgojxtj5XPEyq3STR1fkLiu+XesnUc
         QU5ia5w8dG/71l1Z55HnJQmRQInADBb1sNl7x6aeuUT/y6q1BPYSDCvgpmBhWeM+Z+mh
         AXVxDGWhMUV9j3VOAFcsUFiIntWY+dOOFoXQpYyyfUUEdyjbQguMaGGbtpj5p1vrw984
         ODXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HYWLWTmJNILkmHihZoZqMnAVOHO5Z+JPD1TRn5rR9L8=;
        b=gUHBZ8U2efQmGA2O1aY6esLBhZl22SEnXW8Fg6IvFjlC6YPcI6t4svX7qrsllTpKY2
         qnqBhZHo9dzi7Ik0Na8bh5zb9ngAq7jr9blVbuTAFs/XjqypBbdvPyMehnhMrUvuYjc2
         7w+AKcDQhk69mFYiwD7Eixso8A68MAROJ4XwUC99aO7jA1eApLZOGYODtcvsU6grjkUX
         H5gfZmIvNCgFu7rq9TL2ay0hnjzMQ+M/idp4lEwYrYwlpAuUe6Y1zpD312uSDwdQWg2p
         VZnSUJUCEgj+QJCly0ojIyZeywW5CFSp29LVpDN6Rg6fKmmHf3tSGqcRl0ePd8BhhuQ6
         eiyg==
X-Gm-Message-State: AOAM531UAHmQL5aOHOBQbGkx5C0zo0uWUwMB5HTWi2i0fvlFY/fbiVkB
        NqZO05oBgz0pc6OV8rZGinuEvNvNm+A=
X-Google-Smtp-Source: ABdhPJyPxFIsokqex0tU1bZCyssoNhQcXmbMg7xmBfVSnpJHRzc1xaOuhg1qqDeBQDzHj7VlWoc+4Q==
X-Received: by 2002:a19:2358:: with SMTP id j85mr2490159lfj.264.1609957066448;
        Wed, 06 Jan 2021 10:17:46 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id q7sm556364ljp.77.2021.01.06.10.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 10:17:45 -0800 (PST)
Subject: Re: [PATCH 26/31] PM / devfreq: tegra30: convert to use devm_pm_opp_*
 API
To:     cwchoi00@gmail.com, Yangtao Li <tiny.windzz@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        dl-linux-imx <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, yuq825@gmail.com,
        David Airlie <airlied@linux.ie>, daniel@ffwll.ch,
        robdclark@gmail.com, sean@poorly.run,
        Rob Herring <robh@kernel.org>, tomeu.vizoso@collabora.com,
        steven.price@arm.com, alyssa.rosenzweig@collabora.com,
        stanimir.varbanov@linaro.org, agross@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        mchehab@kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, jcrouse@codeaurora.org,
        hoegsberg@google.com, eric@anholt.net, tzimmermann@suse.de,
        marijn.suijten@somainline.org, gustavoars@kernel.org,
        emil.velikov@collabora.com, jonathan@marek.ca,
        akhilpo@codeaurora.org, smasetty@codeaurora.org,
        airlied@redhat.com, masneyb@onstation.org, kalyan_t@codeaurora.org,
        tanmay@codeaurora.org, ddavenport@chromium.org,
        jsanka@codeaurora.org, rnayak@codeaurora.org,
        tongtiangen@huawei.com, miaoqinglang@huawei.com,
        khsieh@codeaurora.org, abhinavk@codeaurora.org,
        chandanu@codeaurora.org, Guenter Roeck <groeck@chromium.org>,
        varar@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        harigovi@codeaurora.org, rikard.falkeborn@gmail.com,
        natechancellor@gmail.com, Georgi Djakov <georgi.djakov@linaro.org>,
        akashast@codeaurora.org, parashar@codeaurora.org,
        Doug Anderson <dianders@chromium.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20210103035445.23696-1-tiny.windzz@gmail.com>
 <CAGTfZH0sLh=8XhBVOzUr9qO2w_=jp-OuWoh5vgNpnmXq6EzYHA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e49d60f3-f753-6679-7148-f7ea72973197@gmail.com>
Date:   Wed, 6 Jan 2021 21:17:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <CAGTfZH0sLh=8XhBVOzUr9qO2w_=jp-OuWoh5vgNpnmXq6EzYHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

05.01.2021 06:47, Chanwoo Choi пишет:
> You might remove the 'devm_pm_opp_remove_all_dynamic(&pdev->dev)
> under ' remove_opp' goto statement.kkkk

Good catch, thank you.
