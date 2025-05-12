Return-Path: <linux-spi+bounces-8098-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B39AB43A7
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A23464A75
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 18:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE88B228C9D;
	Mon, 12 May 2025 18:35:09 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB6175BF;
	Mon, 12 May 2025 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747074909; cv=none; b=t69SIU1HicCM41x/Eo4EfuxELVLhj9eA45MjUwXqDjaVuVYRShYoBOxBJq30c9hHdv5JrFMrX0oDs7cmLpNxM1x5BCG6nQ8Iom3dzG1LQ8Pla7Q6bQhT+PlVIGR6ZoG7QvZ30DJ+LgeqEoQvF7Cr0eWpz0toyA34rTncl8Qbsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747074909; c=relaxed/simple;
	bh=t9E7jaIRgmZ+jhjkrMSLZufPgigLkMJGG8vibrwiY9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+VoSKg1F96Qlyya+MlttTu5dO71aagILBTDkgQb/ezyW6rHA80EE8sGjelSbu6kft7h+d2il8I+zbXi324tvmeBCkJEvoeT/Jvf9GbTS0dJs9Y7FVcoN5/RfLQKNf6SqY5/9P2grzWS8gekP1thCQ42bdEQk9ohybhOFRDWQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8783bce9f84so1235614241.2;
        Mon, 12 May 2025 11:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747074906; x=1747679706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=faDWq4SXHnuv6JR8rza3bg7AFXqM/F53I5xb503DYJA=;
        b=DWRxmg7uBvsWUAxnD3meLSTpQXi1ClsJ7VQ6Tt/0+OV9F+FxT7dGHGHT67R0VmXxNm
         voLpakFWLL2rZoUbNRbxM8UH0PAy4xXb6yECuwyd8i88aRy3vriULgRLHFkjg4sNXE98
         79upgFrtUnhRYIrXOKUQIFi7mf79ltrogR6+KgNRQr7HpfF7baNToawkHw3GRGiWOg1t
         Eu6pisGb44trL6hh5cV7CQNo+I2PPZQEJI1K0FabMBldn4RbPZ5ECklDXJzlYzHYD6OA
         wOQMsGjmjJR3KaoVy2Hn4Z2kDqvVcvoTaVPTcQph6JRFM2kDq17RAFdqSUFqwjznmB6V
         41jg==
X-Forwarded-Encrypted: i=1; AJvYcCUoDGP+mOSqJcbv1Oioox3YDTr8M+vbUZvgUcn2oOONU+illYyKV7Ipg6WTzjSXSFyNJBIOkgdNXUv3@vger.kernel.org, AJvYcCVUVVeDgDJLPmJ0aPC1E5x/X2eJBrcRKrvtSQIQAzY2w8RfuUR+SU2nOGBSBwszX81mCqw8ba13HldW0OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTwg6thpDt0EsTCP7yEW/c+tGKJ6Ih63tymJW9vsJpuRzUHR2Z
	YIikRcV4Bfyg9S2unZNd5GTcZjBcvwnE38GDvHBCUx07i8JHgfeLhkfYVmbw
X-Gm-Gg: ASbGnctNDaMl9oei7gV+N8LZNH6hNlBDly1ajN5zNKxUO44tOyDgnUR9K2KvEp+uKFS
	wS643+MO0qvgzLzt3SzQkaj7uY8m5AMtznHaBE1wlRm5LM9KpIo+E4JqP3UFR+APyfG6ex0OCcr
	A7vHrOvCI+I7k17Anlxklg9Fqk88JUPBdN0SnKAUPsBfuJ4RqGhcidxrASa7gnex0tJLOZz6TJk
	UnG8DD4L6nGr8rLvU2sLheqiixzp6CK/IAM2DFLO441Xvt46aoC+mx7ZP/fLeTv5Md2/M8LI2u4
	Nn4XR3vt0UCKmRxe5VBwjOU7uGY0nZt2n4YRUnum2/Lfhfg+L91G56i7c98o9/gWQl8jssRc4NO
	nMtBJse3+PoVBSw==
X-Google-Smtp-Source: AGHT+IG/Baza7umAn+ya2o1lnut6yQn9jj5gSstGFTFrs+dHvbM44monQFWD669h+oRYGD7XbZhA7Q==
X-Received: by 2002:a05:6102:800f:b0:4bb:9b46:3f87 with SMTP id ada2fe7eead31-4deed3374d9mr10491936137.6.1747074905969;
        Mon, 12 May 2025 11:35:05 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4deb2016d22sm5382267137.19.2025.05.12.11.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 11:35:05 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4def152384eso1064942137.1;
        Mon, 12 May 2025 11:35:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDgvJGtubwoP7MUrLUKEqvRwXPTfoAcVdmhs820/8VJDh/G9xGIC7+SyTFrqHKxmyNLjSHkuxmILp1@vger.kernel.org, AJvYcCUJ6xIqvnJyHxKytjpA3FjATlYm/zgAyNGzj9mmdysdJJvYDUU5BwbYCULsBfOTzAGvSSz10nBbg0ymM8g=@vger.kernel.org
