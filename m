Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F66C58A613
	for <lists+linux-spi@lfdr.de>; Fri,  5 Aug 2022 08:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiHEGrz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Aug 2022 02:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiHEGry (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Aug 2022 02:47:54 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7563618341
        for <linux-spi@vger.kernel.org>; Thu,  4 Aug 2022 23:47:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r14so2114070ljp.2
        for <linux-spi@vger.kernel.org>; Thu, 04 Aug 2022 23:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PmFeWvuOsvFqIarJirnBQu/eQawP6gPgXVaBOBY1IN0=;
        b=yQYu0aCVNEnx/hdbtFW3QKhXozW4BMi0Gs2M9Ccc2vka9JnK2pizgjaYlUbZSGA8ML
         paDCYOMnbya19+hsGsX+fwRSAlF45RoMdTayxjqtBWl7I0OgZWpVBuXc4f6aUa9TedzY
         rE/HY54wpNEezB953AsgiH/oUxgGTBxrY6A2ySGrP+HH0f4IH14A2oN+9udx4aJvei0P
         NKGkgXExFwyPM1sLVy/A8zzKf6e8/Rh4DTjCKEjNddFA276N0xPKIfN81vFBbh2Fveqi
         OLhaG2kVzrKhYgNEb/9i3ogfjn5wNrAS/bMKU14EfTNUKuMqY+PriaUQFTBjp4GLJeqz
         kUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PmFeWvuOsvFqIarJirnBQu/eQawP6gPgXVaBOBY1IN0=;
        b=Bw8aMm2HRDu6chtL3YkJbd1PiYwCdBip2WSTcpTIiGARURRyWlndJeCDTDM5FFl/tZ
         UI/ZfqwrIA4O87fN6gAQE9B8SRicHAFKkSjOpAnnqby3RaWLVMqPiXwipP0PhLHwW2NP
         7DF9n891BculfON+3XEoV65FRr6ln1GQYZYoBn9QgqSfV45yFZzpE2mWj1pBq34khzNf
         +5BhMEubk7lHPZcpmuZ5yynhksBCwXThS9axBiLt1zi76D35+zOr5yrt1l24CIjS76QW
         xN1UrOelJhEv6yYH712sgqqNb+0tqL2uIvc7+nPUxdCd8UadE0oTEloaBhaum9l+aQ+T
         NGyA==
X-Gm-Message-State: ACgBeo0BKPfvBXs1exBX5iOvuVJKtyrKtR29QLKfEu366WnQWIakGq5i
        iLnFJdAyM/ezlpEU8Djd5NhX0Q==
X-Google-Smtp-Source: AA6agR5eleQqymCQPIxFfTF3U1lX2Tm7Odlj4hz/7K77cIt/DGtNBXPIFt42ojhGNG/UpSvJEXAshw==
X-Received: by 2002:a2e:bd03:0:b0:25e:6aca:ab1c with SMTP id n3-20020a2ebd03000000b0025e6acaab1cmr1643507ljq.479.1659682071839;
        Thu, 04 Aug 2022 23:47:51 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id s15-20020a056512214f00b0048b143c09c2sm359055lfr.259.2022.08.04.23.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 23:47:50 -0700 (PDT)
Message-ID: <86f726ab-d2a3-8ffa-87f0-2bf3dd37ae84@linaro.org>
Date:   Fri, 5 Aug 2022 08:47:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/4] spi: dt-binding: add coreqspi as a fallback for
 mpfs-qspi
Content-Language: en-US
To:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor.dooley@microchip.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valentina.FernandezAlanis@microchip.com
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
 <20220805053019.996484-3-nagasuresh.relli@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220805053019.996484-3-nagasuresh.relli@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 05/08/2022 07:30, Naga Sureshkumar Relli wrote:
> Microchip's PolarFire SoC QSPI IP core is based on coreQSPI,
> so add coreqspi as a fallback to mpfs-qspi.
> 
> Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
