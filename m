Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33DF6982DD
	for <lists+linux-spi@lfdr.de>; Wed, 15 Feb 2023 19:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjBOSDw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Feb 2023 13:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjBOSDv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Feb 2023 13:03:51 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E4034F7D;
        Wed, 15 Feb 2023 10:03:49 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id l4so6654282qvh.11;
        Wed, 15 Feb 2023 10:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+xEPuOAgVK1ngSY9PgG6CPqYyCOMlPvPjzwg5uv/ic=;
        b=YJ2p5pJZZenHNsp6Cc3kp8CXgiqMDpDrAJiPdYiIe6dt9UMjw4N3XbBWd2x9ZVKIgd
         CQYLb8LPKcAPbjeMHKB5M015kH7BnBAXSc9CRphMbeXpyVIbAh2UG+vMkz84jvyqHdUH
         iOhStwk6mxiyBiyn6R2lQLMmBJzocUzK1d8Sy4W1aw+FJqU/1kWfWizYD49KexjjcMfP
         j5MtGxDy2rjpeveEzJQIqAVG8O4MF/vJPm6uCUa1ISx4IItGMK07Pfa3gvCgQYgIgxab
         dSg2WuK2PEWczByLLfUs2mps+lO+Qzk6JmeEb90nypFs7aORO4kN9G5idGxi45RnykrZ
         XKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+xEPuOAgVK1ngSY9PgG6CPqYyCOMlPvPjzwg5uv/ic=;
        b=QexANJQM7X0Cp/4b+kxfw2F9+oQhYbHwLmsMPsIf3emBEfzNigbsiNC5OoB8ZxMAYe
         WVYhV8eEu4tqCLPYnfR0PyfOkVmLRWikFKUw4Kjz/NxRWknhYQ38KVcuS0SrO8oeIuqu
         UVeh5NlHDhkLULFKf9i2cKE5/Uk1sjOon+Ogtg9pUYoY41PaHl0PFoaRh49FJuV4VS15
         joxzmLxRZybRKHGbo+YCZyvNcTE0ucosYUPV6nClzERMqRnt0L1SLcPBvg167N8RTdMr
         17unWpC3OplNIxeog4c/B8BZ7ZwX0sRSvRdvIu8Vvzzd315DpnDc0o7xz/SAjlxeI9o5
         yiBQ==
X-Gm-Message-State: AO0yUKV86eYxrf1vWl+ZPj88xhMvZ/8TFH4+TGP/k/utJIzZXJIxwWo1
        rO+yTKHYzCGkPxs6JuG7/2A=
X-Google-Smtp-Source: AK7set+Ft9C/FkCFp3JgLr3I83y1wVsFlJNi16Af0PTqlChwkHvIBPgF9FydRzp9wDFmUD5XXmXXAA==
X-Received: by 2002:a05:6214:27cc:b0:56e:bd64:62a9 with SMTP id ge12-20020a05621427cc00b0056ebd6462a9mr4812275qvb.38.1676484228784;
        Wed, 15 Feb 2023 10:03:48 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 65-20020a370c44000000b007059c5929b8sm14368482qkm.21.2023.02.15.10.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 10:03:47 -0800 (PST)
Message-ID: <8ea9e441-1f18-c509-70b0-94a9f1b803dd@gmail.com>
Date:   Wed, 15 Feb 2023 10:03:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] spi: bcm63xx-hsspi: fix error code in probe
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>,
        William Zhang <william.zhang@broadcom.com>
Cc:     Kursad Oney <kursad.oney@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <Y+zmoGH6LubPhiI0@kili>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Y+zmoGH6LubPhiI0@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2/15/23 06:05, Dan Carpenter wrote:
> This code accidentally returns success instead of a negative error code.
> 
> Fixes: 50a6620dd1fb ("spi: bcm63xx-hsspi: Add polling mode support")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

