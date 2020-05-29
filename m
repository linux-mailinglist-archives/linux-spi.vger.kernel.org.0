Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DCC1E7F4F
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 15:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgE2NzF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 09:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2NzE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 09:55:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C886DC03E969
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2020 06:55:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id z15so3167541pjb.0
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2020 06:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Y6e0zK8SGiIVSRaW9UOx0T9DS2NxV88rfBTA1VIDvfs=;
        b=cTr16qJWUO8gPXJ7bJih9K+kPvwBN6cnJd48EPQFT23+UF0Qjz3i9NJfamp08IN6w6
         jbKh/hl0LXJjsNEjBRiEaVTvSWw+Mhwaz8XDQfH4ov7p6UPeZUllAvsLzjKP8g20ANyG
         p0YB9f8DFhx4RoPXXprlsFttVlMKm0zsm6DRz3iuaj9RNnxDymcf8xOSRMH0Bqer0ADi
         sl4m4PI6YnVq8bO4lNMNMHfGeRTHUTDF25YftzcTf1Ingx+O7zS3VjWdctUesUqS+l7F
         FNEu7YOjE1a9mdZ8ZIXbZRtkrZMkMpujrYjEg3rjam5QAmbuAz/K5TfbPWXoEIPSUnqX
         ENgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y6e0zK8SGiIVSRaW9UOx0T9DS2NxV88rfBTA1VIDvfs=;
        b=JnCe955wAaz/d2cmUeszsIHCO/l2JTYorwLNMQ/IfHwjBqakg68OArXSOd7WJOJHd0
         GwKUuikBmFA2j03ecGiMmrhp2ariCnlNZPB0eoEnroshZtsijMxll93sLDgAj+nOyiQC
         /xAWN1g/hQ4TUuLXuCRmLbDJvyUwDICUwsq2/RcHd+8+m0NnDQs5LlhoQIBmUmsTRzau
         6FMLMcDJ9rSK8ehaCT/Ns9RUFWNCZFA7Yvjq0xZA6rcs1G92qlKZ8ZLt+x/ntpNPSIYd
         DRXOyXkN8LSwI3h73Z7vYe1MPETHQFzEN0pR34IOKpILmtzZaNVD+iI1yuqVmgSDpHAN
         PFfA==
X-Gm-Message-State: AOAM5339zyqNtCM6hSTqZEMCNHDyXDpPn5NrtS+XvwyCOPkUBv0gnIE5
        ZFzmMGn28E+leeL/KRPP3WS7RJ4Esvs=
X-Google-Smtp-Source: ABdhPJw20mJcvyk7nbB/rdsweM3XjEjwIE/gwToKuhbEtcvNvUm6guBkjILMu57MQuGH5VeLnoG7Eg==
X-Received: by 2002:a17:902:d711:: with SMTP id w17mr8565722ply.139.1590760504077;
        Fri, 29 May 2020 06:55:04 -0700 (PDT)
Received: from [192.168.1.59] (i60-35-254-237.s41.a020.ap.plala.or.jp. [60.35.254.237])
        by smtp.gmail.com with ESMTPSA id 131sm7665987pfv.139.2020.05.29.06.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 06:55:03 -0700 (PDT)
Subject: Re: [PATCH 2/3] spi: pxa2xx: Fix controller unregister order
To:     Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
References: <cover.1590408496.git.lukas@wunner.de>
 <834c446b1cf3284d2660f1bee1ebe3e737cd02a9.1590408496.git.lukas@wunner.de>
 <20200525132143.GX1634618@smile.fi.intel.com>
 <20200526073913.vmgak5xsrjiyn4ae@wunner.de>
 <20200526082204.GM1634618@smile.fi.intel.com>
 <45681e81-7efd-857f-eea1-fb4767e3d946@gmail.com>
 <20200527122753.GN1634618@smile.fi.intel.com>
 <2e9365fd-9307-045a-8afe-1770f7cd7eda@gmail.com>
 <7e085731-a56f-07d5-3ad0-a8f7d0a93516@gmail.com>
 <CAHp75Ve6xUhic1g2A1cGoCOOom55Za=WXzR4C9o5=zMN80nFdA@mail.gmail.com>
 <20200528093127.pjzvrqab6xvvcmgi@wunner.de>
From:   Tsuchiya Yuto <kitakar@gmail.com>
Message-ID: <819795f3-08ce-75af-078f-32c6567a2ecf@gmail.com>
Date:   Fri, 29 May 2020 22:54:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528093127.pjzvrqab6xvvcmgi@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 5/28/20 6:31 PM, Lukas Wunner wrote:
> On Thu, May 28, 2020 at 11:41:21AM +0300, Andy Shevchenko wrote:
>> Thank you very much for testing, I will figure out what can be done
>> more there, but it's minor now.
>> For input and touchscreen I guess you may ask Dmitry (input subsystem
>> maintainer) and Benjamin (HID, but he might have an idea as well).
>
> This might not be an input issue, perhaps the spi-pxa2xx.c driver
> cannot cope with s2idle on this particular platform.
>
> E.g., pxa2xx_spi_suspend() zeroes the SSCR0 register.  It seems this
> disables or resets the controller.  But pxa2xx_spi_resume() isn't
> touching the register at all.  Maybe the register contains crap when
> coming out of s2idle, so needs to be set to a sane value on resume?

Thanks everyone. I later found that touch input (surface3_spi) crashing
is reproducible by just putting display off/on on recent kernels. So,
this is rather not related to s2idle. Also it seems that runtime_pm is
not related, too.

> Tsuchiya Yuto says that reloading the SPI controller driver makes
> the touch driver work again, so I'd check what's done on ->remove()
> and ->probe() both in the touch driver as well as in the SPI controller
> driver that fixes the problem.  The SSCR0 register is zeroed on
> ->remove() and re-initialized on ->probe(), so that register may
> indeed play a role.

I looked into what is done on probe()/remove() in the SPI controller
and it seems that release/setup DMA helps to get surface3_spi driver
working again with DMA mode.

I added details to that bugzilla [1], since this crashing itself is not
relevant to this series.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=206403#c4
