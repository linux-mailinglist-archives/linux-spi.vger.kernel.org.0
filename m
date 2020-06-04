Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81A21EE834
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 18:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgFDQFu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jun 2020 12:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgFDQFu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Jun 2020 12:05:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF0BC08C5C0;
        Thu,  4 Jun 2020 09:05:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i12so1311929pju.3;
        Thu, 04 Jun 2020 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HAWfVJ/MMzDDKipytKTsDnZ0G7qcc8KGtxLvXJOdNtk=;
        b=Vr/I6zf9wpjvEwDaJRBX1+2aezi8wRyFreAa10APW8X1OHOEJVUF5Q7ARa3lfsQxV5
         PonhEHPXMbOZ92Hv3xwguR8YsivIs6B6pm4J5X1yPTPMefCXweIlZEILCdduTmW+yxyw
         OhnEBT4jsdV70Qrr/oA/Ze0IpOOH9DdR2SA5hFnhkya/j7r/2psfkWCwVhcqQIt/xwQy
         shgoaSohosf7QXYHzM2Sp3IzNFwxzNG2HrlEmLya+hN+YPiSKSe2J76DTQQC9iYlPsjv
         N7o0wJbseIrr7hrSLutCvvD3KwHNTA/MPX1Ln8fg20ENbh/0qci1FwGRVgYfXf/irWnd
         uUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HAWfVJ/MMzDDKipytKTsDnZ0G7qcc8KGtxLvXJOdNtk=;
        b=KXLP2vJl/fBSDRxvPujOop52zkcrCnQu4buv448yjXQJZ6alvaj4MoGWYBFWpljZSy
         +I2uT1214BZ0h6Xm+yr7tg3rOZbnbkIZ0Rhl0FkffL9SXNY9Tyb0nu1DGrABJl2N7FV8
         4RNNkZpsnrk5cFJ9GgOSQOQ2Ln5f2s3oj9Vg/a5VRXW137E1O0quLAjc1kqsRykoAf2L
         gmQpTZAy60aeWS55kvQ98njQ9A+xWPYeHfh3W62yqaB9VRB36KdjIq6lyz0+/4ErUI8A
         1DGsWwjG0pBl0+/ESv4AEA/Qkw0GELaxyloIBDJaVZz5BGCeUcYD3pXmhBjXsAutiF6m
         2tGg==
X-Gm-Message-State: AOAM532NjU0I5ExazNOQXGtNEvVtDAMdJancwdvnNbSYn/s9Icdxb3Hg
        sxUzi7BlZCloEvakxtAFiDc=
X-Google-Smtp-Source: ABdhPJzDmXwGbLzqmN4JtHAm4tslIFeo872mF9VRUt+Ly23GpPsGhckeyoYK7qV6BFeOQmVssm8UQQ==
X-Received: by 2002:a17:90a:5806:: with SMTP id h6mr7122674pji.66.1591286749669;
        Thu, 04 Jun 2020 09:05:49 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n8sm5559105pjq.49.2020.06.04.09.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 09:05:48 -0700 (PDT)
Subject: Re: [PATCH 3/3] spi: bcm2835: Enable shared interrupt support
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>, lukas@wunner.de
References: <20200604034655.15930-1-f.fainelli@gmail.com>
 <20200604034655.15930-4-f.fainelli@gmail.com>
 <20200604123220.GD6644@sirena.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <21772111-fa1f-7a50-aa92-e44b09cff4eb@gmail.com>
Date:   Thu, 4 Jun 2020 09:05:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200604123220.GD6644@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/4/2020 5:32 AM, Mark Brown wrote:
> On Wed, Jun 03, 2020 at 08:46:55PM -0700, Florian Fainelli wrote:
>> The SPI controller found in the BCM2711 and BCM7211 SoCs is instantiated
>> 5 times, with all instances sharing the same interrupt line. We
>> specifically match the two compatible strings here to determine whether
>> it is necessary to request the interrupt with the IRQF_SHARED flag and
>> to use an appropriate interrupt handler capable of returning IRQ_NONE.
> 
>> For the BCM2835 case which is deemed performance critical, there is no
>> overhead since a dedicated handler that does not assume sharing is used.
> 
> This feels hacky - it's essentially using the compatible string to set a
> boolean flag which isn't really about the IP but rather the platform
> integration.  It might cause problems if we do end up having to quirk
> this version of the IP for some other reason.

I am not sure why it would be a problem, when you describe a piece of
hardware with Device Tree, even with the IP block being strictly the
same, its very integration into a new SoC (with details like shared
interrupt lines) do warrant a different compatible string. Maybe this is
more of a philosophical question.

> I'm also looking at the
> code and wondering if the overhead of checking to see if the interrupt
> is flagged is really that severe, it's just a check to see if a bit is
> set in a register which we already read so should be a couple of
> instructions (which disassembly seems to confirm).  It *is* overhead so
> there's some value in it, I'm just surprised that it's such a hot path
> especially with a reasonably deep FIFO like this device has.

If it was up to me, we would just add the check on BCM2835_SPI_CS_INTR
not being set and return IRQ_NONE and be done with it. I appreciate that
Lukas has spent some tremendous amount of time working on this
controller driver and he has a sensitivity for performance.

> 
> I guess ideally genirq would provide a way to figure out if an interrupt
> is actually shared in the present system, and better yet we'd have a way
> for drivers to say they aren't using the interrupt ATM, but that might
> be more effort than it's really worth.  If this is needed and there's no
> better way of figuring out if the interrupt is really shared then I'd
> suggest a boolean flag rather than a compatible string, it's still a
> hack but it's less likely to store up trouble for the future.

Instead of counting the number of SPI devices we culd request the
interrupt first with flags = IRQF_PROBE_SHARED, if this works, good we
have a single SPI master enabled, if it returns -EBUSY, try again with
flags = IRQF_SHARED and set-up the bcm2835_spi_sh_interrupt interrupt
handler to manage the sharing.

This would not require DT changes, which is probably better anyway.
-- 
Florian
