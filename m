Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A36F4F7698
	for <lists+linux-spi@lfdr.de>; Thu,  7 Apr 2022 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiDGGwz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 02:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241511AbiDGGwt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 02:52:49 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A19797B98
        for <linux-spi@vger.kernel.org>; Wed,  6 Apr 2022 23:50:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bg10so8828350ejb.4
        for <linux-spi@vger.kernel.org>; Wed, 06 Apr 2022 23:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sOBNvgaCeaKUl0pCxOaStgi4AtDvD5vTjwRPpX1afgI=;
        b=OfjisoY9ADHB/LAaU3PStatTtPjqHuthog/JZLRiCrE400Z4N5kB45I/5186gttD2r
         nqF/uKXWfo1Ud2MnP4pJ4WC0knoEmRdfJ91hf6/vlL68eVgvu0RHxoNJkP9g4Zs76DVJ
         8RH+bH6R+U4/4sVd/QlFSuXrGdiPzwJX/TWcVAJTbIRzADsNPy/b5nd6PyTYpQgdHC3x
         YvayfjGXngIvyYwfBvD35tuOGFTd1+j1ItNqYcQtYbPwo+lNLY7Voo110/C1DT3yhDB8
         HP65WkWBPWfVa/ZQQj97DlMrjNMzeoNE0BDy+7hdFtN3fnCn3kXL+NfqMoe8WTA5oHi0
         biNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sOBNvgaCeaKUl0pCxOaStgi4AtDvD5vTjwRPpX1afgI=;
        b=bbJfKHcnhgqSu1gPhWIpnS7ennSv0YXF23gK7B2AnQBD4d3WUJCJQ/SWzTIp/j1H5X
         Yix9cApEssgGyyuQo4C1zm4BTizpdOOsYnlqZ+NfvYuCKTepqadCrjfdEKZwLcHOmoDL
         e2QApjQHR/gysxlcROSlyMUlgIZkQEr8xoBdlEFvMpJ/vCgzPJtegad92TcC6fJk/7np
         uEb7YuEP6IAZ47kgv3mR6QucMjpPiXXpMfZ0KhEjykyxBnRTktvQIJGDcPqm1KGaAKNL
         csCfrp/TNVHXSMQOghB+Gui0Pkay9kR7mBhNNpJaMjaBC4zljrNCTczdB2boqh2w5/EP
         F1pg==
X-Gm-Message-State: AOAM533B+nVVLO3X4Y49N97/L0RsbNPWipTD5fRKqSP3NU5eWUzGByxu
        zFawt8JsQWvFa7P27xKQkowKYw==
X-Google-Smtp-Source: ABdhPJwZHd06+OJimqgTZYQ8rpgiu2LawfUnsP7vAlBXm6qHLY+PkgrfMGAWiY+1/KrNeuluf81U8Q==
X-Received: by 2002:a17:907:86a8:b0:6e7:fbfd:b5fa with SMTP id qa40-20020a17090786a800b006e7fbfdb5famr12305824ejc.703.1649314248606;
        Wed, 06 Apr 2022 23:50:48 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id z9-20020a17090655c900b006e83ffe41f3sm23085ejp.150.2022.04.06.23.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 23:50:48 -0700 (PDT)
Message-ID: <081c5f7f-31d5-f797-e107-1ea5c9639a5a@linaro.org>
Date:   Thu, 7 Apr 2022 08:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] dt-bindings: qcom: update maintainers (drop Akash and
 Mukesh)
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220405063724.12850-1-krzysztof.kozlowski@linaro.org>
 <Yk3X94DwNR4AcPP4@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yk3X94DwNR4AcPP4@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 06/04/2022 20:12, Rob Herring wrote:
> On Tue, 05 Apr 2022 08:37:24 +0200, Krzysztof Kozlowski wrote:
>> Emails to Akash Asthana and Mukesh Savaliya bounce (550: Recipient
>> address rejected: User unknown in virtual alias table), so switch
>> maintainer to Bjorn (as active Qualcomm platform maintainer).
>>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Changes since v1:
>> 1. Add only Bjorn.
>> ---
>>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml  | 3 +--
>>  Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 3 +--
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> Let me know if you'd rather me pick this up (and the pile of other QCom 
> bindings).

Yes, please pick them up. Few other Qualcomm bindings depend on each
other (SPI+I2C+Serial to finally convert the GSBI which uses it), so not
all of them can go via respective subsystems.

Best regards,
Krzysztof
