Return-Path: <linux-spi+bounces-9173-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BDDB10D32
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 16:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B6C1D01054
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 14:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFE318BBB9;
	Thu, 24 Jul 2025 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3JVEYNG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF8B2DFF13;
	Thu, 24 Jul 2025 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366495; cv=none; b=duQKnRo4auqxirlre9W4ybzxbyF5FDqP0HN93IFwLW5N1wEneqdkdknN0t8Hu/3YMxfU73qT9CE463wWVClDRfgjQC8jfS49JqotHq9VBmFXKPJ96Wb0TN6wXLLy242NsvEMvvS/YQwFfgrAfmi72tbXr+z4ZfwchszHH8vtSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366495; c=relaxed/simple;
	bh=UkVnxCdj3CGx7NXjhOgRQm4CT95kUOfUb/Cgzs2KLJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iGhEfyD/dOVlY54lQ7OMpfbWDJEzigFOczkjqEZx+HkRv4E0/hLcudA2W/5bgpISF2BBfLiyYRSVzwRS/rD3NtF3UtGkbD9XRd9lgEnxlWI3KPfbNzW59dbYILpVoa/04fomQtbaCBrnSpHJGDZOpAe/mmGI89ZOdBX+yp4HNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3JVEYNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36F3C4CEEF;
	Thu, 24 Jul 2025 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753366494;
	bh=UkVnxCdj3CGx7NXjhOgRQm4CT95kUOfUb/Cgzs2KLJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=k3JVEYNG3/6jue5hrisKmNUTMqKq5YurSHi0GIR+B81vmpblYHxT/wQ8utx/CrlQe
	 vij1Zx7Ibn9v3Naf0GvIIERSXm8zyxQgfrHI5rGYtbM6ZW6PHlr3/vJqTI6YcyWZXT
	 w07LVH/Oqtmgjtm311PTiom8agHaoN019GxVYJTuVrYEiy9ip1Gz0VvlSe0HZ0MnMI
	 SwW7fpPzbLl9iKURWzIklbGmjjMO06q8yGOy0RXgiODj8vpRhWCyULV02hTvSNpOxM
	 OBe7g/b8esR9C9wTj4veFug9PsgzCpyTF1evIys1GYmQ3JlA/oCMtDwSfewf0/BtFU
	 gnV5JADsCeyKA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Luke Wang <ziniu.wang_1@nxp.com>
Cc: Bough Chen <haibo.chen@nxp.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Miquel Raynal <miquel.raynal@bootlin.com>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  "broonie@kernel.org" <broonie@kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
  "michael@walle.cc" <michael@walle.cc>,  "p.yadav@ti.com"
 <p.yadav@ti.com>,  "richard@nod.at" <richard@nod.at>,  "vigneshr@ti.com"
 <vigneshr@ti.com>,  Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH v2 6/6] mtd: spi-nor: core: avoid odd length/address
 writes in 8D-8D-8D mode
In-Reply-To: <DU2PR04MB8567950B89B1F4F1F97FCD43ED41A@DU2PR04MB8567.eurprd04.prod.outlook.com>
References: <DU2PR04MB85678048FE8B475B1E323E0AED802@DU2PR04MB8567.eurprd04.prod.outlook.com>
	<10b40148-b949-442d-9d43-0db09517269a@linaro.org>
	<mafs0zffo3gea.fsf@kernel.org> <87cycep8go.fsf@bootlin.com>
	<mafs0wmam6ukq.fsf@kernel.org>
	<DU0PR04MB9496B734F6BA84ABAE051D439097A@DU0PR04MB9496.eurprd04.prod.outlook.com>
	<DU2PR04MB8567950B89B1F4F1F97FCD43ED41A@DU2PR04MB8567.eurprd04.prod.outlook.com>
Date: Thu, 24 Jul 2025 16:14:51 +0200
Message-ID: <mafs0a54tsmjo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 01 2025, Luke Wang wrote:

>> > On Mon, May 12 2025, Miquel Raynal wrote:
>> >
>> > > Hello,
>> > >
>> > > On 07/05/2025 at 09:43:25 GMT, Pratyush Yadav <pratyush@kernel.org>
[...]
>> > >
>> > > The fact is that we will have octal DTR support in SPI NAND as well at
>> > > some point, hence a common solution would be welcome as we will likely
>> > > face similar problems when performing these unaligned accesses. I
>> > > don't know how feasible it is yet, but if we have a fix for SPI NOR,
>> > > we will need something similar for SPI NAND.
[...]
>
> Sorry for delayed response.
>
> After reviewing the SPI NAND driver, I noticed that the addr and len
> alignment has already been implemented in spinand_read_from_cache_op()
> and spinand_write_to_cache_op() functions.

Right. I took a very quick look as well and it seems that SPI NAND only
does page sized reads and writes in spinand_write_to_cache_op() and
spinand_read_from_cache_op(). So it should not be a problem.

Miquel, Luke sent a respin [0] for fixing this in SPI NOR and I need to
decide if I should take them or push for a more generic fix. Did I miss
some place where SPI NAND can do odd-length reads or writes? If not, I'd
rather just take the respinned patches.

>
> Additionally, using 0xff padding in spi_mem_dirmap_write() might not
> be suitable for non-flash memory devices.

NAND also seems to be using 0xff though. From spinand_write_to_cache_op():

	nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
	memset(spinand->databuf, 0xff, nanddev_page_size(nand));

Anyway, if needed we can solve that with a field in struct
spi_mem_dirmap_info I guess.

[0] https://lore.kernel.org/linux-mtd/20250708091646.292-1-ziniu.wang_1@nxp.com/T/#u

-- 
Regards,
Pratyush Yadav

