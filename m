Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C356B1EEBDB
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 22:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgFDUZD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jun 2020 16:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgFDUZD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Jun 2020 16:25:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15E1C08C5C0;
        Thu,  4 Jun 2020 13:25:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t18so7517033wru.6;
        Thu, 04 Jun 2020 13:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kk92pwYJ8IKxem/FhLo1PGHOIRMohDuIFS2c8njRHHI=;
        b=b0R04DBdQzKUkFz3auHl3/33aB8QKHOVW4ieezufx6qQ6fTGBGrN/jtvhl7mbb7FER
         HCuQ78GCrJNMAB3SsvsoZEQWMMEFU15unhzkbtXKC1cw+SvTCdRFEFXqm6kb2pqGGvhm
         acKwZyXm+VLjO1hOnPESdZ7rc4hVZ5W3AYXkesQqduDJOdfx/dd6cDIZVQkMnu3sc+v2
         SpPs5qHe9ndiPh0toGy7mbT+ygxwUA6vANu6SnKQQi084MrjVFig6ORzDKSuzLDJRgew
         Thicol+gjUGeMLM3dykVd8ktmrJ6Ov96MkqfP+yDx9N++dGKDzCaEav0DfLLfb/ZMHlv
         dDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kk92pwYJ8IKxem/FhLo1PGHOIRMohDuIFS2c8njRHHI=;
        b=nE1K+ioukWbXDCEsVi8xx4RrS3PWMhLVhKozpeX2OrUPo3TPnERgExT5h2X7F0+q+B
         VEGnuFfsfW6+GF9tT7Eiq7Y5aomVFeI2Ud+CagcLUE1CCen8fBxpz4Foi7todKOi6zBf
         USRwuaIQ44vR9TNXmNlpXObBUSdNdlmBAs6/iaJNZHO119GUPM66A6uHc6n7cZRvDMfX
         k1+UDMSkYlqPXNlC9hE48DqRfIdJFOEoddPElEyFl+nbYgCMY+3er3jqTu/nJT69tlIZ
         PgGWu512sZJ6L2DnY5diYzDA73oG7ifSqYxvzGTX5bSm0EfYJKlGP1FjRg7VAjTuVknx
         dgrg==
X-Gm-Message-State: AOAM531k9Zo5GDCfkGzZQ8YvnxVPU56AZy/hLio1bdK82LP9saz9wd3/
        I0FFJo+NADnzuUlIVHSgfPI=
X-Google-Smtp-Source: ABdhPJzB8OlXyKXA79AKVZis7NyP04IisboWQ1Cd1jz0jQqqDmOACm2MkLcPS90Phps9g64nMrhXFg==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr6560334wrs.229.1591302300380;
        Thu, 04 Jun 2020 13:25:00 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id c5sm10129201wrb.72.2020.06.04.13.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 13:24:59 -0700 (PDT)
Subject: Re: [PATCH 3/3] spi: bcm2835: Enable shared interrupt support
To:     Mark Brown <broonie@kernel.org>
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
 <21772111-fa1f-7a50-aa92-e44b09cff4eb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8c8d6007-e4c6-8484-9d40-3b679842be27@gmail.com>
Date:   Thu, 4 Jun 2020 13:24:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <21772111-fa1f-7a50-aa92-e44b09cff4eb@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/4/2020 9:05 AM, Florian Fainelli wrote:
> 
> 
> On 6/4/2020 5:32 AM, Mark Brown wrote:
>> On Wed, Jun 03, 2020 at 08:46:55PM -0700, Florian Fainelli wrote:
>>> The SPI controller found in the BCM2711 and BCM7211 SoCs is instantiated
>>> 5 times, with all instances sharing the same interrupt line. We
>>> specifically match the two compatible strings here to determine whether
>>> it is necessary to request the interrupt with the IRQF_SHARED flag and
>>> to use an appropriate interrupt handler capable of returning IRQ_NONE.
>>
>>> For the BCM2835 case which is deemed performance critical, there is no
>>> overhead since a dedicated handler that does not assume sharing is used.
>>
>> This feels hacky - it's essentially using the compatible string to set a
>> boolean flag which isn't really about the IP but rather the platform
>> integration.  It might cause problems if we do end up having to quirk
>> this version of the IP for some other reason.
> 
> I am not sure why it would be a problem, when you describe a piece of
> hardware with Device Tree, even with the IP block being strictly the
> same, its very integration into a new SoC (with details like shared
> interrupt lines) do warrant a different compatible string. Maybe this is
> more of a philosophical question.
> 
>> I'm also looking at the
>> code and wondering if the overhead of checking to see if the interrupt
>> is flagged is really that severe, it's just a check to see if a bit is
>> set in a register which we already read so should be a couple of
>> instructions (which disassembly seems to confirm).  It *is* overhead so
>> there's some value in it, I'm just surprised that it's such a hot path
>> especially with a reasonably deep FIFO like this device has.
> 
> If it was up to me, we would just add the check on BCM2835_SPI_CS_INTR
> not being set and return IRQ_NONE and be done with it. I appreciate that
> Lukas has spent some tremendous amount of time working on this
> controller driver and he has a sensitivity for performance.
> 
>>
>> I guess ideally genirq would provide a way to figure out if an interrupt
>> is actually shared in the present system, and better yet we'd have a way
>> for drivers to say they aren't using the interrupt ATM, but that might
>> be more effort than it's really worth.  If this is needed and there's no
>> better way of figuring out if the interrupt is really shared then I'd
>> suggest a boolean flag rather than a compatible string, it's still a
>> hack but it's less likely to store up trouble for the future.
> 
> Instead of counting the number of SPI devices we culd request the
> interrupt first with flags = IRQF_PROBE_SHARED, if this works, good we
> have a single SPI master enabled, if it returns -EBUSY, try again with
> flags = IRQF_SHARED and set-up the bcm2835_spi_sh_interrupt interrupt
> handler to manage the sharing.
> 
> This would not require DT changes, which is probably better anyway.
Unfortunately this does not work.. The first time we probe the driver we
need to set an interrupt handler that is capable of handling a shared
interrupt. When we probe for subsequent times, we can use the -EBUSY
return code to know that we are in a shared interrupt context, however,
it is too late to change the first controller interrupt handler.

So we do need to know for the first time we install the interrupt
handler whether we will be in a shared situation or not, I cannot think
of any solution other than counting the number of available DT nodes
with the "brcm,bcm2835-spi" compatible string.
-- 
Florian
