Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702BF748F04
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jul 2023 22:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjGEUik (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jul 2023 16:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjGEUij (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 16:38:39 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075F619A9;
        Wed,  5 Jul 2023 13:38:38 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-34574eb05f4so29162685ab.0;
        Wed, 05 Jul 2023 13:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688589517; x=1691181517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbBPc21ldDzQA1syqBYF75bRGCLVt0pgAq3ZxpJ3lYk=;
        b=en4VS5ZhLRvLPoWYr4DiEH39DhScsArFFMemcHKSZ9ClvKAAqeZ0kDZhWhVR0oIf68
         JxAwGk+l2zIOMu1xwYryLDUK0UclHh6OHZ+oz7rktbmKuNg9Op1miA0HwhwlYEkEIm19
         9Qw8PRQqWp/5gFJD6hFu9UBO3dorfpeloYKZA5ii0zwJOvy51L2RJN74rdsBx+z5IM3x
         F7PRY3G6Hp5FOMUS8Bd0jMbsnsjW1amFy5n3AxGg0d6JtWLAiXAiXxuT3qnfYsZZwf4F
         77r04NsYH9ZITWyBR9Dil96cNKlehsr7Pjf9hZpNMqNmEaQe7EyP4zriqnQIObkX/evE
         zeQg==
X-Gm-Message-State: ABy/qLZZau6nBajIy+TUYMJW7SD+Bjhi0plE4LwISwee6KczhgGTGTqL
        NovG9rkjsTwzMeFPhKBIzg==
X-Google-Smtp-Source: APBJJlGvLnhCOIIZo2cdW0r28rwFIQGh0XG5JWZ7puIAWYgNxa1WEco6TFJC4zjGznsjCNN1W4mhnQ==
X-Received: by 2002:a92:d68a:0:b0:345:c72d:33a5 with SMTP id p10-20020a92d68a000000b00345c72d33a5mr227931iln.19.1688589517147;
        Wed, 05 Jul 2023 13:38:37 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z25-20020a029f19000000b0041a9022c3dasm3257155jal.118.2023.07.05.13.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 13:38:36 -0700 (PDT)
Received: (nullmailer pid 1858165 invoked by uid 1000);
        Wed, 05 Jul 2023 20:38:34 -0000
Date:   Wed, 5 Jul 2023 14:38:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: spi: tegra-slink: Convert to json-schema
Message-ID: <168858951392.1858105.14793065413434279529.robh@kernel.org>
References: <20230705152603.2514235-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705152603.2514235-1-thierry.reding@gmail.com>
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


On Wed, 05 Jul 2023 17:26:01 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Tegra SLINK bindings from the free-form text format to
> json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/spi/nvidia,tegra20-slink.txt     | 37 --------
>  .../bindings/spi/nvidia,tegra20-slink.yaml    | 90 +++++++++++++++++++
>  2 files changed, 90 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

