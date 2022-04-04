Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2F14F125B
	for <lists+linux-spi@lfdr.de>; Mon,  4 Apr 2022 11:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiDDJzU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Apr 2022 05:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355174AbiDDJzR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Apr 2022 05:55:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AFA3C4AB
        for <linux-spi@vger.kernel.org>; Mon,  4 Apr 2022 02:53:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r10so4636051eda.1
        for <linux-spi@vger.kernel.org>; Mon, 04 Apr 2022 02:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fIqsgVmiktE8nQPETLlrdHCC3xjtZXql3azcjqVoLik=;
        b=FFLhGV5KmQAibazuXkUZhQcRnTUIz252x+BPSbMrhLXfVEtTWghn9Mcgqcsj74hWvf
         D/KButuDBlljQb+VuwI+GnIEii7NqirbmNxQFIePhWLErcKcnFHjx36fVMSw8bbtIzCQ
         nxPLSOMYL3i70zeVRh1ySNOEcxUIwrlFHV0lQjpj9vfH8rbsARYOyf94zyRFpJpLo80f
         INf57ax+75M68vLt0c+6u9LwWbdawPeKLJyxRQgRVLcHA2c4spXX0nwAoigoHdO0KvbM
         oZWeLta0Wa7pX3lHUt/yV0cSeii1726nQwYStZV5x455pc2koXrnVBcOQfWNL2IPm/+e
         T4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fIqsgVmiktE8nQPETLlrdHCC3xjtZXql3azcjqVoLik=;
        b=Nw9+SMiOwiDVOjkImbhI+PoXHNKnpjw5smbeXN66UNxFfUgRA+n5FU46KSQqxeEiv2
         nSmhX8dZazVAPVH2Xn6I8FoZbPPVb+SNDoXsze6kwXZ5rk8uyGzSEkCns9dp4JqWFsej
         0cVzrKxeLyuYYQkuTvslSvoMYHeM8Ldpl6Jb2Xuqf366I6OcOTltsSE5U3C9Ih862zCE
         bfX1R67gHrOOeI6Ov1Mqt3MThSnAnlNCLO/lwJHUUDdfamhXaV7oaLjEe6EuLDWkHZ9t
         1qjuvK/5gilP9ZnXdWmM7W82C46qrT7i1fUaU6rLJJK+42sa17BlZOsglolx+lAYgYGS
         9QnA==
X-Gm-Message-State: AOAM530QWUvNtcQMopcdIorelazlXM8ELvAbK1OR9Gn61rjLSr5QRpLa
        l+b+zL4Dmk9Gr9ddHCz8Dt3qbQ==
X-Google-Smtp-Source: ABdhPJwUPyb8x56zcOzkevoWgOQMo4j5Vb1clSPdFyvxJeCVe5hEtXGnQTaITHDlCmKTHv8rtaLB6w==
X-Received: by 2002:a05:6402:1107:b0:416:439a:6a9e with SMTP id u7-20020a056402110700b00416439a6a9emr31675509edv.382.1649065997066;
        Mon, 04 Apr 2022 02:53:17 -0700 (PDT)
Received: from [192.168.0.174] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f3-20020a1709067f8300b006ce051bf215sm4101741ejr.192.2022.04.04.02.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 02:53:16 -0700 (PDT)
Message-ID: <bdbf104b-2300-0ea6-bbc4-51d6fb96124a@linaro.org>
Date:   Mon, 4 Apr 2022 11:53:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/4] spi: dt-bindings: qcom,spi-qup: convert to
 dtschema
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>
References: <20220331155320.714754-1-krzysztof.kozlowski@linaro.org>
 <20220331155425.714946-4-krzysztof.kozlowski@linaro.org>
 <YkqkJgLd4LdxF883@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YkqkJgLd4LdxF883@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 04/04/2022 09:54, Mark Brown wrote:
> On Thu, Mar 31, 2022 at 05:54:25PM +0200, Krzysztof Kozlowski wrote:
>> Convert the Qualcomm Universal Peripheral (QUP) Serial Peripheral
>> Interface (SPI) bindings to DT Schema.
> 
> This doesn't apply against current code, please check and resend.

The v2 was superseded with:
https://lore.kernel.org/linux-devicetree/20220402184011.132465-1-krzysztof.kozlowski@linaro.org/

The v3 needs a fix (in different place, not v3), so I will send a v4.

The SPI patch is now dependency for final schema conversion, so I think
would be better if you ack/review it.


Best regards,
Krzysztof
