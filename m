Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C73D1EE8BB
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgFDQkT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jun 2020 12:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbgFDQkT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Jun 2020 12:40:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D251C08C5C0;
        Thu,  4 Jun 2020 09:40:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 5so1420863pjd.0;
        Thu, 04 Jun 2020 09:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A3i1Y/uWZjvOKPJmr6UpXk+ssrbNL04u8CPNIJtcrUM=;
        b=Ib7Wc1GnX3qN2AImWV6NMbcrCTmw3Q2G02/8t7+ZAdbp5pnq9zar82fav50SR9V44Z
         bHjAdfvge/2orXyJV5wgsojwuGWWeM8BgfXjl8HSXxmLvi+1qEokqYWq7UmS1fhwRdLr
         elmkEava9W0hOtXbWzHrlRGI17+TdRAKuAL94+RbdHYU3oQBIM8UkNzUBmPd6WOV1QpC
         OxLxBZeLEdsfu+h1pDPd9m26bbqadt8vw+l3N2zfGSLoVqLR0QfzZ/inWMB6FTkxcD33
         WalkNDwcneAwdvMp+8b6LeV/4ICyRepKs/T5hOcVuQFGKLaH3ok60zkF8ci34OXkMZYT
         1B/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A3i1Y/uWZjvOKPJmr6UpXk+ssrbNL04u8CPNIJtcrUM=;
        b=bGWV9GVGhYXXtpHeaGORX5GFm4vdiX4VQ/ynERJhX6t43q2J4ezNlZEIplpxqJSjhm
         MeCynOvWNeJFHhlJP4u7/VlVtzRYqVDREXA/SmlYWv30Z4ZhbIu55FL/VjX4PoKxUhac
         7svMPQD2yMYWrWiatv4Bd1FwZiMD6h7RWLq4zw8vHAYxdGa0y2MSzK/KWaxlXKuG616K
         +Qb5impTU7Ag5pMVXeaCagzmyR7CAkd4RHqyano+4CRWu0peoi5Ub8+l+BGQ7QvDweBX
         I2LhLYNa+xkixinB12fJHFnqYNenl8v2kNKMqLzpZW1HW6nO01qlzRiB7Nefqp28JdP9
         GdGQ==
X-Gm-Message-State: AOAM533yiivvByCAZnAUMswxsodNH4Tfngu+1spVOO+uXDy0GqwRZ3+1
        4RnLBWY0IVS6CoMRi8rLios=
X-Google-Smtp-Source: ABdhPJwHCqIPELRZMH+m8w5zHxSff7d/Jnxr6zWedksxAa4bE5qv/P/51TM6EZ2sLGPMS2V0vMUnJA==
X-Received: by 2002:a17:90b:3651:: with SMTP id nh17mr7093309pjb.4.1591288818763;
        Thu, 04 Jun 2020 09:40:18 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j8sm5807508pjw.11.2020.06.04.09.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 09:40:16 -0700 (PDT)
Subject: Re: [PATCH 2/3] ARM: dts: bcm2711: Update SPI nodes compatible
 strings
To:     Lukas Wunner <lukas@wunner.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        Martin Sperl <kernel@martin.sperl.org>
References: <20200604034655.15930-1-f.fainelli@gmail.com>
 <20200604034655.15930-3-f.fainelli@gmail.com>
 <20200604042038.jzolu6k7q3d6bsvq@wunner.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <15c3995e-87de-0f2b-3424-5dd698b181d3@gmail.com>
Date:   Thu, 4 Jun 2020 09:40:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200604042038.jzolu6k7q3d6bsvq@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/3/2020 9:20 PM, Lukas Wunner wrote:
> On Wed, Jun 03, 2020 at 08:46:54PM -0700, Florian Fainelli wrote:
>> The BCM2711 SoC features 5 SPI controllers which all share the same
>> interrupt line, the SPI driver needs to support interrupt sharing,
>> therefore use the chip specific compatible string to help with that.
> 
> You're saying above that the 5 controllers all share the interrupt
> but below you're only changing the compatible string of 4 controllers.
> 
> So I assume spi0 still has its own interrupt and only the additional
> 4 controllers present on the BCM2711/BCM7211 share their interrupt?

Correct, there are 5 instances, but only the 4 that were added for 2711
actually share the interrupt line, I will correct that in the next patch
version.
-- 
Florian
