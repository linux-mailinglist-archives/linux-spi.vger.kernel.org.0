Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B39F57F0E0
	for <lists+linux-spi@lfdr.de>; Sat, 23 Jul 2022 20:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbiGWSGj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 23 Jul 2022 14:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiGWSGi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 23 Jul 2022 14:06:38 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297D414001
        for <linux-spi@vger.kernel.org>; Sat, 23 Jul 2022 11:06:37 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id o12so8767068ljc.3
        for <linux-spi@vger.kernel.org>; Sat, 23 Jul 2022 11:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xE6PfpX9DPBqVU42t03L6pTGjzCn9yf1x5xibIRYZmI=;
        b=PAMBYrAuqOWSquLIq2jwj49iBHeaVmdqTfwb5J/hVRlrMG5QzPGoA9DLNyoM5ztf5p
         F/A7h1kGKMOu9rKXRJln9IRSEINPnmQWKDD4UX7vm9DT1lm29SsR42omhWU3nr1Xdn3U
         X28Brm9lmwdTO1gJRPF1khOnZ9qAbc4U6SST5moUdcfOK1XBqAlaJG+X7XsY8ekN39Qa
         v7ATtmIHrhVRXU0TZ4Ypq4/0nCnBmEHMJf5/UgWjq18PQWMsLGd9oWjqoH4/25p3K400
         KKqrZiJQHwqcCm3lFX/BTTYO7uy9YPx0HJbDg/kKFVlDvZ701lnsgvnPmnk3gZP3NKhB
         F86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xE6PfpX9DPBqVU42t03L6pTGjzCn9yf1x5xibIRYZmI=;
        b=Abr855CY0UVFmHS4kKm1cm1jaEGShKh55kHYnQ0HzJTuERLT/B1EZS2SXJt9RwMyzo
         aR3A3dlhAZZVk3LrVQrpGBVC4dndMQ6MsFqlSrFr3sjSKeZnzQlbGJWI7lYPGSVlA46f
         nw6dkzlHdcHlgivfFONQFe7G7Zt3b/zEBTR5K37GrgJ7IVW4X9kh3yyVtqxIRA+LcuRy
         CnID3jIZbWvmA4R84FajzWtIZ/RJdnxIdFHQTrjzxaN+q8qkOETyFLVfoTvFXc+nvn8S
         7LJWnmDbMq80iEDN/Qj+gDfqt11wcplRdBoLcScNK4Lhi+O+gEbrL5U4sSghIe+KuAXi
         qN6Q==
X-Gm-Message-State: AJIora91tlfcKRuD97m1++V7fXfNVsyBUZ/cHpFxQhbLvdmPJn8eyiM4
        f3NUiT4a0oFbzNAmBF/ANd+zJw==
X-Google-Smtp-Source: AGRyM1v6qpIaJNGUb/yO7sFCtnP37Miy/u2XDkyAqNEfeXL2MtAJZr14lu+suanBtLzkxy+tyHOP/Q==
X-Received: by 2002:a2e:9e1a:0:b0:25d:f9db:92f7 with SMTP id e26-20020a2e9e1a000000b0025df9db92f7mr1093961ljk.243.1658599595304;
        Sat, 23 Jul 2022 11:06:35 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id q6-20020a0565123a8600b00489de206812sm1745826lfu.151.2022.07.23.11.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 11:06:34 -0700 (PDT)
Message-ID: <0af4796b-701b-dd3c-7fb5-57f3b20b40c0@linaro.org>
Date:   Sat, 23 Jul 2022 20:06:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/5] spi: dt-bindings: add documentation for
 hpe,gxp-spifi
Content-Language: en-US
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
References: <20220722214920.40485-1-nick.hawkins@hpe.com>
 <20220722214920.40485-3-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220722214920.40485-3-nick.hawkins@hpe.com>
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

On 22/07/2022 23:49, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Create documentation for the hpe,gxp-spifi binding to support access to
> the SPI parts
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> v3:
>  *Fix indentation
> v2:
>  *Removed extra space around < > for reg
>  *Changed interrupt-parrent to interrupt-parent
> ---
>  .../bindings/spi/hpe,gxp-spifi.yaml           | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml b/Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
> new file mode 100644
> index 000000000000..09b0c3fa5ec1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/hpe,gxp-spifi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP spi controller flash interface
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +  - Jean-Marie Verdun <verdun@hpe.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"

What about my comment here?



Best regards,
Krzysztof
