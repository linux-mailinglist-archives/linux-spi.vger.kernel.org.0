Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C50FD44D9
	for <lists+linux-spi@lfdr.de>; Fri, 11 Oct 2019 18:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfJKQBO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Oct 2019 12:01:14 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:33347 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfJKQBO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Oct 2019 12:01:14 -0400
Received: by mail-pf1-f171.google.com with SMTP id q10so6363239pfl.0;
        Fri, 11 Oct 2019 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=itQoi2dgqCgMSiWT5e6lfORl7lgUJoSIb5pqH2SRdb8=;
        b=EE48D9SvWa4Y7ktBRPyGiJaOJitENY9e4a+b3iU214qrQtkjkdd5J8p0xVi1lSqLtB
         ykuxzJhICU9bhPoAq2AvypqBylXUp1e+UQs/wnq7TnOGY20q/VGxZVYy8QomZ2rxf8d/
         QVgHdWUC2Df2hnhkyRPRdBbRsH9ZBhx7lHXxzl2Awanb2kIAEPeY4OuPvnxunRdaQIHq
         uDdvPLmA48EB2uzgmbLlDJKxTH4GKYavhSQC2D8DDIvmbkbE8S4wePLK4EWdno9DNWh8
         z7WSK4Mg7Kiir0wAa+Fq+RipQSGF1EpPei+luszijXebtRkRB1/M1NxFiaJ/MQL7ED65
         Ns1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=itQoi2dgqCgMSiWT5e6lfORl7lgUJoSIb5pqH2SRdb8=;
        b=jtd1vW0Gt+gfqUKNu2dd/3FdDwTdqYDP2OfogkySH8aNcS4EF6Y2TU4ZRm8A62Dp6W
         dKBs9Avfvalt5XRCqpYd9puryFeVFZbHGOgSmdNUbu0muZq4AXNtbctCVw7tb0DVnNKZ
         Nw1Zt0ujYvOIo1D8gjWn2/M4z3CKirRQFsipHHSQpmsx1Z/dI9+4+ZRBinUD3RzCP2lC
         TePGZ+3PbQvGHOadVDy0d5Nj/AUsj7pa3fPRCwwzSqCBejr3iQ3c3tEp25tU0J91t2Fs
         GAt0+xUshG/9cdgVW6LAB72hAiWLehB2WgJtINXfDjA8IN3fW6FwsLcxhxcM9DT9MlkO
         2QPQ==
X-Gm-Message-State: APjAAAWmngMoeGkfE8joqJsWvETXUuUMNxjUlUUMa1bHz7CKtOi/Wfq2
        oxSP3w59OraRWv9AXAOLAgIzHG8I
X-Google-Smtp-Source: APXvYqytD3kiUVj/n9RgfT3nJvTuGMHAhCgy20cz+KMDm2IZ22jcZi7jUehEPkoqNqvwexRDVPYYXg==
X-Received: by 2002:a17:90a:a781:: with SMTP id f1mr18939245pjq.29.1570809673513;
        Fri, 11 Oct 2019 09:01:13 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id y2sm10375535pfe.126.2019.10.11.09.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 09:01:11 -0700 (PDT)
Subject: Re: Potential NULL pointer deference in spi
To:     Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
References: <CABvMjLToYzmCue-TiDhR4Yu4v3+Z+-UV9WhixV7uvwoMh2m5Lw@mail.gmail.com>
 <f3ce1620-c421-b41f-440b-efe3ff6e91fe@gmail.com>
 <CABvMjLTrGprdgFTP-+2XC_p+vE+tVWeYvyuLGkKj1dY7KR+JDg@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <214886b4-ec40-3959-35ff-f9b5a2507300@gmail.com>
Date:   Fri, 11 Oct 2019 09:01:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABvMjLTrGprdgFTP-+2XC_p+vE+tVWeYvyuLGkKj1dY7KR+JDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 10/10/19 10:31 PM, Yizhuo Zhai wrote:
> Hi Eric:
> 
> My apologies for bothering, we got those report via static analysis
> and haven't got a good method to verify the path to trigger them.
> Therefore I sent those email to you maintainers first since you
> know much better about the details. Sorry again for your time and
> I take your suggestions.

My suggestion is that you need to make deep investigations on your own,
before sending mails to lkml@, reaching thousands of people on the planet.

Static analysis tools having too many false positive are not worth
the time spent by humans.

I knew nothing about drivers/spi/spi.c, but after few minutes reading the code,
it was clear your report was wrong.

Do not ask us to do what you should do yourself.

Thanks.

> 
> On Wed, Oct 9, 2019 at 10:48 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>>
>>
>> On 10/9/19 10:37 PM, Yizhuo Zhai wrote:
>>> Hi All:
>>>
>>> drivers/spi/spi.c:
>>>
>>> The function to_spi_device() could return NULL, but some callers
>>> in this file does not check the return value while directly dereference
>>> it, which seems potentially unsafe.
>>>
>>> Such callers include spidev_release(),  spi_dev_check(),
>>> driver_override_store(), etc.
>>>
>>>
>>
>>
>> Many of your reports are completely bogus.
>>
>> I suggest you spend more time before sending such emails to very large audience
>> and risk being ignored at some point.
>>
>> Thanks.
> 
> 
> 
