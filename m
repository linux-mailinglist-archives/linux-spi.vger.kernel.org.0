Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C91E58C30D
	for <lists+linux-spi@lfdr.de>; Mon,  8 Aug 2022 07:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbiHHFxe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Aug 2022 01:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiHHFxe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Aug 2022 01:53:34 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7CD108A
        for <linux-spi@vger.kernel.org>; Sun,  7 Aug 2022 22:53:31 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx38so8689498ljb.10
        for <linux-spi@vger.kernel.org>; Sun, 07 Aug 2022 22:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3vnVtVwupQ8WazaZ/AL9IwhCzJFASSPI0qjJVJcoGaM=;
        b=yjIPdxk6jpZlmk7BoHMOCo62Yfn7cAnV3oiwVY3HUfDPv5VzvqYi8VIzM8o/nd2yTd
         JGC4Rd9g+lOBYGQLkLwp+HPpTahAEcOI1n4S1S7/FX3n+YNGqiw5ZY63vKeDJFeQA2iw
         0ipNhEaWG4MQYKCjoegvDEeN96f4Z9A11EFwLh1DOb7OQCxdN/7baNPv1L/jGpzyRILF
         CgHTpW/RYHmgOo5av9P8c4m+YxAVSzWU7n8Uglf2RLPWdFTA1lOHDRSK69Xl8aCip7/h
         u1t7RerPTHjToAaK9V2cYkzc1kRG9Br4c/u9dpjazwR5mIO/mVuIo/6XTmr++gOVp95w
         3/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3vnVtVwupQ8WazaZ/AL9IwhCzJFASSPI0qjJVJcoGaM=;
        b=TSKjMWX1BIPbKQaMCm6Cmas6O4qTRycS+HeCvaHGMK1BGt5vd4uPHBpR5TTmwSJToQ
         Jw/Aa0lC31MQM5PxC+cIeieg3/et8SrMz6iZbDGLnYSErHg2WnKDvWFjl4WmexHMjQlz
         dRX30es7zmvioTdbRNmm0bZJk0UriyXWKdycaLWR171oD2eRm50ng3Lx38DB6DWwJ/2J
         sO4UdpJ7lg0pLwrhsC7tKV1uciD+nx1WBZ/TeHlVS+0mEtOdejvWMpeQjRG0jGaj2kS7
         VgOk2L3Ay1LvHuunNUAESV3yi/86VWJuUz8whX+1XXGLpynwWe91YsrLa1OqZKL06ULQ
         dJDg==
X-Gm-Message-State: ACgBeo3v0scY5CP/mWOHWH6ceF/v5AdHubL0k+7075oMSWpiHyaeygNe
        VP1FvzEdM/gg/TxiEe6jgTm/Ew==
X-Google-Smtp-Source: AA6agR6Ns2dWP270jXtxfSHr7jqQAWAB2geMsLB2/0u9dfxx6EWGcJLF7DNwM6LljpdVPznto5Rl0g==
X-Received: by 2002:a05:651c:179f:b0:25d:ba24:2e16 with SMTP id bn31-20020a05651c179f00b0025dba242e16mr5080138ljb.422.1659938009749;
        Sun, 07 Aug 2022 22:53:29 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id j16-20020ac25510000000b0048af3154456sm1306679lfk.146.2022.08.07.22.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 22:53:29 -0700 (PDT)
Message-ID: <5e61f334-4712-a41c-e270-d4cef6397112@linaro.org>
Date:   Mon, 8 Aug 2022 08:53:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] spi: s3c64xx: correct dma_chan pointer initialization
Content-Language: en-US
To:     Chanho Park <chanho61.park@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Adithya K V <adithya.kv@samsung.com>,
        kernel test robot <lkp@intel.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <CGME20220808004253epcas2p3937171a6f89a765d67d5cc7b55afb89a@epcas2p3.samsung.com>
 <20220808004851.25122-1-chanho61.park@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220808004851.25122-1-chanho61.park@samsung.com>
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

On 08/08/2022 02:48, Chanho Park wrote:
> Use NULL for dma channel pointer initialization instead of plain integer.
> 
> sparse warnings: (new ones prefixed by >>)
>>> drivers/spi/spi-s3c64xx.c:387:34: sparse: sparse: Using plain integer as NULL pointer
>    drivers/spi/spi-s3c64xx.c:388:34: sparse: sparse: Using plain integer as NULL pointer
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
