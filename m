Return-Path: <linux-spi+bounces-11169-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 134E7C52F5C
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 16:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43B1E507123
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C45C34217C;
	Wed, 12 Nov 2025 14:39:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B1D341AD8
	for <linux-spi@vger.kernel.org>; Wed, 12 Nov 2025 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958353; cv=none; b=l8Qeg4Yo0ZlazGVVDmnfsyQdXI8Q5CItSOIDLEiKyLRCMXiE/zqL1xDg/9eyNUlGN4AcH63ay55O3QtGS7LdFu9jbXLpQAlaV3GS/TQ4K+gcyGmsvvRwe1uta2MliEJ5pC1aUhmPlOLL3vW0y0TpdGRdjOb524R43s9+5uMkC5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958353; c=relaxed/simple;
	bh=YLBWd43A4qz68JA3SZqwZJrrUnRu+5NA9D8YMiytfJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYmFEYftlkZcOIEd8AroP7N3Rj7ToC82tUwBx+k6MTHizgO4W4+ncfMAS/SO2l6y0rVKo9HpY8eCZA+1mY9FDVX0K+CiMW9AYn9piXQ2eQ7rCJktjRqpxWVEqK4V4jGG2fh9uG/3SFEIfGq/MrpIIyfRkT9Srqp21I6btYFw/ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cce892b7dso397821fac.1
        for <linux-spi@vger.kernel.org>; Wed, 12 Nov 2025 06:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762958350; x=1763563150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jduwwJc36NsKSwajdjfjQL6Giew4Hq4QvEpO2y2wUgU=;
        b=Uc2m01/MO35mnTgyvx27DZMyrq1J0IxRhlodKSAXecJuGkUbDBEA+COfSIugjNoJ99
         yjn+OFOb4/wwuXosSm07ogimfQ1VuQsf20Blvin3iIFyG1uwUnNKLT6efjJf877iiccG
         Uc8ISo2Gn2jdCazvjssdYvqD+zT0XLChsaXZGSC7WQrcm9L1xzUDefDw043gmxr5i49D
         KDcAtD5c5t1qhOujOQx9zJr6nksICty/Y1saMfPlyFsT0xvI936vpYPj5e7rHn0VIAEW
         Cs1H4axTHjJzaPhEiQ1Ml+6eBcxaobUDnGsgyyz3r1Jlu+mU4TD7aEuaz04Y4WasDQWW
         5rZg==
X-Forwarded-Encrypted: i=1; AJvYcCUbBV0a4BR38/VHLAv4/UuG2rZ981dq4G5KdakOyifSo9H01MODAplKjkjPEYCMJCxoZol0ihW7JR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZwiTK2sUCYblNyxapMwxmNttCSRf9G4AywVDiBh1o0MX696u
	G5YGy0pjESF57XjbHsZaIOV5DIJtSrVbfJyadRLfWV0++B0O3seWqMnY
X-Gm-Gg: ASbGncv3L5bS1xPHF94SNoFlAo54O0ZWUHTrkiZaaVmhTGvDwlmC09R/4lbmU1to9S9
	CMB+5xPsEgnzhF/MDEsdyNCiFS55tU1CXuX1iE2ONSNWKGpwXtFAWXZqlub7RGohmHpH773kyjV
	G5S+lTHR17kjBhSruaziE60Br/BHzAmijxvXzrgDqo/awmjRsq2B9/Wxgh3dxn8AFE8eeavQFV3
	YA2gWQCb0oBIg2ojm5fCdQ0RZGhQX3KRCgGQwjUg+o0QW1zRCehvF6ZLHqiLyzPsljruJv8V5Cl
	rGhoNY16/aZVX9HsPgf1nu8fHHN38tiuWhaiFVLjEklJPuJxhZT/ocU107ZmCj8//32YIzdHjkW
	q401Hiuk8Rvw+kmaBZyuKWbX8bmWD+r/H+ttUSermzUGs0DIOFVQCib+M/snGVM1XTuRK+Ie5AW
	WIpTQ=
