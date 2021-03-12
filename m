Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4300B338EA2
	for <lists+linux-spi@lfdr.de>; Fri, 12 Mar 2021 14:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhCLNTo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Mar 2021 08:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCLNTS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Mar 2021 08:19:18 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F676C061574;
        Fri, 12 Mar 2021 05:19:17 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p21so45635927lfu.11;
        Fri, 12 Mar 2021 05:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eRvXvpISF4IBOtvYHqIw0A7WGfnjimCkRZ9ja9m0ckM=;
        b=Ut4qFXpcbkXJ22fKP6ZhuibyOgP96LyuXM/q1+jciXezVPuz/jxw6QKj6NuFX+A8sM
         Z24vGAlcKIxP07ikydnjBeYEye0+2Q7JDXOPU6lIX+XaRsFrKKr3um681kRjPJZrSRUp
         eq1JM3cs50lT4lyB9Q4dkTEpyA8USDUYlpj5qmZUY4MXfcP95ewRNJy9Nr+9JEy4KOQL
         o5kGwjT7Ha1fQEK2V8Fgv9whnKvDILXVU/mNw9cisfDHr5RHMcZm1P090BCHyKsItgDK
         8pK2wrIS0v0jwm1Gfa9g5rcIlLK4s9gS9RXRX3GlZzQf2Hm2p0knhCQeC4spgT4WR+3f
         cXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eRvXvpISF4IBOtvYHqIw0A7WGfnjimCkRZ9ja9m0ckM=;
        b=kBuIn02rpveGaikYuHrX6s4rnbf1BF+YBsoywZdBicBFvUSlnEarGg/pLTi1huQA0n
         g2sDyAnWtIj4zkjLndYTfDlIB0ruV0Oo6mZ9sIfr2C921ZmU10n5qfQllKZML0igmH/m
         xjCaOFrBE8dSXwrFYOSl0m5U33wyzwQjB//diZz6dmIDifrD4Rop2xOLySKip70q0KES
         iixaZZEYz/drUh67wtHZEXFSzJnSTryYPHcjq334qKw8vQhnkHIzRPoA34vCY1/znu0j
         qt/DxEkPn1x5yEewYRxjpDVdBNfp1q0zM1/jy0nuy+/+FGFYkznkVVZLFBcE3P57izuD
         bJSA==
X-Gm-Message-State: AOAM533nk3N755Ef3jyxp5Lv0oenauyv5yht4fUGyTXJXqIKrHMICFEk
        +71nJfYj+iHbTVjFoimn5E7nAwVrzTg=
X-Google-Smtp-Source: ABdhPJyGS6708sF0bdyf6iWMHpkhy9JBsuOZ8wSAehH9LCLLnfAoUBl4FILaQoGRMgX23tFnvBnr5g==
X-Received: by 2002:a19:a409:: with SMTP id q9mr5244748lfc.654.1615555155774;
        Fri, 12 Mar 2021 05:19:15 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id x4sm1950915ljj.91.2021.03.12.05.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 05:19:15 -0800 (PST)
Subject: Re: [PATCH v2 01/14] opp: Add devres wrapper for
 dev_pm_opp_set_clkname
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
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
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20210311192105.14998-1-digetx@gmail.com>
 <20210311192105.14998-2-digetx@gmail.com>
 <20210312053312.zgke2mzjkqmwn67i@vireshk-i7>
 <CAPDyKFqrUCjTfrNqZ4gFfQS6LpoQCevGc-tv4WVOwuGhx5iiBg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c9cb7a53-ece7-d71d-7ee2-abb959076954@gmail.com>
Date:   Fri, 12 Mar 2021 16:19:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqrUCjTfrNqZ4gFfQS6LpoQCevGc-tv4WVOwuGhx5iiBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

12.03.2021 13:36, Ulf Hansson пишет:
> On Fri, 12 Mar 2021 at 06:33, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> On 11-03-21, 22:20, Dmitry Osipenko wrote:
>>> +struct opp_table *devm_pm_opp_set_clkname(struct device *dev, const char *name)
>>> +{
>>> +     struct opp_table *opp_table;
>>> +     int err;
>>> +
>>> +     opp_table = dev_pm_opp_set_clkname(dev, name);
>>> +     if (IS_ERR(opp_table))
>>> +             return opp_table;
>>> +
>>> +     err = devm_add_action_or_reset(dev, devm_pm_opp_clkname_release, opp_table);
>>> +     if (err)
>>> +             opp_table = ERR_PTR(err);
>>> +
>>> +     return opp_table;
>>> +}
>>
>> I wonder if we still need to return opp_table from here, or a simple
>> integer is fine.. The callers shouldn't be required to use the OPP
>> table directly anymore I believe and so better simplify the return
>> part of this and all other routines you are adding here..
> 
> Yes, please. I was thinking along the same lines, when I reviewed the
> mmc patch (patch9).
> 
>>
>> If there is a user which needs the opp_table, let it use the regular
>> non-devm variant.

Indeed, that's a very good suggestion! The opp_table isn't needed by the
devm users, I'll change it in v3, thanks!
