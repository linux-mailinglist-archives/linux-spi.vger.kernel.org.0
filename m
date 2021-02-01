Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794A630A2A5
	for <lists+linux-spi@lfdr.de>; Mon,  1 Feb 2021 08:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhBAH0t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Feb 2021 02:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhBAH0r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Feb 2021 02:26:47 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575AFC061573
        for <linux-spi@vger.kernel.org>; Sun, 31 Jan 2021 23:26:07 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o16so11484464pgg.5
        for <linux-spi@vger.kernel.org>; Sun, 31 Jan 2021 23:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=st35ya39PRwTDO/THE02rgYudJLgg+5H5DVN469+W60=;
        b=B/ZLF/7fm/kDoPErknk1CjR+2/3AIkAJHfaz1PdchDYLSJBMOLEYSDPjwpExgaJuuM
         8BO6HiAitvLEvH0ZYVw5WpxPZpGTkSUQoXqQr2WLAQ9xID1exLKGRgIn0+CnPsDJx5JL
         XqhymXXny7o7iOmSbsT0Ps7B75jcPqI/xkU5p/R4QrBJkAN2w2gKUkppGQDEtIYCuaEO
         6Fvzya6++R2ldzl8yUOjhFEeKNKydmju0qIX56doT4zgJ4rUJrgmEEdEkFFCGt0kYZfM
         gY0LO17TaWYjjQglAwGsP66N43WpOeaxXrJCdRO82bnnAJFRLYXJQxxj8EbUmZ9+O1nk
         /K4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=st35ya39PRwTDO/THE02rgYudJLgg+5H5DVN469+W60=;
        b=C04KyxkSD5kvO0UDZw8dMedJbjy5DYhdEpy1PWyO9QpyOHMJuuhxmQ9guTQWVcaGlx
         gfOh/Ky22UlBQWuG2wnoq+2OhYffPoOjQ+cxNn0RC+Nce9ec4PfzlmDbrcCnZOXooH/G
         8hdbZa6k729pvQMHzWloFjZsVpjF37eWzxt7m/F3ub+5Tp7Nt6dIsvWRRzvjVy9SxJpZ
         r/CcTPQg45yzDi7BTIIpJyORlZaDUzqo5lQjAWiasqHDcY4tcRLGpzbumJBXeiSY9BNW
         TZWtuJlaZVjNWC0WVAauN/pK3It9kyjNcL3IN3Z9E5N5lsro9fsOC/F2GjgfOjGJseGC
         FASQ==
X-Gm-Message-State: AOAM532NeS50cfBDUDttz+VoPiQZn0JbqjCPS0Sv6V6Ix99MSZzIQ7Yu
        +vg0jM33a60J0qdr3znFSyQ3T/WGaRItveuq8Mb3ig==
X-Google-Smtp-Source: ABdhPJyZv/4x/jrC2WKRVXznIPBvbfL3mCHH2Bd4OX04vY6GImicIe0l77b1RnYNPaoYE4ayz2ltOnasV/P7TyT2Rbw=
X-Received: by 2002:a65:6881:: with SMTP id e1mr16322492pgt.290.1612164366886;
 Sun, 31 Jan 2021 23:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20210124221755.1587718-1-jassisinghbrar@gmail.com> <20210125123709.GA4510@sirena.org.uk>
In-Reply-To: <20210125123709.GA4510@sirena.org.uk>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Mon, 1 Feb 2021 01:25:55 -0600
Message-ID: <CAJe_ZhenU_VxKgeC0P-quiZr1RfqfNqXUuZjA40LGUu8vCjBMQ@mail.gmail.com>
Subject: Re: spi: spi-synquacer: fix set_cs handling
To:     Mark Brown <broonie@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>, linux-spi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 25 Jan 2021 at 06:37, Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Jan 24, 2021 at 04:17:55PM -0600, jassisinghbrar@gmail.com wrote:
>
> > Respect the set_cs() request by actually flushing the FIFOs
> > and start/stop the SPI instance.
>
> set_cs() is a request to set the chip select not flush the FIFOs or
> restart the hardware - what's the actual issue here?  Transfers should
> happen in the transfer callback, the driver shouldn't be assuming there
> is anything going on with chip select when completing transfers.
>
The controller has one block for each slave-select, and we need to
actually stop the block to deassert the CS. At the minimum we need to
set the DMSTOP_STOP bit.
I will revise the patch to be much easier on the eyes.

thanks.
