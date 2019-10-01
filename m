Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A27C33A7
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 14:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbfJAMCF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 08:02:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41021 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfJAMCF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 08:02:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id w65so1321201oiw.8;
        Tue, 01 Oct 2019 05:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0vk+axt7MtTNP8zJtVF1vqgIMglVNkEgAAeax/JHomA=;
        b=cxtL3eRK0KTlOEbxnGbKqPRIUPCtWzG8nKLAIHuVSo1ujzhpWDpUf7Iq0ZyI6zpl1i
         g8b555vEtyHWd9rrUMen5AEFAHGoUYpI0ufvveoy8AcqgGMOI0oeLG6scSXSyDO7hzu3
         OLyObYxibjGK1HFZ9B62wtv2vEUmm7L34inTWTrrmYBAl4WVOnnCKB7oksoDJukp45CU
         nDY7yVcvzVMFD8afU0Cmds0gi5LjI4bMeaJUwpNOj+CX9jrp6JkVaTEsZZEtKYBLiLsN
         NKTBl/OTJgCjj+TaAIPYaS+o3SdWYzMs+Qnd0iSKmHhVssZt6F2m45eRBDB34dPsxXuu
         nlrg==
X-Gm-Message-State: APjAAAX6hxKf9vl9pGsRl2XaHMD4szJr+Nz8JVFohyAvacpss60oO0Db
        zPUs2eDCfoxXGVmUIrTZiA==
X-Google-Smtp-Source: APXvYqwlEUzV4nhqIYSd1t2SDaN/XUENGs6M0vVKo9abXPpm7/8BdWeJ6O50/RLsD2OVG+1YY8VqFA==
X-Received: by 2002:aca:32d5:: with SMTP id y204mr3465772oiy.59.1569931324623;
        Tue, 01 Oct 2019 05:02:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n17sm4575249otk.5.2019.10.01.05.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 05:02:04 -0700 (PDT)
Date:   Tue, 1 Oct 2019 07:02:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: snps,dw-apb-ssi: Add optional clock
 domain information
Message-ID: <20191001120203.GA28106@bogus>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
 <1568793876-9009-3-git-send-email-gareth.williams.jx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568793876-9009-3-git-send-email-gareth.williams.jx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 18, 2019 at 09:04:34AM +0100, Gareth Williams wrote:
> Note in the bindings documentation that pclk should be renamed if a clock
> domain is used to enable the optional bus clock.
> 
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> ---
> v2: Introduced this patch.
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> index f54c8c3..3ed08ee 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> @@ -16,7 +16,8 @@ Required properties:
>  Optional properties:
>  - clock-names : Contains the names of the clocks:
>      "ssi_clk", for the core clock used to generate the external SPI clock.
> -    "pclk", the interface clock, required for register access.
> +    "pclk", the interface clock, required for register access. If a clock domain
> +     used to enable this clock then it should be named "pclk_clkdomain".

What's a clock domain?

Unless this is a h/w difference in the IP block, then this change 
doesn't make sense.

>  - cs-gpios : Specifies the gpio pins to be used for chipselects.
>  - num-cs : The number of chipselects. If omitted, this will default to 4.
>  - reg-io-width : The I/O register width (in bytes) implemented by this
> -- 
> 2.7.4
> 
