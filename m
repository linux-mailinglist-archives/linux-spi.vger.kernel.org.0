Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2F56A9D8C
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCCRY0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjCCRYL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:24:11 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6FC474F5
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:24:10 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n6so3406051plf.5
        for <linux-spi@vger.kernel.org>; Fri, 03 Mar 2023 09:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677864250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cflsrsd4DH35NrBMKE9wKoAedVoIv4Gk+lJYLvS7AbE=;
        b=ZY1Xtp+N75Q7MyCANI2IrEDd87x3yZ712Nqtywzyc9SjC1IBrjJ0MvRZ5zwI71ZWJ5
         YZB2MRHDIxtcccUUsAm3slWjPFxA5xxOgpNNLUEXVdtvn95Cj4iGsERUyQuZo1W9u/Yr
         F733yZUgwNOLRdQbb0lRVjxwZRalizkTrdQ7GETdoM+sM10Ox1Nk38pNKhw6fxb3L0QQ
         7WmXJpZMeqGsUbHcCTsXMmkWkt9iFxAduzkCNEXnm/YxtPR9lFh0fp8bhGcq0mtvO3qI
         LXkV/4we+zRW10lLwoWDTWDnYCrl7kwKfjIAtoLCUTPVInbUPAkgS3Bj1Gs1FF8H0kcJ
         ke8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677864250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cflsrsd4DH35NrBMKE9wKoAedVoIv4Gk+lJYLvS7AbE=;
        b=ZVQVP5wZReomXcvwCIr9xZ9ooYSw/3zNhaNstJIETV2BB3iv9Ia+BviW0ESqnGbSp9
         WdmbalN9H29lZ9eHFxkdJWu2jFvHnaMpopM7Fvo2rVhx1D8YieEnZxv+GkMu8+OQ59on
         tcIbVB4YsnOF/uDrCVjKcCmujf4jqcqlamdKYBofUHEvWzCh5Ie1sIEcDhg02JNp2H/M
         x2tIPU20cJZ8WNjVQ6tTRBgE/PZptbFljfUnhXuKW4wKLek9JWtsai7M1lL1Y3TfcdOD
         YnYn9p7JGVIvVW0ttbt9AP07g+gGEKhTu2+0/1FfpDCinvCjR4yfZwDjJSE31K6vDhnA
         BLnQ==
X-Gm-Message-State: AO0yUKVBxeUDvn9X6LO6SRr7lYI+dTIVtw3JGO6l0Q5t8neU8hT0rd7W
        QmCJ3ObEvLYpyDdCGGk/M4Y=
X-Google-Smtp-Source: AK7set9R6y1aCmfUQFnyaYHIK6E66YJuzqKmIw3LYqznsYnLSJm2evM1lmug9fkaN9iaB4qqKLLFqA==
X-Received: by 2002:a05:6a20:394b:b0:b8:c6ec:a269 with SMTP id r11-20020a056a20394b00b000b8c6eca269mr3293755pzg.16.1677864249926;
        Fri, 03 Mar 2023 09:24:09 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w18-20020a63af12000000b004fbdfdffa40sm1814399pge.87.2023.03.03.09.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 09:24:09 -0800 (PST)
Message-ID: <1b96cf73-2d96-c70f-b4b0-8f95ad85951f@gmail.com>
Date:   Fri, 3 Mar 2023 09:24:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 13/87] spi: bcmbca-hsspi: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Zhang <william.zhang@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Anand Gore <anand.gore@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-14-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230303172041.2103336-14-u.kleine-koenig@pengutronix.de>
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

