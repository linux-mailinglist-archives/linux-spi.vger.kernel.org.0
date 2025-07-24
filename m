Return-Path: <linux-spi+bounces-9172-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B489DB10C1C
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 15:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D78E1CE1FD7
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 13:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BC52D836E;
	Thu, 24 Jul 2025 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/rhJZXJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883DB18E025;
	Thu, 24 Jul 2025 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365072; cv=none; b=kQPZavjc+yy/nI4XvhUJoVv0m6q4c7xbIaQcep5cYcOhXbUBLNpYqEn8PN8NyrKVD6PXO21ejANDRF03hqP3tHeka1hpfYaucTAOK+cN8UwprPXXwOsp/rAzWE8TsZ0OBvuuD5IZ0Lsu/hbLyiwHC/aUPZCvDhGwn7D3rAiVkQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365072; c=relaxed/simple;
	bh=a5F5WdeNr+6UL1FTjKLm8yq2/Q45+2nnNzBSMbUAfjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hd7rRkyqGmd8mviwF9qh4f8w58rmxnVZaAJXro076xJsTqXXn/iiMjxcN1vvKpX/S1JwBBC/KY/ZN6QCiTne4GN18FuGiVsX2mFfIy6CsfupaIQTrFkWgrccCSEXz93EYhsVF4tTfkg7yC3ZV1VpxpP7vMo9CARcsjzA1ljuPJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/rhJZXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73387C4CEF5;
	Thu, 24 Jul 2025 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753365072;
	bh=a5F5WdeNr+6UL1FTjKLm8yq2/Q45+2nnNzBSMbUAfjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=p/rhJZXJPL+hUu5+jASgQUGlnPJUr1Xc29vibLZ8cNKZe01Mj5RN+KYj7LDB+xhJb
	 o/hSi4YULMPs3UbgtcGgxe/YDYUPUE8xO8HC5+Jmd0ahq+2sKqaMEivl3B75n/w2sQ
	 tJaL41C7P/tqlizhqTU9Uq/xra5sXzQCbNBMnnzr+UXC/Uw0f+7ppybFg/Ny7vEvC8
	 iRMRIWOpswAtwWBK926ekJULZhZcKmwdDTC/Sqteu2FiAd0MNEXULYbRqpCM8ANcGX
	 JP0Zv3NVzmYt9jbIeeGkxoajWjxhIStbkfPpciaPsAuweTqnEBCI7LztQrWQ6+Nd9/
	 VQf1lb2KCJLXQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mark Brown <broonie@kernel.org>,
  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Michael Walle <mwalle@kernel.org>,  Miquel
 Raynal <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Krzysztof Kozlowski
 <krzk@kernel.org>,  linux-spi@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] mtd: spi-nor: Add a driver for the VIA/WonderMedia
 serial flash controller
In-Reply-To: <CABjd4YyRScBgDbi8Sk0D3vxcmLF8+YBetUdkfhrS_4Y7M+gS1g@mail.gmail.com>
References: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
	<20250510-wmt-sflash-v1-2-02a1ac6adf12@gmail.com>
	<mafs01psu89sx.fsf@kernel.org>
	<CABjd4YyRScBgDbi8Sk0D3vxcmLF8+YBetUdkfhrS_4Y7M+gS1g@mail.gmail.com>
Date: Thu, 24 Jul 2025 15:51:08 +0200
Message-ID: <mafs0h5z1snn7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alexey,

This email got buried in my inbox somewhere...

On Mon, May 12 2025, Alexey Charkov wrote:

> Hi Pratyush,
>
> On Mon, May 12, 2025 at 1:20=E2=80=AFPM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
>>
>> Hi Alexey,
>>
>> On Sat, May 10 2025, Alexey Charkov wrote:
>>
>> > The controller is tailored to SPI NOR flash memory and abstracts away =
all
>> > SPI communications behind a small set of MMIO registers and a physical
>> > memory mapping of the actual chip contents.
>> >
>> > It doesn't expose chip probing functions beyond reading the ID though,=
 so
>> > use lower level chip opcodes via the "programmable command mode" of the
>> > controller and the kernel's SPI NOR framework to avoid hard-coding chip
>> > parameters for each ID the way the vendor kernel does it.
>> >
>> > Currently tested on a WonderMedia WM8950 SoC with a Macronix MX25L4005A
>> > flash chip (APC Rock board), but should work on all VIA/WonderMedia So=
Cs
>> >
>> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> > ---
>> >  MAINTAINERS                                  |   1 +
>> >  drivers/mtd/spi-nor/controllers/Kconfig      |  14 +
>> >  drivers/mtd/spi-nor/controllers/Makefile     |   1 +
>> >  drivers/mtd/spi-nor/controllers/wmt-sflash.c | 525 ++++++++++++++++++=
+++++++++
>>
>> Drivers in drivers/mtd/spi-nor/controllers/ are deprecated, and we want
>> to eventually get rid of the API. The expected way is for drivers to use
>> SPI MEM (drivers/spi/spi-mem.c). SPI MEM drivers are usually more
>> general and not tailored specifically to SPI NOR flashes, so it might be
>> a bit tricky to write drivers for specialized hardware with it. But I
>> think the drivers/spi/spi-intel.c driver is written for similar kind of
>> hardware so it should be possible.
>
> Oops. I've had a look at spi-mem, and it seems like it's not a
> particularly fitting abstraction for this controller.
>
> From what I understood, spi-mem primarily expects to be talking SPI
> opcodes to the controller, and for the controller/driver to bring
> their own chip probing routines. This controller on the other hand
> abstracts the opcodes away, and wants someone to tell it what its
> flash chip can do (the controller itself can only get a chip ID in
> "normal" mode, and it needs to somehow know the chip size and
> standard/fast read capability of the chip). So pretty much the
> opposite, huh.

Does it use SFDP to figure out which opcodes to use? Then it feels very
similar to intel-spi. See [0] for example. I know this is fitting a
square peg in a round hole, but if it isn't too painful then it would
make maintenance on SPI NOR end a bit easier.

Mika (+Cc), you did the conversion of intel-spi to SPI MEM. Maybe you
can share how painful/easy the conversion was, and if it ended up being
maintainable?

>
> In the end, I only need something like spi_nor_detect() and can do the
> rest directly on top of the MTD framework without touching any SPI
> opcodes after the detection is done. Is there any other non-deprecated
> framework that can provide something like this? Maybe physmap? It
> looks even older than SPI NOR though :)

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/spi/spi-intel.c#n905

--=20
Regards,
Pratyush Yadav

