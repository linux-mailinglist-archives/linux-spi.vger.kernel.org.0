Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875AC53F17C
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jun 2022 23:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiFFVSK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jun 2022 17:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiFFVSG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jun 2022 17:18:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF4612612
        for <linux-spi@vger.kernel.org>; Mon,  6 Jun 2022 14:18:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n18so13135597plg.5
        for <linux-spi@vger.kernel.org>; Mon, 06 Jun 2022 14:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/Qe8oW+p+BGt/u9zN5VKDridalVYiz6PdWuaHuIAfYU=;
        b=pqQtS44k5xWEUVxMkH5j4p8QagUDe4bybT62BFuWs8YH93O6u037sMfTEBev+tJdm1
         Ab6PwY+WRduG7iTOvB+zrtQyZTOLWmsyUPanuMDwt5Ir54diXtUp+TZUoQBava4yiAB3
         yxxlrAody+C83svOWk3ZhHSx4ewqrle3LPk98uOXLiL3cAJnMAjE9LK+7oBkJbc7KLBo
         I9e/9F8lqpixKHZKiUXOJmt5ysXQpUg2Jwzr+JjWAWRAacGzyGD3+S0cZvm72u2SUZkF
         iDVIJ7XWE/Y6e6LjvBin3hMvNou+l5TTLJjRiuks8OrppfJehOPoFailKqqP++9fXeRs
         Cj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/Qe8oW+p+BGt/u9zN5VKDridalVYiz6PdWuaHuIAfYU=;
        b=vFE3nvUXG73ws2+h5d9fCV8LySF4iGYw2OOTFsD9so4+F/uA72HRcIixKNERadbMnj
         6iJT0H27ff6TpTPsQ7mRPFcYjcRZ+jvkiHV2l6/dGwqP84ESGBSZlSPjx/pd6RqCC29e
         /kbVUhTaBHlbMq5xMIuPFcsJ82pT6xVsijg6ey0DK4ZbHvaMyASrlc1RvzP8b2MQJPKR
         fzvzlEB3pFjzItFFP1Gd2pAOMqqrFFC/+jHGXeLIp1yDybJsEvOXX+FU/OPcNwNlItkG
         Agi0r6tIw3MIeWSnKVpZEng56zEQsNPTGj/KPzV4UBRD5jI0C7/RAOKCEyGQ/IulvxTc
         KrKw==
X-Gm-Message-State: AOAM530vAcQrW1PGFmnQtSvgr4UsnjIa3A5Ia5GN/4rwZ/RowziwOh4h
        QoCGOOMBmnkycPm3haqL9NU=
X-Google-Smtp-Source: ABdhPJxVMP5xEcX4McBoWG7aS+meh2ip2GuWd3WQic6BgDuBdo9w+FKQFk7lz6EU/dDuDYYE+DY1Jw==
X-Received: by 2002:a17:902:e5cb:b0:165:1500:a69b with SMTP id u11-20020a170902e5cb00b001651500a69bmr26105958plf.29.1654550282368;
        Mon, 06 Jun 2022 14:18:02 -0700 (PDT)
Received: from [192.168.1.22] (lfbn-nan-1-24-142.w90-49.abo.wanadoo.fr. [90.49.119.142])
        by smtp.gmail.com with ESMTPSA id h17-20020a63df51000000b003fc704c250dsm3731183pgj.94.2022.06.06.14.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 14:18:01 -0700 (PDT)
Message-ID: <6dae1c9d-89be-e1e5-2ea6-d6dbb56b8343@gmail.com>
Date:   Mon, 6 Jun 2022 23:17:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] check if dma is active before attempting to terminate
Content-Language: en-US
To:     Jens Lindahl <jensctl@gmail.com>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
References: <20220603142340.42271-1-jensctl@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220603142340.42271-1-jensctl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/3/2022 4:23 PM, Jens Lindahl wrote:
> ---
>   drivers/spi/spi-bcm2835.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)

Your patch looks reasonable but is not properly formed:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html
-- 
Florian
