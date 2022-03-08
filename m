Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA904D19CF
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 14:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbiCHN7G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 08:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241473AbiCHN7F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 08:59:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35161B794
        for <linux-spi@vger.kernel.org>; Tue,  8 Mar 2022 05:58:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u1so28651353wrg.11
        for <linux-spi@vger.kernel.org>; Tue, 08 Mar 2022 05:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6YorkRdQ5ODwIMAwkUuKb6tGCEoxWYA4agUcSrocd/g=;
        b=IpWevBUGGjyc07sxf4d2Wsp0YSQ5tGlrYfhlfBt1B391HgmVtpJnFHOhJ4/GhS8TRi
         RxWNzTqTe0+DxCmPJoFVAds4PSDtOrPIQuJFcDxI/Vi9C+PZsurE7gafwm2eK0kdM9QL
         Ok68ouAXklyteNGH0NEQ75QQ5M+wY/XUklT1e6AEGUC+W/xzD9hgyGLqG2Dxe2RKXQT+
         6PY6NgjGZy5HRxpxslGTGiKh3gfNFKMiC64T1sxMp2OAWhc61GihicN0wx6KNwCH3btk
         tkYRj4TK9K08koGVCo4O/kUz7xa/UPfgOqfPDw9zrDcSWk7yTdrpEKbyfPbR1D8V/R5Q
         8qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6YorkRdQ5ODwIMAwkUuKb6tGCEoxWYA4agUcSrocd/g=;
        b=HtjlEeYKGEGsNQHM3l6twspjfxfd8FpP0KVkpw8WZlRUNkq4ivYQtwyg9PMiLNHkGs
         +qzFpg5QwBtWaNavrCafiAuK8kT//jCYAmE+BjYjg+pI/h169d2flgfrzwpIwH/iHRRD
         pNg46TPA7eIoNGWE0aBtjYgZqg1fIEnlrvOJHswppGrLbPS1W+vQf+9PflVBSebF47Ej
         M+suoOZdE+W02b7hhyVoZNPyjB6EqJjZypbt7rrW6iRxOU+Y9KMMZ6P4NOjxlWu6KEVa
         MzjtYj30iBJgBmLSi2rg3wukNzAGiSp0/qC1NluosaorLxxU1A1CnB8L3WVshheZWyXi
         iUzg==
X-Gm-Message-State: AOAM532xXl0f7/59EEeRYd0SpyLe5paQM8jmSkoQ7NVuKsar1kg1PBVc
        W2tivK8a/ox4Ym1YpGDKKz2jgQ==
X-Google-Smtp-Source: ABdhPJy0ijONgUXV2hKiTA5G3/CPfstf6wOumLH9rFqg0Zj3RwwwYyDIDBPDqhbcFBxSq8y/I/Dh0Q==
X-Received: by 2002:a5d:410c:0:b0:1ef:766b:ef5b with SMTP id l12-20020a5d410c000000b001ef766bef5bmr12193064wrp.183.1646747886241;
        Tue, 08 Mar 2022 05:58:06 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d40c1000000b001f1dd6ea504sm8503309wrq.59.2022.03.08.05.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 05:58:05 -0800 (PST)
Date:   Tue, 8 Mar 2022 13:58:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        andi@etezian.org, linux-spi@vger.kernel.org, linux-fsd@tesla.com,
        Adithya K V <adithya.kv@samsung.com>
Subject: Re: [RESEND PATCH v3 1/2] spi: dt-bindings: samsung: Add fsd spi
 compatible
Message-ID: <Yidg64QGGzIbduQ2@google.com>
References: <CGME20220308120701epcas5p3d3d2f5c01055e8c1721ae0ec6c2aa681@epcas5p3.samsung.com>
 <20220308121640.27344-1-alim.akhtar@samsung.com>
 <YidY+ncMVhp7bBvh@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YidY+ncMVhp7bBvh@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 08 Mar 2022, Mark Brown wrote:

> On Tue, Mar 08, 2022 at 05:46:39PM +0530, Alim Akhtar wrote:
> 
> > - Resend of FSD SPI support patches as the dependencies has landed in MFD
> >   tree, hope this will go via MFD tree (as there are dependency between
> > MFD, SPI and DT)
> 
> I either need a pull request for the MFD changes or to wait until those
> changes have come in via Linus' tree.

You mean this one:

  https://lore.kernel.org/all/YiYC7eYx2SpPILyl@google.com/

  spi: dt-bindings: samsung: Convert to dtschema

Or something else?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
