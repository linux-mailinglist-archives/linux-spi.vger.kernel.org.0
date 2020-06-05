Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3221F02B7
	for <lists+linux-spi@lfdr.de>; Sat,  6 Jun 2020 00:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgFEWEv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 18:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgFEWEv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Jun 2020 18:04:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C08C08C5C2;
        Fri,  5 Jun 2020 15:04:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id p5so11159707wrw.9;
        Fri, 05 Jun 2020 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4obgiWJMjzopugCNtxoiM9Fhsn1z9LnA6SizhmkTt9g=;
        b=oWoLOs1DYFcKnc8iyzbCZ5ZjmvwzsLAT0uIZzcGnirqHov3z6YGwjUGZSTtIs7Y8Rg
         8xMoBSEI1DJHKhJu5l/4DyyYhmVYPtrPxGF8cidtj/AY1sx/rUmFNeqb6uhmNwyP9IKK
         JLPa/uJZkImCV+PcqI0o8T8pHZQ74MxP+TYPEtsKScM/B6AGX6ocLuSxmazHCdCPqxBH
         YKZQBoGBMLFLh6YbYGxROSRKqOmtbLRj0aI4EpP+VwyIxNqxnB7bO6Xe4di9FQCV5imO
         fzTaYt/G66Z68LK/oltgGYC0EIj+e3eiMPpBQR/V0pd6dPfEv3sjVEZ0cw2C9Bsmeoy3
         TEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4obgiWJMjzopugCNtxoiM9Fhsn1z9LnA6SizhmkTt9g=;
        b=li7UTBKe+b8qZx59wGmN87GkugFnblDLkzshtUjN6RKS7dRN/VRsM5FxLFZnmhG9rk
         t8wCMVeXuu4iupwrrHu/aKwJqwsxrGlAyJzW2btPE5WypiovNKPRKNLcyz7qF12yV1iW
         dtAblmMgWvXkvDzxtMnvy7n9WRa3zkhRmbmB0XBhd1ZFIZgCrxXM6oWWwJwMABALDvt/
         c35vHawQPne/C3cyW5WPf3NJEpkI+yprGOva5aES/cvyXpalY/ICHgpuQFPO/E1ld5K2
         FR6tuZaI44UapWyWgiXEQ12x5VibsycbO4f/8xnFQv50GBjf9v3q8aL++1eRQRwKYgOY
         QhHQ==
X-Gm-Message-State: AOAM530hO+wsMxJfiAmBcRa25p2fgZQf2Bkv9UKyMEq0PNgezJkrH2F5
        qY/0I8TuXcmtEBKXREI2lSA=
X-Google-Smtp-Source: ABdhPJwJjWSx6RXx3ecmtFnocQfoqBGkAO9vSi2BfvV03xiJ7JhGCPlV2aEFgXx7veXxm5wOr3U6nw==
X-Received: by 2002:adf:8b0c:: with SMTP id n12mr12594963wra.340.1591394689565;
        Fri, 05 Jun 2020 15:04:49 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a1sm13205415wmd.28.2020.06.05.15.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 15:04:48 -0700 (PDT)
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
To:     Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>, lukas@wunner.de
Cc:     "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <20200604212819.715-1-f.fainelli@gmail.com>
 <142d48ae-2725-1368-3e11-658449662371@arm.com>
 <20200605132037.GF5413@sirena.org.uk>
 <2e371a32-fb52-03a2-82e4-5733d9f139cc@arm.com>
 <06342e88-e130-ad7a-9f97-94f09156f868@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d3fe8b56-83ef-8ef0-bb05-11c7cb2419f8@gmail.com>
Date:   Fri, 5 Jun 2020 15:04:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <06342e88-e130-ad7a-9f97-94f09156f868@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/5/2020 7:41 AM, Robin Murphy wrote:
> On 2020-06-05 14:46, Robin Murphy wrote:
>> On 2020-06-05 14:20, Mark Brown wrote:
>>> On Fri, Jun 05, 2020 at 12:34:36PM +0100, Robin Murphy wrote:
>>>> On 2020-06-04 22:28, Florian Fainelli wrote:
>>>
>>>>> For the BCM2835 case which is deemed performance critical, we would
>>>>> like
>>>>> to continue using an interrupt handler which does not have the extra
>>>>> comparison on BCM2835_SPI_CS_INTR.
>>>
>>>> FWIW, if I'm reading the patch correctly, then with sensible codegen
>>>> that
>>>> "overhead" should amount to a bit test on a live register plus a
>>>> not-taken
>>>> conditional branch - according to the 1176 TRM that should add up to a
>>>> whopping 2 cycles. If that's really significant then I'd have to wonder
>>>> whether you want to be at the mercy of the whole generic IRQ stack
>>>> at all,
>>>> and should perhaps consider using FIQ instead.
>>>
>>> Yes, and indeed the compiler does seem to manage that.  It *is* non-zero
>>> overhead though.
>>
>> True, but so's the existing level of pointer-chasing indirection that
>> with some straightforward refactoring could be taken right out of the
>> critical path and confined to just the conditional complete() call.
>> That's the kind of thing leaving me unconvinced that this is code
>> where every single cycle counts ;)
> 
> Ha, and in fact having checked a build out of curiosity, this patch
> as-is actually stands to make things considerably worse. At least with
> GCC 8.3 and bcm2835_defconfig, bcm2835_spi_interrupt_common() doesn't
> get inlined, which means bcm2835_spi_interrupt() pushes/pops a stack
> frame and makes an out-of-line call to bcm2835_spi_interrupt_common(),
> resulting in massively *more* work than the extra two instructions of
> simply inlining the test.
> 
> So yes, the overhead of inlining the test vs. the alternative is indeed
> non-zero. It's just also negative :D

Is it reliable across compiler versions if we use __always_inline?

The only other alternative that I can think of is using a static key to
eliminate the test for the single controller case. This feels highly
over engineered, but if that proves more reliable and gets everybody
their cookie, why not.

Lukas, do you have any way to test with the conditional being present
that the performance or latency does not suffer so much that it becomes
unacceptable for your use cases?
-- 
Florian
