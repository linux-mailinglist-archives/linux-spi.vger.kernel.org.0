Return-Path: <linux-spi+bounces-7215-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BBAA68690
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 09:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D142188ECF2
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 08:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95A42505B8;
	Wed, 19 Mar 2025 08:20:03 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06292500CE;
	Wed, 19 Mar 2025 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372403; cv=none; b=SzOxjrdoqR+hKK/K9l3GrPx8gBIfDluse/KaCYkBprIYCXktJvv4N4HvD6ai5JDH3JT0k9tMYu0gDyF9PnlcQu8mYpRKyZSVZRUdj25LLcOC/MR5ms4B+7Sc57oNoZ45i8hoeIXSCy+1r/SiT75mjM1LVLbEfeNX2dKIHYGCJPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372403; c=relaxed/simple;
	bh=nw2JHhewuwOb3AnEtFuyX6WKAPTojvjERpuELnO2jWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwrPt4p+q9h024ROlTlw6RdlKchyC5UmwofXK1THVmDQQRC1QsSSocQKysf6F7At8PRWfTdW9zl3VDGhF5nlrJtX4+S3t2jctI140zP+aqjzbn+pjgW77R1yBhqqZsR/axMN0lpvdR5NtT1igaNjTfdYYoTwF4Bb7lQ3iNTQ184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86b9d9b02cbso2934875241.1;
        Wed, 19 Mar 2025 01:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742372399; x=1742977199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Str15wCmbKqnizOYQnR2RTvVjukUzPyRH6iLv6/AuGY=;
        b=fF3zXJn+fvxAcJDwqUsTv/5NLcwEAu7ze4Mc6DqgOtnlbjpyuLmmVK/jMF7SWVki7/
         YrXvb4UfIMqInZO7wS2u9X8qQtS1a/DdatinoF8qla5gPb8GP5SPeH+y0jhH8GseCgJL
         oExLN/BsLXN5aUGzA6r6VKsYRiQHHaRsHUGUn00GMpFBFJ8/UwN44OAxd76fjZtwEUcY
         jUal8RHvN3JTvHTTzkZOZWn0fzFWeAZUUjC3VqFA9GT97oUPVTS9stahe3NPVzIlW2ZB
         MMnGWIZFI0oMTaAzDMBKIIHt28sC+8YZXhvItZq9cRt6pAmiefZEgleCDoAzlokfS7CZ
         FVlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKh+ZV20HIHegOSaZgxFAsUPcmiJrxLWDmFmx0AHWmONhRdEho7SVnzPOnZSc0O1kWkvXRxNgzdxQx@vger.kernel.org, AJvYcCWiWC77WO+FeCnkx7z6J1nfJQkFTlESXbEf36Bt3QnWSQL3IrvwoP8M2/SbI/c2JeH0+IxMFEIikaLQ1RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycPCoFkQFLKmejgUadTnlhqil3u9qX77K3LCU7yIkYzhK6P8H8
	Q8vwbMT5RX8frUspTyQWnrVLX/0UGpnSOF/V7KXbONHhnCEQLnb+ucBpbzxg
X-Gm-Gg: ASbGncsjZwPpN4O2gTvUWjtj3VLp70X5Xz8m46YLvPS/omajgTyRKnfyiPlJenpG55o
	qnLinwjcVdOvxNIig+vo39Vnb4/Ny2knTzMccLgoSi1wNsWiEqDcRQWstarvsm7/Jx1O5cqJHcw
	C1sl2ulpGtFHd0FCa5L43G0uUcTMH+nEU/K5cBUXpYBgOUt36Qa80zqHVdoqi5T039Km0CHp2BZ
	fQjNCYatXTtoqgoiAOvMQrpwZ+HLCdT/L16ZAn/YvbIIJjOJVX6u3Fx8YXcqUFyygExKQNdGUN/
	RkAbbgi7/v7ppbkAWyJDFpvgoPvvVWxQfimG4vbqNyH+JdQDOgSC45WgLciAfoWRtuiJ/kFssJr
	ZZKfgVkkqMDoVpYVNpA==
X-Google-Smtp-Source: AGHT+IHIdGSXihKToCdd6Eb93AlOR7EgGSeFF5d2xsyB1lTYya7nEDQ+q2pnAcmZCI2pCCGP2rrASA==
X-Received: by 2002:a05:6102:cce:b0:4c4:e3c7:cc8e with SMTP id ada2fe7eead31-4c4ec846eb1mr918844137.24.1742372399088;
        Wed, 19 Mar 2025 01:19:59 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c374f1eefdsm2401484137.7.2025.03.19.01.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 01:19:57 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86d5a786c7cso2787230241.2;
        Wed, 19 Mar 2025 01:19:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwLIURZJqRTvOkBRu7W1O4ZmW5WbrBtwIoDv2G+tX52y8dUzDUXgG6yJoinPqOSWLXhCkE0NNs2/x8caw=@vger.kernel.org, AJvYcCW0yRw8jL0MNXND1z3TE3TjWfzxxu2AvbpOsC68mHY71u7JnEVRLtcK9SCk3RhBW/zlJLz5qSa09gAv@vger.kernel.org
X-Received: by 2002:a05:6102:3590:b0:4c4:e518:e73b with SMTP id
 ada2fe7eead31-4c4ec813330mr853862137.19.1742372397512; Wed, 19 Mar 2025
 01:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319032305.70340-1-linmq006@gmail.com>
In-Reply-To: <20250319032305.70340-1-linmq006@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Mar 2025 09:19:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWLpV3129akyZ_fY3xZ04m9PWE9O4nM7UwzxZOSBfz3Lg@mail.gmail.com>
X-Gm-Features: AQ5f1JoM4oTnWTCI5waqkrsBM7hUt9YIa99RsCf_Y1uj4DwnMxcm-Pbh5P0JeFw
Message-ID: <CAMuHMdWLpV3129akyZ_fY3xZ04m9PWE9O4nM7UwzxZOSBfz3Lg@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix reference count leak in slave_show()
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 04:23, Miaoqian Lin <linmq006@gmail.com> wrote:
> Fix a reference count leak in slave_show() by properly putting the device
> reference obtained from device_find_any_child().
>
> Fixes: 6c364062bfed ("spi: core: Add support for registering SPI slave controllers")
> Fixes: c21b0837983d ("spi: Use device_find_any_child() instead of custom approach")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

