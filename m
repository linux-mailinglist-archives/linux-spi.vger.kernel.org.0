Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C404F9F0E
	for <lists+linux-spi@lfdr.de>; Fri,  8 Apr 2022 23:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiDHVVx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Apr 2022 17:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiDHVVx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Apr 2022 17:21:53 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22EA2D7D61;
        Fri,  8 Apr 2022 14:19:48 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 12so10083345oix.12;
        Fri, 08 Apr 2022 14:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MhM/VWWqk5axL8sm24UxFHPIbmWv2iOTBuKoEttZpPw=;
        b=cwi/dulEcn1GPB4jP4i4nTSufjQ29jSqxMXgIokq+CI4JaNk+5snbvzxTdTFesmB5d
         Luf9HxAaoQcgzySmsEEYq84wJSL3o4gXjDjaaEYX6T18H+mnwrJUXKMTMOCowPpNLN9j
         x8DAANZ8wCa1bl5LhWS1x/Gn6qFvYRKoit+bhNokpkTQBQpq6X1zj4sS2YXPzc3J8ehB
         1Pm42QK24d6RhcFHqwvi1GLNOKZdwTq0tj9LmC/u/Lldu4oPSoVsz+F1V65035pmoLVb
         38y0Ffe1ydut2b+O9RwWgJC274r9C4v+Bd5hicDQneYLavJbQYhQvVfMhTA6SgOEqakM
         ttUg==
X-Gm-Message-State: AOAM532+dsereI96SByurNWHrk3Td3xWez3IqQH5puVT2PShUy9yaTuZ
        q1rLhBCT8tHIKU3DdXR5DQ==
X-Google-Smtp-Source: ABdhPJzIkNCK9gcrlNrOZSegrGjtqMeaY6LwIEc2+HOwWtvbMjRuqi6NYbKJ0hYKEBx+tcLITHf1lA==
X-Received: by 2002:a05:6808:1704:b0:2f9:bb17:21f6 with SMTP id bc4-20020a056808170400b002f9bb1721f6mr772984oib.23.1649452788039;
        Fri, 08 Apr 2022 14:19:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 38-20020a9d0da9000000b005cb437ac0e2sm9646460ots.44.2022.04.08.14.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:19:47 -0700 (PDT)
Received: (nullmailer pid 4088052 invoked by uid 1000);
        Fri, 08 Apr 2022 21:19:47 -0000
Date:   Fri, 8 Apr 2022 16:19:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: Document CPLD on Menlo
 boards
Message-ID: <YlCm829GvNKOPIBh@robh.at.kernel.org>
References: <20220407210131.256045-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407210131.256045-1-marex@denx.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 07 Apr 2022 23:01:31 +0200, Marek Vasut wrote:
> The CPLD on Menlo boards is used to operate custom hardware,
> document the CPLD DT binding as trivial SPI device.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: NXP Linux Team <linux-imx@nxp.com>
> To: linux-spi@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
