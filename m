Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F633A342D
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jun 2021 21:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFJTkW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Jun 2021 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJTkV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Jun 2021 15:40:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ECEC061574;
        Thu, 10 Jun 2021 12:38:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id c10so889380eja.11;
        Thu, 10 Jun 2021 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CxZFPPf8/Af3IJZUxSvuHpUIlLCprby35hrQY11nLk0=;
        b=BWtEQUN8nf/6VjFK7uhX1RcY5asvzB2UiEbS72Lz0vJtWPA30K4QVKDr6Poc2pDDRe
         sRdWYwKF8HsBo6gKk3HT6GgCsVSXYDKywKq3m02x93ockwiewh/qXh/4UtQAm8fzeCxf
         aMHpeKdJkB431MW04XPNfStFauvgt7cL2szhZCIrWpPmFOpeYHWqtNutYewQnZpWXVe4
         j2CvPpeKXMkT4K2rWmBh0FreOG/A/EX83YXlvalPdxTRUEjX5QrjrcifbA6KRDeBn/zF
         4suCR09L32ROUOHYS7A8X5VizRrJ5ULkzqV5YxpLTU0Be2MMvmrjn+EVOrTwAV4gMnNb
         M+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CxZFPPf8/Af3IJZUxSvuHpUIlLCprby35hrQY11nLk0=;
        b=EiJ88uq/bBhlA/OyJtWnqrr6C5i621Jed2MjafoDZR6FDcOX5jdafkVaK7p+OSYjOH
         ATmPfozNH2yJ4MFL+zP/+xC/e36HLnsV/wKEQCKMzkgYaqnXB581G3jc1QDu7M3srwqb
         31GpHhwVzxymn7y98jcRtxUzJuzcUIg5zHXvoTZwLqWqrUrOdiRNEbOOd6ZRmdKbVVxu
         WXMzPBtSbgNdX0lf8JcW2onR1NwyhsmQ0pCU7sX5uMfkNZ6FjLMXoOqgHYbbBQBEQpbg
         IukbSqdDo6XLlQ9PGJ27c3C7e5t+pqcaTBbLPpBP2LO5FWNjxDqL3muf3UUjhiIDmpcq
         Aecg==
X-Gm-Message-State: AOAM531PuoZ7YhRBHFX8tMww0uEiLy6p+pcGHqL+na8OsVI10TJEUxIw
        E8kFR4qM5JldngjtqP6At5c+6ShjY5IY2w==
X-Google-Smtp-Source: ABdhPJyV9fK6I1s/3kbZNh9kRn5B7l5/zIUTRIqKYyA4U8+9QjxZxRwR6ZMJACtn2u8d3uufYfUE3A==
X-Received: by 2002:a17:906:2f91:: with SMTP id w17mr193983eji.443.1623353889221;
        Thu, 10 Jun 2021 12:38:09 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d2sm1105423ejo.13.2021.06.10.12.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 12:38:08 -0700 (PDT)
Subject: Re: [PATCH v6 1/6] dt-bindings: spi: spi-rockchip: add description
 for rv1126
To:     Rob Herring <robh@kernel.org>, Jon Lin <jon.lin@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
References: <20210607111837.31074-1-jon.lin@rock-chips.com>
 <20210607111837.31074-2-jon.lin@rock-chips.com>
 <20210610160634.GA1894512@robh.at.kernel.org>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <e71e9bca-4c30-d155-2beb-cb85a7b3106a@gmail.com>
Date:   Thu, 10 Jun 2021 21:38:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610160634.GA1894512@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

Similar to the Rockchip SFC discussion this compatible does currently
not add any data or difference to the driver. Therefore a simple
fallback string will do for now. That in the past that was not strictly
enforced, so be it.
Could you have a look at it?

Kind regards,

Johan Jonker

https://lore.kernel.org/linux-rockchip/20210607063448.29589-1-jon.lin@rock-chips.com/T/#e202225dbe50829069becd2915267124f379bf2fe

               - rockchip,rk3368-spi
               - rockchip,rk3399-spi

               - rockchip,rv1126-spi

           - const: rockchip,rk3066-spi


On 6/10/21 6:06 PM, Rob Herring wrote:
> On Mon, 07 Jun 2021 19:18:32 +0800, Jon Lin wrote:
>> The description below will be used for rv1126.dtsi or compatible one in
>> the future
>>
>> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
>> ---
>>
>> Changes in v6:
>> - Consider to compatibility, the "rockchip,rk3568-spi" is removed in
>>   Series-changes v5, so the commit massage should also remove the
>>   corresponding information
>>
>> Changes in v5:
>> - Change to leave one compatible id rv1126, and rk3568 is compatible
>>   with rv1126
>>
>> Changes in v4:
>> - Adjust the order patches
>> - Simply commit massage like redundancy "application" content
>>
>> Changes in v3:
>> - Fix compile error which is find by Sascha in [v2,2/8]
>>
>>  Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
