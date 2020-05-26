Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BED11E1C7E
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 09:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbgEZHqq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 03:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731446AbgEZHqp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 May 2020 03:46:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD21C03E97E;
        Tue, 26 May 2020 00:46:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so9625399pgn.5;
        Tue, 26 May 2020 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hP2gJKDW99uKK2ci16iXnlfh+TatIfa89bbfH5MoI4=;
        b=IhzaWHQ1IZn6kk5fS4iMMRliwb3dMakoIny3kYQoKhPJfWBCrUDuqY1zF35nu+X3uM
         IIMZHSik2wI24wf1Rbv55Zfau50NYOZqwT5E3HJ44qFUyMAbvbwjtiMrX7FzQXecd9kx
         lGIyMAkM6o6NpxpWeGv6qArvRioOMHh8MYr9HAxc+AY0J3ndgjB/AAgwouQuApmwW/2x
         0i5kA8i2KdLS9Cry6afAJIVKO38W+8pxUNG0/aCJmn9FuhIrJGeaz0t9TNXu05wmWp60
         LvOyWZwuhdmVr8GBpjVVjopbyWV+x35/HsE+p0t5/nrUupNP/bELGe190S/g6BN5d+FF
         rd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hP2gJKDW99uKK2ci16iXnlfh+TatIfa89bbfH5MoI4=;
        b=uRmDtXbyOahAa3SYUMBb1yl32ZIAJT/jzxrwSvu/H4++4ktPLDGFq78CVrR9jwdLDj
         InlBPtAb266AIyvad/S7ZyiqTPm/ruVQaSrfjRilRf7aOII9ni3BtA+qHJQl46tvvVqr
         KP7NV4Txn1Z0fh/HOesSiZG6n9cNorbpL1OP8F3aYdRIV8vJspy1YONcGtLs7SjE4tvC
         5aEOYZOC8+e/c8ePAocRgEv+QKOz06U4hVMwK8sE6fhTZ2GSOFdLuO+QR3MJQVBxe2Pq
         7HGezlcNj2J5U5sFLpnKntNzqVgsAPx9wTcrzJ0D/q9i3G8XIWuIfuYoB9c65AwJyIUK
         cvLA==
X-Gm-Message-State: AOAM533pwkYb4tFmtHiOCjns4kthOd6+8zt4Zy+OLDzqX2LCSmczI3Nv
        4U12wZ3MBCf/mdE22Jpe/D9e1ep9sZBZckXKoOc=
X-Google-Smtp-Source: ABdhPJyxzAObFo2fGXgOG0DTaZEGiMDEiM/XhPzUWJLhBUpA9j5+1D9nbFN8JF/guHMeGKz5o2jOHBt1rP1W7jAGnnM=
X-Received: by 2002:aa7:99c8:: with SMTP id v8mr17942364pfi.36.1590479205218;
 Tue, 26 May 2020 00:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com> <1590378348-8115-7-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1590378348-8115-7-git-send-email-dillon.minfei@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 May 2020 10:46:33 +0300
Message-ID: <CAHp75VebSZa6mwAETnM0t42RQCp4iM6_SNjmy3TB48ixsGKV8g@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] drm/panel: Add ilitek ili9341 panel driver
To:     dillon.minfei@gmail.com,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 25, 2020 at 6:46 AM <dillon.minfei@gmail.com> wrote:
>
> From: dillon min <dillon.minfei@gmail.com>
>
>     This driver combine tiny/ili9341.c mipi_dbi_interface driver
>     with mipi_dpi_interface driver, can support ili9341 with serial
>     mode or parallel rgb interface mode by register configuration.

Noralf told once that this driver should be unified with mi0283qt.c.

So, what should we do here?

-- 
With Best Regards,
Andy Shevchenko
