Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD97338E93
	for <lists+linux-spi@lfdr.de>; Fri, 12 Mar 2021 14:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhCLNRg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Mar 2021 08:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhCLNRY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Mar 2021 08:17:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD956C061574;
        Fri, 12 Mar 2021 05:17:23 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u4so45734764lfs.0;
        Fri, 12 Mar 2021 05:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kKylRMS171DSUAUGLyXWsq2Tz6pdoiZRigFrFZwqxVY=;
        b=eUHZSSaI5vPFgCHKI71eDK0ms124Rbgs1AggoS8af2xSFxsDK5SvDdHRqKZcudOXj/
         P7eWD2DuQ5pSSwttIk03LP1GI7IELva1IQj4teSCKjz3NCQwiCFLuZMBEceMFlJ/Q1xY
         fAI3aAvftZ2OHaAcIFUk7dDlK2lrsGn1EcjsP+1W8S29zE8n11MaBaYGTkBsM9mRoPay
         RgR6eXgSRUoKyXx8TzB+ivVIhA/LkIC/9w9Y0n02pjNGA5d2nv8si4OmOFrXBQWnb8s0
         +cr8J/K96dWe6Y8YAwMIUDn+/X+fQ0+L/LRGlc77yg5sWB3K8cC4YDGz6y4OjHy6cSh0
         Tv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kKylRMS171DSUAUGLyXWsq2Tz6pdoiZRigFrFZwqxVY=;
        b=YHgox1TxUbIyzP/V39oDzT+cU2hLJEQjq4ye5xytBMQE0BLiEw+ySHecF5rHFjQu5v
         tqLXoX8dTOgRoSixTGDTpEfNX/sByZGotsXT82EYmDj0BwfDisRi1do0ot5N0i3CnCkl
         IJQSSAhxdqlN4cZoD0oI2jMtpSEokbtR0VlVcf3uyb1wn5nrL7IGYqihOp2qQs0iUjh+
         S10Sv2ZF2Psx4Yr2aE/BNxk57HHSRPw5AyDk9WWSI/hpRdfhkzmt0EHxCALxXS0Koad1
         qzxdyBDnZgpisPHTd1+FDYMuSCFgBg1C6R2HOdBZBalm+BGrxXpjxTe3IsITqjoIaVwS
         mDkQ==
X-Gm-Message-State: AOAM53178vLO7o/ryNY5SFFGhQux3LIHZIi4rL0LGSsNEP5V9E99uXrr
        HW39Oruo262L6JdAkHi7IsUzJ7T8qFM=
X-Google-Smtp-Source: ABdhPJyyXw4QXGPCVy0ERilhNXqz3whUGsc8C9NeIrl8gS+TKEhNS13UCZoBdLhL/YqNG5x1dPt40w==
X-Received: by 2002:ac2:5603:: with SMTP id v3mr5617629lfd.67.1615555042189;
        Fri, 12 Mar 2021 05:17:22 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id k6sm1959405ljb.110.2021.03.12.05.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 05:17:21 -0800 (PST)
Subject: Re: [PATCH v2 05/14] opp: Add devres wrapper for
 dev_pm_opp_register_notifier
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
        Mark Brown <broonie@kernel.org>,
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
 <20210311192105.14998-6-digetx@gmail.com>
 <20210312052659.uih7ikjdnkc5kl4j@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7c288641-99ad-c938-1e5e-8c1ca19c9ea4@gmail.com>
Date:   Fri, 12 Mar 2021 16:17:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210312052659.uih7ikjdnkc5kl4j@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

12.03.2021 08:26, Viresh Kumar пишет:
> On 11-03-21, 22:20, Dmitry Osipenko wrote:
>> From: Yangtao Li <tiny.windzz@gmail.com>
>>
>> Add devres wrapper for dev_pm_opp_register_notifier() to simplify driver
>> code.
>>
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/opp/core.c     | 38 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_opp.h |  6 ++++++
>>  2 files changed, 44 insertions(+)
> 
> As I said in the previous version, I am not sure if we need this patch
> at all. This has only one user.
> 

I'll drop this patch in v3, thanks.
