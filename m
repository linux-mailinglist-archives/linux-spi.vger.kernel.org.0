Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD94B6A9D8B
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCCRYZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjCCRX7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:23:59 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D042247412
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:23:57 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y10so2023286pfi.8
        for <linux-spi@vger.kernel.org>; Fri, 03 Mar 2023 09:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677864237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cflsrsd4DH35NrBMKE9wKoAedVoIv4Gk+lJYLvS7AbE=;
        b=PWZ35PyXkHQFnKx/JVU3O2JTc9qAqQ+HAPpfwRAJ65sVohHO4oiLsjuvAYAO45HAxA
         BXo0PfJ2gOsG/26NCl5kEj5UUWAKqHxQpiu+QCQ9/GvPnlYRppG85JDTd9kZZ3CXBJf4
         wnw4mCAOYu4iZWZvBQmaKiWgHZAOHtz5zwM4v3dwDZOogph0mhwScE67U39LUiAx56Tf
         RELL3g3m1uXw4SRRVb5TwZE1W/g4bj9PWhRVdjAEDX5oXSBcpRzhCE2pntOxqgjqQbAR
         yQwTcKJtXlxY3yVpymIeHh72+YYOX+9vetMg6e/1ki3Mq+KpC2IXf3/YAVkEIUDJFzPc
         Zy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677864237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cflsrsd4DH35NrBMKE9wKoAedVoIv4Gk+lJYLvS7AbE=;
        b=GIqwRQQmqzAuatEWx9/tg0aSDnjTRSHI/6zEN3RhW2cvA8vU1ZTXPuhmlYft1HdhaE
         1NM1UAtGxR8SZRnU4P3guWfiXuIpUO8H3AbQKQtnHCzYvEaEvY+XZMVcCSF7CuJg9yav
         RCki+gNbrQx46z9y5D7vKg07p7Us8bjE1jgxR6tGC5Rrjr8bNCIsjaxdBZuSl3tKK3Br
         0/cMToJ1sITBL48JGqtv9ZYSGUDQ5FWcRWGon/kIRebawnKv3d82A6TJDZMSA551SSXk
         oupfZtwmjYf0HSy8YGb2VDJLbwlaLOqxWHiRngv+chXUHXBioHRKDA2cQV8v1qE0RGVN
         Y5mA==
X-Gm-Message-State: AO0yUKX6ZD0l/CvWRCUYcrEmRMEiYEcTqQnkFqTyKQWzik1Ql/s1GCAs
        IhQo5CUgVm5WaVyu66vNoqc=
X-Google-Smtp-Source: AK7set/USLAiMFFtOVfh+n/zAjGMNrgi/qh6koo2ZKfDq+6uqqiDON2FNg7h8nvYwOPV7Ck1qh1HLQ==
X-Received: by 2002:a62:1bc3:0:b0:5a8:a751:d22 with SMTP id b186-20020a621bc3000000b005a8a7510d22mr2191063pfb.12.1677864237113;
        Fri, 03 Mar 2023 09:23:57 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m21-20020aa78a15000000b00571cdbd0771sm1893856pfa.102.2023.03.03.09.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 09:23:56 -0800 (PST)
Message-ID: <3961d5f1-cbd4-c7f5-89f0-14773d55c434@gmail.com>
Date:   Fri, 3 Mar 2023 09:23:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 10/87] spi: bcm2835aux: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-11-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230303172041.2103336-11-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 3/3/23 09:19, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

