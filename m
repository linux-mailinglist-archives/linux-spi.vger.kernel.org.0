Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8029A5A9177
	for <lists+linux-spi@lfdr.de>; Thu,  1 Sep 2022 10:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiIAICC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Sep 2022 04:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiIAICB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Sep 2022 04:02:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817DF121423
        for <linux-spi@vger.kernel.org>; Thu,  1 Sep 2022 01:01:59 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q7so23235393lfu.5
        for <linux-spi@vger.kernel.org>; Thu, 01 Sep 2022 01:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=JE5EdXExU9KB2vgJJhQ6V2iSs8d1y3Mi7fJ+Qjt9Auc=;
        b=aB2V/BErUKMHkn2ek+qBlKawiRb+bkfxMbWiz40Nt14zziORYJF95FPu6AP71lX8e9
         Dq+xkIoWRMeRwuCQ8sRA0XAnX/tNVCIEHAHmbBph4/o0bT5/AIy1KXewrl85KZf+i1KH
         2AC7ylvXvi3i611Q/YagrkP2nGljcjbRuIgE8RboPsabxMUUg+xBA/IWYfNruvRijGIa
         H96paO6sca481TlKtsgLNNR4bk0LF5MYZJPtztf/D9KOfX0wy/T1JTSRf7GFSntFIRrj
         xUmfOFScRCWDls5Df7UlbH96vkkEkJxequIlOIqRi+256pFmoDr7stoBXjvLiBt5Y08P
         Go4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JE5EdXExU9KB2vgJJhQ6V2iSs8d1y3Mi7fJ+Qjt9Auc=;
        b=JMSTRi+O3dgMw2oOgrqy4tTIwTaCVRx2PKOGnAzrLNK825phg5o9YL5CMLuCK22+Mm
         wlFdh1Lbo77DA4IC2FyUJrf2Ow4MAO80kXGn/DIBtL5g6zoesBA1M5j5drkxhadPF/3Z
         R0ZshCS/QfAAbtVKxyRg6xXb5E9uoojptQqQ4qDU+ik3/dlQBnWi8wHhKLK0ZSFz3C7R
         06RAhEE8ddpguIY5qbyubPrA1rSZgnRyDColTpwNQ3lHGE3+TBChRVImrGZ0xujAQip9
         mZ1HXvn9rNklqwP/ZYPH4IC2rYP+RWunCRzhifDwVOEgGJxbLEG4ACyoI2+J0zFbz9FY
         rBsQ==
X-Gm-Message-State: ACgBeo0kfUE2gin6dx7/9HseUChPh2xj4sqhZtG41N7aKMThItQZchZv
        pKn4f1AaO3vxuADwclcMHPPQnw==
X-Google-Smtp-Source: AA6agR6Gt8vZPLOFDKLLdZvIJqwp7OXLZ31OJ5pouoSLNqUfk7zi/LbFjh2q00ET/ZGzDHMbeKn86Q==
X-Received: by 2002:a05:6512:3dac:b0:494:903a:1f9b with SMTP id k44-20020a0565123dac00b00494903a1f9bmr1877630lfv.498.1662019317892;
        Thu, 01 Sep 2022 01:01:57 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id l19-20020a2e9093000000b0025d5eb5dde7sm2344768ljg.104.2022.09.01.01.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 01:01:57 -0700 (PDT)
Message-ID: <9863bdfc-1de2-62fb-19da-44a68bea3607@linaro.org>
Date:   Thu, 1 Sep 2022 11:01:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 7/7] spi: spi-zynqmp-gqspi: Add tap delay support for
 GQSPI controller on Versal platform
Content-Language: en-US
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     git@amd.com, michal.simek@amd.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, akumarma@amd.com,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
References: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
 <20220901054731.7705-8-amit.kumar-mahapatra@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901054731.7705-8-amit.kumar-mahapatra@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01/09/2022 08:47, Amit Kumar Mahapatra wrote:
> @@ -1165,6 +1214,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>  	struct spi_controller *ctlr;
>  	struct zynqmp_qspi *xqspi;
>  	struct device *dev = &pdev->dev;
> +	const struct of_device_id *match;
>  	struct device_node *np = dev->of_node;
>  
>  	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
> @@ -1176,6 +1226,13 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>  	xqspi->ctlr = ctlr;
>  	platform_set_drvdata(pdev, xqspi);
>  
> +	match = of_match_node(zynqmp_qspi_of_match, pdev->dev.of_node);
> +	if (match) {
> +		const struct qspi_platform_data *p_data = match->data;

There is a helper for that. Use it.

Best regards,
Krzysztof
