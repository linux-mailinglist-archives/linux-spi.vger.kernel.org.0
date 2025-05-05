Return-Path: <linux-spi+bounces-7889-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208AEAA9976
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 18:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D03E189E07F
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D221991A9;
	Mon,  5 May 2025 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8ptWYaK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996C13AF2;
	Mon,  5 May 2025 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463180; cv=none; b=hTyvoTAYL3aihW6bvotrTYJFCWbC+4XI5m7I7HC/tNhfN1lprwtrxsdybJrJMA85XV8ej4FMFbWeD+RzDDBJ+zB7Qm1/a1muE/2OcdQEXQjle198W7sDAfAHNRdspZV7w55r9iPNB13kwmwpjuEi9TC90FD6t/an6uy6F2afSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463180; c=relaxed/simple;
	bh=5TkvbWijlJPTKwJLH5IndsreaI2ziH2edXKHQRQsc18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L5f7GHWNk/7n71OGKQh8xJW5eYDNI60TmGwQI5TJSLNJ7IKh6dgT3helZT7XMzEBfiNmbHyCMNAL/tLkfNvYKCAAJlu8JlbW+vqlYUhXPLVc2lb2VD8QitCyFqMZb1zcTGUT0vCMZ/+rIVu06AUvw/55LhS8ikG+oo66I0R5PLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8ptWYaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94891C4CEE4;
	Mon,  5 May 2025 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746463180;
	bh=5TkvbWijlJPTKwJLH5IndsreaI2ziH2edXKHQRQsc18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b8ptWYaK8Uil7cckLaOfHjIBJEFkX/UV75ynNY/C3dnjoWsdOsme27SlAqqBAoWmA
	 O73zqHNHQgqd894EOIY9omcxDZGLBzo+ZBIlHM7RLJg1ddXta0M1hBssPoOYVF/MRj
	 ukgKWiZ1YFvMTt4r3BryWYk0WVWYQRHUkmhGJn4FeRb/+4JCVgkmvXWXeMr3R2wnfA
	 bs1GQlRu37Y+c2RQPgCPTU7CMtVHL4wNyVYNHWKxN4/vQtmG+2zkqqpo9KEziCW6YD
	 Y69FLFe1xaSvj/gVjXeT0CAx0pxTVpfzcYSs57QGFvChUistmMe4r6yt7SaqyKBmP2
	 KMMzswmjz4Lxw==
From: Pratyush Yadav <pratyush@kernel.org>
To: liwei song <liwei.song.lsong@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,  RichardWeinberger
 <richard@nod.at>,  VigneshRaghavendra <vigneshr@ti.com>,  TudorAmbarus
 <tudor.ambarus@linaro.org>,  PratyushYadav <pratyush@kernel.org>,
  MichaelWalle <mwalle@kernel.org>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
Subject: Re: [PATCH v2] mtd: core: add sync between read/write and unbind
 device
In-Reply-To: <CAND4H7dz94Gsi_tXSQmLNme9uROnouOUwuCX9BW_+RCc2ZFDqA@mail.gmail.com>
References: <20250325133954.3699535-1-liwei.song.lsong@gmail.com>
	<20250331161542.3040005-1-liwei.song.lsong@gmail.com>
	<87jz73v1th.fsf@bootlin.com>
	<CAND4H7dz94Gsi_tXSQmLNme9uROnouOUwuCX9BW_+RCc2ZFDqA@mail.gmail.com>
Date: Mon, 05 May 2025 16:39:37 +0000
Message-ID: <mafs0bjs73tbq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

+Cc Mark and linux-spi@

On Wed, Apr 30 2025, liwei song wrote:

