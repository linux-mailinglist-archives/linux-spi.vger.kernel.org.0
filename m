Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5AB646C1A
	for <lists+linux-spi@lfdr.de>; Thu,  8 Dec 2022 10:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiLHJoq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Dec 2022 04:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiLHJoo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Dec 2022 04:44:44 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6945F6E568
        for <linux-spi@vger.kernel.org>; Thu,  8 Dec 2022 01:44:43 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x28so1199124lfn.6
        for <linux-spi@vger.kernel.org>; Thu, 08 Dec 2022 01:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Au11CpDwn/UURJjwp0rA3AGArUSenl9oJW8Wm3b2MRI=;
        b=oQVy6g6ftbqQnTmQTVvMb8OUxjzE6cI+OwClMDRYtJL4J7shXtdgl9dnIFESMg6CXE
         sqwdeTvpk+qjGrsm+NgWkouPci01Y2frsw5t7yX1DRHmgqOunKOtK3ff8qRUg8Bt6A84
         Lz01eBaKYwHp2SPGwO0/kHZYYcALchNo1wb9OaGkV2K3RFNjkOos7mwrjM3fwYhaH5Cl
         Tv06SYsr8e41IzLg1ZKClIDbCOinFFZwWjxbVSTs+84VG3IA7Je/PalFrAQL584XFyZ6
         hgnxUFkMqlfRGGUHzu+jDTev1aojSSEBZ2qbJY49MFOf1CiPoBozUAiK5YI4c/XvKlwo
         h2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Au11CpDwn/UURJjwp0rA3AGArUSenl9oJW8Wm3b2MRI=;
        b=E4RdI0+8eOt8UtwPU2UGQYz1FExIncIsU6eINmgHE+OkEuHYkROU4krqm1tZB5QJ6w
         X7EDtYkITS/RmE/BsDGWoq9C3A1o57sBn6zbZxxJc0mxXC/tsUhCrRer/hTeVb2sjU/z
         fojox/wao25NHq2NHCpoKKEuB00QrZkKZf5SqRzKKcPPoToQSm1LXH1DimNaaq5BES4Z
         pI0NZvabYUF+LWcMRgJ9cWrRChU0QPu1wTeAqkkO+z6fKYG7pYzy5XdBlJJGu9ubzTOc
         6dWoLpAiC+8tsJS77tKkcjIhJXnZvysriKvob0VGt+MGn/SCSEi8B4prmb2JgZzJmZoA
         Os/w==
X-Gm-Message-State: ANoB5pnGluz33SUBqQsXJaDM3k5pBkeK+ympv1FQ12retUfr+NSrVjmg
        oGNuJmC5lHF4xOprDBblRsUOUw==
X-Google-Smtp-Source: AA0mqf7iPq8OR3W99hPV0n9RoC8HsGux0XFBkldIaraeJ45vK01ol6MYOTxEh2bE5pnb0/WQaoLOKA==
X-Received: by 2002:a05:6512:3f0b:b0:4b5:22:7fbc with SMTP id y11-20020a0565123f0b00b004b500227fbcmr19179516lfa.183.1670492681820;
        Thu, 08 Dec 2022 01:44:41 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p21-20020a05651212d500b00497b198987bsm3273986lfg.26.2022.12.08.01.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:44:41 -0800 (PST)
Message-ID: <4dd69cca-3ae1-7fda-b1ad-01087449afa0@linaro.org>
Date:   Thu, 8 Dec 2022 10:44:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 9/9] dt-bindings: mtd: mediatek,nand-ecc-engine: Add
 compatible for MT7986
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
References: <20221208062955.2546-1-xiangsheng.hou@mediatek.com>
 <20221208062955.2546-10-xiangsheng.hou@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221208062955.2546-10-xiangsheng.hou@mediatek.com>
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

On 08/12/2022 07:29, Xiangsheng Hou wrote:
> Add dt-bindings documentation of ECC for MediaTek MT7986 SoC
> platform.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