X-Received: by 2002:a05:6102:5345:b0:4dd:c8f6:c479 with SMTP id
 ada2fe7eead31-4deed337524mr12552678137.7.1747074904660; Mon, 12 May 2025
 11:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509181737.997167-1-Raju.Rangoju@amd.com> <202505110641.zLT16Dv7-lkp@intel.com>
 <e84f5483-a203-4095-82cd-23fa94c87700@amd.com> <CAMuHMdUAE2umYggDdBjYZJY2-mYwim=P_=4Q00k9b8gB1tNY+Q@mail.gmail.com>
 <8c89410b-80f2-47ad-97fd-6ac10752c040@amd.com>
In-Reply-To: <8c89410b-80f2-47ad-97fd-6ac10752c040@amd.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 May 2025 20:34:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_ugjS475udqa1oOOfbOJ+0s_JAKcCyCcdQfPhhaWOTQ@mail.gmail.com>
X-Gm-Features: AX0GCFvM4NO1qlCePh4MALJ9BqQGETeVVgnvPLy3fBf6nSRJBizZ7wMT2W-NF_U
Message-ID: <CAMuHMdX_ugjS475udqa1oOOfbOJ+0s_JAKcCyCcdQfPhhaWOTQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi_amd: Add HIDDMA basic write support
To: "Rangoju, Raju" <raju.rangoju@amd.com>
Cc: kernel test robot <lkp@intel.com>, broonie@kernel.org, oe-kbuild-all@lists.linux.dev, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krishnamoorthi M <krishnamoorthi.m@amd.com>, 
	Akshata MukundShetty <akshata.mukundshetty@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Raju,

On Mon, 12 May 2025 at 19:55, Rangoju, Raju <raju.rangoju@amd.com> wrote:
> On 5/12/2025 7:47 PM, Geert Uytterhoeven wrote:
> > On Mon, 12 May 2025 at 09:29, Rangoju, Raju <raju.rangoju@amd.com> wrote:
> >> On 5/11/2025 3:51 AM, kernel test robot wrote:
> >>> kernel test robot noticed the following build warnings:
> >>>
> >>> [auto build test WARNING on v6.15-rc5]
> >>> [also build test WARNING on linus/master]
> >>> [cannot apply to broonie-spi/for-next next-20250509]
> >>> [If your patch is applied to the wrong git tree, kindly drop us a note.
> >>> And when submitting patch, we suggest to use '--base' as documented in
> >>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >>>
> >>> url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/spi-spi_amd-Add-HIDDMA-basic-write-support/20250510-021954
> >>> base:   v6.15-rc5
> >>> patch link:    https://lore.kernel.org/r/20250509181737.997167-1-Raju.Rangoju%40amd.com
> >>> patch subject: [PATCH] spi: spi_amd: Add HIDDMA basic write support
> >>> config: m68k-randconfig-r111-20250511 (https://download.01.org/0day-ci/archive/20250511/202505110641.zLT16Dv7-lkp@intel.com/config)
> >>> compiler: m68k-linux-gcc (GCC) 14.2.0
> >>
> >> Thanks for reporting this. We do not support m68k.
> >
> > All write[bwlq]() functions take a volatile void __iomem pointer
> > (https://elixir.bootlin.com/linux/v6.14.6/source/include/asm-generic/io.h#L174)
> > while you are passing a void *, so sparse should complain about this
> > on all architectures.
>
> My bad, with the following flags included, sparse now complains this on
> all architectures.
>
> -fmax-errors=unlimited -fmax-warnings=unlimited
>
> And sparse is right, this driver is using MMIO
> > accessors on allocated DMA memory, which is just plain wrong:
> >
> >      amd_spi->dma_virt_addr = dma_alloc_coherent(dev, AMD_SPI_HID2_DMA_SIZE,
> >              &amd_spi->phy_dma_buf, GFP_KERNEL);
> >
> >       for (i = 0; left_data >= 8; i++, left_data -= 8)
> >              *buf_64++ = readq((u8 __iomem *)amd_spi->dma_virt_addr + (i * 8));
> >
> >> Will re-spin v2 with necessary changes in Kconfig.
> >
> > Please fix the real issue instead ;-)
>
> We are using read*/write* calls instead of memcpy to copy data to/from
> DMA memory due to performance concerns, as we observed better throughput
> during continuous read/write compared to the memcpy functions.

Perhaps your memcpy() copies backwards?
https://lwn.net/Articles/1016300/

There is no guarantee that read*/write* calls work on normal RAM on
all architectures. It may just crash, as some architectures return
cookies instead of real pointers when mapping MMIO.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

