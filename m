Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CF3747CF4
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jul 2023 08:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjGEGVi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jul 2023 02:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjGEGVg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 02:21:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2E710CF
        for <linux-spi@vger.kernel.org>; Tue,  4 Jul 2023 23:21:35 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d80d81d6eso7518245a12.1
        for <linux-spi@vger.kernel.org>; Tue, 04 Jul 2023 23:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688538094; x=1691130094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXzJTSL0C9SwjgGDM+8y6l17lgOMSjsuE+XiEFarJNk=;
        b=JDdijNyMs8YO+LoLmY4HtiDvBobZ9JptXvaqMkpbUBszqzxc6cq82TNPImNYZaxV+Z
         qVgDrM42GC+z+i/lDPscyQIdo7LhRdC/XvFuhUzJABKTlViN2SA12Fcz8cgdPk461T5h
         kDkzai8vvYJh1JE9gbcmeO2YwOtODRh0hIKYCxfH3VBrBTzYbbsX0BIMNfhe0aS4nqYm
         UVM2Efp07zXFMmzkeJj47bifN4lnYOc5ynTauIMCGQFABMTTmPb3FVyUvlgmLMGL6KX/
         tJSBpp3ci2IU9TOPefsDNkNGDmnasJL0Yk7WfUeBpJqqcsXf97ZIQnM0XmF245GpqUoK
         r3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688538094; x=1691130094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXzJTSL0C9SwjgGDM+8y6l17lgOMSjsuE+XiEFarJNk=;
        b=cNB7u4DKOtNXyu/rqwUR5l9q/5DKwBqTkzktkFfdCp8Oz5U6FaMPwOsCUHdLMDF+6v
         d5vidT3aXtkVDlv7tCq6buWrsJ3wsTOBapCk0UVyxP1JLkPy4A6aNjqB0Lebt4IXVzl2
         3u+VHsKMNzAkgl7iKTvd3QPxHGmCrjaFWwUOjD/5iPJAT3EMn/qjLwlwPDx0dUqUSjeA
         PXrxww+zjqWnBvnZZzA7CJRFJsq/raO5vAC6se2+FZD2pd9xEfMixw4ok0IW+jd0MNAK
         WcLbiPGOh+k9qK8yAZMqMBmSiywJ9964XmSYJ44XLBmwH1y++cELxUmZxlvZwBc4Cz4N
         5fKA==
X-Gm-Message-State: ABy/qLYC/hD04dBzhiZMV8Tzul3drJnU9NPvpjthivgqs4AWAcg2ENSZ
        Wl8DvxDeU3RTF6A2EIbOnIrVTA==
X-Google-Smtp-Source: APBJJlExSLHdFgXPPpShsvfpLnQ1I9K6lq+Cv1kUvCmlpBxjhMhTXaJcgj6YoR1Z3h3+qYtEpvI1Ow==
X-Received: by 2002:a17:906:4f0a:b0:965:9602:1f07 with SMTP id t10-20020a1709064f0a00b0096596021f07mr11480125eju.39.1688538093774;
        Tue, 04 Jul 2023 23:21:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e8-20020a1709062c0800b0098822e05539sm14050847ejh.191.2023.07.04.23.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 23:21:33 -0700 (PDT)
Message-ID: <808dac44-a72c-4675-1e4a-0ed96190efb4@linaro.org>
Date:   Wed, 5 Jul 2023 08:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 2/3] spi: cadence-quadspi: Add clock configuration for
 StarFive JH7110 QSPI
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230704090453.83980-1-william.qiu@starfivetech.com>
 <20230704090453.83980-3-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230704090453.83980-3-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 04/07/2023 11:04, William Qiu wrote:
> Add QSPI clock operation in device probe.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306022017.UbwjjWRN-lkp@intel.com/
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/r/202306040644.6ZHs55x4-lkp@intel.com/


>  
> @@ -1840,6 +1858,8 @@ static int cqspi_resume(struct device *dev)
>  	struct spi_master *master = dev_get_drvdata(dev);
>  
>  	clk_prepare_enable(cqspi->clk);
> +	if (of_device_is_compatible(dev->of_node, "starfive,jh7110-qspi"))

Don't add compatible checks inside the code. It does not scale. We
expect compatibles to be listed only in one place - of_device_id - and
customize driver with match data / quirks / flags.

Comment applies to all your diff hunks.

> +		clk_bulk_prepare_enable(cqspi->num_clks, cqspi->clks);
>  	cqspi_wait_idle(cqspi);
>  	cqspi_controller_init(cqspi);
>  

Best regards,
Krzysztof

