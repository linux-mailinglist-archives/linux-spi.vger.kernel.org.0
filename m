Return-Path: <linux-spi+bounces-8075-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B075AB32FE
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 11:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12104179460
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 09:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3468325C814;
	Mon, 12 May 2025 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDUqrjR+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6425B68E;
	Mon, 12 May 2025 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041634; cv=none; b=u0zuwGlFFjcMGPJUEHDjxHcbJ1dzI3tl857fgWmD70jHgYM2FkrrtGIfGXYfARsXVUPaTwgpLE4QTMh9kKOH44bWeCq3lwspEqIbYBAuruUy+IV7yaodw/1T1FlRpqOzZBkVUKoA8Kxh6PKd03tO/sULPBhU6gcfDrsK3oT81PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041634; c=relaxed/simple;
	bh=iXPNXOwECHF6vzmv4N3t7dpHwXal1mkPGC6CEteuntI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TmWNsJ/ZVSWW/cimEJ1SQqMGc3TTbczFGhUj0zedYAJL/PcjLOOQ64JpcBOgG9F6Y6vxpljsBZR4qZRO+uoycAh9htrJ+vd5P2kiJe2fFdfZ421JA4JsA7jWnlKy0BPjGpwg8l3AWsXlI9jgxSRFpLmBrzWRlfe6xFYtWTfLCOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDUqrjR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FEDC4CEE7;
	Mon, 12 May 2025 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747041633;
	bh=iXPNXOwECHF6vzmv4N3t7dpHwXal1mkPGC6CEteuntI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nDUqrjR+3krhDJ5Ew/pgFcib4HULQgxv4dAlZInqyhQuuxUJBdkpuer4jT/99Wvms
	 KeN2hLfi7CWsgMmXuelniYaUvQ7HplFyye9CGeYTj1qjgNT/cqDlI6U6tAu1gyPNlj
	 r2aToEYKw/cggt+4zhuutClE+6TGoIzC/gLHwEixB+1tZI9dUXg1311tkCB3/6rsVH
	 pU3MsCb6MIoOlbkCRtLrIgZMF6hSJsTLeig1rwVD2mICsjQSBHRcovAXvoG5EHnE7S
	 bSiuynmX3XWP6EFYx0fne0Kq79PAsIOGGaOnd0If2dxi9cRv5xnIcl/hYjFlsUJ78o
	 4hTU5HRjTENXg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Tudor Ambarus <tudor.ambarus@linaro.org>,
  Pratyush Yadav <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  Miquel Raynal <miquel.raynal@bootlin.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,  Krzysztof
 Kozlowski <krzk@kernel.org>,  linux-spi@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] mtd: spi-nor: Add a driver for the VIA/WonderMedia
 serial flash controller
In-Reply-To: <20250510-wmt-sflash-v1-2-02a1ac6adf12@gmail.com>
References: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
	<20250510-wmt-sflash-v1-2-02a1ac6adf12@gmail.com>
Date: Mon, 12 May 2025 09:20:30 +0000
Message-ID: <mafs01psu89sx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Alexey,

On Sat, May 10 2025, Alexey Charkov wrote:

> The controller is tailored to SPI NOR flash memory and abstracts away all
> SPI communications behind a small set of MMIO registers and a physical
> memory mapping of the actual chip contents.
>
> It doesn't expose chip probing functions beyond reading the ID though, so
> use lower level chip opcodes via the "programmable command mode" of the
> controller and the kernel's SPI NOR framework to avoid hard-coding chip
> parameters for each ID the way the vendor kernel does it.
>
> Currently tested on a WonderMedia WM8950 SoC with a Macronix MX25L4005A
> flash chip (APC Rock board), but should work on all VIA/WonderMedia SoCs
>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  MAINTAINERS                                  |   1 +
>  drivers/mtd/spi-nor/controllers/Kconfig      |  14 +
>  drivers/mtd/spi-nor/controllers/Makefile     |   1 +
>  drivers/mtd/spi-nor/controllers/wmt-sflash.c | 525 +++++++++++++++++++++++++++

Drivers in drivers/mtd/spi-nor/controllers/ are deprecated, and we want
to eventually get rid of the API. The expected way is for drivers to use
SPI MEM (drivers/spi/spi-mem.c). SPI MEM drivers are usually more
general and not tailored specifically to SPI NOR flashes, so it might be
a bit tricky to write drivers for specialized hardware with it. But I
think the drivers/spi/spi-intel.c driver is written for similar kind of
hardware so it should be possible.
>
[...]

-- 
Regards,
Pratyush Yadav

