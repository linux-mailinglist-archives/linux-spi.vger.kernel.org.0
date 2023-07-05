Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0541D748F17
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jul 2023 22:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjGEUmS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jul 2023 16:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjGEUmR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 16:42:17 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2335410F2;
        Wed,  5 Jul 2023 13:42:17 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7837329a00aso267004039f.2;
        Wed, 05 Jul 2023 13:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688589736; x=1691181736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izRd4zCoIl+RLqQg60XZOpbq1IYeD7QdL1bfDLtsp3Q=;
        b=InU0yFS4YiojgdNz5yn5wwM4Fw0VJtMj8pDH7gm5FoSY6JR5snfSQXEE6LSRpNHrK9
         L07fW728QFBb3qU34D9Z+NJsrycD2f4LgSVf12ZSLdjv0toijhRl3EQlJ83Qa8ZmXOC6
         ikxX7H7o6J6weYWiL78KLXugzdbxXnOBShwYVbOFjgEHK5BZQeGJ63KWAZRpwFZyyahz
         Znm07t+Z1wydvFVreLRglefoEFsTY3sVEd99OKCPU1/mSw09ND9aFq1faHduNb1GtvOM
         Qj9ljrPDyX1dJ/SoCx6Si3LoihvqqAJFLA8jZvl1B6g7PYaRbxL1Sd4q1AH4/oyrNeyN
         0vTA==
X-Gm-Message-State: ABy/qLYhaMjkjpU+M9b8ZUBNnN6hPN0w0dUCF8VV3NAICZc+h2fgbu1l
        5YgQC8WQDcQI4fLmxWe8Tw==
X-Google-Smtp-Source: APBJJlG5akBXpGST/Skxtixnb3Thduxn7FvBmtHcKM6Zo/AuarTA0KCZUGqh4ZsU/VbHVxmONlymeQ==
X-Received: by 2002:a92:de12:0:b0:346:b85:5f2 with SMTP id x18-20020a92de12000000b003460b8505f2mr211023ilm.23.1688589736387;
        Wed, 05 Jul 2023 13:42:16 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k8-20020a02c768000000b0042b669f5084sm1139jao.62.2023.07.05.13.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 13:42:15 -0700 (PDT)
Received: (nullmailer pid 1863266 invoked by uid 1000);
        Wed, 05 Jul 2023 20:42:13 -0000
Date:   Wed, 5 Jul 2023 14:42:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: spi: Convert Tegra114 SPI to json-schema
Message-ID: <168858973323.1863207.4660075413463595757.robh@kernel.org>
References: <20230705152603.2514235-1-thierry.reding@gmail.com>
 <20230705152603.2514235-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705152603.2514235-3-thierry.reding@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On Wed, 05 Jul 2023 17:26:03 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Tegra114 SPI controller device tree bindings from plain text
> to json-schema format.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/spi/nvidia,tegra114-spi.txt      |  61 -----------
>  .../bindings/spi/nvidia,tegra114-spi.yaml     | 100 ++++++++++++++++++
>  2 files changed, 100 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

