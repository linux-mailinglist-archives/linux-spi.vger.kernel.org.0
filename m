Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFCA58A60F
	for <lists+linux-spi@lfdr.de>; Fri,  5 Aug 2022 08:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiHEGqp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Aug 2022 02:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiHEGqn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Aug 2022 02:46:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFD817AA1
        for <linux-spi@vger.kernel.org>; Thu,  4 Aug 2022 23:46:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y11so2140001lfs.6
        for <linux-spi@vger.kernel.org>; Thu, 04 Aug 2022 23:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=elKcXDfUxPr5UWB5Ig8rgcGqrF7Nd89MhfB2Oxmopfk=;
        b=V32+S7YUV/1rfANMUeraQkvs58A9sCUKhnleazkhDf2cidrJm6vb96ts6qDSCw05Kc
         V9CqHvp+Q9ntGdAboe41XOq12L8axSuUoSYofJ6X92D9MwzVEHjJMpsnuXcBk4s2uUb4
         jden0La+rvdxwlcdfn1ZZDPi0NZHXxIn5Qap88of0Mj4xBYt0oP+Bqo1SZ5E6e3N1Ip3
         mj1RfJxCGFsHUrQJwIbho//GG7e7B2cHfuxt2tF+mU64Z4rUttZT0zgHhuUqro5p934c
         gx6JfOifTojzkd/vrmmi5k12KEYjpn3YMZ2Tny1xaNbY1unGDxJNjO+giV7kb5YnxbC8
         8xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=elKcXDfUxPr5UWB5Ig8rgcGqrF7Nd89MhfB2Oxmopfk=;
        b=FXcIghpjR5rV1SipUr8J5OE+7qUY4Qod0W9DG8LQa+QYlhxfEfqM6DMwxvyntNAA4T
         TpBEf/pFXv2Z+Ra2Jy0O7YtVrjKJThL2liJVO0EWDzqivkPfsJlFt7GxH5T8ixbzNRg2
         yQ+DR/E5wss1tbmNx0xGhekbwtcOJhvbLDNQZXdReGPm69cznhHY6zkmlEvQ01l6w3dl
         vbmBYhKA1gOyiVZ1IzJPmfLxFAqpBCHtnwgx01KMdQa+thMWDILidH/aoqI3TBDcg3Dh
         76enigzlsIRS/YpamIvnESfSBIgTMOaayiQcbGUgE1wzJlMOViDvia6mrpz69CyOsQu8
         IAKA==
X-Gm-Message-State: ACgBeo3aP711fizZ3MUfXLgIbOOXHrZuWgU9PzRejURupbhr5MM0Fb+f
        8PUcfgWsBpYSpZ4aOeaDCU7gGQ==
X-Google-Smtp-Source: AA6agR7L9ksA8IWx0gxOVnH6K4HcwGa/7uD0x3KwylcNpI/FkJHrjksOnqu6DQW3NEJoMGkK4Sk9Mw==
X-Received: by 2002:a05:6512:31c9:b0:48b:27af:ad36 with SMTP id j9-20020a05651231c900b0048b27afad36mr2100250lfe.394.1659682000569;
        Thu, 04 Aug 2022 23:46:40 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id t18-20020a056512069200b0048b08e25979sm360374lfe.199.2022.08.04.23.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 23:46:39 -0700 (PDT)
Message-ID: <e84277b2-55ab-6b6d-c2bf-34736b0622be@linaro.org>
Date:   Fri, 5 Aug 2022 08:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/4] spi: dt-binding: document microchip coreQSPI
Content-Language: en-US
To:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor.dooley@microchip.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valentina.FernandezAlanis@microchip.com
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
 <20220805053019.996484-2-nagasuresh.relli@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220805053019.996484-2-nagasuresh.relli@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 05/08/2022 07:30, Naga Sureshkumar Relli wrote:
> Add microchip coreQSPI compatible string and update the title/description
> to reflect this addition.
> 
> Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
