Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B642E9116
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 08:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbhADHb2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 02:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbhADHb1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 02:31:27 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4130C0617A0
        for <linux-spi@vger.kernel.org>; Sun,  3 Jan 2021 23:30:46 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x126so15951327pfc.7
        for <linux-spi@vger.kernel.org>; Sun, 03 Jan 2021 23:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7x+ya3WlDYOlVbzunORT/RgtZi0Bw4k+NgmHAp25z4c=;
        b=WK0hoec2dEzKke+5KHU9JJOZX6GvW3D8DZ/jbKYdzXUAhDpyeTNlQuW/r2gOIuxxzz
         FGTPuLxLDK3piKlDdhjpxwPB2AfzjEDnu0aaCENgjCdUfQ0/xMGKvzQMD7KsBaJEmWRF
         gvw9A0Mwnq/9ilJVR401IyxPTbullL2eD9n84L3t2H3KjXqRKJQ/Bpa7Mm8m9PX8qTzD
         KC8oR20XP3SXsXHtcMIjmh6GdfDaoTqtRuouS9gkf/uEsP06ecifEAfU29rfpoMT6xym
         K9fiCTuvtMIb9me9wnluF4yzaW1ZY4WsHSK4ven/vl9LD05j/3tR1dkak46f5OClKtJT
         5EJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7x+ya3WlDYOlVbzunORT/RgtZi0Bw4k+NgmHAp25z4c=;
        b=SumicUmOAZkUQPZjxk4dQewNQHTW6rEqeVLNsHbUs4ng87SvWOaUgltJ7CW/urwsNB
         6AkDYKrTGCSoK0jjmjJjdk/TP1hcgyhAY3kj/pCOxXeCW9/WG96DYKyg9U9BlBoKT+G5
         W0AOkbEbFSekMoO/fnpUSmMt4lFsPzZzF3ysXPCsFzvMIqptIKi48j4Ztzj/+i8IICiP
         beWhciaXno3fizc9rvXSvp2h3vBN4fLLpnN+FgguR40J+Ni3WC6/YU+5A7JiYmqDWMH0
         o1J1Y869O4CLir2Bhur2Q8fY3hRJOtYhDmK7Q2JSh7bc9EiPWzAzAlbYEZCk1Z7ZQeOB
         B6cg==
X-Gm-Message-State: AOAM5337p4ZmpbulWH97aJUqhUrfEKGaClOvknKZQm75DQDUH3fh2SGV
        BOz2R4l+uHp+VwKgDCSO2/+PcA==
X-Google-Smtp-Source: ABdhPJw8EZ4eSCzESWNyniO8jgscATypf3SyqMk99sQMoYX+wFrC0dRQGUi39G/8m/OrT7kMrwuZRA==
X-Received: by 2002:a63:5805:: with SMTP id m5mr42352866pgb.352.1609745446550;
        Sun, 03 Jan 2021 23:30:46 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id dw16sm19867854pjb.35.2021.01.03.23.30.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 23:30:45 -0800 (PST)
Date:   Mon, 4 Jan 2021 13:00:44 +0530
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
Subject: Re: [PATCH 01/31] opp: Add devres wrapper for dev_pm_opp_set_clkname
 and dev_pm_opp_put_clkname
Message-ID: <20210104073044.pqrkprqsh3qetgwe@vireshk-i7>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <20210101165507.19486-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210101165507.19486-2-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01-01-21, 16:54, Yangtao Li wrote:
> +/**
> + * devm_pm_opp_put_clkname() - Releases resources blocked for clk.
> + * @dev: Device for which we do this operation.
> + * @opp_table: OPP table returned from devm_pm_opp_set_clkname().
> + */
> +void devm_pm_opp_put_clkname(struct device *dev, struct opp_table *opp_table)
> +{
> +	devm_release_action(dev, devm_pm_opp_clkname_release, opp_table);
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_opp_put_clkname);

We shouldn't be needing changes like this, please drop them for all
patches.

-- 
viresh
