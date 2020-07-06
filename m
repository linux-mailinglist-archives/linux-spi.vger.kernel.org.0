Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8DB215FC3
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgGFT6G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 15:58:06 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:38599 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFT6F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 15:58:05 -0400
Received: by mail-oo1-f67.google.com with SMTP id x2so542943oog.5;
        Mon, 06 Jul 2020 12:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYBYeXEBi9fpsYu32+atWlfZWbFyTXeWl6rhYx6hhP0=;
        b=nAdVwJQYqtZl0gK8YdUqI2xRxgY9AJ4GtrF7e/1K7fsTR3Oy26tHkEJTi9M2DjDEg+
         4itBeZqR7aRzcwUW/AHxNnpdViEVkOGrrUGgKZ7GFdqvlCKi5wLJKAMx+JjwHwAN1Rsd
         0RY/F+OunZPgV87KI8yIX/EyzG9ojc214gOYRUrGucf+R6rGP4CxJ2VJP+wN8MtLLZZ4
         /HrDKEMZChjAnHR84GGvvclWlqBvTzxpPSRkDAax850AV87/RzdsF3YM2irS1pb6PcDN
         qv2pWv7EbtIBnLokH3/8/F45aoLWvjuGG0xa5GD4S6g8JBXEYVbgb4bgWNQLiUiSKffQ
         ciTA==
X-Gm-Message-State: AOAM5319Xtaqf5jJmKd9Bw+aMmSbiGlSDRJVIFBv61gJofzhZjkPjBJz
        88LFqDU3UZx5XLCRDJDClXBbRhT+Rz0VG20aMeM=
X-Google-Smtp-Source: ABdhPJzX9ENYMNtWdtWLUsKiUIPey47XkLeKlUt0Fes8kpMgw+ZrL9CvfN/DkVMlEVyogx+972eLPoeQSqQNMaWSID4=
X-Received: by 2002:a4a:5209:: with SMTP id d9mr26731507oob.40.1594065484626;
 Mon, 06 Jul 2020 12:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <202007040833.xIqR5rAw%lkp@intel.com> <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
 <20200706161810.GB6176@sirena.org.uk>
In-Reply-To: <20200706161810.GB6176@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Jul 2020 21:57:53 +0200
Message-ID: <CAMuHMdXK92qO8KB6ejc6LLmfFsy=dZY18vNJGh+CKRZBAov-JA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: Add the SPI daisy chain support.
To:     Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Adrian,

On Mon, Jul 6, 2020 at 6:18 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 06, 2020 at 11:22:43AM +0200, Adrian Fiergolski wrote:
> > The implementation is transparent for the SPI devices and doesn't require
> > their modifications. It is based on a virtual SPI device (spi-daisy_chain)
> > and defines two required device tree properties ('spi-daisy-chain-len' and
> > 'spi-daisy-chain-noop') and one optional
>
> It would really help to have an example of how a client device will use
> this, right now it's a bit hard to follow.  Overall it feels like this
> should be better abstracted, right now there's lots of ifdefs throughout
> the code which make things unclear and also seem like they're going to
> be fragile long term since realistically very few systems will be using
> this.

Can't the ifdefs be avoided by implementing this as a new SPI controller?
I.e. the daisy chain driver will operate as a slave of the parent SPI
controller,
but will expose a new SPI bus to the daisy-chained slaves.

> Perhaps this needs to be a library for devices that can daisy
> chain?  It does feel like the instances should be aware of each other
> since half the point with building the hardware like this is that it
> enables operations on multiple devices to happen in sync.

Indeed. Exposing that functionality is the interesting, but hard part.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
