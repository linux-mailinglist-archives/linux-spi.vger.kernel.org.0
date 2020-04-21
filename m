Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00C41B2DD6
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 19:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgDURL6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 13:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725870AbgDURL6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Apr 2020 13:11:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57AEC061A41;
        Tue, 21 Apr 2020 10:11:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i10so17282741wrv.10;
        Tue, 21 Apr 2020 10:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oWXq+CmUxcR5oGjgIGi8cH6yIaEJ8WHHwP9A2TLvszA=;
        b=t/4cXjNDAVvxUuRDqC0SeUAz0JY4JFR+sU6Cz8/FilRkgKIrVQ4TbLFAyOq6JHlTyH
         mEcch6tjReA+E8MJx0FL+eZSXd/Yuy/9PFbosO1Oeizr/6ncp81K/MZ11zJVntaF310r
         DRaeyfVVHTyPERez3YfgVqMHG4ElIKrc+VTT3ceqn1SNCBS+CtVRmJuQDj2yItaHs+Oi
         5MqwyEYucTZ0HiPrejyJs+rv5V7PBAGYZS4FL28A0Q+MjpnqYXvDoCo2GM7ahI9vE0BA
         0HXMifOexpOMRIYlKwEKwCdXWENCh2OOf3GDH+XBWDdEB3tVRo8VsfPyR2MR0dMvckR6
         IYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oWXq+CmUxcR5oGjgIGi8cH6yIaEJ8WHHwP9A2TLvszA=;
        b=gYTApINIpyRpnALJSEn2RynRzR8lYU8bpqJh9q8DHE9qKeT5ZB4rOhoQgDhDyd+nR5
         9swKMqwCTTGuH1oj2rF3uQ0Po3rYeKnASXpVF5qfhzmwSI80GLUKwMBiZrBbSv5jDAc+
         vJDx2vlycOqfJAkdNsJKKcxG0IK/5megGFsmQev1f/yWEOHkRDNewv7syHZbW9b+ZxQq
         czEzKMuN7BboCgShU7LH9g/GyvnayQyIcIaZZoefxzCZGy+LHkBLlUm9RcI94nhAXHfE
         vyJynBcSNGNgSPIsSsCtP7+97GR7OE537bav+8KMgEVHtzoPMOc2DMObdMq1o2n/Zy6+
         AU0w==
X-Gm-Message-State: AGi0PuZBbi5MCTnDDlFfrBxqv2ZhW/zAEf16kvamxomO9IIpAJggjyvC
        uXpArwrDOQxCNYHE83F+vkgX9DGR
X-Google-Smtp-Source: APiQypJu/C68hg1hMwxmwAGbTtJcpHmk7e7ZQPPioXPfGKR2MQJ2sfWEUG0W9bYrdDy48QE7HU5lDQ==
X-Received: by 2002:adf:f990:: with SMTP id f16mr23210451wrr.33.1587489116264;
        Tue, 21 Apr 2020 10:11:56 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id l5sm4486784wrm.66.2020.04.21.10.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 10:11:55 -0700 (PDT)
Subject: Re: [Patch v3 1/9] spi: bcm-qspi: Handle clock probe deferral
To:     Mark Brown <broonie@kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
 <20200420190853.45614-2-kdasu.kdev@gmail.com>
 <158748156553.18089.8164001089518853868.b4-ty@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2d810e4f-5f05-4257-59a8-882ae790ecd1@gmail.com>
Date:   Tue, 21 Apr 2020 10:11:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158748156553.18089.8164001089518853868.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 4/21/2020 8:06 AM, Mark Brown wrote:
> On Mon, 20 Apr 2020 15:08:45 -0400, Kamal Dasu wrote:
>> From: Florian Fainelli <f.fainelli@gmail.com>
>>
>> The clock provider may not be ready by the time spi-bcm-qspi gets
>> probed, handle probe deferral using devm_clk_get_optional().
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
>>
>> [...]
> 
> Applied to
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

It would be nice if the URL could be clickable, e.g.:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-5.7

> 
> Thanks!
> 
> [1/9] spi: bcm-qspi: Handle clock probe deferral
>        commit: 0392727c261bab65a35cd4f82ee9459bc237591d
> [2/9] dt: bindings: spi: Add support for mspi on brcmstb SoCs
>        (not applied)
> [3/9] spi: bcm-qspi: Handle lack of MSPI_REV offset
>        (not applied)
> [4/9] spi: bcm-qspi: Drive MSPI peripheral SSb pin on cs_change
>        commit: 742d5958062488d03082a9ff01a6afb3cf7bd634
> [5/9] spi: bcm-qspi: when tx/rx buffer is NULL set to 0
>        commit: 4df3bea7f9d2ddd9ac2c29ba945c7c4db2def29c
> [6/9] spi: bcm-qspi: Make PM suspend/resume work with SCMI clock management
>        commit: 1b7ad8c405c3dc0ad6c2dc61fe21fe7a446cceeb
> [7/9] spi: bcm-qspi: Use fastbr setting to allow faster MSPI speeds
>        (not applied)
> [8/9] spi: bcm-qspi: add support for MSPI sys clk 108Mhz
>        (not applied)
> [9/9] spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists only on legacy controllers
>        (not applied)
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 

-- 
Florian
