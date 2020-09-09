Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126D2263824
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 23:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgIIVDH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 17:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIIVDG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Sep 2020 17:03:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467B4C061573;
        Wed,  9 Sep 2020 14:03:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s2so1954883pjr.4;
        Wed, 09 Sep 2020 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kk3dtIEIHLrcJXCtVTcb0P6ovpZXfJeh6sKbAWAj1no=;
        b=Ih+9wWx7tV8Gh3D9ZZOkimGpNEiSmyOQr8AmYz36svx2Lr954NP4kKJ86JWA2YHSNx
         f3lcFYyvCm5+CCgt0IXOKx7LkeGFYeVYiK3rc1s8p3v2qQhMqvXqhOaZm8BiZGOYqP8N
         c2dN+MH1bBxxjj4x6SDnnW+J0PtJjlOQiS2KorrhzojRuQpOt7pf0Q7W3E8kVs2G7CUi
         f06r1D5CRPNz2T8+oi5s4oxpECfpQhl2wfrnBeVzqkr8rcMkhdLGkoZ4zfzLQ0bg14nP
         tdcyxIpz5WzM1h7UytzRqWSoH0QEXm3KMxFPY+d+CKzgZHExf4jaA383k7DbgK9p4vhC
         Bbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kk3dtIEIHLrcJXCtVTcb0P6ovpZXfJeh6sKbAWAj1no=;
        b=rJU9Wm+4ppjxMdgyYjES1cZzi6FODQPgU46QNXI7ZIbonFkausqbU47o7GCQmJxH4U
         mR5DbSzUNux/knFhHuNkO4AToobSe3nInjIBByllKcxOdX+4jJpAEO6XhZ1o+S/UUF7C
         XBDSLZl47W8wmbz3gztLO4n+/91rnxVop4TfpXD73b4cVC9TzGLtMdjH4Qbg9zQR5/MH
         y6vXtAVxKAQkr4gWZWJXHVTkVMusoddBy37JNQjsGJaRgC79+DUjbeXBwSfUCEqnMzJ5
         ibg1yWkCl7ob6IGBpau4JceBHlj8AUPEC6PVaW+OAK5TzQT8LYj2lfNlBQG9YsreW9Pb
         dp3A==
X-Gm-Message-State: AOAM532V4IN8/MYAvo93S9p+BYS4J66t5vRGOg46GsX9avPPTlzevAkQ
        vyGmzW6EWDUrM0GqGzuP+D8=
X-Google-Smtp-Source: ABdhPJzGfNy97zcL46hxGh9zbWvFhq+8lbc6+7e336RdPNYCnFw34GFIjCkyQca02CQCHc+DPUtv4g==
X-Received: by 2002:a17:90a:8d05:: with SMTP id c5mr2271219pjo.222.1599685384654;
        Wed, 09 Sep 2020 14:03:04 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g32sm2951874pgl.89.2020.09.09.14.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 14:03:03 -0700 (PDT)
Subject: Re: [PATCH 1/5] dt-bindings: spi: Fix spi-bcm-qspi compatible
 ordering
To:     Rob Herring <robh@kernel.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "maintainer:BROADCOM SPI DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
References: <20200827181842.1000451-1-f.fainelli@gmail.com>
 <20200827181842.1000451-2-f.fainelli@gmail.com>
 <20200909204111.GA3041530@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0ab569c8-593a-aaa5-daaf-12860ce5931a@gmail.com>
Date:   Wed, 9 Sep 2020 14:02:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200909204111.GA3041530@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 9/9/2020 1:41 PM, Rob Herring wrote:
> On Thu, 27 Aug 2020 11:18:38 -0700, Florian Fainelli wrote:
>> The binding is currently incorrectly defining the compatible strings
>> from least specific to most specific instead of the converse. Re-order
>> them from most specific (left) to least specific (right) and fix the
>> examples as well.
>>
>> Fixes: 5fc78f4c842a ("spi: Broadcom BRCMSTB, NSP, NS2 SoC bindings")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   .../bindings/spi/brcm,spi-bcm-qspi.txt           | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thanks, and sorry about the nagging on IRC :)
-- 
Florian
