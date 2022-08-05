Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0321658A84D
	for <lists+linux-spi@lfdr.de>; Fri,  5 Aug 2022 10:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiHEIrr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Aug 2022 04:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHEIrp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Aug 2022 04:47:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C433B205FC
        for <linux-spi@vger.kernel.org>; Fri,  5 Aug 2022 01:47:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y11so2488016lfs.6
        for <linux-spi@vger.kernel.org>; Fri, 05 Aug 2022 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cPhjnPAp997nXnbGBw6oxpbmrga8vTkPOOZqxdvdOc8=;
        b=Raai421gR0O4saWxOe/hXvr8OAj5W7eRABIdcMbIWZe0qLtZnpnqOydkGuDpSyXQW2
         2WoYdHu9flurOu1S411FSuQuUH6rMs37rn2gqNOXO50/yJHkbfJ9N2WxqpkC3eT/gyJd
         Ln6Fx1bUI+0vu5I0gTLGijS3eY8VHBqCKT6TD3UVxQ8heADLtNGiBZLynk485JjPFbyw
         3pTrOZ6wzwyVSWPo80gysf5JsTlmwXHHrAwTnDdC1ZOox4lA1UXlykrtarORPC5qnHyh
         DQwqwC79E/RE21N/C3gRJJT56r5BEzdzh5pJYWzZuFaE/N9jaHm0OTPT0kpSC7F2IKVl
         QMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cPhjnPAp997nXnbGBw6oxpbmrga8vTkPOOZqxdvdOc8=;
        b=FEMRsM4nTpy9HdOGO44C/0mPB3Rha6YvooGRn3beBQduKaxUUiv1J46fhpwYVqsT6y
         ni9ckBx/iZT/EUyLDRYtgBxWGK4vO5LLJY/bH7LQaC+K3PIkFHCWv17GiFi7yxRgf1Oj
         1mumF9xCSjl4o2CWkk77Cii/3zaWI86guOCO1uO1GlIC7jX9UiHcSHBuJ8d4eLMplrcC
         GBENnYhKzYJ9R/mAPMVpWYaAzR9/380ss88B1+kHDvW/EeUVOiyPFbbbKjN0KK6sl+eU
         lBV2AXqsldB/gW/7mJIu4Mu8smpwW321k42I4NsbXIMihKXfF+YFYj5SccAa0gXItUJi
         UVzg==
X-Gm-Message-State: ACgBeo2MLoUkkC8mKGENWpIeVQtxuKMajN7WN3E0QL7dP7E80mmju+6C
        9V7Zip0i7hBkG9WKjWF2g+aFJA==
X-Google-Smtp-Source: AA6agR6qAtlU5Afpao5FBvkPRc9T+X/qjalJPoTo/YdLTpFSaF3HxsYAjSOiL6PkxBP40e4gKGzPNg==
X-Received: by 2002:a05:6512:12c7:b0:48b:37af:15d3 with SMTP id p7-20020a05651212c700b0048b37af15d3mr2172359lfg.290.1659689263183;
        Fri, 05 Aug 2022 01:47:43 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id x6-20020a2e9c86000000b0025e59a76742sm400638lji.14.2022.08.05.01.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 01:47:41 -0700 (PDT)
Message-ID: <7c9f0d96-2882-964a-cd1f-916ddb3f0410@linaro.org>
Date:   Fri, 5 Aug 2022 10:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/4] spi: dt-binding: add coreqspi as a fallback for
 mpfs-qspi
Content-Language: en-US
To:     Conor.Dooley@microchip.com, Nagasuresh.Relli@microchip.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valentina.FernandezAlanis@microchip.com
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
 <20220805053019.996484-3-nagasuresh.relli@microchip.com>
 <a83c5784-6c86-497c-78d8-1550e8add7ec@linaro.org>
 <1e48a9bb-9e35-66e7-e8e7-ff5de9941fc7@microchip.com>
 <d94704b7-8a21-9eed-68e8-53221a08d677@linaro.org>
 <c2256f4b-95cd-aa9b-f839-8f54e2ba8d5e@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c2256f4b-95cd-aa9b-f839-8f54e2ba8d5e@microchip.com>
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

On 05/08/2022 10:44, Conor.Dooley@microchip.com wrote:
>> 1. It is redundant. I did not look too much at the driver, but none of
>> the of_device_id entries have some driver data to differentiate,
>> therefore - for the driver - the devices are identical. If they are
>> identical and according to binding compatible, use less code and just
>> one compatible.
> 
> Right. Then the binding is correct and the driver should only bind
> against "microchip,coreqspi-rtl-v2".

Yes.

Best regards,
Krzysztof
