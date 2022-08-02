Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80694587963
	for <lists+linux-spi@lfdr.de>; Tue,  2 Aug 2022 10:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiHBIyK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Aug 2022 04:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbiHBIyI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Aug 2022 04:54:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7684E85E
        for <linux-spi@vger.kernel.org>; Tue,  2 Aug 2022 01:54:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bx38so5047934ljb.10
        for <linux-spi@vger.kernel.org>; Tue, 02 Aug 2022 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XR3z9DiZ0DUd8EO4tWpZvpp8MkSks67AedEHj3l8ZF8=;
        b=LLPYpdBYZldQTVnMi5TZ9MSqJ23My5pI3ZjxyzRdOKVa4+VnEAUHVbLcFEFWfG6Qpx
         0PYkqQgkpJDSqA8TJihUg3mn17ojdwerBMXWmWNLXrf9IMgU+Yxx1CqDFaMT9xez6C1U
         MlSGM9zPn907jTvNQ7dBn9doB6080t72nPeO7dpumNaN0hJD1ugLViGJJ3VcFkMGmb/P
         VuJZQp2cz3vYRWCKf16pC6eB7uclrTgSuBL+AdAdeOCLTpRj/IVGfcavlwxP1JtONpi2
         wD7lbnuGZW3fsz7bg58PoUZuGTquY+uxvtkTSu+zX1vngf8druXccdiKFY49d2kMvrcT
         0dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XR3z9DiZ0DUd8EO4tWpZvpp8MkSks67AedEHj3l8ZF8=;
        b=6tx9wV3pxY/G3MBIsBcEOulX4H9I2Z9hGaJKG6TnOFPGj92jpp3RCjdxuE+xXXexP3
         Jc7j557kaXu5pyKaHdzqlFjSjtiXFlJJSUV1fuM80wGUxluYGA9VJdiq4huriDZawX1H
         xufuA5JqyYotV0bfcbVGHdlKv90gd/a4INX+3TjFx7WPJ4d2yItJg6AXA9iz196B99ag
         lRU85EeZ2lZl19j3U0wu2nr+pAuZjmBzg++Ho1puu4HgNLJSR2818umS3UXiwDRQne5d
         TGzEVoEjhqUOIwuEyVk905k9HyZFFlf7UUq+PLlupcOXz54UVc8cl9LYXG75VeczrG86
         3ZaQ==
X-Gm-Message-State: AJIora/ElMk5CTb7+dD5Sxczn4By/yMGAEIGsuxrjaNenmf8nedq6KQp
        ijwvxNW/FJeIeAjC59GlzBKv6Q==
X-Google-Smtp-Source: AGRyM1v6jN2giQnkdU0GSCDvaWsmzaPi5BR/zKcdhtryG+h4RzjUod5ZflQKKYmLYzDtmmtonli6DA==
X-Received: by 2002:a2e:8081:0:b0:253:ce61:3c66 with SMTP id i1-20020a2e8081000000b00253ce613c66mr5908085ljg.98.1659430445327;
        Tue, 02 Aug 2022 01:54:05 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id j7-20020a2e6e07000000b0025e65b3b24csm13448ljc.4.2022.08.02.01.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 01:54:04 -0700 (PDT)
Message-ID: <17a48c8d-fa66-95ba-4666-f4496425bd03@linaro.org>
Date:   Tue, 2 Aug 2022 10:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] spi: microchip-core-qspi: Add support for microchip
 fpga qspi controllers
Content-Language: en-US
To:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor.dooley@microchip.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-3-nagasuresh.relli@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220801094255.664548-3-nagasuresh.relli@microchip.com>
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

On 01/08/2022 11:42, Naga Sureshkumar Relli wrote:
> Add a driver for Microchip FPGA QSPI controllers. This driver also
> supports "hard" QSPI controllers on Polarfire SoC.
> 
> Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>

Thank you for your patch. There is something to discuss/improve.

> +	qspi = spi_controller_get_devdata(ctlr);
> +	platform_set_drvdata(pdev, qspi);
> +
> +	qspi->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(qspi->regs)) {
> +		ret = PTR_ERR(qspi->regs);
> +		goto remove_master;
> +	}
> +
> +	qspi->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(qspi->clk)) {
> +		dev_err(&pdev->dev, "clock not found.\n");
> +		ret = PTR_ERR(qspi->clk);

dev_err_probe() for the two of above.

> +		goto remove_master;
> +	}
> +
> +	ret = clk_prepare_enable(qspi->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable clock\n");
> +		goto remove_master;
> +	}
> +
> +	init_completion(&qspi->data_completion);
> +	mutex_init(&qspi->op_lock);
> +
> +	qspi->irq = platform_get_irq(pdev, 0);
> +	if (qspi->irq <= 0) {
> +		ret = qspi->irq;
> +		goto clk_dis_all;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, qspi->irq, mchp_coreqspi_isr,
> +			       0, pdev->name, qspi);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "request_irq failed %d\n", ret);
> +		goto clk_dis_all;
> +	}
> +
> +	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
> +	ctlr->mem_ops = &mchp_coreqspi_mem_ops;
> +	ctlr->setup = mchp_coreqspi_setup_op;
> +	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
> +			  SPI_TX_DUAL | SPI_TX_QUAD;
> +	ctlr->dev.of_node = np;
> +
> +	ret = devm_spi_register_controller(&pdev->dev, ctlr);
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi_register_controller failed\n");
> +		goto clk_dis_all;
> +	}
> +
> +	return 0;
> +
> +clk_dis_all:
> +	clk_disable_unprepare(qspi->clk);
> +remove_master:
> +	spi_controller_put(ctlr);
> +
> +	return ret;
> +}
> +
> +static int mchp_coreqspi_remove(struct platform_device *pdev)
> +{
> +	struct mchp_coreqspi *qspi = platform_get_drvdata(pdev);
> +	u32 control = readl_relaxed(qspi->regs + REG_CONTROL);
> +
> +	mchp_coreqspi_disable_ints(qspi);
> +	control &= ~CONTROL_ENABLE;
> +	writel_relaxed(control, qspi->regs + REG_CONTROL);
> +	clk_disable_unprepare(qspi->clk);
> +
> +	return 0;
> +}
> +
> +/*
> + * Platform driver data structure
> + */

Drop such comments.

> +static const struct of_device_id mchp_coreqspi_of_match[] = {
> +	{ .compatible = "microchip,mpfs-qspi" },
> +	{ .compatible = "microchip,coreqspi-rtl-v2" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mchp_coreqspi_of_match);
> +
> +static struct platform_driver mchp_coreqspi_driver = {
> +	.probe = mchp_coreqspi_probe,
> +	.driver = {
> +		.name = "microchip,mpfs-qspi",
> +		.of_match_table = mchp_coreqspi_of_match,
> +	},
> +	.remove = mchp_coreqspi_remove,
> +};
> +module_platform_driver(mchp_coreqspi_driver);
> +
> +MODULE_AUTHOR("Naga Sureshkumar Relli <nagasuresh.relli@microchip.com");
> +MODULE_DESCRIPTION("Microchip coreQSPI QSPI controller driver");
> +MODULE_LICENSE("GPL");


Best regards,
Krzysztof
