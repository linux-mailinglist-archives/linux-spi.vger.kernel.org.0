Return-Path: <linux-spi+bounces-5638-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E89BF2EB
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 17:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7751C241EF
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9E92036ED;
	Wed,  6 Nov 2024 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GxJBm5uK"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1777189F5C;
	Wed,  6 Nov 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909551; cv=none; b=V1+mFCGVvHEUs/brkrpSpm1x9hnni4cze8zpJckoxzO2xLoT31QOak3j/Z+djG1fS+h3q07UCdUAcK6iKLmDi+w/h8+QdMfj7OTN36XHFGZx0IpwjDSlb6haftbTnO3V3IFZjrtwQ9sK+aMU7kdYNZRL+Wmh85FqYiHsLYTz1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909551; c=relaxed/simple;
	bh=VbHI5Go0cQBSJCMa+bDHACq+Jn9qnFhUWYRTLUOXoVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oaK48ANPSESvGcbsASloh/sDcnBJvJgkXWU391wRA+uDd/4VWRSkMNAX2RtrUWh370AhnOMyxaXQZWKowoZNV7wL7AlNGBYwv9KaLON6b2nxLEeeABy/Q515EXYTz+CmB6C/mYLAgZjsgy/cZlLhKt47OPmJaTM9lE9NU68Oryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GxJBm5uK; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14A4460005;
	Wed,  6 Nov 2024 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730909547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbHI5Go0cQBSJCMa+bDHACq+Jn9qnFhUWYRTLUOXoVM=;
	b=GxJBm5uK5iksWp7N5LSPUfKZcCq+hGLQvJgj5t1P2JVy4Bkmx87ijVSBNs73xqrlw4doKf
	VSqvn7RqIYTtmxvRmD98Hfw6H+KMSk4c5yrOlfis1CVrkEG6g9hPkmZoVVOiSLTt2oOsnm
	0yOEKtKYJz2VNCxIVRpqdFGmiFJQxRXiZHAtSILlcLFi9c7QuRgAYR9dFKSTEiZrOJIAcT
	EEJ47hUjsaPtDDqorT5ZP5N6ueVAyBMtKWxG+7gCGIYrAS9twFTRRMxaiDgCmr3edZg58O
	gWKKSbbml3TUiOpMrXVIBufUmGBDgOsS8XASWpKON4ibGpA6G5ZLL0RLYLD4yQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
  "broonie@kernel.org" <broonie@kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ubifs_recover_master_node: failed to recover master node
