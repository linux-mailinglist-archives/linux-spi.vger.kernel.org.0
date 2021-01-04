Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB22F2E90FF
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 08:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbhADH3x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 02:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbhADH3x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 02:29:53 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA592C061795
        for <linux-spi@vger.kernel.org>; Sun,  3 Jan 2021 23:29:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e2so14069542plt.12
        for <linux-spi@vger.kernel.org>; Sun, 03 Jan 2021 23:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Zvxtbmv5cjWfnu1yO+roj3Dc1+V/ym+utFrtEq4q1w=;
        b=yUnt4D9QZPzTzHiQfNHCY4vTXTpeUS/UUfHnzvHnrTWEugOOWnaZGI954o2u3qkZuY
         fImRZTEb3rwAFcY1KurJl4B9HCpMlf1QRzxWRG67NvMSD0ZjvVwZvCrN7dmy+kMV7xG+
         yQ7zW1YERjJQVLO3Ba4i4zHq1VMVq5CCSlT+yHhOja2+p6brdVyQnzIVtgOQLb0qN1cM
         fWEQvPM/g0d0JCo8yoeZI6QjtX3OaB47hiPe7pIic6MgwP6hltnXkl4DxNtTLExxU+Je
         DGAHwsSoJapNF2ij8MvE/M4u1Qt9idjEjKXj6uQiJOBUlB93wOX9oaiaQZaA8BMQfEyx
         D22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Zvxtbmv5cjWfnu1yO+roj3Dc1+V/ym+utFrtEq4q1w=;
        b=ia7sR5EdUeupVeb70Myz3ns8OD7ugp5EBiWeQ4JNZplwHWtJpt5C+EWiVfdCyM+rfu
         iIDt82k7cktcLlE1UZPY6q7BVHMq8pYY5c499MgbFC3r7dM38r1cp1k3Vk4M7omBm5xL
         au62AW3aHRlOt56Ybf0zk2AF61jB+sPFEn/j2F9c7FM30qIN8/s3JyxUz6N/FuGiRtvv
         I65hS3PijU/IN/IzD9jj38Qw2rbK+25l9F9GP9tmZPFTVDlygG851r0NWehz05x/h4FV
         kOFHYYV56flbV0Nop0tbZuHiT7RgI9XKLEtbBniDJiuD7YvgE0hJALNe1JY6wEPmK808
         tc5w==
X-Gm-Message-State: AOAM532WFrtKdmg/k6UZ9eGn3pBuYqU2fNXWfw92ZWvxnFOnA7u8DroY
        7g07O1enpI4CXnLTE3AOz5CD8g==
X-Google-Smtp-Source: ABdhPJwV300N5jYEvScTM6CF7cxYiELUrIBZ9hm6pD5g6IeJYKyQcCAUKuneByouRbQaXtOx/PQf3g==
X-Received: by 2002:a17:902:59dc:b029:da:84c7:f175 with SMTP id d28-20020a17090259dcb02900da84c7f175mr48374386plj.75.1609745352302;
        Sun, 03 Jan 2021 23:29:12 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id o9sm21032135pjw.9.2021.01.03.23.29.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2021 23:29:11 -0800 (PST)
Date:   Mon, 4 Jan 2021 12:59:09 +0530
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
Subject: Re: [PATCH 00/31] Introduce devm_pm_opp_* API
Message-ID: <20210104072909.7bdkvckkmddsgqnj@vireshk-i7>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210101165507.19486-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01-01-21, 16:54, Yangtao Li wrote:
> Hi,
> 
> This patchset add devm_pm_opp_set_clkname, devm_pm_opp_put_clkname,
> devm_pm_opp_set_regulators, devm_pm_opp_put_regulators,
> devm_pm_opp_set_supported_hw, devm_pm_opp_of_add_table and
> devm_pm_opp_register_notifier.

You can't put so many names in the cclist, we are getting failure
messages while replying to your patches now.

Put all people you want to inform in the bcc section and only the
important ones in to/cc list.

-- 
viresh