> Hi Miqu=C3=A8l,
>
> On Tue, Apr 29, 2025 at 3:55=E2=80=AFPM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
>>
>> Hello Liwei,
>>
>> On 01/04/2025 at 00:15:20 +08, Liwei Song <liwei.song.lsong@gmail.com> w=
rote:
>>
>> > When unbind mtd device or qspi controller with a high frequency
>> > reading to /dev/mtd0 device, there will be Calltrace as below:
>> >
>> > $ while true; do cat /dev/mtd0 >/dev/null; done &
>> > $ echo ff8d2000.spi  > /sys/bus/platform/drivers/cadence-qspi/unbind
>> >
>> > Internal error: synchronous external abort: 0000000096000210 [#1] PREE=
MPT SMP
>> > Modules linked in:
>> > CPU: 3 UID: 0 PID: 466 Comm: cat Not tainted 6.14.0-rc7-yocto-standard=
+ #1
>> > Hardware name: SoCFPGA Stratix 10 SoCDK (DT)
>> > pc : cqspi_indirect_read_execute.isra.0+0x188/0x330
>> > lr : cqspi_indirect_read_execute.isra.0+0x21c/0x330
>> > Call trace:
>> >  cqspi_indirect_read_execute.isra.0+0x188/0x330 (P)
>> >  cqspi_exec_mem_op+0x8bc/0xe40
>> >  spi_mem_exec_op+0x3e0/0x478
>> >  spi_mem_no_dirmap_read+0xa8/0xc8
>> >  spi_mem_dirmap_read+0xdc/0x150
>> >  spi_nor_read_data+0x120/0x198
>> >  spi_nor_read+0xf0/0x280
>> >  mtd_read_oob_std+0x80/0x98
>> >  mtd_read_oob+0x9c/0x168
>> >  mtd_read+0x6c/0xd8
>> >  mtdchar_read+0xdc/0x288
>> >  vfs_read+0xc8/0x2f8
>> >  ksys_read+0x70/0x110
>> >  __arm64_sys_read+0x24/0x38
>> >  invoke_syscall+0x5c/0x130
>> >  el0_svc_common.constprop.0+0x48/0xf8
>> >  do_el0_svc+0x28/0x40
>> >  el0_svc+0x30/0xd0
>> >  el0t_64_sync_handler+0x144/0x168
>> >  el0t_64_sync+0x198/0x1a0
>> > Code: 927e7442 aa1a03e0 8b020342 d503201f (b9400321)
>> > ---[ end trace 0000000000000000 ]---
>> >
>> > Or:
>> > $ while true; do cat /dev/mtd0 >/dev/null; done &
>> > $ echo spi0.0 > /sys/class/mtd/mtd0/device/driver/unbind
>> >
>> > Unable to handle kernel paging request at virtual address 000000000000=
12e8
>> > Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>> > Modules linked in:
>> > CPU: 2 UID: 0 PID: 459 Comm: cat Not tainted 6.14.0-rc7-yocto-standard=
+ #1
>> > Hardware name: SoCFPGA Stratix 10 SoCDK (DT)
>> > pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>> > pc : spi_mem_exec_op+0x3e8/0x478
>> > lr : spi_mem_exec_op+0x3e0/0x478
>> > Call trace:
>> >  spi_mem_exec_op+0x3e8/0x478 (P)
>> >  spi_mem_no_dirmap_read+0xa8/0xc8
>> >  spi_mem_dirmap_read+0xdc/0x150
>> >  spi_nor_read_data+0x120/0x198
>> >  spi_nor_read+0xf0/0x280
>> >  mtd_read_oob_std+0x80/0x98
>> >  mtd_read_oob+0x9c/0x168
>> >  mtd_read+0x6c/0xd8
>> >  mtdchar_read+0xdc/0x288
>> >  vfs_read+0xc8/0x2f8
>> >  ksys_read+0x70/0x110
>> >  __arm64_sys_read+0x24/0x38
>> >  invoke_syscall+0x5c/0x130
>> >  el0_svc_common.constprop.0+0x48/0xf8
>> >  do_el0_svc+0x28/0x40
>> >  el0_svc+0x30/0xd0
>> >  el0t_64_sync_handler+0x144/0x168
>> >  el0t_64_sync+0x198/0x1a0
>> > Code: f9400842 d63f0040 2a0003f4 f94002a1 (f9417437)
>> > ---[ end trace 0000000000000000 ]---
>> >
>> > when unbind is running, the memory allocated to qspi controller and
>> > mtd device is freed during unbinding, but open/close and reading device
>> > are still running, if the reading process get read lock and start
>> > excuting, there will be above illegal memory access. This issue also
>> > can be repruduced on many other platforms like ls1046 and nxpimx8 which
>> > have qspi flash.
>> >
>> > In this patch, register a spi bus notifier which will be called before
>> > unbind process freeing device memory, add a new member mtd_event_remove
>> > to block mtd open/read, then waiting for the running task to be finish=
ed,
>> > after that, memory is safe to be free.
>> >
>> > Signed-off-by: Liwei Song <liwei.song.lsong@gmail.com>
>> > ---
>> >
>> > Hi Maintainer,
>> >
>> > This is an improved patch compared with the original one:
>> > (https://patchwork.ozlabs.org/project/linux-mtd/patch/20250325133954.3=
699535-1-liwei.song.lsong@gmail.com/),
>> > This v2 patch move notifier to spi-nor to avoid crash other types of f=
lash.
>> > now this patch only aim at fixing nor-flash "bind/unbind while reading=
" calltrace,
>> > but for other types of flash like nand also have this issue.
>>
>> While I agree with the observation and also the conclusion of adding
>> some kind of notifier, I'd like to understand the rationale behind
>> choosing to fix only spi-nor in v2? If any spi memory registered in the
[...]
>> > +static int spi_nor_remove_notifier_call(struct notifier_block *nb,
>> > +                                 unsigned long event, void *data)
>> > +{
>> > +     struct device *dev =3D data;
>> > +     struct spi_device *spi;
>> > +     struct spi_mem *mem;
>> > +     struct spi_nor *nor;
>> > +
>> > +     if (!of_match_device(spi_nor_of_table, dev))
>> > +             return 0;
>> > +
>> > +     switch (event) {
>> > +     case BUS_NOTIFY_DEL_DEVICE:
>> > +     case BUS_NOTIFY_UNBIND_DRIVER:
>> > +             spi =3D to_spi_device(dev);
>> > +             mem =3D spi_get_drvdata(spi);
>> > +             if (!mem)
>> > +                     return NOTIFY_DONE;
>> > +             nor =3D spi_mem_get_drvdata(mem);
>> > +
>> > +             mutex_lock(&nor->lock);
>> > +             nor->mtd.mtd_event_remove =3D true;
>> > +             mutex_unlock(&nor->lock);
>> > +             msleep(300);
>>
>> What is this sleep for?
>
> The sleep is to wait the process which already got the lock and
> running in reading
> routine can be finished before memory is released, show in below scenario:
>
> without sleep:
> --------------------------------------------------------------------
> mtd.mtd_event_remove =3D false;
>                                                             reading start;
> mtd.mtd_event_remove =3D true;
> release memory
>                                                             reading end;
> --------------------------------------------------------------------
>
> with sleep:
> -------------------------------------------------------------------
> mtd.mtd_event_remove =3D false;
>                                                            reading start;
> mtd.mtd_event_remove =3D true;
> sleep() start
>                                                            reading end;
> sleep() end
> release memory
> -------------------------------------------------------------------

This is not how we should manage lifetimes. Adding arbitrary sleeps to
hope races go away is flaky and will break in strange ways that would be
impossible to debug. For example, what if a read happens to take longer
than 300ms? Instead, we should have a way to properly manage the
lifetimes and sequence operations.

I always thought that by the time spi_unregister_controller() returns,
there are no longer any in-flight operations so freeing stuff after it
would be safe. Seems not to be the case.

After a quick look, seems like all SPI MEM devices are doing similar
things in their remove callbacks, so I think they are affected by the
same race. For example, nxp_fspi_remove() unmaps its AHB area, so in
flight SPI MEM operations would fail. Similarly, spi-stm32 will release
its DMA channels, and so on with others.

I suspect that this notifier thing is not the proper way to manage the
lifetimes here and there should be something better. We need a way for
the driver to make sure the underlying MTD device is no longer active
before it frees its memory.

Mark/SPI folks, what do you think is the proper way of doing this?

[...]

--=20
Regards,
Pratyush Yadav

