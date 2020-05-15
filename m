Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975B21D5BA4
	for <lists+linux-spi@lfdr.de>; Fri, 15 May 2020 23:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgEOVdM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 May 2020 17:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726301AbgEOVdL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 May 2020 17:33:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A11C061A0C
        for <linux-spi@vger.kernel.org>; Fri, 15 May 2020 14:33:10 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so1573277pjd.1
        for <linux-spi@vger.kernel.org>; Fri, 15 May 2020 14:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOy7Lg4L/jx9ljWYiP2hH6zPAudKPtQ8cz2fMkkgc8M=;
        b=tVgKWMBHjEmtqjVpyQLXOwSF3oyli942dJLU+cFuXTl/eEOh9nZWB26fUUZltyA+tv
         N0FZWIRnUAawTkNNdT2NnuqiXKY6Cee6T3Wq3h40wS+3YphNxTghqoIij+nb1eAvPitI
         YZ6SSovQvn75a0evK5r61KuKdk+1HEnZRY/Iy4Iq71NS5+/AAAionwFw47ckleVVYnA3
         0vnZVLJ7fr9N5EYOZqm2pJcLnlckFIqhYn41rz/ckZOrzp5b3c3Ycg+YuP3JMOqnPyQk
         co46L5xWCLmuGqzZeQtSdyDbF7B0hzNi8lIISd77hJB4VC2SSH/n0LJbEuQGIFPVxksk
         l/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOy7Lg4L/jx9ljWYiP2hH6zPAudKPtQ8cz2fMkkgc8M=;
        b=WgJSJttgj2wHCk4R5mBavDS2buYOiofYnG3aBQGpzM8SjQoEAo0k6gnxkp7OchlRRG
         qkraEzEd6V8uViBsKXiBrWGTpn/xbA1ccH/T8nd5OF/10FHn3p+KkeKHwWG6OL7FTiLE
         RMFaAGeaeBAOAgmCaPZiPKTImtwu2grX/lcBf1W5OZ2Mud3rVuIbQpFn4Z6PxB4zf1cI
         MnbNS8cC286EmDKCHf/jVo/jJ35LRedhqsYq9k2zr4rE7yetGckKA5BSCQYDL3Ffgbas
         1czt5MHhSc0K2fYxTQYnzKbpjEjEKIYsGCyvFQYk/mS8gcBqW4h06EYhk07CV7auQOCU
         /VMQ==
X-Gm-Message-State: AOAM5310+JE+aEqQcVfYWshk+vJLPBPzgyTU4RFdmIYRBw3a9L5AMhlt
        wTmYRa7bmUMAlpEGCxII8vyRUDVLwQltdkRPnPE=
X-Google-Smtp-Source: ABdhPJyOWCf3pOcAvs0fdU97WiTRVwzsvWjRWLWWSaLTMZSflTGaJ52Q++OOOOZyIDd0ocWOOlclNJisWm7v0HKc/gU=
X-Received: by 2002:a17:90b:3717:: with SMTP id mg23mr5810742pjb.129.1589578390300;
 Fri, 15 May 2020 14:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589557526.git.lukas@wunner.de> <2397dd70cdbe95e0bc4da2b9fca0f31cb94e5aed.1589557526.git.lukas@wunner.de>
 <20200515162903.GH5066@sirena.org.uk> <20200515164404.bev4zjzcmx4nwzhi@wunner.de>
In-Reply-To: <20200515164404.bev4zjzcmx4nwzhi@wunner.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 May 2020 00:33:00 +0300
Message-ID: <CAHp75Vfs=gc9c2h2amhu0eb3ux8jJAuC7CRY8fLrFiBsTwtSYQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] spi: bcm2835: Fix controller unregister order
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 15, 2020 at 7:45 PM Lukas Wunner <lukas@wunner.de> wrote:
> On Fri, May 15, 2020 at 05:29:03PM +0100, Mark Brown wrote:
> > On Fri, May 15, 2020 at 05:58:02PM +0200, Lukas Wunner wrote:
> > > Fix by using the non-devm variant spi_register_controller().  Note that
> > > the struct spi_controller as well as the driver-private data are not
> > > freed until after bcm2835_spi_remove() has finished, so accessing them
> > > is safe.
> >
> > Why not use managed allocations of clocks and DMA channels?  This is a
> > standard issue with the devm APIs, if you're using them you basically
> > need to use them for *everything* up to the point where you start using
> > them.
>
> There is no devm version of clk_prepare_enable(), dma_request_chan()
> and various other functions invoked on ->probe() by spi-bcm2835.c.
> So tearing down DMA channels, disabling clocks etc needs to happen
> in the ->remove() hook and consequently devm_spi_register_controller()
> cannot be used.

There is devm_add_action_or_reset (IIRC the name). It does a trick.


-- 
With Best Regards,
Andy Shevchenko
