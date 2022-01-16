Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7614648FC89
	for <lists+linux-spi@lfdr.de>; Sun, 16 Jan 2022 13:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiAPMMf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 16 Jan 2022 07:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiAPMMe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 16 Jan 2022 07:12:34 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33059C061574
        for <linux-spi@vger.kernel.org>; Sun, 16 Jan 2022 04:12:34 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id g1-20020a9d6481000000b00592d01f2b6eso12139038otl.5
        for <linux-spi@vger.kernel.org>; Sun, 16 Jan 2022 04:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dN4hyAkZ1Miqzb3/QhoFsGXlrqJg5gaQIvzhl2DDXYI=;
        b=CPNaiXWo2pnIicCgCE4TOFjmWNuRA9dzQpr3F9MQWVZndQVObEbrqc0LkwEobvrbAm
         b6jkPIJMdB2Xorzqzp3V0BiqMe5ONj9bKIWeOOKnukHWMiMqb9y3m4SwNrdoQkHfxhXq
         CDquO4Y5+rWhQ+usux8FaGzPpZ95FJFNAJGvYvwxZ9I3+VcEl9PH/Pvh6d4vmzz5tDtF
         V/8iIeMg4OwY/XNOgqmwFtCvGlXid6h50FVXjS+tHS/Kzh585Uwe2iOovV48wXEuLeyt
         nSve4ONIxR8/CbPDzw/rOM9rrux2qd5frYCAqc10IqjcAEKiOuYUepeHxW4aqbyBlcZl
         bWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dN4hyAkZ1Miqzb3/QhoFsGXlrqJg5gaQIvzhl2DDXYI=;
        b=kpCQmBZFZkxfaO2oq7cacamBTIGAS4LnTW/Or4lKJbA9BH5IRut68dNct8Eo2b72Ox
         9lL7kxCN/BbE78AKdnJYgL9898qJR/KVCgiD8nHiLStkN3r+VPf1AFsYw17pTKRiUtfd
         YrwiO114FljE3XzS/yQnCvewBgALKlytb7gVrshVZfc2zAb3AajikPPTdhNNskz8Ktfs
         sU9GG9qWWBDAtBpsY5yMwsG53HqOtxnmLxsHq13cdOcLUhhWYX/5fy0dUyUUzDKYujy/
         36/YvUk7/WcOm+qzhK8k38kU33z4jzJzgwPy1G4UCvQ2irBDFlCs1Tx83mRdLoxqoqqb
         FbHg==
X-Gm-Message-State: AOAM530frVI0sGH0s2kRcIj9/WGITyyXJ7oac26zbYwmOE1NAeoAUL+E
        9YE9FuQoaolJ47yuDgDmpelxHQktQImppUOXkcuzAQ==
X-Google-Smtp-Source: ABdhPJy8usbAaNUR44V9Qk15vyIj3ak49FQUUJBJouk/HUiIm/veRgYnOMPkzs5+HmpbNVpOzFFdybTHvuzzOVkJiXc=
X-Received: by 2002:a9d:465:: with SMTP id 92mr12902887otc.35.1642335153484;
 Sun, 16 Jan 2022 04:12:33 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220113122435epcas5p18e6a2699f193b9e1287588278a570235@epcas5p1.samsung.com>
 <20220113121143.22280-1-alim.akhtar@samsung.com> <20220113121143.22280-19-alim.akhtar@samsung.com>
In-Reply-To: <20220113121143.22280-19-alim.akhtar@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 13:12:21 +0100
Message-ID: <CACRpkdYSR5hiVKoZTffxudNOUQCNFqX-yuys-xgeocn2vG_ecg@mail.gmail.com>
Subject: Re: [PATCH 18/23] spi: s3c64xx: Add spi port configuration for Tesla
 FSD SoC
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        catalin.marinas@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, broonie@kernel.org, linux-spi@vger.kernel.org,
        Aswani Reddy <aswani.reddy@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jan 13, 2022 at 1:24 PM Alim Akhtar <alim.akhtar@samsung.com> wrote:

> This patch adds compatible and port configuration for
> spi controller for Tesla Full Self-Driving SoC.
>
> Cc: linux-fsd@tesla.com
> Cc: broonie@kernel.org
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Note to self: now that I see that the Samsung "S3C" SPI controller,
which I was thinking of as "some kind of early 2000s legacy" is used
by the very latest silicon I bumped up fixing it to use GPIO descriptors
a bit on my TODO list.

Yours,
Linus Walleij