In-Reply-To: <94ffb58b-3242-4ab4-b09a-686116ced781@alliedtelesis.co.nz> (Chris
	Packham's message of "Wed, 30 Oct 2024 10:13:45 +1300")
References: <826c4456-461c-424b-88de-a36e77fd7475@alliedtelesis.co.nz>
	<94ffb58b-3242-4ab4-b09a-686116ced781@alliedtelesis.co.nz>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 06 Nov 2024 17:12:26 +0100
Message-ID: <87ses4ibo5.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com


Hi Chris,

On 30/10/2024 at 10:13:45 +13, Chris Packham <chris.packham@alliedtelesis.c=
o.nz> wrote:

> On 29/10/24 13:38, Chris Packham wrote:
>> (resend as plaintext)
>>
>> Hi,
>>
>> I recently added support for the SPI-NAND controller on the RTL9302C
>> SoC[1]. I did most of the work against Linux 6.11 and it's working
>> fine there. I recently rebased against the tip of Linus's tree
>> (6.12-rc5) and found I was getting ubifs errors when mounting:
>>
>> [=C2=A0=C2=A0=C2=A0 1.255191] spi-nand spi1.0: Macronix SPI NAND was fou=
nd.
>> [=C2=A0=C2=A0=C2=A0 1.261283] spi-nand spi1.0: 256 MiB, block size: 128 =
KiB, page
>> size: 2048, OOB size: 64
>> [=C2=A0=C2=A0=C2=A0 1.271134] 2 fixed-partitions partitions found on MTD=
 device spi1.0
>> [=C2=A0=C2=A0=C2=A0 1.278247] Creating 2 MTD partitions on "spi1.0":
>> [=C2=A0=C2=A0=C2=A0 1.283631] 0x000000000000-0x00000f000000 : "user"
>> [=C2=A0=C2=A0 20.481108] 0x00000f000000-0x000010000000 : "Reserved"
>> [=C2=A0=C2=A0 72.240347] ubi0: scanning is finished
>> [=C2=A0=C2=A0 72.270577] ubi0: attached mtd3 (name "user", size 240 MiB)
>> [=C2=A0=C2=A0 72.276815] ubi0: PEB size: 131072 bytes (128 KiB), LEB siz=
e:
>> 126976 bytes
>> [=C2=A0=C2=A0 72.284537] ubi0: min./max. I/O unit sizes: 2048/2048, sub-=
page
>> size 2048
>> [=C2=A0=C2=A0 72.292132] ubi0: VID header offset: 2048 (aligned 2048), d=
ata
>> offset: 4096
>> [=C2=A0=C2=A0 72.299885] ubi0: good PEBs: 1920, bad PEBs: 0, corrupted P=
EBs: 0
>> [=C2=A0=C2=A0 72.306689] ubi0: user volume: 1, internal volumes: 1, max.=
 volumes
>> count: 128
>> [=C2=A0=C2=A0 72.314747] ubi0: max/mean erase counter: 1/0, WL threshold=
: 4096,
>> image sequence number: 252642230
>> [=C2=A0=C2=A0 72.324850] ubi0: available PEBs: 0, total reserved PEBs: 1=
920,
>> PEBs reserved for bad PEB handling: 40
>> [=C2=A0=C2=A0 72.370123] ubi0: background thread "ubi_bgt0d" started, PI=
D 141
>> [=C2=A0=C2=A0 72.470740] UBIFS (ubi0:0): Mounting in unauthenticated mode
>> [=C2=A0=C2=A0 72.490246] UBIFS (ubi0:0): background thread "ubifs_bgt0_0"
>> started, PID 144
>> [=C2=A0=C2=A0 72.528272] UBIFS error (ubi0:0 pid 143):
>> ubifs_recover_master_node: failed to recover master node
>> [=C2=A0=C2=A0 72.550122] UBIFS (ubi0:0): background thread "ubifs_bgt0_0=
" stops
>> [=C2=A0=C2=A0 72.710720] UBIFS (ubi0:0): Mounting in unauthenticated mode
>> [=C2=A0=C2=A0 72.717447] UBIFS (ubi0:0): background thread "ubifs_bgt0_0"
>> started, PID 149
>> [=C2=A0=C2=A0 72.777602] UBIFS error (ubi0:0 pid 148):
>> ubifs_recover_master_node: failed to recover master node
>> [=C2=A0=C2=A0 72.787792] UBIFS (ubi0:0): background thread "ubifs_bgt0_0=
" stops
>>
>> Full dmesg output is at[2]
>>
>> git bisect lead me to commit 11813857864f ("mtd: spi-nand: macronix:
>> Continuous read support"). Reverting the blamed commit from 6.12-rc5
>> seems to avoid the problem. The flash chip on my board is a
>> MX30LF2G28AD-TI. I'm not sure if there is a problem with 11813857864f
>> or with my spi-mem driver that is exposed after support for continuous
>> read is enabled.
>>
> A bit of an update. The ubifs failure is from the is_empty() check in
> get_master_node(). It looks like portions of the LEB are 0 instead of
> 0xff. I've also found if I avoid use the non-DMA path in my driver I
> don't have such a problem. I think there is at least one problem in my
> driver because I don't handle DMAing more than 0xffff bytes.

I am going through my mails in a chronological order :-)

Glad to see you found a lead. I was already a bit suspicious about the
DMA path, glad to see we might narrow down the problem.

Is the 0xffff limitation a hard constraint or is it just a pure software
constraint? If we reach a hard constraint, maybe you should check that
when you decide which path you take.

Miqu=C3=A8l

