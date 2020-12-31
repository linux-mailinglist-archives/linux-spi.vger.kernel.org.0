Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD72E81A1
	for <lists+linux-spi@lfdr.de>; Thu, 31 Dec 2020 19:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgLaSem (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 31 Dec 2020 13:34:42 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:34204 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgLaSem (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 31 Dec 2020 13:34:42 -0500
Received: by mail-oi1-f170.google.com with SMTP id s75so22581336oih.1;
        Thu, 31 Dec 2020 10:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MK9jvU5T0a1F8Z3yYz4MVsd9Im04HOuhBeQZHz3+74k=;
        b=VyIjriE0xCvZ9WqWgsxcz9NUqLBQ6SlalIi3UGNnEH3JS9P8FI2/AEev4svx+URxsD
         3Du1CYhcb4yyYwzKiM0u8aQS0cDWeXWC48Sv3y62WmMQhCD2xEVAboMoRuNXbk6UE85L
         ql6YCTcCDd+8Rc8bFm4lXJl5re10MN2fEjm3QeJ7Z9sOSSGpUuWAAWvjuSO0cnk73nq0
         GzfguNRThMd/qitV2Kj8PeNK9ZeRofrDMk4CY1lIzZMSHTkaYEMVsE8M8jMYFpyV0CAZ
         ObJWbj2CiwQaegszzrK2yY+LA3h40dXCIXw5HDZ+05FIj6k2FsCnGM1MJGIQ9jMCNt+B
         Ldkw==
X-Gm-Message-State: AOAM53089UlvERat5fays4G9qzSRzSA5iMv92vx8Itbrvv34Ir74NCX2
        3NIRaQxjYnv56XxFDwBXAA==
X-Google-Smtp-Source: ABdhPJzNofcyoenZ3rFYiWkQqrq9Ao9OW2jxP+9TNZPxAR/jbffWTqlpqhPrO4Pi33AiFUHcZ3W+Jg==
X-Received: by 2002:aca:fcd7:: with SMTP id a206mr8527220oii.134.1609439641451;
        Thu, 31 Dec 2020 10:34:01 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i25sm11241585oto.56.2020.12.31.10.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 10:34:00 -0800 (PST)
Received: (nullmailer pid 2112255 invoked by uid 1000);
        Thu, 31 Dec 2020 18:33:57 -0000
Date:   Thu, 31 Dec 2020 11:33:57 -0700
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, lukas@wunner.de, bbrezillon@kernel.org,
        p.yadav@ti.com, linux-tegra@vger.kernel.org, broonie@kernel.org,
        tudor.ambarus@microchip.com, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, thierry.reding@gmail.com
Subject: Re: [PATCH v5 2/9] dt-bindings: spi: Add Tegra Quad SPI device tree
 binding
Message-ID: <20201231183357.GA2112085@robh.at.kernel.org>
References: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
 <1608585459-17250-3-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608585459-17250-3-git-send-email-skomatineni@nvidia.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 21 Dec 2020 13:17:32 -0800, Sowjanya Komatineni wrote:
> This patch adds YAML based device tree binding document for Tegra
> Quad SPI driver.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../bindings/spi/nvidia,tegra210-quad.yaml         | 117 +++++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

