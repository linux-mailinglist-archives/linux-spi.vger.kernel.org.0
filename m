Return-Path: <linux-spi+bounces-6092-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470C09F562A
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 19:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC687A3DC7
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 18:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AF31F8AC5;
	Tue, 17 Dec 2024 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d94QNl2G"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA1B1EE02E;
	Tue, 17 Dec 2024 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460066; cv=none; b=uctuATebiCXa1Qs4kie94/v6vw/m3sif712CTzMdBwiFmEqB5LnjfmR0GQtBSwf02B1PwjPxY2W49Khnc7bjGivJ1yNN+eF+SX9AhQeKshMym1IxSkaCWdZpui3BtNr0kRQ37TTCh61rb1c792Edrwo8ZxUq6cf+wbzN6RTgqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460066; c=relaxed/simple;
	bh=UYa+EF3kXhd1zp5dnzEwlfquwsdv11U4gxiAcD7Xv5c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jVDaIZLQQrkqYNxb897lO5dkEJocXpH/ucgy+TkaTA5XjMDj2e56SwjVdsMRAHsGczb+y2bSIKb13vC9s3rb6PhuB3oki6E/M028WJivX5POQ27psw1XKMxDS95h5yi1bDa+ccQBGF4x8Y4GglL4fUKGD6zBKw1yWfdH2n8roLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d94QNl2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0529AC4CED7;
	Tue, 17 Dec 2024 18:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734460066;
	bh=UYa+EF3kXhd1zp5dnzEwlfquwsdv11U4gxiAcD7Xv5c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d94QNl2GcfWCNjdQoJ2jKMxFSXRfrHRO2SPU7Cn7uzYt0mlGNSK4UQm80xdljgI8r
	 S35e5Nsj3Ybm6UqeOxblQqd8ADbBoPBuj6lxKArbVDXxHfrdzXN7wtiwp/i0wBzww4
	 2atnF94FQfQ2WQLrgXUA3RSZuAAkx+HdFDKUX4s0OgbCpmGKh3zNv2C5HFBsfzlzSg
	 iHx7lYkpkeg1b9qj2NfbxoT2JXKUoj914dHyd2OttVRCBz7tBfdV0MHbKXR4LSJKRx
	 3aTv9grpkCL2UGc7d7kIbdXFpp8usv090NmIrmnTk/7P7dY4ZL+6idrXOnAC1mhW6Q
	 v2AUzq7xJOY7w==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cs=C3=B3k=C3=A1s=2C_Bence?= <csokas.bence@prolan.hu>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241128174316.3209354-1-csokas.bence@prolan.hu>
References: <20241128174316.3209354-1-csokas.bence@prolan.hu>
Subject: Re: [PATCH v3 0/2] spi: atmel-quadspi: Refactor to allow
 supporting SAMA7G5 O/QSPI
Message-Id: <173446006475.142278.5557207366372183006.b4-ty@kernel.org>
Date: Tue, 17 Dec 2024 18:27:44 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 28 Nov 2024 18:43:13 +0100, Csókás, Bence wrote:
> This is based on Tudor Ambarus' submission from 2021, and my refactor
> of said sumbission from roughly a month ago.
> Link: https://lore.kernel.org/linux-spi/20211214133404.121739-1-tudor.ambarus@microchip.com/
> Link: https://lore.kernel.org/linux-spi/20241030084445.2438750-1-csokas.bence@prolan.hu/
> 
> This time, I submit both my refactor and the diff between it and the
> original submission, rebased on top of Linus' master, namely:
> commit 7d4050728c83 ("Merge tag 'vfs-6.13-rc1.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer SoC families
      commit: c0a0203cf57963792d59b3e4317a1d07b73df42a
[2/2] spi: atmel-quadspi: Add support for sama7g5 QSPI
      commit: 5af42209a4d23adc9a09e59e586d1b47fef3cc86

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


