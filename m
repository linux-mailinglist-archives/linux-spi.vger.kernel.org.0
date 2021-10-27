Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34A443D5E0
	for <lists+linux-spi@lfdr.de>; Wed, 27 Oct 2021 23:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhJ0VkS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Oct 2021 17:40:18 -0400
Received: from mail-oo1-f47.google.com ([209.85.161.47]:40907 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhJ0VkR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Oct 2021 17:40:17 -0400
Received: by mail-oo1-f47.google.com with SMTP id m37-20020a4a9528000000b002b83955f771so1399592ooi.7;
        Wed, 27 Oct 2021 14:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cH13AIvgg8k0Tj5jxgXcx1qrJTIGCsaeWp4sPxukdn0=;
        b=RKurhFV8WNt3BsCPAz2hAM+JaXJzHLQisUqtF7+ZCQDSdqQ3QDg72xQAiyc9c4y83h
         AWwF7BVITxmXPxbGBTScCfBSMUe8tGIR5h2cPpqkmzJWUXfJd37PHyvLPNGxHPWUyib7
         mTqDe0cKxNPlzczAOVIdGiKDI7smBbAQPEXOU7n6oeL2Oay+fdKY+kqIMiVkueZeB6W7
         +r3U5/epj9UQauvd11x2vcNG9mPQKqVMg1i4c+Zknek++OVAtROMJC6P2HpdbPUa1Hil
         H5C+TICf9F3h2RjcjlagR5j5l7F+tcl6cZQofj83gSq9G62vdXA4dBguICVs+f+fos9y
         cSeg==
X-Gm-Message-State: AOAM5304pZfaALp5Q4lRU+UmhFdvQBtWI196U+edyMzqqVeYcntcfnlR
        rk1shoeRQqxPGW8mit4bBg==
X-Google-Smtp-Source: ABdhPJwKjoQdV/lk4ZBzFAf27xLExABTyCFx0pS9logH2YB491pcxmxHSix9BsHLJovS61S0SzqYqA==
X-Received: by 2002:a4a:3151:: with SMTP id v17mr149399oog.31.1635370671325;
        Wed, 27 Oct 2021 14:37:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d4sm593150otu.57.2021.10.27.14.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:37:50 -0700 (PDT)
Received: (nullmailer pid 2212397 invoked by uid 1000);
        Wed, 27 Oct 2021 21:37:49 -0000
Date:   Wed, 27 Oct 2021 16:37:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/11] dt-bindings: arm: pensando: add Pensando boards
Message-ID: <YXnGrUDnQxUDZXwU@robh.at.kernel.org>
References: <20211025015156.33133-1-brad@pensando.io>
 <20211025015156.33133-2-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025015156.33133-2-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Oct 24, 2021 at 06:51:46PM -0700, Brad Larson wrote:
> Document the compatible for Pensando Elba SoC boards.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  .../bindings/arm/pensando,elba.yaml           | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/pensando,elba.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/pensando,elba.yaml b/Documentation/devicetree/bindings/arm/pensando,elba.yaml
> new file mode 100644
> index 000000000000..84bd9e7e98e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/pensando,elba.yaml
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/pensando,elba.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Pensando Elba SoC Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Brad Larson  <brad@pensando.io>
> +
> +properties:
> +  $nodename:
> +    const: "/"
> +  compatible:
> +    const: pensando,elba

Going to need board compatibles.

> +
> +additionalProperties: true
> +
> +...
> -- 
> 2.17.1
> 
> 
