Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB674F9F0A
	for <lists+linux-spi@lfdr.de>; Fri,  8 Apr 2022 23:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbiDHVT3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Apr 2022 17:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiDHVT2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Apr 2022 17:19:28 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A036319140F;
        Fri,  8 Apr 2022 14:17:22 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e2442907a1so10671104fac.8;
        Fri, 08 Apr 2022 14:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R+cMUZCmMqDth7D9o6IFbdY5FFYqrLb+GRTuBqbW/ko=;
        b=oFYd+Q8XTrrWE4Dg1/Em6+mXj5cCUDhy89bwPDRe1pKLAlbu1Ebv5TFMWSjB6aXFzq
         5Hoj/6v3Bs0n0NsWxgKsKvhc8bzvX75Z933nqte3OMpO8jQ/dpspnXcHk5nn+1iOZkIK
         XZcq/dAZuxJ7DaRRRwIcEbwiFCKfs5HlceCbC43Fv5BJt/rAngpjyVbgh2borwBqoIyC
         l19TSBsd09KnoXpGwToJ1H/c4zlJ98ZUewpOn8zPC2mz3LmQRh6miyifaQbGxQtzRsxA
         akwoejCHtilzzYQvknSmnZXIlbIEKouBOb0YdHryVQubooo+qZG2uSvy1KtqmiIyAnx5
         jsag==
X-Gm-Message-State: AOAM532VyNO173Ya9aSU/PphMRkmBWfpWZkMa9TBhZU9WLd0Pr8/RxmY
        TT/7wdIFojhGvedAgMBaQdA7y8pwkg==
X-Google-Smtp-Source: ABdhPJzkPtWqObUtXiQhsfMgyWaFe7juMxPwSzHldllRGA/glK7MdbOkVZok37XF1+zN10PxJrdNwA==
X-Received: by 2002:a05:6870:4345:b0:de:f347:e2cd with SMTP id x5-20020a056870434500b000def347e2cdmr9278391oah.113.1649452641972;
        Fri, 08 Apr 2022 14:17:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e22-20020a9d5616000000b005ceb68be2f6sm9511015oti.63.2022.04.08.14.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:17:21 -0700 (PDT)
Received: (nullmailer pid 4082350 invoked by uid 1000);
        Fri, 08 Apr 2022 21:17:20 -0000
Date:   Fri, 8 Apr 2022 16:17:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] dt-bindings: trivial-devices: Document CPLD on DH
 electronics boards
Message-ID: <YlCmYHPd0a7WeRoE@robh.at.kernel.org>
References: <20220407210106.256027-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407210106.256027-1-marex@denx.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 07 Apr 2022 23:01:06 +0200, Marek Vasut wrote:
> The CPLD on DH electronics boards is used to model arbitrary custom
> glue logic, however it does have SPI interface. Document the CPLD DT
> binding as trivial SPI device.
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
