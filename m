Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA862CD8FF
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 15:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbgLCOYQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 09:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389112AbgLCOYP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 09:24:15 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD2FC061A4E;
        Thu,  3 Dec 2020 06:23:35 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f17so1492528pge.6;
        Thu, 03 Dec 2020 06:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNEe52zRl/JFK2lewCdsH9R68fLZgJ1A7bO1RdNpseY=;
        b=gQDEKd7esEzANUNkI2I0FcRoYd6tKkhBLHkduXZM9+10B//ohJgDBCa9fHbpP4YSiG
         g6L0MFBq5z6PyT6z7O3dJed2FdwQdtBHf1U+xLQ6l5GsT7IqtB54uSiurPz4bzdgQU18
         Er4yCxi7CeoRobAzljLf2/D5Lcl32p40J5/vV1/z3/DbDHFYsHKFmnWxG+Hkv8Swz69q
         lKwXWdcprRuJNYmzw8HzJJV4IrC2duqY+3i54+cX4RTu4OHD4OImFD3gEEDCDZXWFj0U
         JR0hoMWCgdyVMMgU+lOKGe+RMk7DahDvJ8WTIOHdqKRRdOAwfbhNlOPaHjmLbgNIJCbP
         JBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNEe52zRl/JFK2lewCdsH9R68fLZgJ1A7bO1RdNpseY=;
        b=WXB6UsFZmmw8HcxwdSle7R2r6c0GjZyfwbHha9z5i5OdrB2ugojJ+k8/H3uYPH/EWh
         I+fqZqzHGzzAK3DixJNCJuec2czpDKrS5otX6ci6S15SmSb07YR/odi/ClDceQnVkuu/
         zMYCMs0ts35A6EWP5DPnH2/rjCu1azqC6MPwkmgUyvuCPoOKbdkqpmNhB3gCMj5M2B68
         J19CXXkPA65BPPms+AhLJXP65OPcJOr66vPaCOAw8uXg2fG3vxaDu9+4NNQ3weFNYIaj
         NAI15O62TTE+yTuiHkYqCmEbpFtMjDOWg7gBaQdHZBgd53BdEITbvt5Sr9WjrGfbeNwr
         ZJwg==
X-Gm-Message-State: AOAM533074TFIZdt6wITf5MoAJilAeCDFnQu7ZIpSOXLYT6jFXMOQ7AP
        AXTusUQjt5csRkOW2VXZkCu4ff8s3q27jVc83GE9dQC2wr/Kwg==
X-Google-Smtp-Source: ABdhPJyLnjjPIaTOWYNBhn+PgS+N8YxTVkISwN6knErys4NjbINUjJpXmTNxi49+S87qVwcV/MM4XK8SoD+FZ9CbTaU=
X-Received: by 2002:a17:902:e98c:b029:da:cb88:f11d with SMTP id
 f12-20020a170902e98cb02900dacb88f11dmr403909plb.17.1607005413652; Thu, 03 Dec
 2020 06:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20201203140531.74470-1-alexandru.ardelean@analog.com> <20201203140531.74470-2-alexandru.ardelean@analog.com>
In-Reply-To: <20201203140531.74470-2-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Dec 2020 16:24:22 +0200
Message-ID: <CAHp75VescC-zQLYORVZzaC7Q16SOHuBOc=TLnOWX0mp7Rx-sSg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] spi: Add SPI_NO_TX/RX support
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Dec 3, 2020 at 4:00 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:

> +#define SPI_MODE_USER_MASK     \
> +       (SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST | \
> +        SPI_3WIRE | SPI_LOOP | SPI_NO_CS | SPI_READY | \
> +        SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD | \
> +        SPI_CS_WORD | SPI_TX_OCTAL | SPI_RX_OCTAL | SPI_3WIRE_HIZ)

Forgot to comment on this. Since it's an uAPI we may not fill the
holes (if any) in the future with the different semantics of values.
And this huge list of names is rather hard to read.

#define SPI_MODE_USER_MASK    (_BITUL(16) - 1)

would be sufficient.

For the record, I was thinking about providing MAX or LAST or
something like that instead of MASK and do the rest in kernel headers
/ modules, but it seems equally good/bad. Let's stick with mask as in
my initial propose and your current code.

-- 
With Best Regards,
Andy Shevchenko
