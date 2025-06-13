Return-Path: <linux-spi+bounces-8546-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90868AD92D5
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 18:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094673B9B07
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37692E11DD;
	Fri, 13 Jun 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjye9jxe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F862E11B5;
	Fri, 13 Jun 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749832255; cv=none; b=PP+Oi5sbqyfNtSuLdilpx8dmsnJ/X7/riALrx3ntx/f8Zco4SQVOJEVbfYrq1pPmOed9YQ96m+GRhbehNIsyXDCyjVx3vzMaK/kvWC0vVX2VfzL8LqjZZ4Tyi411SEsMb4cIoOiYHLJCQRcgw1xZKJtNmH5bZ9EM7SLjBdR+9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749832255; c=relaxed/simple;
	bh=bIXR0RtQXeFW3KLfEoanD7YjVun66GxkFtLLTTFpops=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DheBmXoc3dtZIHKawdPTstmWyKgEiS+JOGZa5UatSUhrQuhrveoilV1LFmPcAAcTQeejjvbVoeD/ACSFPnVm1EcRPIAG4LSO+X82j6f4aDCMOCWcqwELfA7I6eNlcA6WKvdzzX3jqR7q4SZf28d6jLEurT7VbtSSeY3uMD7rECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjye9jxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF4AC4CEF0;
	Fri, 13 Jun 2025 16:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749832255;
	bh=bIXR0RtQXeFW3KLfEoanD7YjVun66GxkFtLLTTFpops=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pjye9jxexYyAYq48QAbnMwYeEveYvxrBJ7rAc7kkDAEyxScpsmKS4QElVWoqbJ4ZP
	 cbrFdyQThi3v/yp3uC7MelfyG8x0szKC03Pcv4AVfrQ3APL+oOho0PfCnEFR7KipwA
	 g440GtxtOAJQROKcABAXGtBEofdGTc81pGzX60Q8Mz3lBmg65D/EATeRFRDaN6jt0J
	 oiqPlpihNIHAl5uosEy/iSw7n3zKmVFz29vVRHeicthVXZw7XeHJfWGWSjPA5R0D1R
	 CT26SGoBQB9FCcirYQ50PeWqIzGV8E46Qc4QbjcpRLXLBmCEjZM7o2fcIs1WqzbwjE
	 mDV9SVuKiKr7Q==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: UNGLinuxDriver@microchip.com
In-Reply-To: <20250612023059.71726-1-thangaraj.s@microchip.com>
References: <20250612023059.71726-1-thangaraj.s@microchip.com>
Subject: Re: [PATCH v1 for-next] spi: spi-pci1xxxx: Drop MSI-X usage as
 unsupported by DMA engine
Message-Id: <174983225399.209053.17415046905781410107.b4-ty@kernel.org>
Date: Fri, 13 Jun 2025 17:30:53 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 12 Jun 2025 08:00:59 +0530, Thangaraj Samynathan wrote:
> Removes MSI-X from the interrupt request path, as the DMA engine used by
> the SPI controller does not support MSI-X interrupts.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-pci1xxxx: Drop MSI-X usage as unsupported by DMA engine
      commit: 9f0ad43b158d07bc7144d219ceabdea36e28e392

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


