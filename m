Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A514F514C92
	for <lists+linux-spi@lfdr.de>; Fri, 29 Apr 2022 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377154AbiD2OT5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 Apr 2022 10:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377006AbiD2OT4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 Apr 2022 10:19:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983C78FFBD
        for <linux-spi@vger.kernel.org>; Fri, 29 Apr 2022 07:16:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dk23so15722330ejb.8
        for <linux-spi@vger.kernel.org>; Fri, 29 Apr 2022 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UdINARUtzcFoW7h6RyjDI8lgOBSw6WOSOqD14X2CFJU=;
        b=R3GZ3IwUpu5UUm3UrgEWZ4yVRf5jvXz7GwFUllasFjFFL0aBEmLKNpewMp+KpvazTf
         g8p8hr+kOKGqyfgS7Y6uQhzrVoBaclahGzEyJPahetcB4lmaLSZiOEXz2JI6zFxDHQpC
         maW0lcQI5+oePb8/E6eX0hAdKzV8yvr+mZ4vk1i/OguhilfBrgpfSdkLeZzOH/QGszCI
         RH2NayuUkJaUmwHXmH4I6VtjsZF4R1jZUbZ8lGtIMUIXu5uVYHzuEr+3e8Zq7RWXMNWD
         XG+381AkVI2TTgKMvdTb9CLibCPzJlooCB/siw0KduRzu5GuQpMZWdmfj293jx06HRzp
         Ng6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UdINARUtzcFoW7h6RyjDI8lgOBSw6WOSOqD14X2CFJU=;
        b=jMKWZ20S5MW99N2YJz1rqTmRtPJTy4PyvpAIX3vgP26OiEFkVNYtcwqy+ubEuR5uoI
         MwfrgcweoSH1yWDgjUTph5B/GH1CqsxZJJk0VOIZkMnmNhCqt8GV+sjJhbtgXvLBSlXf
         UBaTR4/2anlMhYQG8tHxOjaPRRfByltdjdgiT1NsaGHepAFPFKIbyMMrUIQQE501Xbcn
         3eFxnzvW5AxB6IpSz1RqFUuuS+4itar55lsFUoskYFp2mT8hZNW2ydwT0qAeY1ik8xR1
         FVgUhyQ6ka0zxXpRXj+k+0FCKZyUtmvyuGmaF+ByTjxpl1lWqqy3VTGsl7y31QyrhpBj
         iTFw==
X-Gm-Message-State: AOAM532GbbU+pga+4wvWvS7E7oZoHhqbipxIh3yDWnAktFx7pdKwcDc5
        yGwn0KHItr8HI4ttOZIqj0kavQ==
X-Google-Smtp-Source: ABdhPJykYBCwe9aQMDhIZ8XGDNf9p2LGcca3xyCDUbkpjt15wUq7VCOYejWxIXJEzJpfvaAJeCOHOw==
X-Received: by 2002:a17:907:6d12:b0:6f3:d304:e259 with SMTP id sa18-20020a1709076d1200b006f3d304e259mr10624053ejc.110.1651241795135;
        Fri, 29 Apr 2022 07:16:35 -0700 (PDT)
Received: from [192.168.0.170] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j12-20020a50ed0c000000b0042617ba63d4sm2982642eds.94.2022.04.29.07.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 07:16:34 -0700 (PDT)
Message-ID: <75b94ccd-b739-2164-bc4a-20025356cc34@linaro.org>
Date:   Fri, 29 Apr 2022 16:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 12/12] rpmsg: Fix kfree() of static memory on setting
 driver_override
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
 <20220419113435.246203-13-krzysztof.kozlowski@linaro.org>
 <CGME20220429122942eucas1p1820d0cd17a871d4953bac2b3de1dcdd9@eucas1p1.samsung.com>
 <870885de-33f3-e0ba-4d56-71c3c993ac87@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <870885de-33f3-e0ba-4d56-71c3c993ac87@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 29/04/2022 14:29, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 19.04.2022 13:34, Krzysztof Kozlowski wrote:
