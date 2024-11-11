Return-Path: <linux-spi+bounces-5670-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505979C40C7
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 15:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA33B20BB6
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B901A0B12;
	Mon, 11 Nov 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAwkcDFS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEEB15A85A;
	Mon, 11 Nov 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334899; cv=none; b=L7I545BRK4iQ3k9yp02AfH4YOZCfXifb49P+dgZLIPYrGdqa4PYjG8rJSD67r8m5LSqejPoXsd9ZYDYQCgfMmSuM83vKb/qwKWxyGKphNfSH2OejoIDm7QORhbgfLOb3Tw0n/LleNmcdXOg4LUcMssoEPb6Rbry7cDWT+neDwhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334899; c=relaxed/simple;
	bh=8gFxrMF3/Wvj4TqvD2naF6Bn2LPzxX0evtSWpelx57o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MZm5vPeR2FXe1WRlDjsT55naZoXCjtwmnsYB5xN9I7cGdpBM4prxg9Wfct4Fmdlwu0Lip3B9+5EZ5F2K2HM97/5N8uiitZf9oyPrSIUUmVBOenVTRYJKo7X9vxO3RjPdnrZzQpT9DdipRwVQEy8NdVUf7St5VSGvY0miQuXDDnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAwkcDFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB4FC4CECF;
	Mon, 11 Nov 2024 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731334899;
	bh=8gFxrMF3/Wvj4TqvD2naF6Bn2LPzxX0evtSWpelx57o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PAwkcDFS4zG83uPaMR3lA8iyrQEuEuKGTHmWCDGKtBlargPulzfKSXlkRRZ9CUxO7
	 nx2UlHXMO3N/ymPiLop8R1fVzqeIpDLhsg2qW14WDG1wTVxFXGcK+0N1xch4HqZjgb
	 pv9bFgphwOcYJPE20wuqYXhFFJwB2O4e89RXG/tx/zWo3i7+PS6s4ZtNQtThpgXpBT
	 8a6yMZBb7598uB0p8BRrDR5Y7hN/2+vzWqrgA5Ea7rXVIeZHPQMWaJ94c8uB6lrlqI
	 6J+XAtinEorEYFUvuOdWWVNCTY9De8SlmA66BxlXQXgIO1Gjco69cQWT3OZdRmeDB9
	 rIRTWdz5Rekbg==
From: Mark Brown <broonie@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20241111065425.103645-1-jiapeng.chong@linux.alibaba.com>
References: <20241111065425.103645-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH -next] spi: apple: Remove unnecessary .owner for
 apple_spi_driver
Message-Id: <173133489800.303244.15265150821669602652.b4-ty@kernel.org>
Date: Mon, 11 Nov 2024 14:21:38 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Mon, 11 Nov 2024 14:54:25 +0800, Jiapeng Chong wrote:
> Remove .owner field if calls are used which set it automatically.
> 
> ./drivers/spi/spi-apple.c:522:3-8: No need to set .owner here. The core will do it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: apple: Remove unnecessary .owner for apple_spi_driver
      commit: c6d0529fb70c14e3ea67ac70211ed4359bbac99d

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


