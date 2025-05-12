Return-Path: <linux-spi+bounces-8082-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03765AB3A48
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 16:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895F717C9E3
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 14:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A811DF754;
	Mon, 12 May 2025 14:17:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9611E3DE5;
	Mon, 12 May 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059441; cv=none; b=F4BR1MfOP81rZuLCQBnEwbLmt8mIqrwBr142yuWo4jeDHEjXS0nYUyHlw1lVkI5Q9Oam5MCtBA7Z9tkr5EkZlKjRsclV45I9vRWZgIkWqDZtAdspaSDOZ5WgAkQXsjRibMfFu+PSGhCw/GGOWFdqmSc65PQIrfLG7+f/m8yUmv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059441; c=relaxed/simple;
	bh=2IyyNXNnQSfbvykHq8rn1B+uBUbYbh7+8zI3pXsppGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOwcgnhkriG1uvIlUQZKR5sW0Mw+WogZmcPVe9C9iGSgonbnMIoKKzQLFaHBb9CUGa3VLVSsBFrA4vnI5EOUO/YdNO/t0c+/ra9xRu9+H+79bRcnq1XfOWI+5vQKw1wQv+NqEm63mj9eU4QyXN3bdsbrTiCtfw7wtcEKWgWj9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70a35432c21so37572527b3.0;
        Mon, 12 May 2025 07:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747059438; x=1747664238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+uGFXyTYFqNhdsh1y5nDVvPcnH9qAzMoSdfww0Dh/E=;
        b=gxmQ3kF8d8GURSYa+/qad8HT1B0VWwiycukVVZ3ERYFWCu+Imo6dYyBH2sN3R3sSv1
         J/3IzgBmuCV3B2CiM64xSM59te8oFIVyAmomIwJ/bsUJK569f1fODelr1Jb8xrdsrvwD
         6uNSyqzZxnttyTRY7f7omLEN4puI3+3wRqztwS9opcyoqthwKYR/3rSpUDJd0RqIbTX1
         73uCRmJXjbOwylYIl3YlG1gRuN8QzpN1HstPqBx9R3wJS3apRkqd126KhhKcgl6R+rmW
         CmcNbscaH9ebPh6gNABfWz9xCnfXkJ8WJeKRLWT+43b5/EzohNyRUJiZnowY4pKEPCOB
         CHew==
X-Forwarded-Encrypted: i=1; AJvYcCU2FHmHzZHvnc+sHp0tBVE7dwuEj1PT4+SkU03qV5xlZz3HewkH7Iutf8bCBkQZ6dmxQfBVC4IZwaO/r98=@vger.kernel.org, AJvYcCW5X/vICkGw5kKDve3L2qAB/bo1GCQ1iv0yqJSc90/AKyCDyPCKEew96dypVadlV1+ZDOQVOOoTtvQ0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyks2TwjqSbtuj+ZKMG02JdKSg96E/BAtDzzjGvilT3HQ9jOKk8
	hPdhc5tm2rhBxIHPqrrRa1RGHL2H+3LmwBUfxq0idetgXV9IrA/TB52VOHR6
X-Gm-Gg: ASbGncvjs//TMImyb4nrTGr0IMLtLl/TY7/r8hSZUfUm0iyFJYypXEpwyI8VXmwByYe
	s9Dy6A6a6RJJaWlnGdMnwPBdDIpjPCLzNIdk9Kl7cqDkCqKArmY8VYx9OxDtS75XQQ6E0g5ca3T
	UeInG+FSpNhQ87HsmcrFew0R4Le3GsQXV9ZL8RCzgua/ekgG9TFn9spopUVIJjN2CXDVwgItK6i
	rlTbCc6eF+annXebGzozqBuIphwXs307+/USpngjVX0aHXefa7p/kJvc5Kt/+26KTqe/atFxG0I
	io8A/ZwdUMb2dEUlE67gFNtBfGc1JjwvShPbIvqvz14FlhwNoVdX6AsLYnpCuTdJBDfCXAaGkCc
	G1y9RCs5zQGtY5BntZw==
