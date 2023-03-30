Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AB66D12F4
	for <lists+linux-spi@lfdr.de>; Fri, 31 Mar 2023 01:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjC3XW5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Mar 2023 19:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjC3XWx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Mar 2023 19:22:53 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65FE113CA
        for <linux-spi@vger.kernel.org>; Thu, 30 Mar 2023 16:22:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id s8so13684659pfk.5
        for <linux-spi@vger.kernel.org>; Thu, 30 Mar 2023 16:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680218572; x=1682810572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpMbxrrdDscwNjErz3IAiuqvaFdZEEwZOIQdRb6keUI=;
        b=lIx1PRXCSLLMWs51ETL7VyXl264nJDY8mFGa2z56HJv63Cnn8TUjG9EpaYjioOkK1V
         0QHRxfQpZmUy6lJu77npISc4i2aBnkPi2TwuiWXY9gNne6XzN0s1Ldv1U9NcC6IWBZAm
         MqUrtHiFcijlnAHCJr0gU/Um+p2UHTlIarSBvjL0oLNMC/CNck38T/+O5UH2n3uC5DFP
         9qjMt5ErQ0NPSWK5Ri/0iGbVCcdEMovyy2ayxO2cWyMDBodtIb76Td5VHiS9KaYTLc5w
         +mw38aftmBYX4ekOGUrkncxFcBcp4ZXkhvDVjFkqV1NNfeWsQjJekptLn5ZiybmFUMkF
         x6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680218572; x=1682810572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpMbxrrdDscwNjErz3IAiuqvaFdZEEwZOIQdRb6keUI=;
        b=7jhxOW7EOAF0c6oIrDag4hChTeJBWVv+XdbYrDAVN5eQfjBmz0hXlFelG3htmV+Lri
         qdEUZdporir4VeUUzl0RRRdSvhsl5PwVXSr9Vi2dvZWvIX3ubw7LQST13dwr/kdhvItd
         n6VhpizdRl5XXE3UyjhCW9SbiBMt+MlsEgRej3g5RHpVnIqOni9lkB1837+nVyok7jFA
         Ti1F3bDK43ZtPhryUl6Q56sPL2a5RtRvFfgUavnKC7Acc9ZU+aM8CB/jyMeV7y3dN5zI
         V+nMCgJMZlj4T6qvAc/lm5DP9L63msJ5ZJRK7nYLtGsFvxMQVQNkCbxdQ8ZWrFfzpxKt
         DXlg==
X-Gm-Message-State: AAQBX9dOfVof7AcjaNWKWNG3q5FofmNaoStrxM/PThUdmwnngua+sxCR
        PZNmsUzj/eDGTS/cfPaZlCQ=
X-Google-Smtp-Source: AKy350aHhWXMC152wd8CdET6qBPC+OG4u4Ves4xuQcKXG2peKuHJl36nWI4jx2SX1PNLp3aqO6M1hg==
X-Received: by 2002:aa7:982c:0:b0:627:e1a5:27b4 with SMTP id q12-20020aa7982c000000b00627e1a527b4mr24668962pfl.33.1680218571919;
        Thu, 30 Mar 2023 16:22:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j15-20020aa7928f000000b0062a474cd46asm378650pfa.137.2023.03.30.16.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 16:22:51 -0700 (PDT)
Message-ID: <355da7b2-3190-fbf1-697a-b7006c66540d@gmail.com>
Date:   Thu, 30 Mar 2023 16:22:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] spi: bcm2835: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20230330211022.2460233-1-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230330211022.2460233-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 3/30/23 14:10, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Convert this driver from always returning zero in the remove callback to
> the void returning variant.
> 
> Now that bcm2835_spi_remove returns no error code any more,
> bcm2835_spi_shutdown() does the same thing as bcm2835_spi_remove(). So
> drop the shutdown function and use bcm2835_spi_remove() as .shutdown
> callback.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

