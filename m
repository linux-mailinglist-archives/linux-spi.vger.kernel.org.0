Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA222C4092
	for <lists+linux-spi@lfdr.de>; Wed, 25 Nov 2020 13:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgKYMu4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Nov 2020 07:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKYMuz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Nov 2020 07:50:55 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6CCC0613D4;
        Wed, 25 Nov 2020 04:50:55 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d20so2925546lfe.11;
        Wed, 25 Nov 2020 04:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+fl0Adh1mh54cQ9Og4MLp5LZHOBD2iqcORQUaJwa2Jo=;
        b=m2slVasvvvIUl1dUOYAlgUF3CnzR8MqUQZKD7k3capZvRezAl3S9p47sEHS7JoJVKV
         dcZjpMWZiQoNnmugKJ1sZWECYJKpA6fqVlLBscHKGJNDysvMKEGCCwQRnXsdHsl3kAbD
         62+I6/VuJ9yC7CAN2CPwTsI972noycYq81WvvSmbaFZwwjqHR5Outwj+o5Dk3lOjxVnM
         KG9CYrJlUIu5jQFK3mTx2GQuPryjO9vsUbT4+XjfVV/9QniiY7tLv/b1msC7a/DxB9m0
         91mpJBHPcIilg4VRfO6Z4yprBPfMacD1Vd7c6ta6lGhZ8+kPm8QRxnkiMDY9heHYdTur
         4dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+fl0Adh1mh54cQ9Og4MLp5LZHOBD2iqcORQUaJwa2Jo=;
        b=rV8wh/kW6xeR3UBOurp8E3s4pwnugmrMg3xZQVylGuL+emfc+4XqUiJ1SV7B0p2Lga
         Z+RWzKw1vrty2fla0xeQyD/cb9n4TjchajaHaGv+avteEQO7va6UDiQ6wQ+UVsAfrbN3
         6TdUkRHDFz0tsI6iOjlP+PnlVJ2nfY97Y9sBX84aKK2dIgm1PXU03eprqxhRmUNcgd8P
         MwvraWgQLEYgHfqO9yALT49YcXHOBdkn9+uHLg1qm3xVtvTxw61lHVgqndi0LLWWrods
         Jt0BfadQNLlNAQ4Sesnv2n95FC7HlUjoSJcGWKoUp71q13dCkUItr5MEskaYDaN7lkf7
         lF9Q==
X-Gm-Message-State: AOAM533D8DB5LMJfUKpyAkgXdAa63SH8Lz0OwNFQgQk03EdlwRk4+hji
        oZWaaikYM7bX8+8dgnT5t68=
X-Google-Smtp-Source: ABdhPJxl2Y2/nAwVvIzL9OSvm4w2yY1JE83F/cy/PjthEw1B0z4LHSXxH54RNsKIC2WqLLTrHqAACw==
X-Received: by 2002:a19:ac07:: with SMTP id g7mr1466368lfc.125.1606308653774;
        Wed, 25 Nov 2020 04:50:53 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id a22sm251226lfl.11.2020.11.25.04.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:50:53 -0800 (PST)
Date:   Wed, 25 Nov 2020 15:50:51 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: Update Synopsis DW apb ssi bindings
Message-ID: <20201125125051.tx3knfzvezrhyq3a@mobilestation>
References: <20201119120253.390883-1-damien.lemoal@wdc.com>
 <20201119120253.390883-4-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119120253.390883-4-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Damien,

> [PATCH 3/3] dt-bindings: Update Synopsis DW apb ssi bindings

The patch subject is too uncertain. There is no subsystem name and
what is added to the bindings. I'd suggest something like:
"dt-bindings: spi: dw-apb-ssi: Add Canaan K210 SPI controller"

Then feel free to add
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

On Thu, Nov 19, 2020 at 09:02:53PM +0900, Damien Le Moal wrote:
> Update the snps,dw-apb-ssi.yaml document to include the compatibility
> string "canaan,k210-spi" compatible string for the Canaan Kendryte K210
> RISC-V SoC DW apb_ssi V4 SPI controller.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index 99ed9b416e94..4825157cd92e 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -65,6 +65,8 @@ properties:
>          const: baikal,bt1-ssi
>        - description: Baikal-T1 System Boot SPI Controller
>          const: baikal,bt1-sys-ssi
> +      - description: Canaan Kendryte K210 SoS SPI Controller
> +        const: canaan,k210-spi
>  
>    reg:
>      minItems: 1
> -- 
> 2.28.0
> 
