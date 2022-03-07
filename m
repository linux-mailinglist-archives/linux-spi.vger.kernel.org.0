Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC50D4CF4F0
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 10:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiCGJYP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 04:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbiCGJXW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 04:23:22 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BC366630
        for <linux-spi@vger.kernel.org>; Mon,  7 Mar 2022 01:21:46 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b5so22169980wrr.2
        for <linux-spi@vger.kernel.org>; Mon, 07 Mar 2022 01:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FEjD5UnY3g+LJSLtm81A4hBh6vcWY851fxWX9klidBY=;
        b=S7UDc4e5bGd9CFcmgYIIsHJSuiXGjtH5EdyDFEEpI1ILcpNuKoVaSebz8vvnCfklhA
         Q3ZhwpthHRwsoyg1QRPPpReHy/Hkk4DNuZNfye2Y9ubNuPFN1VFTTzeu+tT88/6yEglK
         +g91WFyJRb4sfb0ET90aImvI8rW6kdLZ5NKTqLen4mOzqfwFbFrBm3fUuBkXsZqYRHeL
         CpALospQSfVtoSpsR5KbRfjwsDBfm+uss1lpYi8vYG9iyTNu9AxBmC+1/WpZprY7DYN5
         A2t/svZ1+oe1/9KkKFmiN1nwoYbUwcBs9Xd6xmfxXEa1s6uilZUFxBTRygnTSNQIyXea
         46tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FEjD5UnY3g+LJSLtm81A4hBh6vcWY851fxWX9klidBY=;
        b=deWNB9LSTTz7GhB84QYiqx4rkk/ADx645FlHcEjzTpGGtltDGZOecKtLthb3ZQ01pa
         zoO5NL7h2HeaTn6ZaypS6yGP3BtDoVZMsiBd4YiknErqTM4YCEgxZl2m+n+r+Sssbfz3
         XzJ1miMdLKQa2t8rvDcQYpQH0m0Mxr8VZ3D2b78Xto0t6UQi0xmhYxQocazlnmHOWu2f
         nj5vI+7NDn4u7ZwOLvxDW09Dsgrmed2AWHQeI+lFcfNtDttQCCazZpVej0ACQMfuXt2w
         GfPt9SbgSY0m0LLsERspRM6hF2P8m43QUzmM/eZzyi2ewCVDTJQ25S3eLC+uAOBbWRIJ
         6KlA==
X-Gm-Message-State: AOAM530j2pyJ+xzaPoRGbCIH8avC9PnLll+bYd1e4QmVnNusnddODwIb
        aM8ujv9BrzwwPqHna+lMbQ7qxw==
X-Google-Smtp-Source: ABdhPJxNUOpnh3+aVjnLQhhuXGLFg25COoG20HVZw9DPDpFrcABTTJyv32aW4ES/yVz79d/Hwc0WPQ==
X-Received: by 2002:a5d:4487:0:b0:1f1:232b:794f with SMTP id j7-20020a5d4487000000b001f1232b794fmr7769355wrq.715.1646644905072;
        Mon, 07 Mar 2022 01:21:45 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id ay23-20020a5d6f17000000b001ea79f73fbcsm10517130wrb.25.2022.03.07.01.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:21:44 -0800 (PST)
Date:   Mon, 7 Mar 2022 09:21:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v6 2/4] mfd: dt-bindings: google,cros-ec: reference
 Samsung SPI bindings
Message-ID: <YiXOph97XObDB2X4@google.com>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
 <20220124082347.32747-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220124082347.32747-3-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 24 Jan 2022, Krzysztof Kozlowski wrote:

> The ChromeOS Embedded Controller appears on boards with Samsung Exynos
> SoC, where Exynos SPI bindings expect controller-data node.  Reference
> SPI peripheral bindings which include now Samsung SPI peripheral parts.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/mfd/google,cros-ec.yaml          | 29 ++++++++++---------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
