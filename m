Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5F728E185
	for <lists+linux-spi@lfdr.de>; Wed, 14 Oct 2020 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbgJNNme (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Oct 2020 09:42:34 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41628 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgJNNme (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Oct 2020 09:42:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id n15so2341855otl.8;
        Wed, 14 Oct 2020 06:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EPC8LENkqru9ordHAc2jHtuu2caeD/J3+oqQoXlywEQ=;
        b=O/XyToavm2XOpZiq+XMLnnUGZuayxN/HkE85jgAU+C7olHSYdTy2pIcFxX7vTlnxeF
         p2JXETJlOn96GAaYxvPorBWHlCmm/1hVb+jZFwlgMW1/1MdK9Tx9zcDEpBLyrRyx+fBP
         kG2VJZqrhwPLo4SowBVq+EC+HYexdS3CNG2XAIBZbCNTWmFvXWL0ScFL9MXesC4C9nHP
         NwgOB7HaDEBoZb8oBlKNeWvCHFDDtb3nwEEhrcyQf95/IUJmnTdlBO6B0lF2qjdrSFAw
         Y8/JLiHrvc+jjeWYS0uC+Hno8dfd2c9yzUs1OoXAazTReatjZ9lqOdSggfnijYKl0Flg
         Gf0w==
X-Gm-Message-State: AOAM5323KNN/I7umIbvyk9fcmK47nRbyUk/YfALLEmfHY0/KzlN/vTFQ
        1S3Gyo/j7nKxYLhSlLpWmM2eNuRvRm9D
X-Google-Smtp-Source: ABdhPJwHCh5Q3872UyXP5k/GeTKKX/bi7N1UPHyb5U7AVXgwjiq0oACMMoAmODf5du3pirXwz8CabA==
X-Received: by 2002:a05:6830:2316:: with SMTP id u22mr3041582ote.245.1602682951509;
        Wed, 14 Oct 2020 06:42:31 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j83sm1355166oia.19.2020.10.14.06.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 06:42:30 -0700 (PDT)
Received: (nullmailer pid 1563789 invoked by uid 1000);
        Wed, 14 Oct 2020 13:42:29 -0000
Date:   Wed, 14 Oct 2020 08:42:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds <linux-leds@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Dan Murphy <dmurphy@ti.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/6] dt-bindings: misc: explicitly add #address-cells for
 slave mode
Message-ID: <20201014134229.GA1563657@bogus>
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
 <20201013160845.1772-5-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013160845.1772-5-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 14 Oct 2020 00:08:43 +0800, Zhen Lei wrote:
> Explicitly add "#address-cells = <0>" and "#size-cells = <0>" to
> eliminate below warnings.
> 
> (spi_bus_bridge): /example-0/spi: incorrect #address-cells for SPI bus
> (spi_bus_bridge): /example-0/spi: incorrect #size-cells for SPI bus
> (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
