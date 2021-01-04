Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5C82E9CB1
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 19:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbhADSG3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 13:06:29 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:56062 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbhADSG2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 13:06:28 -0500
Received: by mail-wm1-f46.google.com with SMTP id c124so83066wma.5;
        Mon, 04 Jan 2021 10:06:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jOT7bogYKKGgIq8O2irZ9r1kFpEDJmSFkZaBnss719w=;
        b=KPOj9aWowlF7PfJidnm2szasCQctrcE30MiPe9YtndOv5cv/BPktQTAxFtXQTWVI0X
         +8/GpN2k7KVZa5h6khjd5FL7nbYcG7W6nVKpjWCCUWjxUgdy7nYXhE0zg8LNOk8LlgK5
         5FGu+pkJhVjabwRtkQ5HGqdtPLLHLz/lzMOvPpxnwweU5nKo/bJ+kijRm+ueag7hgp2v
         5nOCvshvS9cj+wTO1OG76XmtyHByHGM3o7tiRv0BfXaEiJo0pNn/1tvHVbUkOph+0ZfU
         n65u4Fzz/yBFe4vaJaihy70ADzRmiVQObr2yppuAhZn6shzBQhLOAKNDQfTg0tBILI6a
         TdYQ==
X-Gm-Message-State: AOAM532+q2TDt2lhS2dbYJzRiYp8oEcyqCTTA1m3h8iiLX+NHher9bgq
        g4PvpXuA6MMrdv/isSqYxKo=
X-Google-Smtp-Source: ABdhPJyWxf8aqXZ72N3yUrhdj4LKkC0F8cRhPjKuApDiViHhoYgl46TOLAmISrBtj83N/Gp1V/qsrA==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr105327wme.72.1609783545149;
        Mon, 04 Jan 2021 10:05:45 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id d191sm124746wmd.24.2021.01.04.10.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:05:44 -0800 (PST)
Date:   Mon, 4 Jan 2021 19:05:41 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        digetx@gmail.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        yuq825@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robdclark@gmail.com, sean@poorly.run, robh@kernel.org,
        tomeu.vizoso@collabora.com, steven.price@arm.com,
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
Subject: Re: [PATCH 24/31] memory: tegra20: convert to use devm_pm_opp_* API
Message-ID: <20210104180541.GC26189@kozik-lap>
References: <20210101165507.19486-1-tiny.windzz@gmail.com>
 <20210101165507.19486-25-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210101165507.19486-25-tiny.windzz@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jan 01, 2021 at 04:55:00PM +0000, Yangtao Li wrote:
> Use devm_pm_opp_* API to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
