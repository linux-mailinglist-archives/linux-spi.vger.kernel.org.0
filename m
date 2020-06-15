Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7331F9E0C
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 19:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbgFOREw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 13:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgFOREw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 13:04:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558F6C061A0E;
        Mon, 15 Jun 2020 10:04:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 10so8064800pfx.8;
        Mon, 15 Jun 2020 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ZukZRysDpxL7fluIxKkVz5UMBr+FzAndpusseTc58o=;
        b=RRk08ULTO8k9lQEnZPvMHzTmLcBYiBUfQqYtqU0+OXYULw/mQHXm1p+4jWfh6uWqVy
         XvGa5nV6UfH+8LUhazVxdugNTG+Ig2BKwdEqEvDlKp+/ZHCJfu0qmZmKLctYTHF8/5I0
         tKl+o71fVnw8sKFXKi9LBaLsLQAg0VW4fo4fxA/NEzSICTJ4lUJMEz4jPFxoW95ow25E
         evL5iC/gZi8hQ4RGxXqVBGGjY2giAMgQDXVSMfBkvIxaNpr9exnTy8EX3ZWjTPetND+S
         hghLTzEoONyP3+ZOXHPAA3tt2Kh3xb7m1gs8QFmgOGiEwnmMN1RG6Yle7Zih94TlqQXH
         gxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ZukZRysDpxL7fluIxKkVz5UMBr+FzAndpusseTc58o=;
        b=qWSKX67dhZ1pxb+R28ozD/HrDr+TR7/m0eeVOob1mZ2ThWzp0t3IaZIQV7etTPlwlY
         BMFBUAVKoJ6WywYc5/laa6BaOOv6HNfR7aj0SLip5eUr/Gn7MFqYA78TwMc/bPAkLHhM
         LquxJhovgNeZ1wM5gXptIycptNOfjMANyN7oaFZpNh8nar3NnEf3fncvlWUBFCFnpZI6
         G9CFez/PKWilxvOxV6Yh1Xg5Pdti6MYZ706VUJXhV/I43ql19j0JkUgKh0vpLIKQ0Bm0
         8JY58uVcNel7Z4fMMfMlCtvU57EpjW7kXhUYEBYRPK6tbIYioZSZgL3EhswusS95WSdG
         a1aw==
X-Gm-Message-State: AOAM532uUtSf04wPZWyI/6o/u5qddm2ZX77uzOi/PFfyJa5oeydAUyTz
        xbiQLYn7zLlPf3nWe4XUYYs=
X-Google-Smtp-Source: ABdhPJxkrT/eEFR2lr5RpODPo3zO/3YcXLxATPx3PWI7oA17rPMi1gELvyI+TosRvIfdlRhWVQPn9g==
X-Received: by 2002:a63:c407:: with SMTP id h7mr21679517pgd.174.1592240691842;
        Mon, 15 Jun 2020 10:04:51 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b23sm12254427pgs.33.2020.06.15.10.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 10:04:51 -0700 (PDT)
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
To:     Mark Brown <broonie@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, lukas@wunner.de,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
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
 <d3fe8b56-83ef-8ef0-bb05-11c7cb2419f8@gmail.com>
 <a6f158e3-af51-01d9-331c-4bc8b6847abb@arm.com>
 <20200608112840.GC4593@sirena.org.uk>
 <bb9dbf11-9e33-df60-f5ae-f7fdfe8458b4@gmail.com>
 <20200615170031.GA4447@sirena.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <692bc94e-d574-e07a-d834-c0d569e87bba@gmail.com>
Date:   Mon, 15 Jun 2020 10:04:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615170031.GA4447@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/15/2020 10:00 AM, Mark Brown wrote:
> On Mon, Jun 15, 2020 at 09:34:58AM -0700, Florian Fainelli wrote:
> 
>> OK, so this has been dropped for spi/for-next right? How do we move from
>> there?
> 
> Well, I actually have it queued up for applying so unless I pull it
> before my scripts get that far through the stuff I queued over the merge
> window it'll go in (I dropped it due to it not being a bugfix).  If it
> were me I'd go with the two instruction hit from checking the flag TBH
> but otherwise I guess __always_inline should work for compilers that
> misoptimize.  None of this is getting in the way of the framework so if
> everyone involved in the driver is happy to spend time optimising it
> and dealing with the fragility then it's fine by me.

OK, how about I send you an increment patch (would a fixup be okay?)
that adds __always_inline since we know from this thread that some
compilers may mis-optimize the function inlining?
-- 
Florian
