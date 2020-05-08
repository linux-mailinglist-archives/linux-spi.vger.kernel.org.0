Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04681CB0A8
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 15:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgEHNmw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 09:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726736AbgEHNmv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 09:42:51 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFBFC05BD43;
        Fri,  8 May 2020 06:42:51 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id a8so954968ybs.3;
        Fri, 08 May 2020 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBzNAF/rm7qf9JD/mlsQ0iA9eh+VbbrEwR4tF97TGU0=;
        b=BdKPI5hcsGYeVJ2qAcgoxudFb/SH8PYr5sEVthDkxf5m2TDBAz2c0Q2KnFBcs9vAye
         KgE0EKzHjCXC6wRWMk6S/U/UHJXgz7Za12YEeGR7FXT5T6kJYFbWLnK80VeUg+6c/7yb
         VK4Wd6O2kVyvPLz1Z11l2e7CtJWaVXrKJ8Icu4pbptqGD71IqTu/m/nS/5l/pGmCz87B
         L/6EFRMpVUfAkUMPOM5ZRt1AZjfSopnzh6aXTDK23EhWaM2e6RRsISDF1GoHOpvx4iON
         UbaiWxelgTSYwLNqty6k+rNaj7eA1fztdFYvfOORBjgF4dzGzs/MtVcbkOPy99H+19jO
         b9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBzNAF/rm7qf9JD/mlsQ0iA9eh+VbbrEwR4tF97TGU0=;
        b=iuUSYI+Lzey6Jm69wzBGo4DCUWf/6fKHWKPelKlA1KLvaQc00vXf+a9E2ZA9M1lSx1
         EsyOze9JUrNK1qm/ZI2o/pe65xBG6cYTY2fmQy/E4sHRmqUNAboMKgRYJbbUUqTNCg5A
         Eii0ycbMLrNgzOyd0/iNFVC5pKYmmiPXG5pUGwBWAZHgktKV3/2CQ6mP9my6DXglQi+N
         yfGbotVXk07+x8rsJ6yBiLZlp/plxgzAE0E2MhTOWLLPO5pxz6irKVTQp6MtAUPkXhRQ
         ZzIm7B6fg3HIftclveVVB7e9dO9Ym6Qo+00jU5SggSodYKWfQ3DevH/io6fURdjvuABB
         Z1Ug==
X-Gm-Message-State: AGi0Pua7lQy9golfdHjIGddrL8EoPGuOtyORehwNWaFlAQoRwFw8b7NA
        y2dEdcWAbJ/em0p3TexpbobGK4ai5V9U3HstyC0=
X-Google-Smtp-Source: APiQypIX5kfqFGCBsLkvNmM3MXcMOc1ZzFCbC1vb3bZA4gU/cyEFJAiTo63nwaUf5Ac11beleDD7UJGrQ7Oe237J/X8=
X-Received: by 2002:a25:487:: with SMTP id 129mr4557690ybe.1.1588945370813;
 Fri, 08 May 2020 06:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200508083729.5560-1-chris.ruehl@gtsys.com.hk>
 <20200508083729.5560-2-chris.ruehl@gtsys.com.hk> <CANBLGcwA+=OB-_nOYUijWrDBSkLYhR7_PNG1ewO7LZ-zRVGoxg@mail.gmail.com>
In-Reply-To: <CANBLGcwA+=OB-_nOYUijWrDBSkLYhR7_PNG1ewO7LZ-zRVGoxg@mail.gmail.com>
From:   Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date:   Fri, 8 May 2020 15:42:39 +0200
Message-ID: <CANBLGcwAhOHVBUrwLat_60D=wwKkXP2==fazQEeJNuB-CizZLQ@mail.gmail.com>
Subject: Re: [PATCH v0 1/1] spi: spi-rockchip: add support for spi slave_mode
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chris,

On Fri, 8 May 2020 at 15:13, Emil Renner Berthing
<emil.renner.berthing@gmail.com> wrote:
> If you do something like this you won't need the temporary num_cs variable:
>
> if (of_property_read_u32(np, "num-cs", &master->num_chipselect))
>     master->num_chipselect = 1;

Sorry, that should be of_property_read_u16, since num_chipselect is a u16.

/Emil
