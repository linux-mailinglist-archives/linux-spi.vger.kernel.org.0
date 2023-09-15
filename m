Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7DD7A1CAC
	for <lists+linux-spi@lfdr.de>; Fri, 15 Sep 2023 12:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjIOKrP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Sep 2023 06:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjIOKrO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Sep 2023 06:47:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB34B18D
        for <linux-spi@vger.kernel.org>; Fri, 15 Sep 2023 03:47:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99357737980so260554566b.2
        for <linux-spi@vger.kernel.org>; Fri, 15 Sep 2023 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694774826; x=1695379626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/o4N+rJdDvPOkHZP4rGeji09Be+GMTp3ncXx+q6uC0=;
        b=icG5iIDZbs+c41vEqRqwJCd2yZhBnHjuWRpAGvFzCVGt1LybTXZIJnG5IyVWedUCsu
         A3l1kbET70LN0DcPv7u97MkPJ0KjmsN1D92X47rb49tnmWT37ByXSlP1BbtSM11JInTX
         MF1K6rnHPcFuaOHkHVxUNQBe8PhUFCL6L/HL0cCcJGshExeIFsP95CeWS/Fqv5FClh2S
         fIW3/iGywh+JEf9gZ/Z82dEjqNHyuDq4MFTUOssybK8sgixh/1G1b0wbGL82rK5rwDcg
         NqVmKnqSct8EXVgxB7XGHWt4/5EFN3boSG/cVCx8mDnWQUQi8w4gElQCiT7E8HrqZL0k
         vUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774826; x=1695379626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/o4N+rJdDvPOkHZP4rGeji09Be+GMTp3ncXx+q6uC0=;
        b=edf/pM9FpHmiT6tdYBOiHZhJg1zLU/p+Rj2yE8mBu38t6kcEPdRZmQFXiDpzqsBaYE
         rYonMXN3seiCJIZQRydM1H0syxdVoQ4LL4RW6hmEe/WY0Ce3mc9xD/0p/QONEabw9q6g
         33HTbpl6EzUe2ciy4X+pgJRykgt3v1Tdr1EExRz3pVhMTdPzG8ieEQcf2gSq8DE480AM
         jSRzl0WPRYmo6wm+fUDnCkTvvvoLV+FAQYNRfiHVEBUQd/mIBZ5JsVZMLrEeEqrx4KLB
         C/wPGb+5/q6qhGxpppXd4dr/1q37yCjpR9Qn5dT8SMxxsCTxjTIHRdMSWsvKgYC4DWN6
         GA8w==
X-Gm-Message-State: AOJu0YwyKjy82839U8/7m6B+UfMP542wyBcMcxW93WTZt+waNOPTipe+
        gN+tf8oiko62gtLeSg4HABSclQ==
X-Google-Smtp-Source: AGHT+IHVOd/ddryjn2v0lhERAAcKk6mQCZCf4sdk9KrpW6+CUqWi6F4ZfilyAWQn9jSB9zOV0NnX8g==
X-Received: by 2002:a17:906:311b:b0:9a1:c352:b6a5 with SMTP id 27-20020a170906311b00b009a1c352b6a5mr1069106ejx.69.1694774826009;
        Fri, 15 Sep 2023 03:47:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906191200b0098e42bef736sm2224043eje.176.2023.09.15.03.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:47:05 -0700 (PDT)
Message-ID: <d334267f-38dd-bf70-4246-263de1a4747f@linaro.org>
Date:   Fri, 15 Sep 2023 12:47:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 19/42] dt-bindings: spi: Add Cirrus EP93xx
Content-Language: en-US
To:     nikita.shubin@maquefel.me, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-19-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-19-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 15/09/2023 10:11, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add YAML bindings for ep93xx SoC SPI.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

