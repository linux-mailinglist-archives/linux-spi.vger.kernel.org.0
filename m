Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9BA34D1DC
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 15:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhC2Nxd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 09:53:33 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:42808 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhC2NxC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Mar 2021 09:53:02 -0400
Received: by mail-ot1-f53.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so12310351ota.9;
        Mon, 29 Mar 2021 06:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2kx0G07YczhDjJFsWiCaS8pRYvouvk30VF+p/QfTjfQ=;
        b=uGe+wqwHHs1k8mCZaonfi2DWNjIl9/YHTG3UjuaQbg7XjhEupKR5q0TI6nqdkuavs9
         A1DYQ+7rBJEgCNBwCcwkGtHa1iF8Bf9U/RyXnbsFNRBRti68nH2qUIxDhLRgC94SPg0j
         xwOXporZsJv2OIqEGKNVxxm9BJhshoF22iDBj2dumfOj7HMKVKExEIH6dzZnqZPWd9i9
         0DHxj5tPC09CxiLoP7VhkNRYCV6ViNmUiqJTcJIL2wRGGDnNxG6ldil/s4eEEtsmmddC
         SE/fVswPszUUU7xjVvGqH2oGHGCU4ddIKvnKDE4cFgH1j0TDExD/kLpaRSecjcGrBNEE
         LCWQ==
X-Gm-Message-State: AOAM530gbm/MJSUWyX7fpcWTpxRZ98JXGqAt5SzxKORVaG51LDEfKlmA
        RJXGXAssSDJZZfHlEN7Huw==
X-Google-Smtp-Source: ABdhPJwaihSqXeKVUznslk6PKBV7X4dxzic9ks8hZXlzs/XK31nyBmCTPSWG7Qb7dkg/ViDIU/d4RQ==
X-Received: by 2002:a9d:20c6:: with SMTP id x64mr22311868ota.262.1617025981177;
        Mon, 29 Mar 2021 06:53:01 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y10sm3450231oih.37.2021.03.29.06.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:53:00 -0700 (PDT)
Received: (nullmailer pid 2469448 invoked by uid 1000);
        Mon, 29 Mar 2021 13:52:59 -0000
Date:   Mon, 29 Mar 2021 08:52:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: nvidia,tegra210-quad: Use documented
 compatible "jedec,spi-nor" in example
Message-ID: <20210329135259.GA2423613@robh.at.kernel.org>
References: <20210327203357.552794-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327203357.552794-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Mar 27, 2021 at 03:33:57PM -0500, Rob Herring wrote:
> The 'spi-nor' compatible used in the example is not documented. Use the
> documented 'jedec,spi-nor' compatible instead.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-spi@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ugg, I guess I should have tested this first:

Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dt.yaml: flash@0: 'nvidia,rx-clk-tap-delay', 'nvidia,tx-clk-tap-delay' do not match any of the regexes: '^partition@', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml


This issue has come up a couple of times recently. There's not really an 
easy fix for this other than dropping the properties from the example 
and that doesn't help for actual dts file checks.

The issue is nvidia,tegra210-quad.yaml is applied to the SPI controller 
node and jedec,spi-nor.yaml is applied to the child node. Since those 
are independent, there's never a single schema with all possible child 
properties.

We could have a schema listing all these slave properties and every SPI 
slave binding has to reference that schema.

Rob
