Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C227379FDDA
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 10:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbjINIIr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Sep 2023 04:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbjINIIr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 04:08:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB761BF6
        for <linux-spi@vger.kernel.org>; Thu, 14 Sep 2023 01:08:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401b0d97850so6682025e9.2
        for <linux-spi@vger.kernel.org>; Thu, 14 Sep 2023 01:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694678921; x=1695283721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFIpHL9VYrVju1srIEb7KTEErlMH5PD4UTJ9ZjItCnE=;
        b=xrDcu8JTa5hj2BxK6tzVe2c6kLAPBhQxDM10t0Nw6f+hXBtumezBiXZMlmuS97zZ2A
         mSLME/5GUcl4QurzOOHAUT4CjJXoQ1H4R7RdMOGkdNv2jzZ+QPgViJmk0ga/jswakasM
         xvP8wqaltnpTLUjujk/VZtQOLFgldcbRgbKTIBQWIHFazUwaBUy473C4TWqZWP8DACCC
         iepjgyylECL2HAnOhKgNzXHzD6IaZ7IH2FJAlPYTIIZ9Q6uJfaMpzfPHc75vqSmQw2TX
         gs12CEWQ/fpg1Y5l5R3bPHXo6brCE/DjypY2QDzw4PmoCsyxNU0G6StXtBLnio7HPDpV
         NTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694678921; x=1695283721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFIpHL9VYrVju1srIEb7KTEErlMH5PD4UTJ9ZjItCnE=;
        b=mn+6rs2OdOz2gv1i+T9Z6Dd+vOESd0pZTCRWoxuttr3IZO2+SCYz3dFRBT0vz/DEtF
         Y1SV0wcpMIwcRax106VhXkBNPjXXXQRSvSc4ieJptNzUGOdqp5Dekkd45xysgQ5E9NjW
         s4ezCVTqO/J1xEglRFzl/eHmnQfNSLiRTCV4F/Mvl51ljn9BOR/QcOpPNra6QWopFXpD
         w9kv+VaIzYOQD1hoRsU4UMWpskMlTSRb/EeWc7lxgN0sfh1WtSpmNRYqZ7NqMpm0aIyG
         fWOtOGWEEymp+Z2g6/rfjtjlSI//GNVWikLB8YMawDhO/hu0Qb65CZA58n8hF059GaRf
         RpqQ==
X-Gm-Message-State: AOJu0YziWj427Dx5i+I8oTO9UpcH4XiYXR1kK0nEP//tMJDyQmqqK4Uv
        E6BKAwobp9WB8FtZtI+Gb6NofQ==
X-Google-Smtp-Source: AGHT+IHdSSW7cqigrJz17mNPzAMmgLW3bAzPGgKG7KPeyKWDC6CMaXrSzXIfxWpY/Jyu3wDtBpMs9g==
X-Received: by 2002:a5d:4a09:0:b0:317:70da:abdd with SMTP id m9-20020a5d4a09000000b0031770daabddmr3889005wrq.59.1694678921435;
        Thu, 14 Sep 2023 01:08:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id z8-20020a056000110800b0031f3ad17b2csm1045535wrw.52.2023.09.14.01.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:08:40 -0700 (PDT)
Message-ID: <502336e9-2455-f3f6-57d1-807bc4b71f7f@linaro.org>
Date:   Thu, 14 Sep 2023 10:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>
References: <20230830145835.296690-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
 <TYCPR01MB5933571F06789BFF27A8FCC786E6A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TYCPR01MB5933571F06789BFF27A8FCC786E6A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 30/08/2023 17:18, Biju Das wrote:
>>>                 regmap_update_bits(rpc->regmap, RPCIF_CMNCR, @@ -774,6
>>> +776,12 @@ static int rpcif_probe(struct platform_device *pdev)
>>>                 return ret;
>>>         }
>>>
>>> +       if (rpc->info->type == RPCIF_RZ_G2L &&
>>
>> Wouldn't this apply to non-RZ/G2L systems, too?
> 
> It applies, if the device uses the flash[1] or [2] and it needs
> 4-bit tx support.
> 
> [1] Figure 20: QUAD INPUT/OUTPUT FAST READ – EBh/ECh
> https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qlks_u_512_aba_0.pdf?rev=3e5b2a574f7b4790b6e58dacf4c889b2
> 
> [2] section 8.14
> 
> https://www.renesas.com/eu/en/document/dst/at25ql128a-datasheet?r=1608586
> 

Geert,

Does it answer your comment or do you expect here some changes?

Best regards,
Krzysztof