X-Google-Smtp-Source: AGHT+IG0oAMuhT3R8lJ4MNgVuX25ZEk6AkcShmOGbeTE1tI0iPoZPalrexbJGU8biGeqQ87XzZVhiw==
X-Received: by 2002:a05:690c:6f81:b0:708:3375:3a33 with SMTP id 00721157ae682-70a3fa1fd64mr172961307b3.12.1747059438177;
        Mon, 12 May 2025 07:17:18 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70a3d896049sm19563027b3.9.2025.05.12.07.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 07:17:18 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7082ad1355bso37678257b3.1;
        Mon, 12 May 2025 07:17:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmtYrkS7KjKwH14t4/0yLlRWbkJOKkrctTLEJr6lHYxrj+YaiAh/yIUVc86Ce1LNmvfYKtMclF8FaA2E4=@vger.kernel.org, AJvYcCWaTtcceJNaz6mAl6zCByXO39FJ8tVBFragW9CGtpElxTtnYWS/6rpJSoGcqELC+gznhsGTb8tm85ig@vger.kernel.org
X-Received: by 2002:a05:690c:7406:b0:703:afd6:42e3 with SMTP id
 00721157ae682-70a3fb68ed7mr176247997b3.37.1747059437816; Mon, 12 May 2025
 07:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509181737.997167-1-Raju.Rangoju@amd.com> <202505110641.zLT16Dv7-lkp@intel.com>
 <e84f5483-a203-4095-82cd-23fa94c87700@amd.com>
In-Reply-To: <e84f5483-a203-4095-82cd-23fa94c87700@amd.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 May 2025 16:17:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUAE2umYggDdBjYZJY2-mYwim=P_=4Q00k9b8gB1tNY+Q@mail.gmail.com>
X-Gm-Features: AX0GCFvPeCVVWJSx_u6CiKRqRCs9Wi8eoap8nT8SCO-AJVBCg084LJ1ts4ptq_o
Message-ID: <CAMuHMdUAE2umYggDdBjYZJY2-mYwim=P_=4Q00k9b8gB1tNY+Q@mail.gmail.com>
Subject: Re: [PATCH] spi: spi_amd: Add HIDDMA basic write support
To: "Rangoju, Raju" <raju.rangoju@amd.com>
Cc: kernel test robot <lkp@intel.com>, broonie@kernel.org, oe-kbuild-all@lists.linux.dev, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krishnamoorthi M <krishnamoorthi.m@amd.com>, 
	Akshata MukundShetty <akshata.mukundshetty@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Rangoju,

On Mon, 12 May 2025 at 09:29, Rangoju, Raju <raju.rangoju@amd.com> wrote:
> On 5/11/2025 3:51 AM, kernel test robot wrote:
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on v6.15-rc5]
> > [also build test WARNING on linus/master]
> > [cannot apply to broonie-spi/for-next next-20250509]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/spi-spi_amd-Add-HIDDMA-basic-write-support/20250510-021954
> > base:   v6.15-rc5
> > patch link:    https://lore.kernel.org/r/20250509181737.997167-1-Raju.Rangoju%40amd.com
> > patch subject: [PATCH] spi: spi_amd: Add HIDDMA basic write support
> > config: m68k-randconfig-r111-20250511 (https://download.01.org/0day-ci/archive/20250511/202505110641.zLT16Dv7-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 14.2.0
>
> Thanks for reporting this. We do not support m68k.

All write[bwlq]() functions take a volatile void __iomem pointer
(https://elixir.bootlin.com/linux/v6.14.6/source/include/asm-generic/io.h#L174)
while you are passing a void *, so sparse should complain about this
on all architectures.  And sparse is right, this driver is using MMIO
accessors on allocated DMA memory, which is just plain wrong:

    amd_spi->dma_virt_addr = dma_alloc_coherent(dev, AMD_SPI_HID2_DMA_SIZE,
            &amd_spi->phy_dma_buf, GFP_KERNEL);

     for (i = 0; left_data >= 8; i++, left_data -= 8)
            *buf_64++ = readq((u8 __iomem *)amd_spi->dma_virt_addr + (i * 8));

> Will re-spin v2 with necessary changes in Kconfig.

Please fix the real issue instead ;-)

> > reproduce: (https://download.01.org/0day-ci/archive/20250511/202505110641.zLT16Dv7-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202505110641.zLT16Dv7-lkp@intel.com/
> >
> > sparse warnings: (new ones prefixed by >>)
> >>> drivers/spi/spi-amd.c:594:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
> >     drivers/spi/spi-amd.c:594:57: sparse:     expected void volatile [noderef] __iomem *addr
> >     drivers/spi/spi-amd.c:594:57: sparse:     got void *

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

