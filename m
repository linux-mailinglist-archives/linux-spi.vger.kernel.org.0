Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAF64D541C
	for <lists+linux-spi@lfdr.de>; Thu, 10 Mar 2022 23:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiCJWGm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Mar 2022 17:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiCJWGk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Mar 2022 17:06:40 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9B11903EB;
        Thu, 10 Mar 2022 14:05:39 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id j83so7427783oih.6;
        Thu, 10 Mar 2022 14:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sToXRItp1gfUeCrvpJh3Xp5twxaBxUIQVRbpXfSXTCo=;
        b=hA/17FNJDG/9J+29zErBEI0DjfzkozhPLf1x/dHIxUXmMpQON6oZe246n4AUvmk2jZ
         sY0ZAU0NY1M7Sc9GO9thBDDMr3ptQVUiMnG01r9colGjE4oBYJASObl8EKZoN7YhieRK
         WFSXl9L1v73bl5hH5Z1Z8WhGNKNT/9QUla+SSnYFzGcR2TYlyYr13+27rr1k7UBpeoLK
         aOeZEIRr2NJtWlB25NcRRPC47XQ8xqq6delTr+i+Fr1FWVMpyYQYmkZ3yydkxLwdm6mq
         MyJXWYq59DjH201b3EGS6j9JIALw+NHEk5kPWVzuF+LNMniNbd+RTjbp2Jm7dIZDg0OE
         ek+Q==
X-Gm-Message-State: AOAM530GuI00oXK2ZFcvl5zJUBfv/oWGeS3Zn21FtDp7hhu8BGimcT9G
        ZjeEC1eFcOrAefSL/7eL5Q==
X-Google-Smtp-Source: ABdhPJzxKpsaVdseUDe2Zmx+JlU/UKJ1bLqFJEKAXwy6UIVuFw5j0kc92yXwJCL1IzigNVQ3DVfePw==
X-Received: by 2002:a05:6808:f8a:b0:2da:1e9b:e85d with SMTP id o10-20020a0568080f8a00b002da1e9be85dmr4695831oiw.111.1646949938690;
        Thu, 10 Mar 2022 14:05:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 60-20020a9d0f42000000b005ad59a0fe01sm2853401ott.35.2022.03.10.14.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:05:38 -0800 (PST)
Received: (nullmailer pid 2164514 invoked by uid 1000);
        Thu, 10 Mar 2022 22:05:37 -0000
Date:   Thu, 10 Mar 2022 16:05:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Update clocks property for ARM
 pl022
Message-ID: <Yip2MZdQNjMz/Cos@robh.at.kernel.org>
References: <20220308072125.38381-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308072125.38381-1-singh.kuldeep87k@gmail.com>
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

On Tue, Mar 08, 2022 at 12:51:24PM +0530, Kuldeep Singh wrote:
> Add missing minItems property to clocks in ARM pl022 bindings.
> 
> This helps in resolving below warnings:
> clocks: [[4]] is too short
> clock-names: ['apb_pclk'] is too short

Again, the error is in the dts files, not the schema.


There's 2 possible answers. First, both clock inputs use the same source 
clock. That's an easy fix. List the clock twice. Second, one clock is 
not described in DT or visible to s/w. It still has to be in the h/w and 
could be described as a 'fixed-clock'. A DT should either be all in with 
clocks or not use the clock binding IMO. Describing some clocks and not 
others is not a good solution.

For example, let's look at bcm-cygnus as one of the single clock 
examples. The first thing I notice is there is a apb_pclk already 
defined. The pl330 uses it. The watchdog (also Primecell) lists the 
source clock twice. So what should pl022 be? IDK, ask the Broadcom 
folks. If they don't know, then list the source clock twice. That's 
effectively no change from what we have now.

The other issue with allowing a single clock is then any new user can 
just repeat this mistake.

Rob
