Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAF243DC5D
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 09:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJ1HwR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 03:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1HwQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 03:52:16 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C76C061570;
        Thu, 28 Oct 2021 00:49:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so11738372lfu.5;
        Thu, 28 Oct 2021 00:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QKVQr4u2lbE5ti1lbaiCRX5MIqUo+DZbME0j76QVfuk=;
        b=jA5+cbDyux4+/+bwAYjbhsNuQkyQBnks0b83Dca2bVHgjxVG08zgEVOUgJhfuuzlvG
         0l/FGmArMPW0MZ5nKNjlEoNYQwTns9702yJ6i8WM9Xbh4+RaF/OcKW/fXliVdX6TZj/Q
         etVPolyIZ5Q8S75ow7Q7R03mYErIcADRXCnfqDMaejlACocbygJGFUQQCcWbv1idrgHi
         l1bpqrvLQV5GLFt8dSx1gyBX21NogilohamuigDClCR8NVyRzTF/p9mDDBdsjsqpdVHC
         KUXrWqWTknN04t72TPcVO1RIZBaYrWSYN6NO7TID8Ym5lxCbUTBHCs77kGfXM5K3Uqeq
         f9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QKVQr4u2lbE5ti1lbaiCRX5MIqUo+DZbME0j76QVfuk=;
        b=AuMa8zBr5NBn5hp6t4Pr844eErkxwqxcfOaoZrM257nVo6aeJxTm/ncRsEIk5tutqx
         XsAnJ9C1S0k+cQyi6I8fze1K1rvuqjvoslScS+jCjAzR2iDUiIok5Z3CAgbwpz/KRoCc
         RNE0mBNPUVY40YKosZDNIp+38CB4SGhqWzIiFxQgB2QobyrZyMSMKgD5+LS+7l8LbdjR
         YA5D+axhjW8RBN0vYBy2qiHpC5EPVMSg/uAfHXK5fZTlNhZRklekUNYDmkvhAg8vB2GT
         S5i/MQAEzwRTPGgmE8+2LPgedmG1NPkR0Dh9OD8lNdV/xsx0D84fIDIZrfaipgvG3+vO
         F83g==
X-Gm-Message-State: AOAM532IjmeXiDvCEDoEwlIEgzADzBRJp1XECGKSWbernE6lF5HiX7Wb
        M45gTzAOApdWTv1UBCEaGec=
X-Google-Smtp-Source: ABdhPJwY2umGOD4vrkd3kqSp2+v30UMZ0zZfP4rSYhyF6YjKey5F1JLdjWuIbgO5EbawjxN0at++/A==
X-Received: by 2002:a05:6512:3409:: with SMTP id i9mr2761613lfr.664.1635407388153;
        Thu, 28 Oct 2021 00:49:48 -0700 (PDT)
Received: from mobilestation ([95.79.132.211])
        by smtp.gmail.com with ESMTPSA id a11sm229366lji.90.2021.10.28.00.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 00:49:47 -0700 (PDT)
Date:   Thu, 28 Oct 2021 10:49:45 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/11] spi: dw: Add Pensando Elba SoC SPI Controller
 bindings
Message-ID: <20211028074945.rv2j5kgzk7yc2srr@mobilestation>
References: <20211025015156.33133-1-brad@pensando.io>
 <20211025015156.33133-6-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025015156.33133-6-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Oct 24, 2021 at 06:51:50PM -0700, Brad Larson wrote:
> The Pensando Elba SoC has integrated the DW APB SPI Controller

Please add the "dt-bindings: " prefix to the patch name and discard
the word "bindings" from the title as the submitting DT-patches
requires:
Documentation/devicetree/bindings/submitting-patches.rst

> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index d7e08b03e204..0b5ebb2ae6e7 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -73,6 +73,8 @@ properties:
>                - renesas,r9a06g032-spi # RZ/N1D
>                - renesas,r9a06g033-spi # RZ/N1S
>            - const: renesas,rzn1-spi   # RZ/N1

> +      - description: Pensando Elba SoC SPI Controller
> +        const: pensando,elba-spi

AFAICS from the driver-part of the patchset it's not enough. You've
also got the syscon phandle, which needs to be reflected in the
bindings. That also makes me thinking that you didn't perform the
"dtbs_check" on the dts-files you were going to submit, but for some
reason discarded from this series (btw why?). If you did you would
have got an error of an unevaluated property detection.

-Sergey

>  
>    reg:
>      minItems: 1
> -- 
> 2.17.1
> 
