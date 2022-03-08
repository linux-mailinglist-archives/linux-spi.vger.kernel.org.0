Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF1F4D0EF8
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 06:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiCHFW4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 00:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiCHFWz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 00:22:55 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC0239839;
        Mon,  7 Mar 2022 21:22:00 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q19so2851470pgm.6;
        Mon, 07 Mar 2022 21:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CtARMaggSSWrV7NfHcUkCG/o5DV3pdLuaH3FfGzHsUQ=;
        b=TeL1lTuGrYSDnbTg9AnrJ2wbZVa9iOcJD5ZeFwd6ollVYkfUAgGm8jcv/1P4YLmfG2
         ruECfE63kUt83ZD5BppjnGaAfUkUaawbgz7kgLLiaYxf3dbowbnekamT5MDaW8YymMe7
         iScuiXSz+F/+0GucHpXUyA+NSHo8vhgIkBpbKHBzmAQGZydj8BJPvTF3ezJxBTixz7m7
         ikNvpNfYsYqY3VGC60MKXNnkmV+wNaipUbH8hD6nmTOPfxkftdBnaoC8LixMaFrYpQ4h
         r6LCqsbsMgJwdfcOv2vK0zH86KxJOQW+dax0xIvnUILYGTfj1bAa78jaTEOb158hneqi
         60tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CtARMaggSSWrV7NfHcUkCG/o5DV3pdLuaH3FfGzHsUQ=;
        b=0vmVPve3rbtpdERBrXKFg4kK03/1TBG0V3bd2F/IadYEhQPnKw7C3a1Et5Q1touJqP
         9eW8pdesANDnV9s4onLBrYRjra/IMTLfRdrZZhxnfmEJmIUBd+aepCqp+yzLODUH72qn
         OGbgN9zeaO9aK+AP/LrpDhtSbpmcU9rQANo9cBcf6/pWpGiirdkeZHBPL3jiPOFbJ9JI
         hLhmoYpvn0gJSzebBIwWVaNz+K/QEjtutQYOuy/HpLDujh3uxR2HpsAQbV1BciU4FiGi
         PdERLwkdS4MluCpY8IcVSMHfV74W8ZQ8ITLD4kXc78J03j83hmKEh0Bpnkc6rZD9Za8F
         KbFQ==
X-Gm-Message-State: AOAM532tXlVsRFq36JD8KO0yU2hB+0kQL57Jhmd20LeUvUNL0KtsBMr5
        FEcs7NtO78xlNU9jUIPtVXY=
X-Google-Smtp-Source: ABdhPJwFp20jh0dkQmrm0tlgd1cRevvUdzaAUabVETOsI+kNcyzJK+T91/tTKf+OrXCSUMyX1lNb4A==
X-Received: by 2002:a63:5214:0:b0:373:8aca:7453 with SMTP id g20-20020a635214000000b003738aca7453mr12446013pgb.574.1646716919702;
        Mon, 07 Mar 2022 21:21:59 -0800 (PST)
Received: from 9a2d8922b8f1 ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id a32-20020a631a20000000b003756899829csm13464044pga.58.2022.03.07.21.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 21:21:59 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:51:53 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Update clocks property for ARM
 pl022
Message-ID: <20220308052153.GA67357@9a2d8922b8f1>
References: <20220307203745.65210-1-singh.kuldeep87k@gmail.com>
 <f157651b-07c7-43ee-372a-81bd5d615d5d@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f157651b-07c7-43ee-372a-81bd5d615d5d@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 07, 2022 at 10:55:52PM +0100, Krzysztof Kozlowski wrote:
> On 07/03/2022 21:37, Kuldeep Singh wrote:
> > Add missing minItems property to clocks in ARM pl022 bindings.
> > 
> > This helps in resolving below warnings:
> > clocks: [[4]] is too short
> > clock-names: ['apb_pclk'] is too short
> > 
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-pl022.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> I saw these series in the past... please do not send the same version again.
> 
> You need to version your series (git format-patch -v2 -2) and add
> changelog in cover letter (or for small patches after '---' in commits).

Ahh no. I completely missed out updating series number before sending.
Actually I have been struggling to get mutt client setup with gmail
account to send replies but it doesn't seem to work properly. Gmail
labels has been hardest part. In between these hurdles, I rolled out
patches and missed out this important thing.

Kindly consider these 2 patches as deprecated.

> 
> How did you resolve the comments that the DTS might be wrong? It looks
> like you simply resent it...

Few broadcom boards(stingray and ns2) require DT updation for which I
sent patches and received Florain's blessings. Those patches are now
available in github.com/Broadcom/stblinux, devicetree-arm64

There are several other updations(in realview, versatile etc.) required
which I couldn't mention before as they are part of different tree.
