Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2DF55D705
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiF0Jls (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 05:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiF0Jlr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 05:41:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680BF6349
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 02:41:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id pk21so17955511ejb.2
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dfOqnIn7sYWvsEoD8p7lU+FbuPf108gUfhhcodP/p+A=;
        b=IJzsnv0qXb1ns6J4xa7IEXq96G32D+Qp4g8YF5CI0pYBo+yj3FO/6uFFY26rZLIfAe
         ULWELqNwh4DXpGTEKC7Bac9ydmfzrUuaLHbRjYt+w98Ma5qdxBCyzc4Gq4G4QQkdZ5Sl
         u/fJqU8sDfDfLoh5hzpF8WhtbzeYOuJrwKbGAseBm72FN3bjYu+dEVlDRx8zOH9cNPUG
         FNoJcvFMfGM42Abryu/cTVRpvg4t2ySzAexhRE1rNUv5Sw/6puzlBpJ0IPIIxdeL62zK
         rLouv9L0APUgUSJRwyT6NoJTButQ0N6FkyJB5so23RoXublE+61UYHWVCZWDrIgkfMOk
         lNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dfOqnIn7sYWvsEoD8p7lU+FbuPf108gUfhhcodP/p+A=;
        b=dLIudnpunWTKm6ni8HsoJvPKHBaNv+m0w0yM2J5TzZEdBHEKMz+XilskVF4tfAcyIN
         7R7YGKC7ZNx1tRpDGQ/qrBrv9Hq6MbHl8YeG3Kq4T7v1ghL4iPA5FtiA8aRmoHQGIz4M
         rHAF68LPPIwQF9qhLH1c2Hcl2BTcuWqS3deK8+/gIuNRnV9bDBrCpVxvGAtKTgih4tWn
         j/0IcEuDhaphJf7YgmiuLMrE9WmMRkdYZMyRTsJ5whYWXHQNL7erdof7r5cxrdTfUZt9
         OKwcp6HMR3bKTlYhLvIlfTvgjQ3KQVoQpUbR2p4THW8v06QjwmM0lBR7l/n/+GrybMEv
         2OSA==
X-Gm-Message-State: AJIora8FxwZoo2AF9s8LbkyT7e7EWcficJXoVLFAAxdNONzlEL/Dv13u
        cXdIfufcJc3qhlO4JlAcdFr+9w==
X-Google-Smtp-Source: AGRyM1s1Q8GgiGrT28tprCtyd95DrJnywVBf00+YemMFNkRC+bm+Hq3CQJZ0mKASitmCqwgjmM5ybw==
X-Received: by 2002:a17:907:6289:b0:6e0:eb0c:8ee7 with SMTP id nd9-20020a170907628900b006e0eb0c8ee7mr11403607ejc.245.1656322905040;
        Mon, 27 Jun 2022 02:41:45 -0700 (PDT)
Received: from [192.168.0.247] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i23-20020aa7c9d7000000b0042de3d661d2sm7204870edt.1.2022.06.27.02.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 02:41:44 -0700 (PDT)
Message-ID: <858d08db-1233-78d5-6374-468b222a52d7@linaro.org>
Date:   Mon, 27 Jun 2022 11:41:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/5] dt-bindings: samsung,spi: define exynosautov9
 compatible
Content-Language: en-US
To:     Chanho Park <chanho61.park@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220627064707.138883-1-chanho61.park@samsung.com>
 <CGME20220627064931epcas2p2ad75d53ceabb2b0f10dfb13f5fcb0ff4@epcas2p2.samsung.com>
 <20220627064707.138883-5-chanho61.park@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220627064707.138883-5-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 27/06/2022 08:47, Chanho Park wrote:
> Define "samsung,exynosautov9-spi" for Exynos Auto v9's spi.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
