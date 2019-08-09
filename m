Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF8787882
	for <lists+linux-spi@lfdr.de>; Fri,  9 Aug 2019 13:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406550AbfHIL3f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Aug 2019 07:29:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33949 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfHIL3b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Aug 2019 07:29:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id z16so1495885qka.1;
        Fri, 09 Aug 2019 04:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9OL1q0b89StTOskN3x54TpYnbWG2EtxXE4LeFSFHD8=;
        b=U9ndGjPkvtiZ9sdah0iPKwD0UOfgUCLlCeEaX8gn5yohvcazlbs0DAyKF7b0xYO4CI
         2TRQzM6WQ5J2fqemzInIgxzkB9naRGDbV7TV0ytfwI85QMmHAnUssBUMANy5JFgcuJz9
         Ib9m28xuiy+go42nbmfxB4wp/zXA8cwnHK9YzMRtpNoNgbMZe06VGJkLZuMPER9jK35m
         GriNM2Kr1j4xtFCvTKvNQ8VhQmmnGJZkDTcZslBj3jDPr/O3ghvj6P5qgIrQ1gIu2sy2
         aJC29ks6ho/9flFjb00+udHIq5jHEi1vgMuSYBOmP1JUX61PqAprULoXosWkTdUBXDPY
         2yFg==
X-Gm-Message-State: APjAAAUu+4jHbSTCa1zhwHrjmuFMuz6x09vczaW8iB2HulCl1nKN4dob
        N9YarYQuwLKIaAEOJKTYD/A8vq8yDwyjMsBIEeM=
X-Google-Smtp-Source: APXvYqxl5obkgUvxS66Qeexv0igWPgPwk/RdVpkXMBFke1nhX+eNFdxUQ8CpQGywVOsc9uUsHUW2XXLFGod7PMkEzPY=
X-Received: by 2002:a05:620a:b:: with SMTP id j11mr17802595qki.352.1565350170063;
 Fri, 09 Aug 2019 04:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190808212234.2213262-1-arnd@arndb.de> <20190808212234.2213262-8-arnd@arndb.de>
 <20190808222408.GS3795@sirena.co.uk>
In-Reply-To: <20190808222408.GS3795@sirena.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Aug 2019 13:29:13 +0200
Message-ID: <CAK8P3a0qTvDFMj4GrKfD=2mkPpKN=eRJ--mp0r7mqAH+b2r=kg@mail.gmail.com>
Subject: Re: [PATCH 07/22] ARM: omap1: move perseus spi pinconf to board file
To:     Mark Brown <broonie@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Aug 9, 2019 at 12:24 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Aug 08, 2019 at 11:22:16PM +0200, Arnd Bergmann wrote:
> > The driver has always had a FIXME about this, and it seems
> > like this trivial code move avoids a mach header inclusion,
> > so just do it.
>
> This appears to be part of a series but I've no cover letter or anything
> else from it.  What's the story for dependencies and merging?

Sorry for missing you on the cover letter. The patch is part of a series
to make omap1 part of ARCH_MULTIPLATFORM. I'd like to merge the entire
series through the arm-soc tree to avoid dependencies:

https://lore.kernel.org/linux-arm-kernel/20190808212234.2213262-1-arnd@arndb.de/T

      Arnd
