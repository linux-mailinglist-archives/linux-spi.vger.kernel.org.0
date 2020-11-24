Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E12C24F0
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 12:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgKXLsr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 06:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbgKXLsr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Nov 2020 06:48:47 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30601C0613D6;
        Tue, 24 Nov 2020 03:48:47 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c66so18266793pfa.4;
        Tue, 24 Nov 2020 03:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bew3Foss59SH2vxXIn0vqfZszKHH7IPfRGCktSQ+XUM=;
        b=Erzsnp2EiL1wc/Tm0mQooV6Kc3q1yGA1ZIrBMace0GrXdGac88eSiCk4nWhUzJgS6X
         Kw/stexvh4/QhMY7OMSG3sfdzvDmf+GWY6ZPZDY9iMtP4Zd6bmMeFLcCsWVsyLEdJNdn
         1SmWHAf9mHuJUh8wNi08MaIhU4ZdLDFMsszJIYuyLpMoeJwSk0a0EjY9EobzWZF28cpv
         Lk4uPkeBJ3qH5PEAezEbSh6qsUGtKuZ/itWvDbTiZW6vp+/D3iiyxrYJCoopFjbf6XZq
         SO3YcylLzsrxsg9zoN2sVfA8p3wge3MlPLU/Dd3zqHPvKLkLkVKQxGaSEUsDdPVwsDZo
         Nrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bew3Foss59SH2vxXIn0vqfZszKHH7IPfRGCktSQ+XUM=;
        b=c0hGgpDRuyobVYXa40l5653xrRVFwz3ryExN3q6ID7q5uPOpJlVYCEYbG1gdK3Lq/k
         /gsTwaqU6aO/+Z2gXD/9sKLNyDYUFYn7HsmITzbT/3khnnJiFgWCcAkCvFE25PMOr7F0
         jIdPtg54cq1wnAfkBBB+FJDOGI31UXceLh1r8nUvZ/70kpHBNeip2edIRMAnKsIbk/mj
         0EPT+CTYJFTTCwpHn85GWqKgvv/3NnHOdArcH1OCvg++54eckRGNgXVEyinCuaUW62+u
         7hKDTcAqkYCZDZzXG49qdlBffpBv5dkaws2YV/DEB7PWGWHNqKBC6IE55X+bLleg3Zu/
         rY+w==
X-Gm-Message-State: AOAM532mFPnS78ihPQIMTQZfVV5hFKHvKhDqWzTGaOi0U62ig653MUNh
        Az7f2liptyQydg6k8qREvhYpGoGloX4gW41Rhpc=
X-Google-Smtp-Source: ABdhPJxrpj3VZYBuwcG1mGU/LW82BoA03TWprutQm67datui6eLDZ7fVcZ9Z0X2DfuPfy/XIBaDe8vjWrwt1r5TDuxQ=
X-Received: by 2002:a63:1514:: with SMTP id v20mr3448015pgl.203.1606218526763;
 Tue, 24 Nov 2020 03:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20201124102152.16548-1-alexandru.ardelean@analog.com> <202011241901.eIm4FyEB-lkp@intel.com>
In-Reply-To: <202011241901.eIm4FyEB-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 Nov 2020 13:49:35 +0200
Message-ID: <CAHp75Vc+M2veG25pehO-8LSj0WcXvotijwaYvkYvAr3LF1n10Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] spi: convert to BIT() all spi_device flags
To:     kernel test robot <lkp@intel.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 24, 2020 at 1:42 PM kernel test robot <lkp@intel.com> wrote:

> All warnings (new ones prefixed by >>):
>
>    In file included from drivers/spi/spidev.c:26:
> >> include/uapi/linux/spi/spidev.h:33: warning: "SPI_CPHA" redefined
>       33 | #define SPI_CPHA  0x01

Argh! Can we have only one set of flags?

-- 
With Best Regards,
Andy Shevchenko
