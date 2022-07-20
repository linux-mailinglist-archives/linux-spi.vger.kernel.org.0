Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9C357BB9E
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jul 2022 18:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiGTQn5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jul 2022 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiGTQnr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jul 2022 12:43:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A20A655A3
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 09:43:45 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o12so21797746ljc.3
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t55C1XFbWIhH1E3uo69pdnvGfBCTN1U6gyLTc72uBSE=;
        b=cNwVQM9/qzCyD2IKuo1xDl4MCgiOMOtK9saoWRgvboxGgf3aefT2299HywHocJdFCS
         xobwsWcr8OJHf1Ank3M5TzaQsZ3MG3g0qwx/fTCz1wwjK5HGK41fB4d4fY1zGSJL8ban
         MVCMprXIeRbTNo7u7ZUNpqfBJBucu1SlL1Ih5Myao0M3k081ey65bWCQGNYUijrOVJIv
         w9RnJz0KT4WJOoX8A8Y9BlU+riVOIYfvB/mH7hr4URwpunnqr5mj4ZQ0gpT6+SvnQoI2
         JEvT2D634RdR/cQ7hxBcl+GRwD1iNEzdkVIo+pMGpNY5saOYXIREGsw2H7HRS2YqqQWy
         vBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t55C1XFbWIhH1E3uo69pdnvGfBCTN1U6gyLTc72uBSE=;
        b=ZkJLAKRAi2/7FzUo08ZCz0ki1BwEt2XLWFx9j0XL9tcLmitUvwy/5vthNMXBt603ft
         4DRbv4iIq0u7LPn/3LrkAT/DyflRZSBBBFopr/kQ7APxQ81J7Mc1fvpWHeQAnmPs7mHk
         oUNaHuGOV8Vigr7tAmWicNXwQYMUmb98wohQ9hq0REfIhN+oj1CJ5gjEPIDHfPh8eeTx
         Z5EAr81DuTtFqQWopjZEIKAuFAtuF1PLkEh8GjBh0GHGpghqdq1mi3jgjxIjWUcnWgvY
         QfkYLzwRcKhFBBonafOuRIuwJbMiSmspFGWG+qmFH6cXRfzzFh99heLol/CeQVl5LZGk
         6nIw==
X-Gm-Message-State: AJIora/AAtA/yypIK9iveSGFHvq/vUap0eJiYgrtiPsueEsaSR8PzWWD
        3AC4sRJhk2MaYrTunm3bwwVRrQ==
X-Google-Smtp-Source: AGRyM1u7K/8V0unyfLWjleyBDtR1Lmb0itlTD+sQyKskV23cTShVVobCpw0TWfpowsjHukv/yOtk+A==
X-Received: by 2002:a05:651c:1587:b0:25d:7844:5910 with SMTP id h7-20020a05651c158700b0025d78445910mr18644605ljq.325.1658335422174;
        Wed, 20 Jul 2022 09:43:42 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id o20-20020a056512231400b00478772eb18esm3911500lfu.92.2022.07.20.09.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 09:43:41 -0700 (PDT)
Message-ID: <13607b6c-83a9-4688-aa5b-934319a01f5b@linaro.org>
Date:   Wed, 20 Jul 2022 18:43:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND v2] spi: dt-bindings: qcom,spi-geni-qcom: allow
 three interconnects
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20220720163841.7283-1-krzysztof.kozlowski@linaro.org>
 <Ytgv9R3/hmxql0Lz@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Ytgv9R3/hmxql0Lz@sirena.org.uk>
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

On 20/07/2022 18:40, Mark Brown wrote:
> On Wed, Jul 20, 2022 at 06:38:41PM +0200, Krzysztof Kozlowski wrote:
>> Recent Qualcomm Geni SPI nodes, e.g. on SM8450, come also with three
>> interconnects.  This fixes dtbs_check warnings like:
>>
>>   sm8450-qrd.dtb: spi@a98000: interconnects: [[46, 1, 0, 46, 4, 0], [47, 2, 0, 48, 12, 0], [49, 1, 0, 50, 1, 0]] is too long
>>   sm8450-qrd.dtb: spi@a98000: interconnect-names: ['qup-core', 'qup-config', 'qup-memory'] is too long
>>
>> Fixes: 5bdcae1fe1c5 ("spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> I'm assuming from the fact that I acked this that there's some sort of
> dependency here which means I can't apply it?

Sorry, I did not drop your ack. Intention is that you pick it up. No
dependencies. Fixed commit was in v5.19-rc1 so it could be considered
for fixes, but it is not urgent fix so could wait till v5.20.

Best regards,
Krzysztof
