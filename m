Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2EF2562B4
	for <lists+linux-spi@lfdr.de>; Fri, 28 Aug 2020 23:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgH1V5z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Aug 2020 17:57:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36738 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1V5x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Aug 2020 17:57:53 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so567989iow.3;
        Fri, 28 Aug 2020 14:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yvx7y4KO5hON+maGgy2XOz7Vc/Lv8LVgQ1Pmt9FA4bc=;
        b=F4AtHdHYzrYebM/WGQVnMDAyoZnODMPiUGrwAbs8/GxhcI5afTuzxyyGl46qCnlHul
         Jc0flk7bryKgdg9srR/IzbMsHyry04+SWe13Ys3in52c4vfYXp44j7MbT/4ZEHdVrlLJ
         YeU9PytSJoECn3jmxiMStrtIM8lm5Y0Jg+XSPrAEg10bHhHDitJTrZhYqQDtYP7/ZVog
         k/IDJPGRL/53L3x7qAjGOz9I3uumrpgMUB1PTeQ9fL0IWu3vQkp7wYbd4/4S0GLRavQx
         ModvKB7KXlhLNYavN0pJmOpU6Y/3M5M17j4zaD/1pqe3ir4sgaBKXErjoAQyAdDNitl3
         UbFg==
X-Gm-Message-State: AOAM531E5/ecD88W78oE1IXxQEMGQtby/a47nfoT2239cmzC1s8zDbkt
        0DDbgGPAE7xWjefmYVWQ/g==
X-Google-Smtp-Source: ABdhPJygpGQkwKhol1V/eGf9rZOUR6DEf88cn9+vMCUaX6Uv0kIBtX7xXrYeP+5Jj1P9393ZRnSQtA==
X-Received: by 2002:a05:6638:1649:: with SMTP id a9mr3151648jat.115.1598651872196;
        Fri, 28 Aug 2020 14:57:52 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id h15sm298740ils.74.2020.08.28.14.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 14:57:51 -0700 (PDT)
Received: (nullmailer pid 3476186 invoked by uid 1000);
        Fri, 28 Aug 2020 21:57:49 -0000
Date:   Fri, 28 Aug 2020 15:57:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v5 4/6] dt-bindings: snps, dw-apb-ssi: Add sparx5
 support, plus rx-sample-delay-ns property
Message-ID: <20200828215749.GA3476156@bogus>
References: <20200824203010.2033-1-lars.povlsen@microchip.com>
 <20200824203010.2033-5-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824203010.2033-5-lars.povlsen@microchip.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 24 Aug 2020 22:30:08 +0200, Lars Povlsen wrote:
> This has the following changes for the snps,dw-apb-ss DT bindings:
> 
> - Add "microchip,sparx5-spi" as the compatible for the Sparx5 SoC
>   controller
> 
> - Add the property "rx-sample-delay-ns"
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
