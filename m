Return-Path: <linux-spi+bounces-5252-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F259A33FD
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2024 07:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86531C20FCE
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2024 05:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1DA20E311;
	Fri, 18 Oct 2024 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hfv87CUd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7A2152E12
	for <linux-spi@vger.kernel.org>; Fri, 18 Oct 2024 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729227612; cv=none; b=eH3kyEO1hNbJJACyzISv/i49jRlpiJaAEFs57l5+SXywOlVNm463orfVi4jcE5WH4wrlkrLRHrk1DQMFennvmuJ5h1vYL7jyIt6Zf2eFvniceAg8gmSvAI69VknmBpZhYP+7/Pnxrh1TpRXCvYcG1nmyYYOoyg6gJUDgTleowIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729227612; c=relaxed/simple;
	bh=UWd85DMgUxd6psLXNjotk0Y+5Twq1J4hgHNTBOzf5YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwAtooE39xTx0vgbNniK018QTn8+PNEHWGoWUVhbeDgFRgBVfnd2dYQqgi3GY5gCZcleo/QKnr/Kq9YTJq1ItvrwEkV1XqpffhZmw18HNJPJNp9iByEYE53Q/8ysKnGrS1JJwMxsr9kKKOD4bGv38AM88V5EV18cWypJZC5ze5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hfv87CUd; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb443746b8so19937521fa.0
        for <linux-spi@vger.kernel.org>; Thu, 17 Oct 2024 22:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729227608; x=1729832408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1efHh81xX3jC4IuyP91Xe5XjAPEENg0V/kBgagPLjj4=;
        b=hfv87CUdtqi2D72iTun1iAchT4rydfYiBnmfTWaKfWyqZre0Ursn3lEvlxvAWECP5S
         VrrWdyrMuYP2Ev/l2HXNBKahjtT6wu/8c2zHECOCAcxc3hp3GQT7PddM7inT7mUhdyAo
         e8gn29TtsWP4NsqwZV3NgtTnyQhcOnPrIwniskZsoOi6sNIlNrqK1ungvX5DENi5Tjgj
         72HAeQcXhafI+I7TkVWWP8Q5dwdI1lt4WdM75/O/lmIFYvjJHsSSVIfLwkTpMNJZAbV6
         TiBnpsVBnBiqIfmbYwtwCtz0lejsr5aDQ2uKeHAAvCkFj49FF7XV/Ngtk3dfNRu7YojR
         4e2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729227608; x=1729832408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1efHh81xX3jC4IuyP91Xe5XjAPEENg0V/kBgagPLjj4=;
        b=K/Nqw3HSwAgkQGN7M7HEz/1Xh3Mj6qL66kiGgbClvSBTx+rR3s3/eLYwG/xSSKNhdk
         vzL4CQ94frOEnGLapaf8tiRxfdGR645CvuwdhfbpzF3ZDU/rra9D3bkPd0GTUnGROtVx
         qx8OYf+wcu7DYFE5Lj1nVpsGEpya8gMiPg9v05mMogmQAURjNz+oLRGV8568LUf4tVh4
         hVUhJE8Zyx+8MCce1f15z/oC6gGR0N6eTLJozH4eYnrB+VHRaABmXms0+5yl2C242WDh
         CEhf4xr47IfSh5QfTflHv1RpsjFsWtW95pyO+E+1ODJCPk7c06QaS+ZMdPPecjsdGk0o
         n3gw==
X-Forwarded-Encrypted: i=1; AJvYcCVTzvc8oumassl3kGlv+h/f/h7Rn55hp/kcacSQ5LHHasGm7nVFUW4r9IH3TGnU8lzWHOyoaV8Rk88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmJr0sx4ieUDKSJ5h3AQcYgixyWazd6yh1Ui25Cz6RfitW1278
	6AqAfdpM5LcShlg1uqJowYzmepHnyL+Pj++Fh7uT8drE1zSf2o3mKUq+THwso179u3QrpFzD/S0
	lIJrqiJwVMSO1UE6OOhFMKvvtSYbmRxzVisnn
