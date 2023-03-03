Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E466A9DA0
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCCR0b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjCCR0a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:26:30 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0C7559CB
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:26:29 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s18so1941620pgq.1
        for <linux-spi@vger.kernel.org>; Fri, 03 Mar 2023 09:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677864389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cflsrsd4DH35NrBMKE9wKoAedVoIv4Gk+lJYLvS7AbE=;
        b=BiACgPmlePYURe7vILpxUZsyOwxFMxDySHFtUUAdEYWJjY0YoXJwQthJgzCooNkMIU
         4DU45j+yMKBtc5h/21Yxr7GRSdORrx+oDbekh2nETSjtgHGWDLwxvKDnks1wzA+GAWU8
         gPXTHSwRxK3T9hG9w4dmia9HBTo+2InNZnSQyvea6Y8gaKSU1xufkGDKrxZ8OeMsdE7d
         OEkPFVf2Bpjj82EYBHeqhrpuN6zh47KYW92iwThih0SGLXivHsRmCS6V/IUWZlHKZPZ8
         gAUgnXUpgVzM9aFuNHtQwIAGcr6tBp8FMyOu4+66V8hJ8SFld8QoD9nvWYKeAVNc4hMF
         AwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677864389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cflsrsd4DH35NrBMKE9wKoAedVoIv4Gk+lJYLvS7AbE=;
        b=DMAgL+zJHq4kXuwJsqNCYttFVEcnOCTHtf9aFieoQYrCTPcG5DxXrkPDTAuMt2KQo/
         0MNjn7sj62p2F2KFzj5UmISghhoMOVnLMGaiuPz+9IvCXqBZpEjGwpwf+x5iOiyMxzKY
         TibGFkGjUm1okNMs5dClvLHkSSiNaQUEfoMPj4QfzDekIy6jDzOI2uAZjR6FHWzItD8+
         kc1NdECWJAiH1vWcFQH6QqQqQrbLtepKnmICr776e6UBS+YKPJb05F/lkl3D6J2ywkf0
         trFqoaR7eaPkWHMFih/AlK6hvWLNO19P3L5SVMTFHkbUfisV+v+xlrFrZzG1iV5Wo+yA
         hPBA==
X-Gm-Message-State: AO0yUKV86Y0W3dvZ22pijfdGqKx7uPmB9JX9qkFhILySQWHK1qlxijG0
        bi5xYLnqvsX7gSKEPEEPjMKOChdrtAs=
X-Google-Smtp-Source: AK7set+r/5IkbilCFxJNiHcqRXcJkfsWdYHb4hhkeECHTntzXENGTXlVNfpsnXguaphkzQKzh3OOZA==
X-Received: by 2002:a62:3813:0:b0:5a8:9858:750a with SMTP id f19-20020a623813000000b005a89858750amr2362800pfa.13.1677864388660;
        Fri, 03 Mar 2023 09:26:28 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e16-20020a62ee10000000b005d791692727sm1878770pfi.191.2023.03.03.09.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 09:26:28 -0800 (PST)
Message-ID: <7fda06ad-46e4-2939-ac95-08d2da57401f@gmail.com>
Date:   Fri, 3 Mar 2023 09:26:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 32/87] spi: iproc-qspi: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-33-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230303172041.2103336-33-u.kleine-koenig@pengutronix.de>
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

