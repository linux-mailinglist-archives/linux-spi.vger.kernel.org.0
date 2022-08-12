Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1026590CE9
	for <lists+linux-spi@lfdr.de>; Fri, 12 Aug 2022 09:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiHLHxq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Aug 2022 03:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbiHLHxp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Aug 2022 03:53:45 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E101A7225
        for <linux-spi@vger.kernel.org>; Fri, 12 Aug 2022 00:53:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u3so291427lfk.8
        for <linux-spi@vger.kernel.org>; Fri, 12 Aug 2022 00:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=t2zD4Gc+IBCwzaxQZm5nwnj8VKZ7uXAPobM5jnwBEqA=;
        b=SFc6bpVFjiEaA23ezbdzEs3D6ojxba6KHtkjXT3HBYrQ2Y9qiiX7bQ9c704Efm+Z0O
         NZWiGkdSICTxjRLMcDRJT90eNKxPx8uk+tQBjjkxMJWTwDJBePtPf5/apZT9TD279GDw
         d5EKb9AUpqk2OkDNzuteDESRe8hMWSRx52exsv9FcnXR+X743hCZsl24BfyhXl4FWEwk
         LyqAhPY+zrRh4jvue/gn/S84EXiTVR3GEKgrswD23hkJJsNIStDy06gOoPXnFKFTgz2g
         8iiJOMby08LD7rZ3S7h0wxype7uky+Wqo0KGi4EFCgJq8pRqGeQ6/vmVAstWimEdLma5
         aC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=t2zD4Gc+IBCwzaxQZm5nwnj8VKZ7uXAPobM5jnwBEqA=;
        b=J7RCbE+HGb2TkPIolKLRvFqRAlA0ndYoOSNDQqnJ88DK8cyjtQBGMTJp5QIF0bpuhy
         acGwgYIg9IP/fh2hlIygNnQb5uNregCONFmMtM4y4MRPrE4eLBNYz/h9A7WwQBDxQvp9
         maiCGkwL2/dI7cj0r3r49Lb+uXQQf3X8AEXnsKsfgTCPwoWvMaAduBbG52MmC8p+U0cf
         GMQXEqb9S9XaUsWPM4CsHKM9LJ7rQArb5+kZzkJWlazdj+Peq56pUbYk1XQ0WTou2boL
         kwyKfpQ4zTNN5+SMI+vwzSw9cJOtrvsDn/2P8UqZk+YkcSjGoyMH2DYb7JXECMf3xABw
         vTXw==
X-Gm-Message-State: ACgBeo1RQT659NaS7tBotC1MlKETqKhfwdwOZByWUdzW+gtg1X4vN20s
        pa6hwn8aEPfvJX6+dTeEyTjLLQ==
X-Google-Smtp-Source: AA6agR5Wa3VvEz8uJYDP2FuCpRkMsOLcFxYLMgj+eenDX64O08TUWHnEsN/OEQyEZqcXqJg1wXJ7OA==
X-Received: by 2002:a05:6512:b86:b0:48a:e5cc:89a7 with SMTP id b6-20020a0565120b8600b0048ae5cc89a7mr990705lfv.599.1660290822861;
        Fri, 12 Aug 2022 00:53:42 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id o5-20020a2e9445000000b0025e4de48d36sm265435ljh.94.2022.08.12.00.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 00:53:42 -0700 (PDT)
Message-ID: <946d6858-522e-ce31-618e-a04e84aab72c@linaro.org>
Date:   Fri, 12 Aug 2022 10:53:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] dt-bindings: lpspi: add i.MX93 compatible
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     xiaoning.wang@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20220812073452.45763-1-peng.fan@oss.nxp.com>
 <20220812073452.45763-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812073452.45763-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/08/2022 10:34, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 LPSPI compatible


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
