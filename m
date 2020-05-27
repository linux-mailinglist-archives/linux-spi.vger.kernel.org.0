Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75161E4329
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 15:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgE0NO6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 09:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbgE0NO6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 May 2020 09:14:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24483C08C5C1
        for <linux-spi@vger.kernel.org>; Wed, 27 May 2020 06:14:58 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b190so11795709pfg.6
        for <linux-spi@vger.kernel.org>; Wed, 27 May 2020 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KYlW/AdW1ATlNURwl4MEZxOIucq6kVS5uC0pT2QvX1E=;
        b=HSKOYY8b1DhyEjwmdEJVEmAwoRpWo9m6jVnHAqpTC4C0aoiONgOiNO4bZFF43sa/zv
         4HVuIfLra7vIBXao7CCSi828K23OkYfrCPy0Rh8mOnVDuPsfNA0bqCfSPLYEcV80ihqo
         mfPzsFpEjMEPZEkauRfRbPp48K3l62Ot2EsD9NDaYiR7SrKTtC90iUvMjL4iyLvsXh8+
         GoaEIIQsXttr9l3jzpCsJyI9VqZ7sTBPsHCoq6PFuRXilpa++x6BvRiqJVNr4331gQg3
         Oz5yv+Q4mtH5/w0l/vG+pC1kwk1yCMLfofLB83lZ9tAdBjLiAjyF9Dea5HgUwrLmKr1a
         0mRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KYlW/AdW1ATlNURwl4MEZxOIucq6kVS5uC0pT2QvX1E=;
        b=rQlG3wVl3GeHEk2egSHx8wxqLpneg1xDi5eO9SWldbQVGGEyHRyQRu3HhjxFlTPsd3
         JU8TN9yT14AhopckRpeV08HT5um8vjklOqTkecPvP2tsf0XldTb18RhY2FiakYgxYveM
         nceRCsXj6P/rxTkH5hXXWN8UWnsTEaINGsjKkduCOXQePSgbloBHYraHkWMiFMbMUjv1
         0Qczb2sB9xD1JK2UMqMGt/+Y2THYSCnifphb6ui+ARMP1AbxY0sc17+W/4VOCQcybYJD
         trV57BUWRqb2e9gACOjOpcnfOspUyawHO20/Bbv0xTOynm+7K8rY0C+AJffA2mpWxo2n
         il0Q==
X-Gm-Message-State: AOAM531cqx5Bmc+uTAxTsPR/2VOx2eHUCI4rkmxFeko61ftDDq7sAhEk
        3NVasJ0BQ9qQoFCaSheus2s=
X-Google-Smtp-Source: ABdhPJzdzD3TYMEtkfu3fqI0ZCgVNfab3xRPNw26iFFYOqlV3VRG9DCgQOrtS9yMNov+Rl7zVuwgJg==
X-Received: by 2002:aa7:84da:: with SMTP id x26mr3911109pfn.24.1590585297340;
        Wed, 27 May 2020 06:14:57 -0700 (PDT)
Received: from [192.168.1.59] (i60-35-254-237.s41.a020.ap.plala.or.jp. [60.35.254.237])
        by smtp.gmail.com with ESMTPSA id b29sm2151555pff.176.2020.05.27.06.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 06:14:56 -0700 (PDT)
Subject: Re: [PATCH 2/3] spi: pxa2xx: Fix controller unregister order
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
References: <cover.1590408496.git.lukas@wunner.de>
 <834c446b1cf3284d2660f1bee1ebe3e737cd02a9.1590408496.git.lukas@wunner.de>
 <20200525132143.GX1634618@smile.fi.intel.com>
 <20200526073913.vmgak5xsrjiyn4ae@wunner.de>
 <20200526082204.GM1634618@smile.fi.intel.com>
 <45681e81-7efd-857f-eea1-fb4767e3d946@gmail.com>
 <20200527122753.GN1634618@smile.fi.intel.com>
