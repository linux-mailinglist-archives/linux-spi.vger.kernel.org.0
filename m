Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B114D30A5
	for <lists+linux-spi@lfdr.de>; Wed,  9 Mar 2022 14:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiCIN6n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Mar 2022 08:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiCIN6l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Mar 2022 08:58:41 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748F462DF;
        Wed,  9 Mar 2022 05:57:41 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id m2so2055268pll.0;
        Wed, 09 Mar 2022 05:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=faIIfTxQAdrbYwzah/aXL8R3vzKjdbBY0/6Hv4kojO4=;
        b=ba7FoR/sP7LQDzjdOdh904xFCN5OCpME0XYdqUUPWFsQqPIyZdWJ9D2U7967Qd2wPM
         shujyXE3lX67ic5tFWgsfPcoB5Iy3CU/KsE83wxIDppLDo7ifwYHPWiKvcCDC8jkDVxn
         cMKBNHxGu2va0/R9F6EdN05AUbkNxcnjEsLXLlYP1y56Do/hjlEHb7gbQT8zRCJ7zl13
         IGCZl7WSP1Qmx4SMAQzhO/IIh82NIXq/oMmTNiSpFEGUGXFSYm5iMCcwIfK5ciUPjf0n
         nXrO25hM6xwS64LhBlNI3OdaKh+6JjBE9DV1SjUozCu5ylJhEREeGXVbVERd8pFzLD2L
         Xg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=faIIfTxQAdrbYwzah/aXL8R3vzKjdbBY0/6Hv4kojO4=;
        b=L/taCVsjDgU57ZyLRDStohWqTNlt2XqAFLCZ0WGO5WAF2Uq+ifShYYVjPusJMWXjJk
         c1Gzyax7CVLEmRPAc/oDSrupCekh9Gr3OqvWclEOq10RWpncy7oUgMc62dJ+nhR9wHTk
         okqyzQetO2jzfIshXveXHR1o/ooBV1DIgNX7huFWbca2YhMdtvL7VvGXz0tLgiEWECxW
         y/ngpIxNpqqZBhKum9xjdjSwqQKdmE8v/huWv7kW7tMQdS2hwfOr3N1vl4vQnlElbaxC
         2uvl38e4anVRshnIEYg6j/LDxUFedBxDrYmbAfolsPlRtvDJQnW6NHcRUpdRmYz2CJFQ
         KhlA==
X-Gm-Message-State: AOAM532gKjPAfxF8PI4btsdFsi+Doh8kfXX/NPY7/BreD3MuDUUIUbI4
        57b4rLTAhQnwotqbNtRnsMc=
X-Google-Smtp-Source: ABdhPJxNl9iNPU4HIEro6FlW6Jac4RZUF7NPRzFtZKB+VP7mfRKYdbEoz+zBYnqrki4rdFud5EnLEw==
X-Received: by 2002:a17:90a:a591:b0:1bc:8015:4c9e with SMTP id b17-20020a17090aa59100b001bc80154c9emr10303253pjq.154.1646834260513;
        Wed, 09 Mar 2022 05:57:40 -0800 (PST)
Received: from 9a2d8922b8f1 ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id c18-20020a056a000ad200b004f0f9696578sm3571032pfl.141.2022.03.09.05.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:57:40 -0800 (PST)
Date:   Wed, 9 Mar 2022 19:27:34 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Update clocks property for ARM
 pl022
Message-ID: <20220309135734.GA87543@9a2d8922b8f1>
References: <20220308072125.38381-1-singh.kuldeep87k@gmail.com>
 <f9fa1045-c0a4-97fa-16ee-20530b404381@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9fa1045-c0a4-97fa-16ee-20530b404381@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 08, 2022 at 09:27:48AM +0100, Krzysztof Kozlowski wrote:
> On 08/03/2022 08:21, Kuldeep Singh wrote:
> > Add missing minItems property to clocks in ARM pl022 bindings.
> > 
> > This helps in resolving below warnings:
> > clocks: [[4]] is too short
> > clock-names: ['apb_pclk'] is too short
> > 
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > ---
> > v2:
> > - Keep actual warning and remove path to file
> > - Reword commit message a bit
> 
> It still misses information whether it is actually correct from PL022
> point of view to have just one clock.
> 
> If the DTS are wrong, do not change the bindings to match such wrong
> DTS. If the DTS is correct, please explain why bindings are wrong.
 
Thanks Krzysztof for pointing it out.
So far I was wondering spiclk clock-name was the only culprit there and
had different perception w.r.t number of clocks.

Anyway, below reference is from pl022 point of view:
https://documentation-service.arm.com/static/5e8e3bc7fd977155116a936d?token=
https://developer.arm.com/documentation/ddi0194/h/functional-overview/primecell-ssp-operation/clock-ratios

The reference no where mention that single clock can exist.
So far Amd seattle and LG platforms don't comply with binding and define
single clock which require updations.

So now from bindings perspective, I am looking forward to keep only one
notation of sspclk and will respin a patch. Kindly provide comments on
the same.

Regards
Kuldeep

> > 
> >  Documentation/devicetree/bindings/spi/spi-pl022.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> > index 6d633728fc2b..7d36e15db5b3 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> > @@ -34,6 +34,7 @@ properties:
> >      maxItems: 1
> >  
> >    clocks:
> > +    minItems: 1
> >      maxItems: 2
> 
> This does not match clock-names which requires two clocks. It's not
> correct now.
> 
> >  
> >    clock-names:
> 
> 
> Best regards,
> Krzysztof
