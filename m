Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2DB6F7F95
	for <lists+linux-spi@lfdr.de>; Fri,  5 May 2023 11:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjEEJJm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 May 2023 05:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjEEJJe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 May 2023 05:09:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BE918DD1
        for <linux-spi@vger.kernel.org>; Fri,  5 May 2023 02:09:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9659e9bbff5so262237666b.1
        for <linux-spi@vger.kernel.org>; Fri, 05 May 2023 02:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683277771; x=1685869771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jk1DeIVD6aFFUK+hNctD6yXAEyZEjJLVTe/neBKRhIY=;
        b=jvrwp9mhWR1wGFxOJwjAl/pdhYYzCxyUk8PoYVhPQccwp1nAGcO51/C6zUli7auMGw
         c0HM3n1GJjFAbAapsfDDLt95A+XJUadNvXIC35gmlHsPVUUZZkh7qCYyEIxZuDExF26H
         NBCO1HamoDJIwMO8IHRoxJiHNSNG/jmFbNJLrFwNw5AheNAdZzsiqGm5LjJG/2y56UNV
         huJ0eukgei4iUw+lBpo885iTl79hyGeaJUVGuS9BO4zMD2O3Ad1nOTeE2bQ9yfk0qRii
         xDVwHDU3xv+Uy1YKF1kb5CSA+N7H1qTdggAz2okwkUmkjuwr+Cx5pzpiPQDQP9Axarwq
         4Ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683277771; x=1685869771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk1DeIVD6aFFUK+hNctD6yXAEyZEjJLVTe/neBKRhIY=;
        b=kBjSo8lERZlI2re1CcKn/R0scSOCfR0WV/ymNHjxervm5cxWzd6RID7IGBJkWMA2VY
         mdNiX2FUSmpr8n7t7Igm0KHdv1zHYBEWmrk2tsAFMvsLcURiTNW24j7nXSGLlim5p36M
         7R2JYXXtFkLajoKQnjKa9+SyX7KV0iMlXAhWp1DRQgwNMp/Tl4VgLHX+w4pGn9ntCxUR
         N5lHocIYdZoH9WiiuBVRkYTYqgD4KlcISSgH/JELH2B6pof+ChaMxX43+FABhA9rNCVi
         /eCmfHUmlZOXABnMB//+y2bMsAccF6JX3KDIz+zLqQx5pJQHC/v5X1oN62OMNNR1ZUPO
         OGYA==
X-Gm-Message-State: AC+VfDy0w6Y8s4S8cGbi4+9eTOhFxxbXuGBpjPjQERNCQ/AnKX6CEFvc
        tvtz3Ry6Mgu/oZOpmeAxNXLPeA==
X-Google-Smtp-Source: ACHHUZ41/e6NYpsPmJO0DWdwanI/+UcDIguU5Jfcf7pNmuyKAPFXae54BJBHo5lO/KWa1f7rZWJCww==
X-Received: by 2002:a17:906:dc92:b0:955:34a5:ae46 with SMTP id cs18-20020a170906dc9200b0095534a5ae46mr537020ejc.77.1683277771141;
        Fri, 05 May 2023 02:09:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906669000b00965b2d3968csm674500ejo.84.2023.05.05.02.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 02:09:30 -0700 (PDT)
Message-ID: <862cc092-d561-7e65-e8d4-a1c2d56a52ab@linaro.org>
Date:   Fri, 5 May 2023 11:09:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 2/3] spi: s3c64xx: add sleep during transfer
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20230502062813.112434-1-jaewon02.kim@samsung.com>
 <CGME20230502065025epcas2p11549db7400e6707c61bbb1cff1b22252@epcas2p1.samsung.com>
 <20230502062813.112434-3-jaewon02.kim@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230502062813.112434-3-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 02/05/2023 08:28, Jaewon Kim wrote:
> In polling mode, the status register is continuously read to check data
> transfer completion. It can cause excessive CPU usage.
> To reduce this, we can calculate the transfer time and put the sleep during
> transfer.
> 
> When test on ExynosAuto9 SADK board, throughput remained the same, but
> 100% CPU utilization decreased to 40%.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

