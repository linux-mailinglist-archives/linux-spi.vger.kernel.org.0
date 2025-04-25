Return-Path: <linux-spi+bounces-7760-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDF9A9CDB4
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 18:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42E34C60E4
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 16:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D975E18A6A9;
	Fri, 25 Apr 2025 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp/o8stG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2C2701DA;
	Fri, 25 Apr 2025 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597022; cv=none; b=fFkmPW1X8tDmHoK8JqLfx7XaTEiur8x29wBc0Uuiw/VboVYOMDA85ldDWTDcz5CVpg1+LfWFzKbejmWpmJBt4AyQpHEZMnBAB5VQdpssX/VyIm7lrUoqQyfBYsPmC2AVvUQrXKSMh8GHCY1aFgRxDUX/lQVFJp1Bb+9LxMI6gfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597022; c=relaxed/simple;
	bh=pgHM0pQQh/AnS0sjVOOQG8XMAzr1ppzquqp9PxwxD9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uqFuLkZ5j3YXl0YGL3agy1Bqid8JajRBjcs+2rINOq8SPhPaF0xghA5Qp3DhPaevOoZ/4weNG3bzK+1TL1Hsn+tJPQXY9LuW+txfudm1FkbMUdpn7mBx7twpPaE2GoyTG0/1BZUW0gbelpXUacbwR77mKNksQLpsWwG1vfbLKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp/o8stG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27DAC4CEE8;
	Fri, 25 Apr 2025 16:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745597020;
	bh=pgHM0pQQh/AnS0sjVOOQG8XMAzr1ppzquqp9PxwxD9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Xp/o8stGuvZrxmfHGzPdB4Xhb057kr4y8ixeKPp5waTpTb6DQCI794+GkW9NVUgst
	 W/nl+r0HEWnxzfGt5zNexY7I8sEhTqXdB8qkZYz41pKchjHrWc/OnJuJSa8S7kg9Eb
	 zoKDjAXwBdM9M22LEzttByIaREl4nRUhAOcN3HJ0EREYuJf+Q4ltJ5CDm2WnJcPmSc
	 uPcvkmYEklwSEFuoAlsL8puQU/ZT7Zanvmm7gb96r7M8Ee1zqXkhBS5nHMUzNKGPqy
	 dczmIj4Gmwqgi1vcrIORXa2zwErqWA4gp0PsOZo3kR6ZaOe4MTDFpuICYmkw6XzWw6
	 llpuBSMXB9YSg==
From: Mark Brown <broonie@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 miquel.raynal@bootlin.com, Krishnamoorthi M <krishnamoorthi.m@amd.com>, 
 Akshata MukundShetty <akshata.mukundshetty@amd.com>
In-Reply-To: <20250424121333.417372-1-Raju.Rangoju@amd.com>
References: <20250424121333.417372-1-Raju.Rangoju@amd.com>
Subject: Re: [PATCH] spi: spi-mem: Add fix to avoid divide error
Message-Id: <174559701872.197127.17635970599658123215.b4-ty@kernel.org>
Date: Fri, 25 Apr 2025 17:03:38 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 24 Apr 2025 17:43:33 +0530, Raju Rangoju wrote:
> For some SPI flash memory operations, dummy bytes are not mandatory. For
> example, in Winbond SPINAND flash memory devices, the `write_cache` and
> `update_cache` operation variants have zero dummy bytes. Calculating the
> duration for SPI memory operations with zero dummy bytes causes
> a divide error when `ncycles` is calculated in the
> spi_mem_calc_op_duration().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mem: Add fix to avoid divide error
      commit: 8e4d3d8a5e51e07bd0d6cdd81b5e4af79f796927

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


