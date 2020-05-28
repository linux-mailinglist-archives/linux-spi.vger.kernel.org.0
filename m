Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0D71E5819
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 09:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgE1HCO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 03:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgE1HCO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 03:02:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C98C05BD1E
        for <linux-spi@vger.kernel.org>; Thu, 28 May 2020 00:02:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so12991431pgn.5
        for <linux-spi@vger.kernel.org>; Thu, 28 May 2020 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2rfJt6cMB0A5H+KRJ06GfOB35inHfbKK+Lu2N3H0uLs=;
        b=aigRQ1Zglr9P+qpkaVgFFNXz1lFYKsLiUUWLzQMf8c0jB/Mb7IhoqaLI6+5JYa7D4/
         5dowqioADwxSRIXPDbBA2TEeBe7tsX6wTMc7xYnVgrRQCDXSAmmItUIRvuA0eZgt2eQB
         ISdfGbjQzcFiuGYda7Nc5eTWIKuvXC5mRj0+9xlNj+fgGN5RVFyyQCf/92sfHcxMaNZi
         oTXrdcWN0/SEEhvLPQwZJ4z2+cdaOBNmOEYIct0hnXuZisryrS6jBQvcWtZUQGjKB6MY
         vG98XYpeADxtCxi3Zvb2wrg61kz6lTJzjYRNvJVWiLaoNB8u2gN8dpQzwZLhCzMQaaEm
         bnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2rfJt6cMB0A5H+KRJ06GfOB35inHfbKK+Lu2N3H0uLs=;
        b=XE5MkvUYabITI0fW02SkKVqtoCopN1C3Aew+ZGfLK2j7n8McU0AMgyP6D/Ro2h7lJY
         19QIzkP2kK866XRSDm4cIi5Esag758Ed3LTsEl1HpcgP701jcjwRhdPGy/SqlipBX1Oc
         qnzwi/0wWYmTu/svS+8mJSa2zWuZK8JpTHWhC29PiYHYv9hAdJkvClz8AlSGwQATe5lE
         LuHr8iQplLXQPZiV6h2XapEuFF2P8cGt8D7el1aVqTbwJ/XWrtiJQdphFdR5aemvIDmK
         Cu+mVkFUzLHTgNdpxXwarWGOpF21qdPp/bkH+GY+1uV5eMTxigbTNA/6fa53MryIoxkC
         xMMw==
X-Gm-Message-State: AOAM532eX7q61fvKICCLrJtiR/8O5IMZF9RMP68gik1Rp1EjrT3ByhpT
        0rRpyWjA4zYYRMN+7kwh5JY=
X-Google-Smtp-Source: ABdhPJz5iueeugsXc7TxiAaH19Ivz2j7wOR8L+M0mxHPEr5GcGTMAWORPlCMzXIuWnrRMB3gz+rqFA==
X-Received: by 2002:a63:711b:: with SMTP id m27mr1546596pgc.324.1590649333534;
        Thu, 28 May 2020 00:02:13 -0700 (PDT)
Received: from [192.168.1.59] (i60-35-254-237.s41.a020.ap.plala.or.jp. [60.35.254.237])
        by smtp.gmail.com with ESMTPSA id y65sm3835719pfb.76.2020.05.28.00.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 00:02:12 -0700 (PDT)
Subject: Re: [PATCH 2/3] spi: pxa2xx: Fix controller unregister order
From:   Tsuchiya Yuto <kitakar@gmail.com>
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
 <2e9365fd-9307-045a-8afe-1770f7cd7eda@gmail.com>
Message-ID: <7e085731-a56f-07d5-3ad0-a8f7d0a93516@gmail.com>
Date:   Thu, 28 May 2020 16:02:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <2e9365fd-9307-045a-8afe-1770f7cd7eda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Correction (obvious but just in case)

On 5/27/20 10:14 PM, Tsuchiya Yuto wrote:
>
> On 5/27/20 9:27 PM, Andy Shevchenko wrote:
>> On Wed, May 27, 2020 at 09:09:17PM +0900, Tsuchiya Yuto wrote:
>>> [...]
>>>
>>> I also built a kernel against your branch topic/spi/reload
>>> (permalink: https://github.com/andy-shev/linux/tree/55cb78d5a752). The
>>> result is the same as only applying this series; so, to fix the NULL pointer
>>> dereference that I mentioned in bugzilla [2], only this series is required.

*I also built a kernel from your branch topic/spi/reload

>>> Also, I want to make sure that what you tried in that branch is fixing
>>> the NULL pointer dereference on spi_pxa2xx_platform module removal when
>>> touch input crashed, not fixing the touch input crashing itself?
>>
>> Yes, my aim was to fix the SPI module reload issue. While the applied patch
>> from Lukas does a huge improvement, there are still issues with ordering (you
>> probably will never see them, though it's still possible based on the code).
>>
>> So, as far as I understood, the touch still able to come into position where
>> it's not anymore responsive. Is it correct?
>
> Yes, the touch still able to come into non-working state after every s2idle,
> but always can be resurrected by reloading spi_pxa2xx_platform.

This is true for both this series and branch topic/spi/reload

> What this series fixed is the following thing:
> - without this series: reloading spi_pxa2xx_platform resurrects touch
>   input with causing NULL pointer dereference (system still operational
>   after this anyway)
> - with this series: reloading spi_pxa2xx_platform resurrects touch input
>   *without* causing NULL pointer dereference
>
> Let me know if any further info is required.

*What this series (and branch topic/spi/reload) fixed is the following thing:

>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=206403
>>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=206403#c1