X-Google-Smtp-Source: AGHT+IF+vmpVUL48pzbRvgMPKy5paiMVCfDFZC4Al8Rnz3GKUo6H/WH8lH6+2H80FiylBUFXEE35QWnfPrQY0Dr3Elw=
X-Received: by 2002:a05:651c:2109:b0:2fa:e658:27a1 with SMTP id
 38308e7fff4ca-2fb82e92b5bmr4866801fa.5.1729227608174; Thu, 17 Oct 2024
 22:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+nYHL8yoXy99GXqTXHzgNT2BtU3=OKi8Av-XQLDO6C0SvzWLQ@mail.gmail.com>
In-Reply-To: <CA+nYHL8yoXy99GXqTXHzgNT2BtU3=OKi8Av-XQLDO6C0SvzWLQ@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 18 Oct 2024 06:59:53 +0200
Message-ID: <CACT4Y+a-pfLFKW5a4H3JdKMgddt3F-s-KficqF5zgvSgyAYXmQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in spi_unregister_controller
To: Xia Chu <jiangmo9@gmail.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 06:49, Xia Chu <jiangmo9@gmail.com> wrote:
>
> Hi,
>
> We would like to report the following bug which has been found by our modified version of syzkaller.
>
> ======================================================
> description: KASAN: use-after-free Read in spi_unregister_controller
> affected file: drivers/spi/spi.c
> kernel version: 5.15.0-rc6

Hi Xia,

This kernel is 3 years old (which is very old).
Please see the following for some guidelines for kernel reports:
https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kernel_bugs.md

in particular:
Do NOT report bugs on old kernel versions. Old kernel generally means
older than a week. Reports on old kernels are typically not considered
as valid, and asked to be reproduced on a fresh kernel. Do not report
bugs found on stable/LTS kernels.

