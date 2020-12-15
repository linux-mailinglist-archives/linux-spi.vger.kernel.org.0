Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF902DB17C
	for <lists+linux-spi@lfdr.de>; Tue, 15 Dec 2020 17:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgLOQc5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Dec 2020 11:32:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35806 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbgLOQcz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Dec 2020 11:32:55 -0500
Received: by mail-ot1-f67.google.com with SMTP id i6so19966096otr.2;
        Tue, 15 Dec 2020 08:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7YAQAVt9xHPWfTAqPkRDtbeSmHmka4bZA5QuCv8X5zw=;
        b=OLBLtfJRU17lty7kCH5DghkjJJpsP//I7IQ9w2oYUGwnSOkLiCokCgD/4Tz766TSD8
         Mwe/VPrTij2WCzaOrpa78fLFuOjp+M3xjfq/zyZUVyxqA8jGQPHAtZyZzsZ7aWjRbdCf
         uSPV84sKN9leBULmMkuebppS+oS6aVuVD7XREG8nD/3MaDWEF/2norWxZ9QuE8ss8S4L
         MfsYpwFhj4tdDpX308/TC8hoXrXxSYa4CdX5t0phWEY+g3C2drNASRUoglYjxhb/LgHn
         uEAitFl9WtBi139mW/boam6GY6xHZ+fFZmPmmZDSrAlVeCb/Iz7dMAXR+2IIh3W6TkDq
         9cAQ==
X-Gm-Message-State: AOAM5312n1lkyaeDE8HMZ2QKvnDzfT3eGNjcKHNSn3KPwzDvbqQDJX42
        BY2VdmQjdH9r0iw9E+820A==
X-Google-Smtp-Source: ABdhPJxuHLb1e0yz4x9X/eFcHxas2aAdH3/P0n37LQH1eEbsb1g0eOoptatCyZ7DZlJdcmpZxBvBfQ==
X-Received: by 2002:a9d:6255:: with SMTP id i21mr24143646otk.346.1608049934531;
        Tue, 15 Dec 2020 08:32:14 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r14sm523413ote.28.2020.12.15.08.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 08:32:13 -0800 (PST)
Received: (nullmailer pid 3980195 invoked by uid 1000);
        Tue, 15 Dec 2020 16:32:12 -0000
Date:   Tue, 15 Dec 2020 10:32:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Subject: Re: [RFC PATCH 10/12] dt-bindings: spi: sun6i: add compatible for
 V831 SPI
Message-ID: <20201215163212.GA3972588@robh.at.kernel.org>
References: <20201212040157.3639864-1-icenowy@aosc.io>
 <20201212051202.3645115-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212051202.3645115-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Dec 12, 2020 at 01:12:00PM +0800, Icenowy Zheng wrote:
> V831 has a SPI controller similar to the H6 one.
> 
> Add a compatible string for it.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> H6 and V831 SPI controllers is not totally the same with H3: they have
> QSPI support added. Here V831 compatible string is just added in
> parallel with H6 one, but maybe we should make H6 SPI do not fallback to
> H3 one, and add H6 one as fallback to V831?

A fallback is really only needed if there's a user you expect to work 
unmodified. For example, say a new DMA mode is added, but that's 
something a bootloader wouldn't use. Given QSPI mode is probably 
fundamentally different?, then a fallback is probably not needed.

> 
>  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> index 7866a655d81c..a620ff30033e 100644
> --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> @@ -24,6 +24,7 @@ properties:
>        - items:
>            - enum:
>                - allwinner,sun8i-r40-spi
> +              - allwinner,sun8i-v831-spi
>                - allwinner,sun50i-h6-spi
>            - const: allwinner,sun8i-h3-spi
>  
> -- 
> 2.28.0
