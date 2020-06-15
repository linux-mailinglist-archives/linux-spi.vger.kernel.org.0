Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198D91FA0A3
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 21:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbgFOTm4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 15:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbgFOTmz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 15:42:55 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A6CC061A0E;
        Mon, 15 Jun 2020 12:42:54 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s23so8265516pfh.7;
        Mon, 15 Jun 2020 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0qrQRoXABWjnKwQa7O+onv4TFfIuamL/7UM0/e+lKcY=;
        b=L2sUgJQOmXLIdpN/acBHO/x2Cs7rcGS5cLssbvpSCPQavY3CLsMPoxVRWpDQ4X3gg2
         Q6EhXUvFvQYhYYYikWxkiO8jgo9sxSaLKxp0irclj3xWDXwHWzSmnmErDycvzIxS3G0i
         fKcDmGBbWHU5ZcS45ePpyoZ62Grc589q5VCS5LX8TwDSRLtIrtWycymbEQ0o3/Xb/FP4
         K/IlsTc96LpXUjzuoz74MUtSgISWwunogcs9Kn7bx5EbyvWj8Dah2flMxF9A0IKyNFOe
         qylDtRWWQUxDgq9sjf9xcJLZWxo4W1z4ascb3zMs8UXv1cFkP939eIgwwnwwVCaEdeI6
         WQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0qrQRoXABWjnKwQa7O+onv4TFfIuamL/7UM0/e+lKcY=;
        b=X2ny6vDoe+7KIUVmK1lWnDte8x3yD3KPMryMY4HcAzUN6ZdZ1WoQixAW1YFz6CtXju
         Rkj60ldv0/DAyqz5qcxBLwBqjuVxoPorteYHEgYPoC5ZBYFbUdy/a8hJkjxyU6iNwsPU
         BRld8FZ4T8a/cJ7GalG5MdhoZ/MJQk1zARI171p2Tmgu7FZZjgQcQG7dnQB+bwwIXngG
         FTKJQL79XacsEmrqFJ8PqhxuNukq4boGomMxIzATTH2ixRhujCB2lcgnCZkhHM5zoOSp
         cHnfJvSaqH5+W4R//PnZ/nVQZ5eLO3t37MKNW/bJpAXg+crgLhWEa5sdeuiod9TO/szD
         VU3w==
X-Gm-Message-State: AOAM5321NhYxSb4vfi8Diau057WeFlDMRKg7xcoXRe9Wn5VyoD8sX3zq
        qMz+lxc3pxWGAjqMc6MMGCE=
X-Google-Smtp-Source: ABdhPJzd8NKZ4V1T8V4Nkdlh9ron23wWPpYk6qMRFJf5t5GVGxrIMoa3t6qMXRy8YkjSV+ietR9EQg==
X-Received: by 2002:a63:546:: with SMTP id 67mr23612510pgf.364.1592250173912;
        Mon, 15 Jun 2020 12:42:53 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n65sm14213758pfn.17.2020.06.15.12.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 12:42:53 -0700 (PDT)
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
To:     Robin Murphy <robin.murphy@arm.com>, Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
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
 <20200608114148.4bau4mdcvwgf25ut@wunner.de>
 <3d4fd3f9-9bde-90a8-bef5-9fc97cc9b363@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2e4a6c4b-857f-1000-e7fd-327b0800fb97@gmail.com>
Date:   Mon, 15 Jun 2020 12:42:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3d4fd3f9-9bde-90a8-bef5-9fc97cc9b363@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/15/2020 12:09 PM, Robin Murphy wrote:
> On 2020-06-08 12:41, Lukas Wunner wrote:
>> On Mon, Jun 08, 2020 at 12:11:11PM +0100, Robin Murphy wrote:
>>> And all in code that has at least one obvious inefficiency left on
>>> the table either way.
>>
>> Care to submit a patch to overcome that inefficiency?
> 
> I'll have a quick go, but without any way to measure performance impact
> (or even test for correctness) I don't fancy going too deep based purely
> on disassembly and ARM11 cycle timings.
> 
>>> This thread truly epitomises Knuth's "premature optimisation"
>>> quote... ;)
>>
>> The thread came about because it can be determined at compile time
>> whether the interrupt is going to be shared:
> 
> ...which is exactly my point - "because it can be" is anything but proof
> that avoiding a trivial check makes enough measurable difference to
> justify putting in the effort to do so.
> 
>> On the BCM2835 (Raspberry Pi 1), CONFIG_ARCH_MULTI_V6 is set and this
>> SoC doesn't have multiple bcm2835-spi instances, so no shared interrupt.
>>
>> The question is how to discern BCM2836/BCM2837 (Raspberry Pi 2/3), which
>> do not have multiple instances, and BCM2711 (Raspberry Pi 4) which does.
> 
> Hmm, how much relative importance does that have? On a 700MHz ARM11 it's
> obviously desirable to spend as little time in the IRQ handler as
> possible in order to have time left to do anything else, but on the
> other SoCs even if the IRQ remains permanently asserted it can still
> only consume 25% of the available CPU capacity, at which point the
> impact of 2-3 cycles either way at 1GHz+ seems pretty much immeasurable.
> 
>> The Raspberry Pi Foundation compiles BCM2711 kernels with
>> CONFIG_ARM_LPAE=y,
>> but Florian considered that kludgy as a discriminator and opted for
>> runtime-detection via the compatible string instead.  If you've got
>> a better idea please come forward.
>>
>> Is "optimize shared IRQ support away if IS_ENABLED(CONFIG_ARCH_MULTI_V6),
>> else leave it in" the best we can do?
> 
> In all honesty I'm starting to think it seriously might be :)

Or how about this: we slightly re-structure the interrupt handler such
that all possible interrupt conditions are explicitly handled and
terminate with a return IRQ_HANDLED, and those which are not, including
in the case of a "spurious" (because the interrupt was triggered for
another SPI controller instance), then we finish the function with
IRQ_NONE. This would not impact the performance for the BCM2835/36/37
which would still have a single controller/single interrupt line to handle.
-- 
Florian
