Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9944D591D
	for <lists+linux-spi@lfdr.de>; Fri, 11 Mar 2022 04:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345980AbiCKDck (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Mar 2022 22:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343915AbiCKDcj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Mar 2022 22:32:39 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B30F4629;
        Thu, 10 Mar 2022 19:31:21 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id e6so6401089pgn.2;
        Thu, 10 Mar 2022 19:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=imNBSIwjSlC6ItQ14TLvh/vdfAlGhNku+y9tGsB5/7E=;
        b=gVobWzDkBrAo+hw4n9VuzK5+h5agn58l1RW4JxQd078MoX0q92ou/neAtOD9QSXZWE
         6DPpTbQ3uPOr0JI6Xb5U9xXEgh3w546jVUsSJ1fD1IG4DSL3N2JiEgFXd4eq3vr2ZFWl
         /wiiEu+BVpr6Lj+m8X38R2A1f1GPOBvtUkVY5bUez1TFKlMh459M14hgiApzWZ/R2bQq
         31AGfynKM7iqLLmgj0ui6aSEelBRH/yu6pR6j8v4iqPa8qgYtpFgxeVm6Mbob1Nccd3e
         V2h5c83YHxBcazrd0g4VEbJarTAfuGnCjSP9rnACJtnKXjiX+2Se50dT0QzWxXb3U4Wl
         9LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=imNBSIwjSlC6ItQ14TLvh/vdfAlGhNku+y9tGsB5/7E=;
        b=jL30adcSZFuQE8qCFSbV7nZ1vlwVGkwPSjeQFN6g2EUJBDDMnZIjgunBRYGLyvDDQt
         IaasBMFaE2yLVr4KPiHfOXkUvuKIimHWbs71IBkPURUpz6+R27QhhK3thtPq/DmKvaN8
         Fr1WEP74JspvhmatxtCT5uvRqFTHiXqcMWkwuT7mZC1k1TIqxbDmBR9GvX+IGrdUsdfr
         Ft2Kh4MCfovPXgE5V5rSn2UVMMTeBvAv2Z71f8lmm1rvLIVoQ/5IYSXuK8lPY5/Gkh9w
         Esbo7Sa6NR+mA9G1tWx72rz/bhbUv4KfFhi8++3JoINf1GcpF8hm18luA7K8wo3VRqWO
         BrcA==
X-Gm-Message-State: AOAM5316L06eAjzobPJIXHBilPdLi5fF5dnihCSAjR3GWME4T+GtpXkI
        t+8Kn6yYJ2tTxoCa6SjpcpA=
X-Google-Smtp-Source: ABdhPJwP3rQzh9FHLMFEruTIGTsCLsEHHjoOf1bZkvHQ/h8cbul5OSBu/iFTOzYa5Gom6BPhxyC8Hw==
X-Received: by 2002:a05:6a00:2166:b0:4f6:67fe:a336 with SMTP id r6-20020a056a00216600b004f667fea336mr8321867pff.17.1646969480464;
        Thu, 10 Mar 2022 19:31:20 -0800 (PST)
Received: from 9a2d8922b8f1 ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm8132847pfh.174.2022.03.10.19.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 19:31:20 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:01:14 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Update clocks property for ARM
 pl022
Message-ID: <20220311033114.GA91368@9a2d8922b8f1>
References: <20220308072125.38381-1-singh.kuldeep87k@gmail.com>
 <Yip2MZdQNjMz/Cos@robh.at.kernel.org>
 <20220311025502.GB54098@9a2d8922b8f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311025502.GB54098@9a2d8922b8f1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Mar 11, 2022 at 08:25:02AM +0530, Kuldeep Singh wrote:
> On Thu, Mar 10, 2022 at 04:05:37PM -0600, Rob Herring wrote:
> > On Tue, Mar 08, 2022 at 12:51:24PM +0530, Kuldeep Singh wrote:
> > > Add missing minItems property to clocks in ARM pl022 bindings.
> > > 
> > > This helps in resolving below warnings:
> > > clocks: [[4]] is too short
> > > clock-names: ['apb_pclk'] is too short
> > 
> > Again, the error is in the dts files, not the schema.
> 
> Rob, kindly note this series number is deprecated and I have sent v3
> version some time back. Here's the link:
> 
> https://lore.kernel.org/linux-spi/20220309171847.5345-1-singh.kuldeep87k@gmail.com/T/#u
> 
> > 
> > 
> > There's 2 possible answers. First, both clock inputs use the same source 
> > clock. That's an easy fix. List the clock twice. Second, one clock is 
> > not described in DT or visible to s/w. It still has to be in the h/w and 
> > could be described as a 'fixed-clock'. A DT should either be all in with 
> > clocks or not use the clock binding IMO. Describing some clocks and not 
> > others is not a good solution.
> > 
> > For example, let's look at bcm-cygnus as one of the single clock 
> > examples. The first thing I notice is there is a apb_pclk already 
> > defined. The pl330 uses it. The watchdog (also Primecell) lists the 
> > source clock twice. So what should pl022 be? IDK, ask the Broadcom 
> > folks. If they don't know, then list the source clock twice. That's 
> > effectively no change from what we have now.

I just noticed not all platforms possessing single clock are raising
'dtbs_check' warning. For example, bcm-cygnus and lpc32xx passes check
even though their DT clock entry has just "apb_pclk".

Any reason why they pass successfully through checks?

> 
> Yes, I took motivation from sp805 watchdog(primecell) while resolving DT
> conflicts. I found LG and amd seattle platform with single clock in DT
> for which I have sent patches. Link is below:
> 
> https://lore.kernel.org/linux-devicetree/CAL_Jsq+k+ridWTkdy4xwTC7VxUTU8tu+Q2BA9kbQVA222PWvZw@mail.gmail.com/
> 
> Moreover, I observed that clocks and clock-names are not required
> properties for pl022. I am wondering reason behind the same when you
> first made changes. Any specific reason not adding them which I am not
> aware of or it just got missed?
> 
> - Kuldeep
