Return-Path: <linux-spi+bounces-8314-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B925AC5307
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 18:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941551BA3286
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 16:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE1527CB35;
	Tue, 27 May 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlNYqNDO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566222CCC0;
	Tue, 27 May 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748363456; cv=none; b=n6Mu/hcHeD6tHQTK1I+hNfnYpYr+GNnD2lcUC0KvbyFiTRSrMky/mb3sUXSzJ9258msIFGmWpGJm49HPS8ZJ4LtjzHkZUAwfdPbTSnVAkDOsWoEGOHmg8e1JbgrNio529sWZbHOIBVfGp3Jv9XRndBpge0gwIOHzOv9FPyWGYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748363456; c=relaxed/simple;
	bh=GuhC62725B74CDQxC/yoRR13F77zMV2WzAptKnXrRbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f+Heec+KwqLeaO2TKO6TFwtk1SysPXu5hFLUQncc0ZhSNqYrN/3rABR+wsx2bQpdXyFvxuoeWhzmjvv6fD2kjQIxyb0uhQylR9AKXEOhCKJwp3jT8/FJz4VK6Vq/1z6uT6kQkTjP4ss0uc0xZrYgMRgqjcHOYTDPSd2xn9/JszU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlNYqNDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DFFC4CEE9;
	Tue, 27 May 2025 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748363455;
	bh=GuhC62725B74CDQxC/yoRR13F77zMV2WzAptKnXrRbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PlNYqNDOtOmMCyy3kUWVdLbu14efKch6HwKNvabIXOn3tGCFNL63UmKUlPWIqfSo1
	 v/5Orf9OqD06ZD+KI5ruCMAcIwaFubWzmKsdYQfslCs5naZZPvcg3DuOsJviNiexUH
	 VifC6ecM71J4rE45zvm78hpYSmOQ4yGW87MvipcQnmQ+kaYDN2Eohea0QrGJvdqWbI
	 mTzqtjzSR7lbWQ2eLdsvRTQdfzETGN9eiVqJMTJhdl4ymC/mO9FD01pJiKcYEz2r9H
	 98Ia7W3Zth5F2x6leXQbLg5zLzdggEoEPlqahdjkFS5j9UpGBX7f3ZJl5ra4q6/MJr
	 KSWOaj5ldUpvA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Pratyush Yadav <pratyush@kernel.org>,  Miquel
 Raynal <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Chen Wang
 <unicorn_wang@outlook.com>,  Inochi Amaoto <inochiama@gmail.com>,  Mark
 Brown <broonie@kernel.org>,  Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Paul
 Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,
  Longbin Li <looong.bin@gmail.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  sophgo@lists.linux.dev,
  linux-spi@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-riscv@lists.infradead.org,  dlan@gentoo.org,  ziyao@disroot.org
Subject: Re: [PATCH 2/3] mtd: spi-nor: Add GD25LB512ME GigaDevice flash_info
In-Reply-To: <aDCf84cRw0tmcAbm@calculate>
References: <20250523-sfg-spifmc-v1-0-4cf16cf3fd2a@gmail.com>
	<20250523-sfg-spifmc-v1-2-4cf16cf3fd2a@gmail.com>
	<DA3HXNN7HTD2.2NUKORU5V6CS2@kernel.org> <aDCf84cRw0tmcAbm@calculate>
Date: Tue, 27 May 2025 18:30:51 +0200
Message-ID: <mafs0msayrp6s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, May 24 2025, Zixian Zeng wrote:

> Hi, Michael, Thank you for your reviews.
>
> On Fri, May 23, 2025 at 01:16:50PM +0200, Michael Walle wrote:
>> Hi,
>> 
>> > Add GD25LB512ME SPI-NOR flash information
>> 
>> Please have a look at [1].
>> 
>> This flash supports SFDP, do you really need a new entry in the
>> flashdb? Could you try without it?
>> 
>> In any case, could you please dump the SFDP see [1], too.
>> 
>> [1] https://docs.kernel.org/driver-api/mtd/spi-nor.html
>> 
>> -michael
>
> I was following the testing requirements from [1].
> Before that, I have applied the patch:
> "mtd: spi-nor: Add GD25LB512ME GigaDevice flash_info"
> Because without this patch, the spi-nor device cannot be detected normally.
>
> ------------------------------- LOG ------------------------------------
> root@localhost ~ # dmesg | grep -i spi
> [   10.199526] spi-nor spi0.0: supply vcc not found, using dummy regulator
> [   11.206477] spi-nor spi0.0: unrecognized JEDEC id bytes: c8 67 1a ff c8 67
> [   11.213691] spi-nor spi1.0: supply vcc not found, using dummy regulator
> [   12.220614] spi-nor spi1.0: unrecognized JEDEC id bytes: c8 67 1a ff c8 67

The flash seems to have a valid SFDP but for some reason
spi_nor_check_sfdp_signature() is not able to validate it to allow the
generic driver. Can you please take a look at why? Ideally the generic
driver should be enough and you shouldn't need to add an entry unless
something is wrong with SFDP data.

-- 
Regards,
Pratyush Yadav

