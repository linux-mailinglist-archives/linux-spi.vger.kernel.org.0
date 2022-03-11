Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37E94D5873
	for <lists+linux-spi@lfdr.de>; Fri, 11 Mar 2022 03:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345789AbiCKC4N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Mar 2022 21:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345811AbiCKC4M (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Mar 2022 21:56:12 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B941A6F97;
        Thu, 10 Mar 2022 18:55:08 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id mv5-20020a17090b198500b001bf2a039831so9880316pjb.5;
        Thu, 10 Mar 2022 18:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Me7hT9AANgy5+2Wv0ivBaS8/sti8zcauVvAwoiWjGZ8=;
        b=LBYuGtdQ52NNz1BpOrKepKeWw3H0APbePuZdtR8reLvS4ufZLcGHyAJ+NkYSxEwbsR
         1L4pPldLz6w7oBlQKyTdvQvgLWPfEBb2oNJXaYraH0uey/fmAzjfOg2HD511FBAYb06e
         U3jcaitOJur6kmuAfFtSRRsqRbGM/Tr9fkwUnjfmLfKa6ephY3HRzoddeCPyZp1L2kgW
         T+/vLS3AvOTbpPuAWBVjlFdeU6qBZVlVwwCBW5LdgZFJc2u44V9AL4HCZtwhwBWWD4wW
         qEAzqmHCNQeXuIxXbv0F+fQmYniPBUq6T0FCzQZWONRELMatbefTz/BBpgRPY1qeEPDu
         xD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Me7hT9AANgy5+2Wv0ivBaS8/sti8zcauVvAwoiWjGZ8=;
        b=Ilign7OFgdQ+JtscWu84Lg2U1lisH5cLqTrRFQSZPfBQyEvh7EbxgZutGtMenuKy4w
         m6+I0B+Bzm3OBZgJeWbq7y5AeI2nvwV6o0PYAfeT7CAdp0WUNL4Sk8ye7kZTqVTaObdV
         a2oTBoe/mChaJv9GT6KliJMy+ECbTuHdFDX0VaOcoXoPufs2tBe88rRXkAIdi0M8P+8v
         aIVTqyLtRW743OsyGFutN3FGyaP5C4v0Ba3+p9pjt6MVJz0cy/XXKSdART9yrdLCsIDt
         mlIFuZpkCEIdFl96tfjBCLuRwgWFNmH8jrZtNuHVwNdnZGO+xj89yfT6CgGwWYW2mJQf
         nUEg==
X-Gm-Message-State: AOAM532mWiM1zSqJGRlGF8Yg7bvnireRpOcjHkFulSzKSile8ObC5GIl
        CrYwP7AEUydADIXUWU84xmI=
X-Google-Smtp-Source: ABdhPJzmED5JxuqhDqb9IERzE0ga9+GHJcB/S360Jr/np9+iD9u0O6IBcfMXq3aOZZ9/ga5WV+ewxQ==
X-Received: by 2002:a17:902:ce09:b0:151:96e2:d4b5 with SMTP id k9-20020a170902ce0900b0015196e2d4b5mr8008486plg.3.1646967308379;
        Thu, 10 Mar 2022 18:55:08 -0800 (PST)
Received: from 9a2d8922b8f1 ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id g13-20020a056a000b8d00b004f75395b2b4sm8398196pfj.55.2022.03.10.18.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 18:55:08 -0800 (PST)
Date:   Fri, 11 Mar 2022 08:25:02 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Update clocks property for ARM
 pl022
Message-ID: <20220311025502.GB54098@9a2d8922b8f1>
References: <20220308072125.38381-1-singh.kuldeep87k@gmail.com>
 <Yip2MZdQNjMz/Cos@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yip2MZdQNjMz/Cos@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 10, 2022 at 04:05:37PM -0600, Rob Herring wrote:
> On Tue, Mar 08, 2022 at 12:51:24PM +0530, Kuldeep Singh wrote:
> > Add missing minItems property to clocks in ARM pl022 bindings.
> > 
> > This helps in resolving below warnings:
> > clocks: [[4]] is too short
> > clock-names: ['apb_pclk'] is too short
> 
> Again, the error is in the dts files, not the schema.

Rob, kindly note this series number is deprecated and I have sent v3
version some time back. Here's the link:

https://lore.kernel.org/linux-spi/20220309171847.5345-1-singh.kuldeep87k@gmail.com/T/#u

> 
> 
> There's 2 possible answers. First, both clock inputs use the same source 
> clock. That's an easy fix. List the clock twice. Second, one clock is 
> not described in DT or visible to s/w. It still has to be in the h/w and 
> could be described as a 'fixed-clock'. A DT should either be all in with 
> clocks or not use the clock binding IMO. Describing some clocks and not 
> others is not a good solution.
> 
> For example, let's look at bcm-cygnus as one of the single clock 
> examples. The first thing I notice is there is a apb_pclk already 
> defined. The pl330 uses it. The watchdog (also Primecell) lists the 
> source clock twice. So what should pl022 be? IDK, ask the Broadcom 
> folks. If they don't know, then list the source clock twice. That's 
> effectively no change from what we have now.

Yes, I took motivation from sp805 watchdog(primecell) while resolving DT
conflicts. I found LG and amd seattle platform with single clock in DT
for which I have sent patches. Link is below:

https://lore.kernel.org/linux-devicetree/CAL_Jsq+k+ridWTkdy4xwTC7VxUTU8tu+Q2BA9kbQVA222PWvZw@mail.gmail.com/

Moreover, I observed that clocks and clock-names are not required
properties for pl022. I am wondering reason behind the same when you
first made changes. Any specific reason not adding them which I am not
aware of or it just got missed?

- Kuldeep
