Return-Path: <linux-spi+bounces-5637-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C179BF1D2
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 16:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E242228446C
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344A720110E;
	Wed,  6 Nov 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fK/QW1FC"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F10A16CD29;
	Wed,  6 Nov 2024 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907345; cv=none; b=quZ4oykibC9amb1CfnHdgYIVdLm9FWdZpcp53ObjToXivT8Jq8iTXM371Y7lmRcWtEx7/LFjpv13D14qbHSXKLg+phuqVlRt034O9HHAYfvhewP9F3e2khxJDxdTn+KHkbd9bk7B1iH+3GVQeJcAmMyekjUuUH0v/3dtkMcmVfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907345; c=relaxed/simple;
	bh=7qHzpB3TG+C8tGAFsrcXsTV+YPrG0APq81/k9Dc8bHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jwH98cim8WdUuGfsXvFyjq717P4zfdcQTwvfPEXtS35Idd57Otr4djQQtzKTnL51u8W/a0uSaq6LnizaSzTOvBvfYsZjgQCtD4i6mUQV5XHmA4h0JLokrl5DBsv8jLxMCqBFnzEgiQDhu6J9Vd+89otAKd21dzAlpVbI8zlFW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fK/QW1FC; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A297B240007;
	Wed,  6 Nov 2024 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730907340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0O1DZej7ntn5vlTTkeOAaf/z20TWgE994IzTCP97PI=;
	b=fK/QW1FCogdbqrToYB8N3GWm4ZqL1Zprc0NhwciUGNy+i+X97EREKODC6FfqKFJBmRoU30
	u36cU4dfvTnv/uHDR8xke1mBANmSr7IDVVIR39I8AoTZhGkzuq5LptP7ovk58yDtaZddqH
	TIV2a0IbXGSg4mWVb5qT85gP95qAW9s/KdaNt2hqmW6axv9Szhr4srC8M+kHqrjr09xUiP
	Opvivl4D3bdn7CM4qNtcB47gL6CD/TX8EY+GL/xBmpQOfCguWnzP0X/N8uKqJAz3jqryL2
	EJYRwHNVhc3+ImBs1PU3YH20OhE5X2zVbLH8HfWMZqKBcM13KBci/mX1Dep2JQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ubifs_recover_master_node: failed to recover master node
In-Reply-To: <7eaf332e-9439-4d4c-a2ea-d963e41f44f2@alliedtelesis.co.nz> (Chris
	Packham's message of "Tue, 29 Oct 2024 13:37:31 +1300")
References: <7eaf332e-9439-4d4c-a2ea-d963e41f44f2@alliedtelesis.co.nz>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 06 Nov 2024 16:35:39 +0100
Message-ID: <87jzdgjrxw.fsf@bootlin.com>
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

On 29/10/2024 at 13:37:31 +13, Chris Packham <chris.packham@alliedtelesis.c=
o.nz> wrote:

> Hi,
>
> I recently added support for the SPI-NAND controller on the RTL9302C SoC[=
1]. I did most of the work against Linux 6.11
> and it's working fine there. I recently rebased against the tip of Linus'=
s tree (6.12-rc5) and found I was getting ubifs
> errors when mounting:
>
> [    1.255191] spi-nand spi1.0: Macronix SPI NAND was found.
> [    1.261283] spi-nand spi1.0: 256 MiB, block size: 128 KiB, page size: =
2048, OOB size: 64
> [    1.271134] 2 fixed-partitions partitions found on MTD device spi1.0
> [    1.278247] Creating 2 MTD partitions on "spi1.0":
> [    1.283631] 0x000000000000-0x00000f000000 : "user"
> [   20.481108] 0x00000f000000-0x000010000000 : "Reserved"
> [   72.240347] ubi0: scanning is finished
> [   72.270577] ubi0: attached mtd3 (name "user", size 240 MiB)
> [   72.276815] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 b=
ytes
> [   72.284537] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 2=
048
> [   72.292132] ubi0: VID header offset: 2048 (aligned 2048), data offset:=
 4096
> [   72.299885] ubi0: good PEBs: 1920, bad PEBs: 0, corrupted PEBs: 0
> [   72.306689] ubi0: user volume: 1, internal volumes: 1, max. volumes co=
unt: 128
> [   72.314747] ubi0: max/mean erase counter: 1/0, WL threshold: 4096, ima=
ge sequence number: 252642230
> [   72.324850] ubi0: available PEBs: 0, total reserved PEBs: 1920, PEBs r=
eserved for bad PEB handling: 40
> [   72.370123] ubi0: background thread "ubi_bgt0d" started, PID 141
> [   72.470740] UBIFS (ubi0:0): Mounting in unauthenticated mode
> [   72.490246] UBIFS (ubi0:0): background thread "ubifs_bgt0_0" started, =
PID 144
> [   72.528272] UBIFS error (ubi0:0 pid 143): ubifs_recover_master_node: f=
ailed to recover master node
> [   72.550122] UBIFS (ubi0:0): background thread "ubifs_bgt0_0" stops
> [   72.710720] UBIFS (ubi0:0): Mounting in unauthenticated mode
> [   72.717447] UBIFS (ubi0:0): background thread "ubifs_bgt0_0" started, =
PID 149
> [   72.777602] UBIFS error (ubi0:0 pid 148): ubifs_recover_master_node: f=
ailed to recover master node
> [   72.787792] UBIFS (ubi0:0): background thread "ubifs_bgt0_0" stops
>
> Full dmesg output is at[2]
>
> git bisect lead me to commit 11813857864f ("mtd: spi-nand: macronix: Cont=
inuous read support"). Reverting the blamed
> commit from 6.12-rc5 seems to avoid the problem. The flash chip on my boa=
rd is a MX30LF2G28AD-TI. I'm not sure if there
> is a problem with 11813857864f or with my spi-mem driver that is
> exposed after support for continuous read is enabled.

Crap. I had a look, and TBH I don't know. The only thing I see in your
driver might be the DMA vs PIO choice. Could you try to always return
false from rtl_snand_dma_op()?

However you say you're using an MX30* device, this is a raw NAND chip,
SPI-NAND chips are I believe starting with MX35* in their IDs, no?

Thanks,
Miqu=C3=A8l