>> The driver_override field from platform driver should not be initialized
>> from static memory (string literal) because the core later kfree() it,
>> for example when driver_override is set via sysfs.
>>
>> Use dedicated helper to set driver_override properly.
>>
>> Fixes: 950a7388f02b ("rpmsg: Turn name service into a stand alone driver")
>> Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> This patch landed recently in linux-next as commit 42cd402b8fd4 ("rpmsg: 
> Fix kfree() of static memory on setting driver_override"). In my tests I 
> found that it triggers the following issue during boot of the 
> DragonBoard410c SBC (arch/arm64/boot/dts/qcom/apq8016-sbc.dtb):
> 
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> WARNING: CPU: 1 PID: 8 at kernel/locking/mutex.c:582 
> __mutex_lock+0x1ec/0x430
> Modules linked in:
> CPU: 1 PID: 8 Comm: kworker/u8:0 Not tainted 5.18.0-rc4-next-20220429 #11815
> Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> Workqueue: events_unbound deferred_probe_work_func
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __mutex_lock+0x1ec/0x430
> lr : __mutex_lock+0x1ec/0x430
> ..
> Call trace:
>   __mutex_lock+0x1ec/0x430
>   mutex_lock_nested+0x38/0x64
>   driver_set_override+0x124/0x150
>   qcom_smd_register_edge+0x2a8/0x4ec
>   qcom_smd_probe+0x54/0x80
>   platform_probe+0x68/0xe0
>   really_probe.part.0+0x9c/0x29c
>   __driver_probe_device+0x98/0x144
>   driver_probe_device+0xac/0x14c
>   __device_attach_driver+0xb8/0x120
>   bus_for_each_drv+0x78/0xd0
>   __device_attach+0xd8/0x180
>   device_initial_probe+0x14/0x20
>   bus_probe_device+0x9c/0xa4
>   deferred_probe_work_func+0x88/0xc4
>   process_one_work+0x288/0x6bc
>   worker_thread+0x248/0x450
>   kthread+0x118/0x11c
>   ret_from_fork+0x10/0x20
> irq event stamp: 3599
> hardirqs last  enabled at (3599): [<ffff80000919053c>] 
> _raw_spin_unlock_irqrestore+0x98/0x9c
> hardirqs last disabled at (3598): [<ffff800009190ba4>] 
> _raw_spin_lock_irqsave+0xc0/0xcc
> softirqs last  enabled at (3554): [<ffff800008010470>] _stext+0x470/0x5e8
> softirqs last disabled at (3549): [<ffff8000080a4514>] 
> __irq_exit_rcu+0x180/0x1ac
> ---[ end trace 0000000000000000 ]---
> 
> I don't see any direct relation between the $subject and the above log, 
> but reverting the $subject on top of linux next-20220429 hides/fixes it. 
> Maybe there is a kind of memory trashing somewhere there and your change 
> only revealed it?

Thanks for the report. I think the error path of my patch is wrong - I
should not kfree(rpdev->driver_override) from the rpmsg code. That's the
only thing I see now...

Could you test following patch and tell if it helps?
https://pastebin.ubuntu.com/p/rp3q9Z5fXj/

-----

diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 3e81642238d2..1e2ad944e2ec 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -102,11 +102,7 @@ static inline int
rpmsg_ctrldev_register_device(struct rpmsg_device *rpdev)
        if (ret)
                return ret;

-       ret = rpmsg_register_device(rpdev);
-       if (ret)
-               kfree(rpdev->driver_override);
-
-       return ret;
+       return rpmsg_register_device(rpdev);
 }

 #endif
diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
index 8eb8f328237e..f26078467899 100644
--- a/drivers/rpmsg/rpmsg_ns.c
+++ b/drivers/rpmsg/rpmsg_ns.c
@@ -31,11 +31,7 @@ int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
        rpdev->src = RPMSG_NS_ADDR;
        rpdev->dst = RPMSG_NS_ADDR;

-       ret = rpmsg_register_device(rpdev);
-       if (ret)
-               kfree(rpdev->driver_override);
-
-       return ret;
+       return rpmsg_register_device(rpdev);
 }
 EXPORT_SYMBOL(rpmsg_ns_register_device);
