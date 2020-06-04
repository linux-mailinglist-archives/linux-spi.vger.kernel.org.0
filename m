Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6DF1EE8F1
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 18:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgFDQ4g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Jun 2020 12:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgFDQ4g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Jun 2020 12:56:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE12C08C5C0;
        Thu,  4 Jun 2020 09:56:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k26so6424487wmi.4;
        Thu, 04 Jun 2020 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yyo4KyvNLCp48hTrE/2wSjir4V0WrNaYX/MRdBgNvDA=;
        b=IU4b3IdczSWQInpvnunrpURYrLt9dtAraztan0YpZXMhsrIooTfV+cKrzsgD2w8NrH
         iO2lSkobzNPiBIzzqRROjNx1d/yDEsMzTAjW2Vgbp0smWuVh523AUxRitJbak7koxdmE
         zUHUvgri1wv2ok4NsfZxp57OGAtOzXwiu3cJRE3+kiNAIChRKj3TeKssKcv1GDezBmKy
         ABRcYshhW7ucUX9J1BY1WCqTzADIWKfscnyEGrzmS4gyam8AmvfevbqgsD8/ZkrNYft1
         aKYcdNw1WEx1nR8BvGl4sQrAKB1wPYUruVW7vgBcLv28VZ7xpVRRwfu3i/hKn8TF/TDR
         c+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yyo4KyvNLCp48hTrE/2wSjir4V0WrNaYX/MRdBgNvDA=;
        b=oA586ZC8AioYbtuqdxUgF+3fCMAG/yjuHB4+cf5KYfKPZjTTWPpvg+I0RDQjcc7J6y
         xJkAeqw/wOoORR5eTvraWPFx9l3WeBEHmT3uy2qDVp8LRdFe4HE7AgVAx6A4u/rGlYMT
         ahonUcvMQe+jfnM+8plePKdos8b046a/Y3jrNHbk88zKDRJlgUWZU7erUcLmb81E6vG/
         Rey2tMGKFt4jaN3rqu9ED2ZJUCVRL6CVh1l5g/69SdGQWD8/TrA5y1iFXivLO+y9Tvfo
         JV+0NntNbUpzrXhj7VVHSxE1EzE3i2vQDE9tyttu7TWn73k6RXNhtS2WkcDggFU2PYOx
         Ke6A==
X-Gm-Message-State: AOAM530g0Qw+qgmNT4FutQaXvMUIX76Yg7NYoJxifhbCzdYf0MKHpoTs
        0A9AGNUHDC4SFbtGxKklXd8=
X-Google-Smtp-Source: ABdhPJyxMsabr1zTTvpkZOvWyqmukJw7LjSZh+pHXhWsCUNL2Y0pldact5JckuW0x6wB8nxIGpJFGw==
X-Received: by 2002:a1c:408:: with SMTP id 8mr4796343wme.15.1591289794801;
        Thu, 04 Jun 2020 09:56:34 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id u13sm7751254wmm.6.2020.06.04.09.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 09:56:34 -0700 (PDT)
Subject: Re: [PATCH 2/3] ARM: dts: bcm2711: Update SPI nodes compatible
 strings
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <20200604034655.15930-1-f.fainelli@gmail.com>
 <20200604034655.15930-3-f.fainelli@gmail.com>
 <20200604042038.jzolu6k7q3d6bsvq@wunner.de>
 <15c3995e-87de-0f2b-3424-5dd698b181d3@gmail.com>
 <2978874a-fe1e-3b07-381d-55dcb00ecca7@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <903cf9fc-d493-583f-a3da-42f58cd7b474@gmail.com>
Date:   Thu, 4 Jun 2020 09:56:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <2978874a-fe1e-3b07-381d-55dcb00ecca7@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/4/2020 9:54 AM, Stefan Wahren wrote:
> Am 04.06.20 um 18:40 schrieb Florian Fainelli:
>>
>> On 6/3/2020 9:20 PM, Lukas Wunner wrote:
>>> On Wed, Jun 03, 2020 at 08:46:54PM -0700, Florian Fainelli wrote:
>>>> The BCM2711 SoC features 5 SPI controllers which all share the same
>>>> interrupt line, the SPI driver needs to support interrupt sharing,
>>>> therefore use the chip specific compatible string to help with that.
>>> You're saying above that the 5 controllers all share the interrupt
>>> but below you're only changing the compatible string of 4 controllers.
>>>
>>> So I assume spi0 still has its own interrupt and only the additional
>>> 4 controllers present on the BCM2711/BCM7211 share their interrupt?
>> Correct, there are 5 instances, but only the 4 that were added for 2711
>> actually share the interrupt line, I will correct that in the next patch
>> version.
> 
> No, all 5 instances uses the same interrupt line. Please see my comment
> before.

OK, but this is not going to be needed, I have another solution that
does not involve device tree changes.
-- 
Florian
