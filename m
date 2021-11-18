Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052E7456591
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 23:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhKRW0w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Nov 2021 17:26:52 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44981 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhKRW0w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Nov 2021 17:26:52 -0500
Received: by mail-ot1-f53.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso13487680otj.11;
        Thu, 18 Nov 2021 14:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zzrLG1dp1sDs7fna1qV6Y2VpWnTsqTBbMcn4hdUaAzY=;
        b=rAdbSmD8PMl4iuqGMiM4TYP5SsRqrImtEEjSswOWEgT4dhhvQ0zcaier72qm8Tn3oq
         Ik0cInjAbNzSi8PA40pBg02f/9NJRJf9wPPvsjQlivIyp1itLkZgMkgbsgPnEAIqMSNu
         2zDg1xT1dhbWUvDbtO9gCsIk+Unse8ONh/NS84Wf1XITmqqlzqzqWJGVJYUqE8Ozar1F
         TyA00KPuB1AoLT2/t1N0NuQfSPDaQ1ZeN/6DXXNpgqQEOGAEXwU1zPzLTHEC60UgG8HM
         Eo2y55CZB252SIggcUTCEuhePa0bK590fgYwZH9nu4YjBzje5qapOvifrX+90N0cNuxu
         HKcA==
X-Gm-Message-State: AOAM531z4TboQrQp7d2rJWeLhrS7pR8ESXoRSU1FTrpNrgNV3hJegnvy
        T3uw+jmQ/PJ/yzL81QIYWQ==
X-Google-Smtp-Source: ABdhPJz5Z1YFMtbLnWkXmfMCsB7VO8FlPE/OAwfQ2S8cQOJtOZwMIcvu48+SzOghBsFb28Sw1iQ2ug==
X-Received: by 2002:a9d:2077:: with SMTP id n110mr520097ota.261.1637274231192;
        Thu, 18 Nov 2021 14:23:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e14sm253782oow.3.2021.11.18.14.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 14:23:50 -0800 (PST)
Received: (nullmailer pid 1864953 invoked by uid 1000);
        Thu, 18 Nov 2021 22:23:49 -0000
Date:   Thu, 18 Nov 2021 16:23:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: mtd: spi-nor: Add a reference to
 spi-peripheral-props.yaml
Message-ID: <YZbSdarZL7VmcT8B@robh.at.kernel.org>
References: <20211109181911.2251-1-p.yadav@ti.com>
 <20211109181911.2251-4-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109181911.2251-4-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 09, 2021 at 11:49:11PM +0530, Pratyush Yadav wrote:
> The spi-peripheral-props.yaml schema contains peripheral-specific
> properties for SPI controllers that should be present in the peripheral
> node. Add a reference to that so its constraints are followed.
> 
> additionalProperties: false cannot be used since it marks the controller
> properties as unknown. Use unevaluatedProperties: false instead. This
> has the side effect of allowing extra properties that are not specified
> in the schema. The alternative is to list all the controller properties
> in this schema but that would mean every peripheral binding would have
> to repeat the same set of properties for each controller.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v3:
> - s/slave/peripheral/g
> 
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