> kernel commit: 64222515138e43da1fcf288f0289ef1020427b87
> git tree: upstream
> kernel config: attached
> crash reproducer: attached
> ======================================================
> Crash log:
> WARNING: held lock freed!
> 5.15.0-rc6+ #1 Not tainted
> -------------------------
> kworker/0:0/5 is freeing memory ffff88801659c000-ffff88801659cfff, with a lock still held there!
> ffff88801659c668 (&ctlr->add_lock){+.+.}-{3:3}, at: spi_unregister_controller+0x3e/0x260 drivers/spi/spi.c:2964
> 8 locks held by kworker/0:0/5:
>  #0: ffff888041bc7d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:633 [inline]
>  #0: ffff888041bc7d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
>  #0: ffff888041bc7d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x5aa/0xe60 kernel/workqueue.c:2268
>  #1: ffffc9000036fdc8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:633 [inline]
>  #1: ffffc9000036fdc8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
>  #1: ffffc9000036fdc8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x5aa/0xe60 kernel/workqueue.c:2268
>  #2: ffff88807ea7ea20 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
>  #2: ffff88807ea7ea20 (&dev->mutex){....}-{3:3}, at: hub_event+0x172/0x3030 drivers/usb/core/hub.c:5662
>  #3: ffff88800f618220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
>  #3: ffff88800f618220 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0xb3/0xd0 drivers/usb/core/hub.c:2216
>  #4: ffff8880283fd1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
>  #4: ffff8880283fd1a8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1032 [inline]
>  #4: ffff8880283fd1a8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal drivers/base/dd.c:1233 [inline]
>  #4: ffff8880283fd1a8 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x22/0x40 drivers/base/dd.c:1259
>  #5: ffff888011c32d38 (&dev->vb_queue_lock){+.+.}-{3:3}, at: msi2500_disconnect+0x50/0x100 drivers/media/usb/msi2500/msi2500.c:571
>  #6: ffff888011c32ca8 (&dev->v4l2_lock){+.+.}-{3:3}, at: msi2500_disconnect+0x5a/0x100 drivers/media/usb/msi2500/msi2500.c:572
>  #7: ffff88801659c668 (&ctlr->add_lock){+.+.}-{3:3}, at: spi_unregister_controller+0x3e/0x260 drivers/spi/spi.c:2964
> stack backtrace:
> CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.15.0-rc6+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd6/0x142 lib/dump_stack.c:106
>  dump_stack+0x15/0x17 lib/dump_stack.c:113
>  print_freed_lock_bug kernel/locking/lockdep.c:6376 [inline]
>  debug_check_no_locks_freed.cold+0x83/0x88 kernel/locking/lockdep.c:6409
>  slab_free_hook mm/slub.c:1672 [inline]
>  slab_free_freelist_hook+0x7d/0x1e0 mm/slub.c:1726
>  slab_free mm/slub.c:3492 [inline]
>  kfree+0xeb/0x540 mm/slub.c:4552
>  spi_controller_release+0x16/0x20 drivers/spi/spi.c:2401
>  device_release+0x68/0x130 drivers/base/core.c:2232
>  kobject_cleanup lib/kobject.c:705 [inline]
>  kobject_release lib/kobject.c:736 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x189/0x370 lib/kobject.c:753
>  put_device+0x20/0x30 drivers/base/core.c:3503
>  spi_unregister_controller+0x234/0x260 drivers/spi/spi.c:2986
>  msi2500_disconnect+0xa2/0x100 drivers/media/usb/msi2500/msi2500.c:577
>  usb_unbind_interface+0x12e/0x500 drivers/usb/core/driver.c:458
>  __device_release_driver+0x419/0x420 drivers/base/dd.c:1205
>  device_release_driver_internal drivers/base/dd.c:1236 [inline]
>  device_release_driver+0x2c/0x40 drivers/base/dd.c:1259
>  bus_remove_device+0x1ec/0x2e0 drivers/base/bus.c:529
>  device_del+0x338/0x7b0 drivers/base/core.c:3583
>  usb_disable_device+0x225/0x4c0 drivers/usb/core/message.c:1419
>  usb_disconnect.cold+0x161/0x491 drivers/usb/core/hub.c:2225
>  hub_port_connect drivers/usb/core/hub.c:5199 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
>  port_event drivers/usb/core/hub.c:5634 [inline]
>  hub_event+0x1816/0x3030 drivers/usb/core/hub.c:5716
>  process_one_work+0x6d6/0xe60 kernel/workqueue.c:2297
>  worker_thread+0x3af/0x900 kernel/workqueue.c:2444
>  kthread+0x27a/0x2c0 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> ==================================================================
> BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> BUG: KASAN: use-after-free in atomic_long_read include/linux/atomic/atomic-instrumented.h:1183 [inline]
> BUG: KASAN: use-after-free in __mutex_unlock_slowpath+0xa4/0x430 kernel/locking/mutex.c:860
> Read of size 8 at addr ffff88801659c600 by task kworker/0:0/5
>
> CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.15.0-rc6+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd6/0x142 lib/dump_stack.c:106
>  print_address_description.constprop.0.cold+0x6f/0x314 mm/kasan/report.c:256
>  __kasan_report mm/kasan/report.c:442 [inline]
>  kasan_report.cold+0x82/0xdb mm/kasan/report.c:459
>  check_region_inline mm/kasan/generic.c:183 [inline]
>  kasan_check_range+0x148/0x190 mm/kasan/generic.c:189
>  __kasan_check_read+0x11/0x20 mm/kasan/shadow.c:31
>  instrument_atomic_read include/linux/instrumented.h:71 [inline]
>  atomic_long_read include/linux/atomic/atomic-instrumented.h:1183 [inline]
>  __mutex_unlock_slowpath+0xa4/0x430 kernel/locking/mutex.c:860
>  mutex_unlock+0xd/0x10 kernel/locking/mutex.c:536
>  spi_unregister_controller+0x1d4/0x260 drivers/spi/spi.c:2995
>  msi2500_disconnect+0xa2/0x100 drivers/media/usb/msi2500/msi2500.c:577
>  usb_unbind_interface+0x12e/0x500 drivers/usb/core/driver.c:458
>  __device_release_driver+0x419/0x420 drivers/base/dd.c:1205
>  device_release_driver_internal drivers/base/dd.c:1236 [inline]
>  device_release_driver+0x2c/0x40 drivers/base/dd.c:1259
>  bus_remove_device+0x1ec/0x2e0 drivers/base/bus.c:529
>  device_del+0x338/0x7b0 drivers/base/core.c:3583
>  usb_disable_device+0x225/0x4c0 drivers/usb/core/message.c:1419
>  usb_disconnect.cold+0x161/0x491 drivers/usb/core/hub.c:2225
>  hub_port_connect drivers/usb/core/hub.c:5199 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
>  port_event drivers/usb/core/hub.c:5634 [inline]
>  hub_event+0x1816/0x3030 drivers/usb/core/hub.c:5716
>  process_one_work+0x6d6/0xe60 kernel/workqueue.c:2297
>  worker_thread+0x3af/0x900 kernel/workqueue.c:2444
>  kthread+0x27a/0x2c0 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>
> Allocated by task 5:
>  kasan_save_stack+0x23/0x50 mm/kasan/common.c:38
>  kasan_set_track mm/kasan/common.c:46 [inline]
>  set_alloc_info mm/kasan/common.c:434 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:513 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:472 [inline]
>  __kasan_kmalloc+0xa9/0xe0 mm/kasan/common.c:522
>  kasan_kmalloc include/linux/kasan.h:264 [inline]
>  __kmalloc+0x1b2/0x330 mm/slub.c:4400
>  kmalloc include/linux/slab.h:596 [inline]
>  kzalloc include/linux/slab.h:721 [inline]
>  __spi_alloc_controller+0x3b/0x1d0 drivers/spi/spi.c:2545
>  spi_alloc_master include/linux/spi/spi.h:730 [inline]
>  msi2500_probe+0x3d7/0x640 drivers/media/usb/msi2500/msi2500.c:1223
>  usb_probe_interface+0x219/0x4f0 drivers/usb/core/driver.c:396
>  call_driver_probe drivers/base/dd.c:517 [inline]
>  really_probe+0x1a7/0x730 drivers/base/dd.c:596
>  __driver_probe_device+0x226/0x2e0 drivers/base/dd.c:751
>  driver_probe_device+0x51/0x180 drivers/base/dd.c:781
>  __device_attach_driver+0x14f/0x1f0 drivers/base/dd.c:898
>  bus_for_each_drv+0x12e/0x190 drivers/base/bus.c:427
>  __device_attach+0x1d5/0x390 drivers/base/dd.c:969
>  device_initial_probe+0x1b/0x30 drivers/base/dd.c:1016
>  bus_probe_device+0x14f/0x170 drivers/base/bus.c:487
>  device_add+0x920/0x1370 drivers/base/core.c:3396
>  usb_set_configuration+0xd1b/0x1060 drivers/usb/core/message.c:2170
>  usb_generic_driver_probe+0xa2/0xe0 drivers/usb/core/generic.c:238
>  usb_probe_device+0xa9/0x200 drivers/usb/core/driver.c:293
>  call_driver_probe drivers/base/dd.c:517 [inline]
>  really_probe+0x1a7/0x730 drivers/base/dd.c:596
>  __driver_probe_device+0x226/0x2e0 drivers/base/dd.c:751
>  driver_probe_device+0x51/0x180 drivers/base/dd.c:781
>  __device_attach_driver+0x14f/0x1f0 drivers/base/dd.c:898
>  bus_for_each_drv+0x12e/0x190 drivers/base/bus.c:427
>  __device_attach+0x1d5/0x390 drivers/base/dd.c:969
>  device_initial_probe+0x1b/0x30 drivers/base/dd.c:1016
>  bus_probe_device+0x14f/0x170 drivers/base/bus.c:487
>  device_add+0x920/0x1370 drivers/base/core.c:3396
>  usb_new_device.cold+0x1b0/0x905 drivers/usb/core/hub.c:2563
>  hub_port_connect drivers/usb/core/hub.c:5348 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
>  port_event drivers/usb/core/hub.c:5634 [inline]
>  hub_event+0x1d50/0x3030 drivers/usb/core/hub.c:5716
>  process_one_work+0x6d6/0xe60 kernel/workqueue.c:2297
>  worker_thread+0x3af/0x900 kernel/workqueue.c:2444
>  kthread+0x27a/0x2c0 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>
> Freed by task 5:
>  kasan_save_stack+0x23/0x50 mm/kasan/common.c:38
>  kasan_set_track+0x20/0x30 mm/kasan/common.c:46
>  kasan_set_free_info+0x24/0x40 mm/kasan/generic.c:360
>  ____kasan_slab_free mm/kasan/common.c:366 [inline]
>  ____kasan_slab_free mm/kasan/common.c:328 [inline]
>  __kasan_slab_free+0x101/0x140 mm/kasan/common.c:374
>  kasan_slab_free include/linux/kasan.h:230 [inline]
>  slab_free_hook mm/slub.c:1700 [inline]
>  slab_free_freelist_hook+0x95/0x1e0 mm/slub.c:1726
>  slab_free mm/slub.c:3492 [inline]
>  kfree+0xeb/0x540 mm/slub.c:4552
>  spi_controller_release+0x16/0x20 drivers/spi/spi.c:2401
>  device_release+0x68/0x130 drivers/base/core.c:2232
>  kobject_cleanup lib/kobject.c:705 [inline]
>  kobject_release lib/kobject.c:736 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x189/0x370 lib/kobject.c:753
>  put_device+0x20/0x30 drivers/base/core.c:3503
>  spi_unregister_controller+0x234/0x260 drivers/spi/spi.c:2986
>  msi2500_disconnect+0xa2/0x100 drivers/media/usb/msi2500/msi2500.c:577
>  usb_unbind_interface+0x12e/0x500 drivers/usb/core/driver.c:458
>  __device_release_driver+0x419/0x420 drivers/base/dd.c:1205
>  device_release_driver_internal drivers/base/dd.c:1236 [inline]
>  device_release_driver+0x2c/0x40 drivers/base/dd.c:1259
>  bus_remove_device+0x1ec/0x2e0 drivers/base/bus.c:529
>  device_del+0x338/0x7b0 drivers/base/core.c:3583
>  usb_disable_device+0x225/0x4c0 drivers/usb/core/message.c:1419
>  usb_disconnect.cold+0x161/0x491 drivers/usb/core/hub.c:2225
>  hub_port_connect drivers/usb/core/hub.c:5199 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
>  port_event drivers/usb/core/hub.c:5634 [inline]
>  hub_event+0x1816/0x3030 drivers/usb/core/hub.c:5716
>  process_one_work+0x6d6/0xe60 kernel/workqueue.c:2297
>  worker_thread+0x3af/0x900 kernel/workqueue.c:2444
>  kthread+0x27a/0x2c0 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>
> The buggy address belongs to the object at ffff88801659c000
>  which belongs to the cache kmalloc-4k of size 4096
> The buggy address is located 1536 bytes inside of
>  4096-byte region [ffff88801659c000, ffff88801659d000)
> The buggy address belongs to the page:
> page:ffffea0000596600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16598
> head:ffffea0000596600 order:3 compound_mapcount:0 compound_pincount:0
> flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000010200 0000000000000000 0000000300000001 ffff88800c842140
> raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, ts 16693266737, free_ts 16667681738
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook+0x10f/0x150 mm/page_alloc.c:2418
>  prep_new_page mm/page_alloc.c:2424 [inline]
>  get_page_from_freelist+0x82b/0x1fd0 mm/page_alloc.c:4153
>  __alloc_pages+0x1a5/0x470 mm/page_alloc.c:5375
>  alloc_pages+0xe3/0x250 mm/mempolicy.c:2191
>  alloc_slab_page mm/slub.c:1770 [inline]
>  allocate_slab mm/slub.c:1907 [inline]
>  new_slab+0x32e/0x4b0 mm/slub.c:1970
>  ___slab_alloc+0x950/0x1050 mm/slub.c:3001
>  __slab_alloc.constprop.0+0x53/0xa0 mm/slub.c:3088
>  slab_alloc_node mm/slub.c:3179 [inline]
>  slab_alloc mm/slub.c:3221 [inline]
>  __kmalloc+0x319/0x330 mm/slub.c:4396
>  kmalloc include/linux/slab.h:596 [inline]
>  tomoyo_realpath_from_path+0x86/0x3c0 security/tomoyo/realpath.c:254
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_path_number_perm+0x19c/0x4a0 security/tomoyo/file.c:723
>  tomoyo_path_mkdir+0x91/0xc0 security/tomoyo/tomoyo.c:166
>  security_path_mkdir+0x88/0xd0 security/security.c:1140
>  do_mkdirat+0x13a/0x2b0 fs/namei.c:3907
>  __do_sys_mkdir fs/namei.c:3931 [inline]
>  __se_sys_mkdir fs/namei.c:3929 [inline]
>  __x64_sys_mkdir+0x97/0xc0 fs/namei.c:3929
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1338 [inline]
>  free_pcp_prepare+0x1e2/0x4c0 mm/page_alloc.c:1389
>  free_unref_page_prepare mm/page_alloc.c:3315 [inline]
>  free_unref_page+0x1c/0x3d0 mm/page_alloc.c:3394
>  free_the_page mm/page_alloc.c:705 [inline]
>  __free_pages+0x111/0x140 mm/page_alloc.c:5448
>  __free_slab+0x194/0x340 mm/slub.c:1995
>  free_slab mm/slub.c:2010 [inline]
>  discard_slab+0x3c/0x70 mm/slub.c:2016
>  __unfreeze_partials+0x340/0x360 mm/slub.c:2502
>  put_cpu_partial+0x171/0x240 mm/slub.c:2582
>  __slab_free+0x203/0x350 mm/slub.c:3361
>  do_slab_free mm/slub.c:3480 [inline]
>  ___cache_free+0x33e/0x350 mm/slub.c:3499
>  qlink_free mm/kasan/quarantine.c:146 [inline]
>  qlist_free_all+0x5e/0xd0 mm/kasan/quarantine.c:165
>  kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
>  __kasan_slab_alloc+0x9d/0xb0 mm/kasan/common.c:444
>  kasan_slab_alloc include/linux/kasan.h:254 [inline]
>  slab_post_alloc_hook mm/slab.h:519 [inline]
>  slab_alloc_node mm/slub.c:3213 [inline]
>  slab_alloc mm/slub.c:3221 [inline]
>  kmem_cache_alloc+0x21b/0x3a0 mm/slub.c:3226
>  getname_flags.part.0+0x3c/0x310 fs/namei.c:138
>  getname_flags include/linux/audit.h:319 [inline]
>  getname+0x5f/0x90 fs/namei.c:217
>  do_sys_openat2+0xf6/0x3d0 fs/open.c:1194
>
> Memory state around the buggy address:
>  ffff88801659c500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88801659c580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff88801659c600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  ffff88801659c680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88801659c700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ======================================================
>
> Wishing you a nice day!
>
> Best regards,
> Ditto
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/CA%2BnYHL8yoXy99GXqTXHzgNT2BtU3%3DOKi8Av-XQLDO6C0SvzWLQ%40mail.gmail.com.

