Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DEA6425B3
	for <lists+linux-spi@lfdr.de>; Mon,  5 Dec 2022 10:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiLEJXA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Dec 2022 04:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiLEJWx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 5 Dec 2022 04:22:53 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AD363AD
        for <linux-spi@vger.kernel.org>; Mon,  5 Dec 2022 01:22:52 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id x11so12808565ljh.7
        for <linux-spi@vger.kernel.org>; Mon, 05 Dec 2022 01:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifApAlZTQFbWg5ohlrPWCvJNXEFvsjQ5YMa0cqLSe/Q=;
        b=SMRaKuNVOMEMtKb9Ghp1P5LbxZ2NAL0PdCBOihZKAP3eyoOLXSa4aR9S/qbj0z3r8T
         T7cFDebZRT0b0vN/E23WFhNOKpi64lihKYO1rHt/APkYNJNso3Kv+0uO7VQv2WnYHLMW
         Z5Y6PuivtqO8N3JMa7TwdqZ9/H9rF41rYI+a8pkXjIIAqFUvA5wuLFpg85oxro8jtEws
         F9HU6sZnpuzQhmH3r5cRvhb7H43hB4aW1q3oeeElxjSDF+HvJ+5yhTJxms9NbPLGa7hm
         9lh89zB/V6Zy1S9+pqOFmgOe9hSVr566UMQTgYe4xuB7GgAaFYcaqhGTdZxUvKQFx6tu
         jemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifApAlZTQFbWg5ohlrPWCvJNXEFvsjQ5YMa0cqLSe/Q=;
        b=uJVBS7Fd9/sbfAz/vCiwRjWzC35CV5O8nmkl1SnXdlmUq3qa53MF+WzF4Bd176Fdkf
         FRsDXAvX/m/8/W1acGicK+uBzSWLq6biwVbf3+LbmCof8HCHqP8kkPMTQ9Zo+e0G1GC1
         MvspMSZL1f7HeAEwXLTTsReGisXM/V/Fjf+c7b9Nrw0F1npjQFpO89yVGEUwThXgpop8
         3ZZU2FBJE3HdiRl5KJUdijXoiRiLWlsrM45D383F8FGzGQpYpVkg4BiMp+r2H0MXjEjJ
         TnFErqINWcPmdg39viNGBC8RNkVXRD0nax66DGTp2tQ27hm/50addfWCCTzIU45fQ99+
         rhSQ==
X-Gm-Message-State: ANoB5pnctTY4xZfGQoJCBIMwuS0HWX6SBZMZqwEEazbQ76CG3QoB64C1
        7GXk9qbm6n5MALtm9Bv+nDFy1Q==
X-Google-Smtp-Source: AA0mqf5ubdilEPhhSGVBVAmanSy+eKOOTQiyr5re3MOtJ+WUJkcNhxnD/whPCuSsjcoLuGGPaa2jmA==
X-Received: by 2002:a05:651c:2211:b0:26c:66c1:87f9 with SMTP id y17-20020a05651c221100b0026c66c187f9mr20482455ljq.47.1670232170396;
        Mon, 05 Dec 2022 01:22:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k1-20020ac257c1000000b004b55075f813sm1304683lfo.227.2022.12.05.01.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 01:22:50 -0800 (PST)
Message-ID: <6ba5f4c6-d725-0bee-9fb2-eddfae5760ca@linaro.org>
Date:   Mon, 5 Dec 2022 10:22:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 9/9] dt-bindings: mtd: ecc-mtk: Add compatible for
 MT7986
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
 <20221205065756.26875-10-xiangsheng.hou@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221205065756.26875-10-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 05/12/2022 07:57, Xiangsheng Hou wrote:
> Add dt-bindings documentation of ECC for MediaTek MT7986 SoC
> platform.
> 

Now your subject prefix does not match file. Filename is
"mediatek,nand-ecc-engine." so use it instead of "ecc-mtk".


Best regards,
Krzysztof

