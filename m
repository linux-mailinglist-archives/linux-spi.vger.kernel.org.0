Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCE91E4198
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 14:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgE0MJY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 08:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgE0MJW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 May 2020 08:09:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1958BC08C5C1
        for <linux-spi@vger.kernel.org>; Wed, 27 May 2020 05:09:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 131so3365106pfv.13
        for <linux-spi@vger.kernel.org>; Wed, 27 May 2020 05:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KY6Tznn/z7pknc6YzPoxOJU/b/w6YOoY471UwuqUlQU=;
        b=kGXXsfzEktkR8Ixzk/o0WNJReihZtwUM4yTSHapYSIFzANPgGFSroDfKHZpNN0OGuy
         z7PCqic47M8HFWLpYRICDDmmrjcIJZJybWUpOLaZroqwsn1DNwzxxZM93kky+so1x93C
         eLdkTrpJJsgjKW1ksSrVRsgEkH7YEbbi6zHo8xcEiWAax33L3hPLzyw6zZcncdWCVOWj
         lTK8jQaOnvIhouzpkcteeAECvrhBa02CUzVzysIHj3ZovXB1dcbxfDxvpw/uKbmqHs71
         XLMR7R16LRn8mPOD/TzFkES4EGfyR98bon3JM78AuPAVpiPyAFSNxBLAiCJPDJrRwJ+Z
         o8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KY6Tznn/z7pknc6YzPoxOJU/b/w6YOoY471UwuqUlQU=;
        b=o/LgCcpJlJhWXCbsrHcAck5pogjSHbue2OLEwbMXAGZ2Q1a5MxOa0sbnkU6c9N7rAN
         u95xOL7rWv4RXVerX1jei8waFdgl7i11CfFTgb+gSyydM/2vrjdeU+rTxPqbgYqxgXJG
         LidnqiiYsMh4wB6YZDSZHINAkbvD0udWnRz//I3GLEgbWN6Ulp7c6/kh0IdSpv3HI4uV
         bnvDVANNv1t+fI9LmgjrrHkNsxObmunCOQhcNFD3tFiEYzOJVsPSvlLFM8OkUt0+JWjc
         C3Hcxyk1vWY7BT1aeMR5XX8SZsWVHgVgROjebMmG+xXuZ7muAbwf+mFo2+dAiSAQ/HOf
         Edxg==
X-Gm-Message-State: AOAM531J+PScPfGbOrgIaoV7GhAsmITuxaVq5YCfIX6M607jS3OKyW86
        9EatNy+b4/31MQd/CMLRa1w=
X-Google-Smtp-Source: ABdhPJyJGXBeo7jK3/LuxOtBFMFRBV96ClU5V3zXOD8m16nKnWx9m5lKx0iZ5A7UaS/HC3Pfo/lP6w==
X-Received: by 2002:a62:1512:: with SMTP id 18mr3668793pfv.326.1590581361355;
        Wed, 27 May 2020 05:09:21 -0700 (PDT)
Received: from [192.168.1.59] (i60-35-254-237.s41.a020.ap.plala.or.jp. [60.35.254.237])
        by smtp.gmail.com with ESMTPSA id q12sm2078517pfn.129.2020.05.27.05.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 05:09:20 -0700 (PDT)
Subject: Re: [PATCH 2/3] spi: pxa2xx: Fix controller unregister order
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
References: <cover.1590408496.git.lukas@wunner.de>
 <834c446b1cf3284d2660f1bee1ebe3e737cd02a9.1590408496.git.lukas@wunner.de>
 <20200525132143.GX1634618@smile.fi.intel.com>
 <20200526073913.vmgak5xsrjiyn4ae@wunner.de>
 <20200526082204.GM1634618@smile.fi.intel.com>
From:   Tsuchiya Yuto <kitakar@gmail.com>
Message-ID: <45681e81-7efd-857f-eea1-fb4767e3d946@gmail.com>
Date:   Wed, 27 May 2020 21:09:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200526082204.GM1634618@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I tried a kernel built with the prerequisite patch to this series + all
of patches in this series on top of v5.7-rc7 (with Arch Linux config
+ olddefconfig).

Current situations on 5.7-rc7 with Arch Linux config + olddefconfig
(without applying this series):
- I can reproduce the touch input crashing (surface3-spi) I mentioned
  in bugzilla [1] only after s2idle.
- all the other situations are the same as described in that bugzilla;
  I see NULL pointer dereference [2] after touch input crashing then try
  to unload only spi_pxa2xx_platform module.

So, the steps to test that I did with this series applied are:
1. go into s2idle then resume from s2idle
2. make a touch input then surface3-spi reports that "SPI transfer
   timed out" repeatedly and no longer responds to any touch input
3. try to unload only spi_pxa2xx_platform module and see if the NULL
   pointer dereference no longer occurs

and I can confirm that I no longer see the NULL pointer dereference.
Thanks!

On 5/26/20 5:22 PM, Andy Shevchenko wrote:
> On Tue, May 26, 2020 at 09:39:13AM +0200, Lukas Wunner wrote:
>> On Mon, May 25, 2020 at 04:21:43PM +0300, Andy Shevchenko wrote:
>>> Tsuchiya Yuto, I'm going to apply this series as preparatory to my
>>> WIP patch in topic/spi/reload branch in my kernel tree on GitHub,
>>> so, it would be possible to see if this + my patch fixes crashes
>>> on removal. Though, please test this separately from my stuff to
>>> clarify if it fixes or not issue you have seen.
>> You also need to cherry-pick commit 84855678add8 ("spi: Fix controller
>> unregister order") from spi/for-next onto your topic/spi/reload branch
>> for reloading to work correctly.
>>
>> Alternatively, rebase your topic/spi/reload branch and redo the merge
>> from spi/for-next.  (You've merged spi/for-next into your branch on
>> May 14, but the commit was applied by Mark on May 20.)
> Ah, right. Will do it soon.

I also built a kernel against your branch topic/spi/reload
(permalink: https://github.com/andy-shev/linux/tree/55cb78d5a752). The
result is the same as only applying this series; so, to fix the NULL pointer
dereference that I mentioned in bugzilla [2], only this series is required.

Also, I want to make sure that what you tried in that branch is fixing
the NULL pointer dereference on spi_pxa2xx_platform module removal when
touch input crashed, not fixing the touch input crashing itself?

[1] https://bugzilla.kernel.org/show_bug.cgi?id=206403
[2] https://bugzilla.kernel.org/show_bug.cgi?id=206403#c1

Thanks,

Tsuchiya Yuto
