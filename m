Return-Path: <linux-spi+bounces-87-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06987FD15C
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 09:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC6D1C208F8
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 08:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E321173A;
	Wed, 29 Nov 2023 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rfxa37kB"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636E0E1;
	Wed, 29 Nov 2023 00:49:36 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D5F21BF214;
	Wed, 29 Nov 2023 08:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701247774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHYyA04RyuVgTs8xy4NFBtsU7wIEQs7+tVUD7OSa4v0=;
	b=Rfxa37kBP2potWEHY8/kzMKMdMrXC+ZqZ9mYdpNDz6Jg1+K6/pDj/ozSOv33EtJxeWK3bD
	2DeT07v8C6W/S+wVqYXxNomK8wV2rGaI/32PEN3Pv2fbzc5PRxpwmysSB28PXyfHrmewrv
	x78YYdym5A78BVbU1qhwztPAmen2oIh4D6tf/y4PbIuLxA3vCulO4IH8FGhFyjN5NCQXeA
	Qy3i69NOYY+0MhOrBKCLlSLBXQy8b1z1LCYmEYiqxLNWRMfZpqLiD0O66BPALOQEscjIeN
	gN0QvND3jht8PlQa4/VjS0voKt8SSUipVLXkQ9X1ooLoF89/3Rg/xe73sAToMg==
Date: Wed, 29 Nov 2023 09:49:32 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Ryan Wanner
 <ryan.wanner@microchip.com>, stable@vger.kernel.org, Richard Weinberger
 <richard.weinberger@gmail.com>
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any
 signal
Message-ID: <20231129094932.2639ca49@xps-13>
In-Reply-To: <0ce4c673-5c0b-4181-9d8b-53bcb0521f3e@raritan.com>
References: <20231127095842.389631-1-miquel.raynal@bootlin.com>
	<a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com>
	<0ce4c673-5c0b-4181-9d8b-53bcb0521f3e@raritan.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Ronald,

+ Richard, my dear jffs2 expert ;)

ronald.wahl@raritan.com wrote on Mon, 27 Nov 2023 18:54:40 +0100:

> On 27.11.23 16:10, Ronald Wahl wrote:
> > On 27.11.23 10:58, Miquel Raynal wrote: =20
> >> The intended move from wait_for_completion_*() to
> >> wait_for_completion_interruptible_*() was to allow (very) long spi mem=
or =20
> y
> >> transfers to be stopped upon user request instead of freezing the
> >> machine forever as the timeout value could now be significantly bigger.
> >>
> >> However, depending on the user logic, applications can receive many
> >> signals for their own "internal" purpose and have nothing to do with t=
he
> >> requested kernel operations, hence interrupting spi transfers upon any
> >> signal is probably not a wise choice. Instead, let's switch to
> >> wait_for_completion_killable_*() to only catch the "important"
> >> signals. This was likely the intended behavior anyway. =20
> >
> > Actually this seems to work. But aborting a process that has a SPI
> > transfer running causes ugly messages from kernel. This is somehow
> > unexpected:
> >
> > # dd if=3D/dev/urandom of=3D/flashdisk/testfile bs=3D1024 count=3D512
> > ^C[=C2=A0 380.726760] spi-nor spi0.0: spi transfer canceled
> > [=C2=A0 380.731688] spi-nor spi0.0: SPI transfer failed: -512
> > [=C2=A0 380.737141] spi_master spi0: failed to transfer one message fro=
m queue
> > [=C2=A0 380.746495] spi-nor spi0.0: spi transfer canceled
> > [=C2=A0 380.751549] spi-nor spi0.0: SPI transfer failed: -512
> > [=C2=A0 380.756844] spi_master spi0: failed to transfer one message fro=
m queue
> >
> > JFFS2 also logs an informational message which is less visible but also
> > may rise eyebrows:
> > [=C2=A0 380.743904] jffs2: Write of 4164 bytes at 0x0016a47c failed. re=
tu =20
> rned
> > -512, retlen 68
> >
> > Killing a process is something to expect in certain cases and it should
> > not cause such messages which may create some anxiety that something bad
> > had happened. So maybe the "kill" case should be silent (e.g. level
> > "debug")
> > but without out hiding real errors. But even when hiding the message in=
 t =20