X-Google-Smtp-Source: AGHT+IGOaUiBUnjCORPb2sikNr2bFgJVOUtqqbSVaoY7pBHbrk9Eo9bCP5k5x9A+nXecxYbNPaOn+A==
X-Received: by 2002:a05:6870:ebcb:b0:3e8:3382:aaed with SMTP id 586e51a60fabf-3e834080c5amr1365633fac.12.1762958350559;
        Wed, 12 Nov 2025 06:39:10 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f116ddcbsm8564167a34.33.2025.11.12.06.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:39:10 -0800 (PST)
Date: Wed, 12 Nov 2025 06:39:08 -0800
From: Breno Leitao <leitao@debian.org>
To: Vishwaroop A <va@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, smangipudi@nvidia.com, 
	kyarlagadda@nvidia.com, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v5 1/3] spi: tegra210-quad: Fix timeout handling
Message-ID: <jzmbuiqm5usjfklqs2cmxz72j5qjvttcib6grn5visgqe37qtx@cowi4mtcvwfh>
References: <20251028155703.4151791-1-va@nvidia.com>
 <20251028155703.4151791-2-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028155703.4151791-2-va@nvidia.com>

On Tue, Oct 28, 2025 at 03:57:01PM +0000, Vishwaroop A wrote:
> When the CPU that the QSPI interrupt handler runs on (typically CPU 0)
> is excessively busy, it can lead to rare cases of the IRQ thread not
> running before the transfer timeout is reached.
> 
> While handling the timeouts, any pending transfers are cleaned up and
> the message that they correspond to is marked as failed, which leaves
> the curr_xfer field pointing at stale memory.

I saw something similar on one of my hosts, and I debugged it, and it
seemed similar to what you are fixing in here.

Just sharing what I got while debugging this, in case this is useful:

	UBSAN: shift-out-of-bounds in drivers/spi/spi-tegra210-quad.c:385:25
	shift exponent 198 is too large for 32-bit type 'u32' (aka 'unsigned int')
	CPU: 0 UID: 0 PID: 883 Comm: irq/43-NVDA1513 Tainted: G        W   E    N  6.16.1 #1 PREEMPT(none)
	Tainted: [W]=WARN, [E]=UNSIGNED_MODULE, [N]=TEST
	Hardware name: Quanta JAVA ISLAND PVT 29F0EMAZ049/Java Island, BIOS F0EJ3A14 09/02/2025
	Call trace:
	show_stack+0x1c/0x30 (C)
	dump_stack_lvl+0x38/0xb0
	dump_stack+0x14/0x1c
	__ubsan_handle_shift_out_of_bounds+0x24c/0x2c0
	tegra_qspi_isr_thread+0x1cc8/0x1e60 [spi_tegra210_quad]
	irq_thread_fn+0x80/0x108
	irq_thread+0x158/0x258
	kthread+0x3fc/0x530
	ret_from_fork+0x10/0x20
	---[ end trace ]---

	------------[ cut here ]------------
	UBSAN: shift-out-of-bounds in drivers/spi/spi-tegra210-quad.c:397:20
	shift exponent 32 is too large for 32-bit type 'u32' (aka 'unsigned int')
	CPU: 0 UID: 0 PID: 883 Comm: irq/43-NVDA1513 Tainted: G        W   E    N  6.16.1 #1 PREEMPT(none)
	Tainted: [W]=WARN, [E]=UNSIGNED_MODULE, [N]=TEST
	Hardware name: Quanta JAVA ISLAND PVT 29F0EMAZ049/Java Island, BIOS F0EJ3A14 09/02/2025
	Call trace:
	show_stack+0x1c/0x30 (C)
	dump_stack_lvl+0x38/0xb0
	dump_stack+0x14/0x1c
	__ubsan_handle_shift_out_of_bounds+0x24c/0x2c0
	tegra_qspi_isr_thread+0xc90/0x1e60 [spi_tegra210_quad]
	irq_thread_fn+0x80/0x108
	irq_thread+0x158/0x258
	kthread+0x3fc/0x530
	ret_from_fork+0x10/0x20

	---[ end trace ]---

