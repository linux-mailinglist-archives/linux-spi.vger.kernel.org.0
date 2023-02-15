Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9A56982A0
	for <lists+linux-spi@lfdr.de>; Wed, 15 Feb 2023 18:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBORrr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Feb 2023 12:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBORrq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Feb 2023 12:47:46 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E53D37F15;
        Wed, 15 Feb 2023 09:47:45 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id o42so11067302qvo.13;
        Wed, 15 Feb 2023 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFBor5UvoURzDIhUi2ANDgvJb7I1vJzRftM/nDRmQ/0=;
        b=VVA3ZILoU2CpGLIgVq7WUztfKwAV8+HbpCemGVGbDRdckRXjSC0MqE+S+ZGnv0ufyR
         XQpTdkow/gpRciaSNEQ/mXPSANYJ2vq0yci/pxkIBtgSY3Tu2D/S4BNXVi/83MZnjHC9
         zSQrnD8r/SRu8+xUtyF9+nw2xR4+65CoYNMGHX9XR9pDvTL5Vus2zTEaOi6LyFrC+cVm
         3SwIoUo3++KRqkrY/JM1ulb5y9WjI36wAELJxFJhJofUbKxDMYbbp+gzRrRnvQBA/bPa
         O7ts43yoT8oorzA6tdOt6BBlU4PkAnPkyPXA7E/6qEDnbNWU/1jS8fOVdrrz3Izcza1o
         QRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFBor5UvoURzDIhUi2ANDgvJb7I1vJzRftM/nDRmQ/0=;
        b=dTrX3tN5YYH0ANmlHoc7iS4xidRXR4CV1rQhQ+DbCpcW2OEv1VIEmgWPsdASXcZw3g
         2BE/PnhZxXmkath+lPRKIgO1ANEud7858T4QVGLKWfzZZLIoc0NwoHzavEkPziySi3qR
         U1L7SUpSI73sJMWCCIHt0AWKA/+HeX4JNvrx+RiATOVn2qvhe2LeTf3LgXvZ4btDU9n5
         QFSaQjMeNuBy4NWSlU3lgTUCtD0p4zJz9GH18FOu6o/d5DZQyou55TEUAEDGBzc8S+/c
         tYn275KvdvOAqarpCkwJNP3zkuJW/OuqGOdzUY14Uis19rMGFbjHr/9RlORhpFkLRUl9
         rE3A==
X-Gm-Message-State: AO0yUKWg0eadST6xY3f0afDlc1wIGjhs1OGRvQhHRWjPN2BY+PtCuSnV
        OxX3SQWgH8SUFgPslxuSQgE=
X-Google-Smtp-Source: AK7set9HhR9JtoGU/X+ptdxD2/fr4vhxiySFOf9f6dnU4YmPuG295Kv0vjZRsCOTZeDZJrNN4mSNxg==
X-Received: by 2002:a05:6214:c29:b0:56e:a96a:2beb with SMTP id a9-20020a0562140c2900b0056ea96a2bebmr5048741qvd.43.1676483264213;
        Wed, 15 Feb 2023 09:47:44 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o62-20020a374141000000b0072ad54e36b2sm14276562qka.93.2023.02.15.09.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 09:47:43 -0800 (PST)
Message-ID: <a8a1ffec-7c62-77c4-a1ca-b52f4e6a80e3@gmail.com>
Date:   Wed, 15 Feb 2023 09:47:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] spi: bcmbca-hsspi: Fix error code in probe() function
To:     Dan Carpenter <error27@gmail.com>,
        William Zhang <william.zhang@broadcom.com>
Cc:     Kursad Oney <kursad.oney@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Anand Gore <anand.gore@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <Y+zmrNJ9zjNQpzWq@kili>
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Y+zmrNJ9zjNQpzWq@kili>
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
> Fixes: a38a2233f23b ("spi: bcmbca-hsspi: Add driver for newer HSSPI controller")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