> he
> > SPI framework it may cause additional messages in upper layers like JFF=
S2 =20
> .
> > I'm not sure whether all of this is a good idea. This is something othe=
rs
> > have to decide. =20
>=20
> ... and now I just got a crash when unmounting and remounting jffs2:
>=20
> unmount:
> [ 8245.821105] spi-nor spi0.0: spi transfer canceled
> [ 8245.826288] spi-nor spi0.0: SPI transfer failed: -512
> [ 8245.831508] spi_master spi0: failed to transfer one message from queue
> [ 8245.838484] jffs2: Write of 1092 bytes at 0x00181458 failed. returned =
-5
> 12, retlen 68
> [ 8245.839786] spi-nor spi0.0: spi transfer canceled
> [ 8245.844759] spi-nor spi0.0: SPI transfer failed: -512
> [ 8245.850145] spi_master spi0: failed to transfer one message from queue
> [ 8245.856909] jffs2: Write of 1092 bytes at 0x0018189c failed. returned =
-5
> 12, retlen 0
> [ 8245.856942] jffs2: Not marking the space at 0x0018189c as dirty becaus=
e the flash driver returned retlen zero
>=20
> mount:
> [ 8831.213456] jffs2: error: (1142) jffs2_link_node_ref: Adding new ref 2=
8b
> d9da7 at (0x000ad578-0x000ae5bc) not immediately after previous (0x000ad5=
78
> -0x000ad578)
> [ 8831.228212] Internal error: Oops - undefined instruction: 0 [#1] THUMB2
> [ 8831.234996] CPU: 0 PID: 1142 Comm: mount Not tainted 6.6.2-sama5 #1
> [ 8831.241587] Hardware name: Atmel SAMA5
> [ 8831.245478] PC is at jffs2_link_node_ref+0xe/0xe2
> [ 8831.250360] LR is at jffs2_link_node_ref+0xb9/0xe2
> [ 8831.255473] pc : [<c020969c>]    lr : [<c0209747>]    psr: 00000033
> [ 8831.261893] sp : c974dd78  ip : 00000000  fp : c09c6a5c
> [ 8831.267428] r10: c1572f18  r9 : 0000e002  r8 : c2849964
> [ 8831.272801] r7 : 00001a44  r6 : 000ae5bc  r5 : c14df4a8  r4 : c1620208
> [ 8831.279647] r3 : 00000001  r2 : 40000000  r1 : c090ce3c  r0 : 00000093
> [ 8831.286340] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Seg=
me
> nt none
> [ 8831.293974] Control: 50c53c7d  Table: 21470059  DAC: 00000051
> [ 8831.300025] Register r0 information: non-paged memory
> [ 8831.305239] Register r1 information: non-slab/vmalloc memory
> [ 8831.311220] Register r2 information: non-paged memory
> [ 8831.316427] Register r3 information: non-paged memory
> [ 8831.321630] Register r4 information: slab kmalloc-2k start c1620000 po=
in
> ter offset 520 size 2048
> [ 8831.330796] Register r5 information: slab jffs2_refblock start c14df3e=
0 pointer offset 200 size 248
> [ 8831.340219] Register r6 information: non-paged memory
> [ 8831.345422] Register r7 information: non-paged memory
> [ 8831.350784] Register r8 information: slab kmalloc-4k start c2849000 po=
in
> ter offset 2404 size 4096
> [ 8831.360032] Register r9 information: non-paged memory
> [ 8831.365243] Register r10 information: slab pde_opener start c1572f18 p=
oi
> nter offset 0 size 24
> [ 8831.374137] Register r11 information: non-slab/vmalloc memory
> [ 8831.380041] Register r12 information: NULL pointer
> [ 8831.385140] Process mount (pid: 1142, stack limit =3D 0xb9d2bb39)
> [ 8831.391215] Stack: (0xc974dd78 to 0xc974e000)
> [ 8831.395884] dd60:                                                     =
  000ad578 000ae5bc
> [ 8831.404242] dd80: 000ad578 000ad578 c2849dec c2805e00 c1620208 c2849de=
c 00000000 c021130d
> [ 8831.412762] dda0: c1572d50 00000694 0000069c 00000036 00010000 c293775=
5 00000000 20061985
> [ 8831.421280] ddc0: 0000069c 00000000 c2849964 c2805e00 c1620208 c284996=
4 0000069c 00000008
> [ 8831.429799] dde0: 00000000 c2849ff8 c2849000 c020c40b c09c6a5c c974de3=
4 c974de30 00000000
> [ 8831.438154] de00: 00000004 0000069c 00001000 c2937bc0 00000208 c162000=
0 00000000 000a0000
> [ 8831.446665] de20: 00000000 00000000 0000000a 00070000 c2849000 0000000=
0 00001000 00000000
> [ 8831.455184] de40: 00000000 00000000 00010000 c2805e00 00000000 0000000=
0 00200000 c2937e00
> [ 8831.463704] de60: 00000000 00008000 c0975a98 c020e02d c1001300 0000020=
0 c020f3eb 00000dc0
> [ 8831.472062] de80: c2937e00 00000000 c020f3eb c2805e00 c156fc80 c29b940=
0 00200000 c2937e00
> [ 8831.480584] dea0: 00000000 c020f42d c29b9400 c156fc80 c09c6a64 c29b940=
0 c1298c00 c156fc80
> [ 8831.489100] dec0: c020f5c9 c02a853d 0000003a 00000000 c156fc80 c020f5c=
9 c974df58 c02a85ff
> [ 8831.497458] dee0: c156fc80 c020f5c9 00000000 c020f5bf c156fc80 c156fc8=
0 00000020 c016fdc3
> [ 8831.505976] df00: c156fc80 00000000 c1374780 c0115c75 00000000 0000000=
0 c156fc80 c0182209
> [ 8831.514497] df20: c2937e00 c974df58 c2937f80 00000000 c2937e00 c2937f8=
0 00008000 00000000
> [ 8831.523015] df40: 0006d71a 00008000 00068991 c0182307 00000000 c015048=
b c1360d90 c18b3a18
> [ 8831.531370] df60: 00001000 c2937f80 c2937e00 00000000 00000015 c018253=
9 00000000 0006d71a
> [ 8831.539881] df80: 0006d725 00000000 0006d70c 0006d71a 00000015 c010023=
c c1374780 00000015
> [ 8831.548399] dfa0: 00068991 c0100041 00000000 0006d70c 0006d70c 0006d71=
a 0006d725 00008000
> [ 8831.556908] dfc0: 00000000 0006d70c 0006d71a 00000015 00008000 0000000=
0 0006d938 00068991
> [ 8831.565263] dfe0: b6ea606c beb82b9c 00039818 b6ea607c a0000010 0006d70=
c 00000000 00000000
> [ 8831.573779]  jffs2_link_node_ref from jffs2_sum_scan_sumnode+0x1a5/0x3=
20
> [ 8831.580860]  jffs2_sum_scan_sumnode from jffs2_scan_medium+0x2d7/0xab0
> [ 8831.587595]  jffs2_scan_medium from jffs2_do_mount_fs+0xeb/0x356
> [ 8831.593958]  jffs2_do_mount_fs from jffs2_do_fill_super+0xf7/0x182
> [ 8831.600332]  jffs2_do_fill_super from mtd_get_sb+0x61/0x98
> [ 8831.606176]  mtd_get_sb from get_tree_mtd+0x4f/0xe8
> [ 8831.611241]  get_tree_mtd from vfs_get_tree+0x13/0x7c
> [ 8831.616648]  vfs_get_tree from path_mount+0x409/0x4d4
> [ 8831.621891]  path_mount from do_mount+0x33/0x40
> [ 8831.626593]  do_mount from sys_mount+0xeb/0xfe
> [ 8831.631367]  sys_mount from ret_fast_syscall+0x1/0x5c
> [ 8831.636591] Exception stack(0xc974dfa8 to 0xc974dff0)
> [ 8831.641961] dfa0:                   00000000 0006d70c 0006d70c 0006d71=
a 0006d725 00008000
> [ 8831.650314] dfc0: 00000000 0006d70c 0006d71a 00000015 00008000 0000000=
0 0006d938 00068991
> [ 8831.658818] dfe0: b6ea606c beb82b9c 00039818 b6ea607c
> [ 8831.664195] Code: 6a63 b085 990a b903 (de02) 6ae5
> [ 8831.669135] ---[ end trace 0000000000000000 ]---
> [ 8831.673902] Kernel panic - not syncing: Fatal exception
>=20
> The previous aborted I/Os from a dd may also play a role here but the cra=
sh
>  is
> clearly a cause of the interrupted transfers. It's a bit odd that it is an
> undefined instruction but probably it was a stack overflow.
>=20
> Looking back in the SPI driver history I see some occasions where interru=
pt
> ible
> transfers were changed to non-interruptible transfers because filesystems=
 l
> ike
> jffs2 used SIGKILL during unmount or maybe other reasons:
>=20
> 775c4c0032c4 "spi: stm32-qspi: remove signal sensitive on completion"
> 26cfc0dbe43a "spi-zynq-qspi: use wait_for_completion_timeout to make zynq=
_q
> spi_exec_mem_op not interruptible"
> 7f3ac71ac3b0 "spi: davinci: fix spurious i/o error"
>=20
> Having them in spi-atmel now seems a bit off and even a source of misbeha=
vi
> our
> and even crashes.

It's not just spi-atmel, any spi-mem controller might be tempted to use
interruptible^Wkillable transfers just because the timeout values can
be really big as the memory sizes increase.

One solution is to change the completion helpers back to something
non-killable/non-interruptible, but the user experience will be
slightly degraded. The other would be to look into jffs2 (if it's the
only filesystem playing with signals during unmount, tbh I don't know).
But maybe this signaling mechanism can't be hacked for compatibility
reasons. Handling this at the spi level would be a mix of layers, I'm
not ready for that.

Richard, Mark, what's your opinion here?

Thanks,
Miqu=C3=A8l

