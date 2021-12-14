Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944E64749B4
	for <lists+linux-spi@lfdr.de>; Tue, 14 Dec 2021 18:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbhLNRhs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Dec 2021 12:37:48 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46604 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbhLNRhq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Dec 2021 12:37:46 -0500
Received: by mail-oi1-f170.google.com with SMTP id s139so28042663oie.13;
        Tue, 14 Dec 2021 09:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WR9gGYu8QQ5K/woO2Lwtdpoe5T+WeJunkKn+dMZvc8w=;
        b=7cHYhnq35Xx8BaiLTJ8kNiZ8j7CunkYv7BoigRowDzP9H6HTBAddFG0KnIce5pYAk5
         KEJUdjb2bV4XHxn+UckyWBUsTkDGUxFwmfJoYhRTPcSXu3Z3qtovy1gqo0ke2OxK6ALB
         WHNNFeqNHw3osunTfJYM5d7jDrgWPLMqqPM3SL9In7hBf2PFT3q38QB1O5zbY8dVw/kN
         1xP3LzAHHIefNx37Gx05+0n1vRVAMnq9A+2qGszxbzXqryQ5RjT8HmQAlLMd7guogkGe
         sVonJXtith7XfwT3mvnWvkM0Je3RoKp8LOi7p2L2768ji2H8UJ/UMznCyTDtbWqqIaRX
         wcjg==
X-Gm-Message-State: AOAM531zOQrAQOx2wMcsZFYvFEKKOLAuwAXPq/1e9+WUGKbqrASOyaCb
        dzITNM7Bx67TAOBqXWy35w==
X-Google-Smtp-Source: ABdhPJyeANG0XOSBeKhvl+rrKsdX6O51quAB/Q0zd1QnHPf6CDYKn4K8Pm5zHFarIk1R6asLr4/DpA==
X-Received: by 2002:a05:6808:1509:: with SMTP id u9mr35869237oiw.13.1639503465518;
        Tue, 14 Dec 2021 09:37:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c9sm98122oog.43.2021.12.14.09.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:37:44 -0800 (PST)
Received: (nullmailer pid 3604503 invoked by uid 1000);
        Tue, 14 Dec 2021 17:37:44 -0000
Date:   Tue, 14 Dec 2021 11:37:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 3/3] spi: dt-bindings: Add an example with two stacked
 flashes
Message-ID: <YbjWaE5ZwmuRd/EI@robh.at.kernel.org>
References: <20211210201039.729961-1-miquel.raynal@bootlin.com>
 <20211210201039.729961-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210201039.729961-4-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Dec 10, 2021 at 09:10:39PM +0100, Miquel Raynal wrote:
> Provide an example of how to describe two flashes in eg. stacked mode.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 36b72518f565..048d2bbc74a5 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -139,4 +139,11 @@ examples:
>              spi-max-frequency = <100000>;
>              reg = <1>;
>          };
> +
> +        flash@2 {
> +          compatible = "jedec,spi-nor";
> +          spi-max-frequency = <50000000>;
> +          reg = <2>, <3>;
> +          stacked-memories = /bits/ 64 <0x10000000>, /bits/ 64 <0x10000000>;

stacked-memories = /bits/ 64 <0x10000000 0x10000000>;

While the source syntax allows for multiple (and mixed) /bits/ 
annotations, that's not something we support really.

If you have problems with the schema tools on this, let me know. The 
handling of this is not the greatest.

Rob
