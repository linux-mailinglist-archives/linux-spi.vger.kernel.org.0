Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF8E4D1BCB
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 16:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347832AbiCHPgu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 10:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347752AbiCHPgu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 10:36:50 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58C7377FA
        for <linux-spi@vger.kernel.org>; Tue,  8 Mar 2022 07:35:52 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 19so11127449wmy.3
        for <linux-spi@vger.kernel.org>; Tue, 08 Mar 2022 07:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FFfN3QwTXpZEEydH4Dw318ViohtLD0q25q7VNgA043Q=;
        b=q0q3FKMYmpXp6Vo8YguOocX+0fxxKvZeHlWnzv6IRNnAtdQ8S6BmItOAU0LfnBXooe
         jdKwVfXpNs0ZDes0JNm+9aB948rif8vb8hIj5Njm1GyNtcUDnAmoXQTRSXvssOYKvRNB
         7GV7fcoDP7u+6UxKKuYYN/NKUpaFiI4SOI38PKw4EaA8EbhU9J7p8TOR+kW+gm6XaU3X
         JRgPsSjox3FUvCpNka7Y3i4XcfjRPKvLOcwv5ZxnL45Sg8Z7Rokej9umddf4QjTtn4tY
         1cByh8M8bEPCATdReHnr6McSYhnWGr0zPyioWwizL43p2+92gqOxbWtJNO31GXCZBgeD
         O/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FFfN3QwTXpZEEydH4Dw318ViohtLD0q25q7VNgA043Q=;
        b=wJoIA2Ql6roE54IJtC8msvqyZjXhI3M2R1/IKQl5V5eZHmWxFPjhrDvnNdYKiu94v1
         rANaByJBKJhKIgFUvV0XIqvM9K7k69A+XfF+Zz0rHOz/NWnkEJ8/c95rRUUxmHPRoFBW
         2KX2M19wx/ZGFiuVTi2OC8gjuoar/RGy4mSf7ZaBUe1QQjovj28gxsplRYPmM5GwaqiG
         RSTtiJPTQq6T4DEqnZS1xxNsXtiezdbaGCLA1Gw1y6l94vyaqjMVz62C0R9WtM4LnXjO
         7Ry74CcJDpD8vdZbcpCxM8ylLqAxktgmkgpYeyX8AjqLZ+IrTQ/fV+RPDKbVhp9U4LsF
         y3Qw==
X-Gm-Message-State: AOAM532S51MrCtPYWeJrS0cfaqO/n0lIuEyJZGv247QwVDhVbVMKppQA
        WXfCcAnoQLRC7oUZ+cgEmlWOFw==
X-Google-Smtp-Source: ABdhPJxfIn23wUihncDqqZVYLYdtQidJTz+X7ddXzfusg0GRpC7ODv6hu4iQUu8fm7PVB628rmCZrA==
X-Received: by 2002:a05:600c:4fd0:b0:382:716a:c5fc with SMTP id o16-20020a05600c4fd000b00382716ac5fcmr4051006wmq.81.1646753751398;
        Tue, 08 Mar 2022 07:35:51 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0037c91e085ddsm3059749wmq.40.2022.03.08.07.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 07:35:50 -0800 (PST)
Date:   Tue, 8 Mar 2022 15:35:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        andi@etezian.org, linux-spi@vger.kernel.org, linux-fsd@tesla.com,
        'Adithya K V' <adithya.kv@samsung.com>
Subject: Re: [RESEND PATCH v3 1/2] spi: dt-bindings: samsung: Add fsd spi
 compatible
Message-ID: <Yid31AK5BlZEgmoA@google.com>
References: <CGME20220308120701epcas5p3d3d2f5c01055e8c1721ae0ec6c2aa681@epcas5p3.samsung.com>
 <20220308121640.27344-1-alim.akhtar@samsung.com>
 <YidY+ncMVhp7bBvh@sirena.org.uk>
 <Yidg64QGGzIbduQ2@google.com>
 <YidosChLIwIAKDmG@sirena.org.uk>
 <010901d832fb$212124f0$63636ed0$@samsung.com>
 <Yidv5aGB3CljCEWg@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yidv5aGB3CljCEWg@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 08 Mar 2022, Mark Brown wrote:

> On Tue, Mar 08, 2022 at 08:15:15PM +0530, Alim Akhtar wrote:
> 
> > >There were changes adding the FSD SoC as well as DT stuff IIRC.
> 
> > FSD SoC DT changes are already in -next.
> > I think this can go with MFD tree because of immutable
> > branch between MFD, SPI and DT due for the v5.18 merge windows.
> > I am not sure if there are better ways to handle this.
> 
> I need the changes that are hard dependencies to actually be in my tree
> so my tree is not broken, -next isn't good enough here.  If there are
> dependencies for things you're posting you should explicitly say what
> they are when you post (not just vauge statements that there are
> dependencies), and when you post things that will be dependencies for
> other trees it's good to mention this so that people can think about
> putting them on a separate branch for easier cross merging.

Right.

Which patch(es) contain the dependencies please Alim?

I tend to send out pull-requests for cross-subsystem changes I merge.

Not sure I see anything relevant in my tree currently.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
