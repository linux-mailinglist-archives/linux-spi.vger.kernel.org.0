Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3130337E82
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhCKTw6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhCKTwe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:52:34 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A27CC061574;
        Thu, 11 Mar 2021 11:52:33 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 9so3731859ljd.7;
        Thu, 11 Mar 2021 11:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NzktC61WLHyGiWXBjMZlD5s3DKyEhRdHqxU4GfY6M6c=;
        b=aAhQavJLtQkk/nECiXIlx+O/QFcYOij/vUvk4Wb3id8VTVQ0DyGKOupLcfPcnhws9M
         iTylNQCipW5MSqd0wNcpVw4dB3diCb3QY/PKAwT+/BxAHD4yYg+lSPtwGG/DTHT3NehP
         CaoEl5t7uGJD3ud2WDG316ejAt9g9t9FDMn5fpvYV9Ui71GaGzvyAItDW9kJ2gOneKSC
         asVAk7ZuMTAk2n+46AdJFDyaKPMsG4xv/4UfEf6ULxafrkhpkpzYK2+5iVazZOxsor5w
         uTljITefaZioOQJAu4nlANrdsnfQbXc2UvMRBg4l1oavRU/lcVlrzwLCJQ86EbOo4P7r
         Jzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NzktC61WLHyGiWXBjMZlD5s3DKyEhRdHqxU4GfY6M6c=;
        b=BaGPppYF6xa0YcL/sZY7Ar6+pmg+KaMaCVBr2SG6QNwUxvcxjNvEbu8OfDDRGXFRvl
         EdL5peQ2xA0AW3XVFpNvoQVr4e/ypgj7xZVQrpunrU78ZHwMAOxby4N4BVL8HM7u8+GN
         1mAoKCPjbryUD9D3aeSnnJYVL7a88O8F8OEV8QYshO3YnyKUciBKzSWdziLGULtWg+eZ
         wAPA+qHH/kzPmrmJwnHIVpZ/yEsf7o8+g25rb4pOKfsWhgAW6LytWCq9SYY3Jd321YPX
         xK50aAsb8i3pbkiHzHjqq37DkDathrnNJPif2PQoQIS6y3cLTtb9Bq6fWiUHoqDkBg76
         95eQ==
X-Gm-Message-State: AOAM532Vqs93wweySnn/BOuuhOh00+Jk9b2G24m9egrACVp/g8DElKQu
        3vMFwlQ1887T/D7psBtTrj8U13XWePg=
X-Google-Smtp-Source: ABdhPJy1BIvKdq3/KI+BkHi/0PnhadIhGpaaLM0alJjY9nXsG8WO7V4czzQ/EgXdXTqTkrhNdbzLPg==
X-Received: by 2002:a05:651c:303:: with SMTP id a3mr285703ljp.290.1615492351563;
        Thu, 11 Mar 2021 11:52:31 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id d14sm1075232lfg.128.2021.03.11.11.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 11:52:31 -0800 (PST)
Subject: Re: [PATCH v2 07/14] spi: spi-geni-qcom: Convert to use
 resource-managed OPP API
To:     Mark Brown <broonie@kernel.org>
Cc:     Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210311192105.14998-1-digetx@gmail.com>
 <20210311192105.14998-8-digetx@gmail.com>
 <20210311194428.GK4962@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <552bb8fe-cd46-a420-8646-3fbe8975f01d@gmail.com>
Date:   Thu, 11 Mar 2021 22:52:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210311194428.GK4962@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

11.03.2021 22:44, Mark Brown пишет:
> On Thu, Mar 11, 2021 at 10:20:58PM +0300, Dmitry Osipenko wrote:
> 
>> Acked-by: Mark brown <broonie@kernel.org>
> 
> Typo there.
> 

Good catch! Although, that should be a patchwork fault since it
auto-added acks when I downloaded v1 patches and I haven't changed them.
I'll fix it in v3 or, if there won't be anything else to improve, then
maybe Viresh could fix it up while applying patches.