and then KASAN and a kernel crash.

	BUG: KASAN: vmalloc-out-of-bounds in tegra_qspi_isr_thread+0xce8/0x1e60 [spi_tegra210_quad]
	Write of size 1 at addr ffff8000db950000 by task irq/43-NVDA1513/883

	CPU: 0 UID: 0 PID: 883 Comm: irq/43-NVDA1513 Tainted: G        W   E    N  6.16.1-0_fbk0_debug_rc20_0_g977c20cb5846 #1 PREEMPT(none)
	Tainted: [W]=WARN, [E]=UNSIGNED_MODULE, [N]=TEST
	Hardware name: Quanta JAVA ISLAND PVT 29F0EMAZ049/Java Island, BIOS F0EJ3A14 09/02/2025
	Call trace:
	show_stack+0x1c/0x30 (C)
	dump_stack_lvl+0x38/0xb0
	print_report+0x164/0x6d8
	kasan_report+0xcc/0x128
	__asan_report_store1_noabort+0x1c/0x28
	tegra_qspi_isr_thread+0xce8/0x1e60 [spi_tegra210_quad]
	irq_thread_fn+0x80/0x108
	irq_thread+0x158/0x258
	kthread+0x3fc/0x530
	ret_from_fork+0x10/0x20

	The buggy address belongs to a 1-page vmalloc region starting at 0xffff8000db940000 allocated at copy_process+0x258/0x28d8
	Memory state around the buggy address:
	ffff8000db94ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	ffff8000db94ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	>ffff8000db950000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
			^
	ffff8000db950080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
	ffff8000db950100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
	==================================================================
	Unable to handle kernel paging request at virtual address ffff8000db950000
	KASAN: probably user-memory-access in range [0x00000006dca80000-0x00000006dca80007]
	Mem abort info:
	ESR = 0x0000000096000047
	EC = 0x25: DABT (current EL), IL = 32 bits
	SET = 0, FnV = 0
	EA = 0, S1PTW = 0
	FSC = 0x07: level 3 translation fault
	Data abort info:
	ISV = 0, ISS = 0x00000047, ISS2 = 0x00000000
	CM = 0, WnR = 1, TnD = 0, TagAccess = 0
	GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0


	 pstate: 234010c9 (nzCv daIF +PAN -UAO +TCO +DIT +SSBS BTYPE=--)
	 pc : tegra_qspi_isr_thread+0xcc0/0x1e60 [spi_tegra210_quad]
	 lr : tegra_qspi_isr_thread+0xce8/0x1e60 [spi_tegra210_quad]
	 x26: 0000000000000001 x25: 0000000000000028 x24: ffff8000db94ffff
	 x23: ffff0000d16b0918 x22: 0000000000000040 x21: 000000000000003a
	 x20: ffff8000db94ffff x19: ffff0000d16b08c0 x18: 0000000000000001
	 x17: 3d3d3d3d3d3b2d2c x16: 3d3d3d3d3d3b2d2c x15: 0000000000000001
	 x14: 1ffff00010bfce80 x13: 0000000000000000 x12: 0000000000000000
	 x11: ffff700010bfce81 x10: 0000000000000019 x9 : 0000000000000000
	 x8 : 0000000000000000 x7 : 0000000000000001 x6 : 0000000000000001
	 x5 : ffff8000b49cf8e0 x4 : ffff800084e7b140 x3 : ffff8000801bbd8c
	 x2 : 0000000000000001 x1 : 0000000000000008 x0 : 0000000000000001
	 Call trace:
	  tegra_qspi_isr_thread+0xcc0/0x1e60 [spi_tegra210_quad] (P)
	  irq_thread_fn+0x80/0x108
	  irq_thread+0x158/0x258
	  kthread+0x3fc/0x530
	  ret_from_fork+0x10/0x20
	 Code: 540001aa 1ad92768 f85f83aa 6b1a039f (383a6b08)
	 ---[ end trace 0000000000000000 ]---
	 Kernel panic - not syncing: Oops: Fatal exception
	 SMP: stopping secondary CPUs
	 Kernel Offset: disabled
	 CPU features: 0x2000,000003c0,62534ca1,5467fea7
	 Memory Limit: none

