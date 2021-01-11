Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C314C2F1C31
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 18:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbhAKRV5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 12:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbhAKRV5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Jan 2021 12:21:57 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF40C061786;
        Mon, 11 Jan 2021 09:21:16 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id h186so340744pfe.0;
        Mon, 11 Jan 2021 09:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i5cmPuiNFiV2Z2Bc98/7qCbawofWR9QNfKOY0FHTMDU=;
        b=l5m2vawLtdoeGoYNBocLbLZL6a353qCpr4ObbagwcT1X2ArZsZSlqo4OES4b/pye9b
         QkUdDxotSW17QTlqILlnMHLVRR+lbMP0gU7hswMMW1mXNXFwgXC6yWxdiE6qgrG6Yfnz
         d1nQEzfh/lYGRkBbpxHf7joOgVmhWmuhQzhFbclit+lqBry4vC8+sY22IjfpDUZkOhvW
         EPeNVRryCThwlSo+c0UmVnPjIERV999AGZvJFjZeDaZoIW3Tsix5j3/ShwebIU8kRiP+
         uoRLEe0O8cdnAZY+OCjrckxYpTox7rs357H+y6O4MaZ7nlADAYqg0gygmHOXWSYzSf+y
         JfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=i5cmPuiNFiV2Z2Bc98/7qCbawofWR9QNfKOY0FHTMDU=;
        b=k9lf+zZ1joBix7kdaB0Kb+LFxCLpBJ97eWhaZO7brOl+v2ySGTgVZHN56JDVHpO0p9
         mmT2NjDrk/KC7lb3ee8NV6SxOV6uqxNbPPh+MDohrzrKzOz2nJe7JsC75WIep/XuuqEp
         sVD8WQ4fA+9g/AtQKmcU4NXCgmeOwYEqcwfaB3AnPdkVMz6RH7IvBF2FCnuzK02N/hzj
         GwdG+7aPQWJ0urX3hGzOQTtQ+D3TQM1GKRJkv2WwIKTtI8Z5p1Ivp7ulVfAkXyVr1YCq
         cp8E+/BFLcO0R6IVno+4qQ1kA6pox97eFo00BrPlxrD1gQMiGSlO+I1jv3FWMndy0G7U
         049w==
X-Gm-Message-State: AOAM530NY62ocYcIhGzzG9/7L/WClcofdQ8Tcwa1gUI7JzG6CMuNzXCp
        PV8ST4kSSGC2aNZ9Zi1v31ISQu+xjT8=
X-Google-Smtp-Source: ABdhPJw5nJth7s+/Ss3Uo832Km0vxlzEfDkzHdyMqicr0gSYIAGIedNn41aCEJr5/kyJE22/ZG+Sng==
X-Received: by 2002:a63:1110:: with SMTP id g16mr498719pgl.357.1610385675640;
        Mon, 11 Jan 2021 09:21:15 -0800 (PST)
Received: from [10.67.48.230] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f24sm108958pjj.5.2021.01.11.09.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 09:21:14 -0800 (PST)
Subject: Re: [PATCH] spi: spi-bcm-qspi: style: Simplify bool comparison
To:     Mark Brown <broonie@kernel.org>
Cc:     YANG LI <abaci-bugfix@linux.alibaba.com>, kdasu.kdev@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <1610357189-60031-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <161038255869.32886.11006261963964555197.b4-ty@kernel.org>
 <ec735a59-0fbd-3d4a-e997-895099a8e534@gmail.com>
 <20210111170556.GF4728@sirena.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <32b6ba61-91a8-ada3-1c8f-0e85d330f27e@gmail.com>
Date:   Mon, 11 Jan 2021 09:21:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111170556.GF4728@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 1/11/21 9:05 AM, Mark Brown wrote:
> On Mon, Jan 11, 2021 at 08:41:19AM -0800, Florian Fainelli wrote:
> 
>>> [1/1] spi: spi-bcm-qspi: style: Simplify bool comparison
>>>       commit: 6650ab2a44268af8d24995d28ae199b57b2ebff8
> 
>> I don't think that "style: " is a subject prefix that is used commonly
>> and it certainly should not belong in a commit subject. Mark can you
>> please people at least 10-12 hours to review changes before applying
>> them? This one is trivial except the commit subject does not match
>> previous changes done to this file and it should have been fixed.
> 
> Honestly for super trivial stuff like this I'm not sure it's a useful
> use of anyone's time to police this sort of stuff aggressively, it's
> after the prefixes that matter so I saw it easily and I'm having a hard
> time caring that it happens to be done as a prefix rather than saying
> style somewhere else in the subject.

That sounds fair, however it does look like people who submit trivial
patches are typically the ones that also tend not to follow prior
commits to the same file, and given the patch is trivial, enforcing a
consistent subject sort of offsets the less amount of time spent in
reviewing the patch.

> 
> I will generally hold off for longer with these trivial patches on
> things where I expect to see some review but that's felt a bit patchy
> with the Broadcom drivers.
> 

OK, we will try to be more reactive then, Kamal is in GMT-0500 and I am
GMT-0800 so it make take a bit of time for us to get to our review backlog.

Thanks!
-- 
Florian
