Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1CB3AEC6A
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 17:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFUPeA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 11:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhFUPd7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Jun 2021 11:33:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1CCC06175F;
        Mon, 21 Jun 2021 08:31:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j1so2949534wrn.9;
        Mon, 21 Jun 2021 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Avdk1cUnyC3+7ojOpNcEOTf+b0zh4pnCSxeUUKvMgU=;
        b=pb7zUMh4jKMQrXlWGF+7NuVNDCPEG6tfXli5PjjwPOJ6HZl6kEKtEt31V353GSH8N9
         azwWA9imwKfh5CyHXlWxxZBRs0P0k3+3BnlbFbjrBWqaFJJ0CclGEblfvKg+SDGE8oRf
         y94s2Ixn2moENrpLEj/jHRig8K260Bft0Q34xERqDtL4hFYOj0GujA/2FIfC+jFoTI1x
         WF3KUpkLkdCgn5OGezzuRkZ0oFfywS1Bggv9Ux0hseaBKLSZZ9MAdNzkWmfYrrdEwtBf
         QCcojUWBn1A567DX5L7JjLnC1o81ffrGqH2MG8blB7i7fWalU/5Kd1jgpybsAnlJLRmY
         ByiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Avdk1cUnyC3+7ojOpNcEOTf+b0zh4pnCSxeUUKvMgU=;
        b=AHTfrnGkFznHpK678pFXwXS634JU1YUkR1o8QUhIdL1hjDfYXi5O8jmfM2AnJSxyAV
         WjB0qAyMJVJlZRorzgkkRJIYkGI0g33V/m9xQe7bI5RW1pQeGlosncAJ/eixldBUSait
         wrrM80fOyDk3z0JdXB2OCre/GGo2lGKIuFoGHY7zHGeNNQrBpZH9f399+EwuZOvl8r3E
         J9neGgRTjO5u2Gxs3pCgz0lBGLaYcMb48TxhaSXMl0n7ttoBV7YcV9evGuFCI7rSLyTU
         zK9fg6MZfkBv/My3cqC+KlKr0vCNCEKPeo61RSMqUwwelPhTjapVkd0vJbPmP2dqTOy2
         4tew==
X-Gm-Message-State: AOAM533BPvk+I5FfALI2DpzYuljqxTWrQd0sjBrjEVcjdR54TvFZ+Gow
        ByP7HDaKWpmm8MFQHhxRItM=
X-Google-Smtp-Source: ABdhPJwsdPv8YPaJiJ+psK8OYI/7K0cxWXu8s9IqZypjDJJHlYTbHy6awnRQ23P4LyPYJmXCXSph3A==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr29225427wrv.373.1624289503156;
        Mon, 21 Jun 2021 08:31:43 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
        by smtp.gmail.com with ESMTPSA id k13sm4506181wrp.73.2021.06.21.08.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:31:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] dt-binding: mediatek: mt6779: update spi document
To:     Mark Brown <broonie@kernel.org>,
        Mason Zhang <mason.zhang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, hanks.chen@mediatek.com,
        linux-kernel@vger.kernel.org,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1623721803.24597.9.camel@mbjsdccf07>
 <20210615111426.GC5149@sirena.org.uk>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <732a8061-e8be-5c8a-ea75-6da87947db02@gmail.com>
Date:   Mon, 21 Jun 2021 17:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210615111426.GC5149@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 15/06/2021 13:14, Mark Brown wrote:
> On Tue, Jun 15, 2021 at 09:50:03AM +0800, Mason Zhang wrote:
>>
>> this patch update spi document for MT6779 SOC.
> 
> I don't have either patch 1 or a cover letter, what's the story with
> dependencies here?
> 

No dependency. The dt-bindings was just send a second patch in the series. First
one can be found here:
https://patchwork.kernel.org/project/linux-mediatek/patch/20210613055458.6073-1-mason.zhang@mediatek.com/

Regards,
Matthias