From:   Tsuchiya Yuto <kitakar@gmail.com>
Message-ID: <2e9365fd-9307-045a-8afe-1770f7cd7eda@gmail.com>
Date:   Wed, 27 May 2020 22:14:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527122753.GN1634618@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 5/27/20 9:27 PM, Andy Shevchenko wrote:
> On Wed, May 27, 2020 at 09:09:17PM +0900, Tsuchiya Yuto wrote:
>> I tried a kernel built with the prerequisite patch to this series + all
>> of patches in this series on top of v5.7-rc7 (with Arch Linux config
>> + olddefconfig).
>>
>> Current situations on 5.7-rc7 with Arch Linux config + olddefconfig
>> (without applying this series):
>> - I can reproduce the touch input crashing (surface3-spi) I mentioned
>>   in bugzilla [1] only after s2idle.
>> - all the other situations are the same as described in that bugzilla;
>>   I see NULL pointer dereference [2] after touch input crashing then try
>>   to unload only spi_pxa2xx_platform module.
>>
>> So, the steps to test that I did with this series applied are:
>> 1. go into s2idle then resume from s2idle
>> 2. make a touch input then surface3-spi reports that "SPI transfer
>>    timed out" repeatedly and no longer responds to any touch input
>> 3. try to unload only spi_pxa2xx_platform module and see if the NULL
>>    pointer dereference no longer occurs
>>
>> and I can confirm that I no longer see the NULL pointer dereference.
>> Thanks!
>
> Thank you very much for testing!
>
>> On 5/26/20 5:22 PM, Andy Shevchenko wrote:
>>> On Tue, May 26, 2020 at 09:39:13AM +0200, Lukas Wunner wrote:
>>>> On Mon, May 25, 2020 at 04:21:43PM +0300, Andy Shevchenko wrote:
>>>>> Tsuchiya Yuto, I'm going to apply this series as preparatory to my
>>>>> WIP patch in topic/spi/reload branch in my kernel tree on GitHub,
>>>>> so, it would be possible to see if this + my patch fixes crashes
>>>>> on removal. Though, please test this separately from my stuff to
>>>>> clarify if it fixes or not issue you have seen.
>>>> You also need to cherry-pick commit 84855678add8 ("spi: Fix controller
>>>> unregister order") from spi/for-next onto your topic/spi/reload branch
>>>> for reloading to work correctly.
>>>>
>>>> Alternatively, rebase your topic/spi/reload branch and redo the merge
>>>> from spi/for-next.  (You've merged spi/for-next into your branch on
>>>> May 14, but the commit was applied by Mark on May 20.)
>>> Ah, right. Will do it soon.
>>
>> I also built a kernel against your branch topic/spi/reload
>> (permalink: https://github.com/andy-shev/linux/tree/55cb78d5a752). The
>> result is the same as only applying this series; so, to fix the NULL pointer
>> dereference that I mentioned in bugzilla [2], only this series is required.
>>
>> Also, I want to make sure that what you tried in that branch is fixing
>> the NULL pointer dereference on spi_pxa2xx_platform module removal when
>> touch input crashed, not fixing the touch input crashing itself?
>
> Yes, my aim was to fix the SPI module reload issue. While the applied patch
> from Lukas does a huge improvement, there are still issues with ordering (you
> probably will never see them, though it's still possible based on the code).
>
> So, as far as I understood, the touch still able to come into position where
> it's not anymore responsive. Is it correct?

Yes, the touch still able to come into non-working state after every s2idle,
but always can be resurrected by reloading spi_pxa2xx_platform.

What this series fixed is the following thing:
- without this series: reloading spi_pxa2xx_platform resurrects touch
  input with causing NULL pointer dereference (system still operational
  after this anyway)
- with this series: reloading spi_pxa2xx_platform resurrects touch input
  *without* causing NULL pointer dereference

Let me know if any further info is required.
>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=206403
>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=206403#c1
>
