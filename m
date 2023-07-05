Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97A2748F0D
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jul 2023 22:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjGEUkS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jul 2023 16:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjGEUkS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 16:40:18 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7459E19A6;
        Wed,  5 Jul 2023 13:40:17 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-346129c9512so2874645ab.1;
        Wed, 05 Jul 2023 13:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688589616; x=1691181616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlaHnREsOPLyTM8GMOj9uJrgkZfJDQoCkc21T5aIjUY=;
        b=HhUYYUFhEcf/D9axzXqM+5/e9ma0QBr9j7wikRA4RsGlZB7h58X0DoVcaYvgvG4vD3
         l92iZiLMIPUm6WXBrb+nPNt6xUxsl2FhCnVutE4e1rbhKel1onHLwMKhYrvrwAXAy8F4
         QXzkwaLoNFQy9XpND50cMnPaSBBKtGE64NF+mqr0aLpVnUw1RCLSNdXsQh3pNfYenRFA
         SwulUMpfM6LP9E/ovJQquFnpAHJNw5bOXDyIVKxF2bN+E157D40VE9EcySUXZB1QKkNH
         4eghqe/VnP1SOLRaGNladgrSdzjufjuyovLR40GxA44N839paRxotfPQAq4NoZfThTcH
         DvFg==
X-Gm-Message-State: ABy/qLZvfMt4USyHv6ydWuIEkjByc3shOV74YY5CEJLkhq1z/V44gekv
        jo2TakS/S6udJeijZhCtsw==
X-Google-Smtp-Source: APBJJlFa/dmFswwB2r0RBaSddDBuS60nPfRAPGCmB3qFEtMDDKlfkhir0nedgx0Vn84mIiJU3pR9cw==
X-Received: by 2002:a05:6e02:1102:b0:345:a764:f760 with SMTP id u2-20020a056e02110200b00345a764f760mr2117917ilk.8.1688589616661;
        Wed, 05 Jul 2023 13:40:16 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r14-20020a92d98e000000b003459023deaasm7865968iln.30.2023.07.05.13.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 13:40:15 -0700 (PDT)
Received: (nullmailer pid 1860523 invoked by uid 1000);
        Wed, 05 Jul 2023 20:40:14 -0000
Date:   Wed, 5 Jul 2023 14:40:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-spi@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jon Hunter <jonathanh@nvidia.com>,
        Conor Dooley <conor+dt@kernel.org>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: tegra-sflash: Convert to
 json-schema
Message-ID: <168858961370.1860460.16533353173756011870.robh@kernel.org>
References: <20230705152603.2514235-1-thierry.reding@gmail.com>
 <20230705152603.2514235-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705152603.2514235-2-thierry.reding@gmail.com>
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


On Wed, 05 Jul 2023 17:26:02 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Tegra SFLASH controller bindings from the free-form text
> format to json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/spi/nvidia,tegra20-sflash.txt    | 37 ---------
>  .../bindings/spi/nvidia,tegra20-sflash.yaml   | 81 +++++++++++++++++++
>  2 files changed, 81 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

