Return-Path: <linux-spi+bounces-4900-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C397D4BC
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 13:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E99B239B7
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 11:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2042A1422BD;
	Fri, 20 Sep 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTqxTJFz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED31D45027;
	Fri, 20 Sep 2024 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726831256; cv=none; b=Zqt1uGjJa09CwNyGxsoXg+r9ka6zJrEbOafG1dnfLjZvEdKSxjyAR1clPaLbf0UZ/CkRaF57Z4bUG778mzQR1R+UXve0OnOD2zqGOpLKVGd32cRe6u92tpW4MSealwKovzrR1WrPfRbLZlui6UHu7F8Dou+L6p3F/QMQFIQVOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726831256; c=relaxed/simple;
	bh=AOm6CiYihAUPza1oEC3n4S6HAK1ZQbToAsiMUNAJ9v0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DQmPlfc6D8aZ3QR8Syo61sp+Lr9GLo/XFpqMPDMuIGm+ykqNMbQj0EmHYLbtubGnVwyFKXFo1kPzjfIfnkbX0vmTBUnzF+phAJl/8UU1p+cgsmYKa0/Du23Od8ydIDj0RdOeqRTWF1Mm3VUxcTnv5A5oLnNjHdv9atOvD65Ua/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTqxTJFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E39C4CEC3;
	Fri, 20 Sep 2024 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726831255;
	bh=AOm6CiYihAUPza1oEC3n4S6HAK1ZQbToAsiMUNAJ9v0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NTqxTJFzr0tX4MKGLnh2smz/O2hVmLyooLMZJg7/Ec79dsQ7Um+yJTW2oaLxybR9v
	 mS1X/yv93l5OT0rWTAQjBfQsa67mZaXZLE6AKl6s7FNH1C/Qz54kcMwkkWRh/jNAe2
	 gA99CnUSKatFoGW/5UQqijuqJyKc8r5cOyA1TMqfkEgdXgZ5zvvJj/sAjtQD6Ce2Jr
	 0SUadizHI+6JxvBEJRyw2m+XTnx4cCt0KrvfRnOISWPqWKOsOQ+KYh/+meKfbVADjh
	 dO+h+uZkkjOODp36lCngvVjBmpRzvfbfwd1RYeVLM1nYM312Vg3Jprc7B/7T2W+xII
	 Lwzqf8/iUezIQ==
From: Mark Brown <broonie@kernel.org>
To: Alexander Dahl <ada@thorsis.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240918082744.379610-1-ada@thorsis.com>
References: <20240918082744.379610-1-ada@thorsis.com>
Subject: Re: (subset) [PATCH 0/2] spi: atmel-quadspi: Fix and add full CS
 delay support
Message-Id: <172683125380.1876737.2732107267327234575.b4-ty@kernel.org>
Date: Fri, 20 Sep 2024 13:20:53 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 18 Sep 2024 10:27:42 +0200, Alexander Dahl wrote:
> when testing on a SAM9X60 based board with an FPGA implementing a custom
> SPI-MEM protocol, we found the need to fully control the delay settings
> the atmel/microchip QSPI controller offers.
> 
> Greets
> Alex
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: atmel-quadspi: Avoid overwriting delay register settings
      commit: 329ca3eed4a9a161515a8714be6ba182321385c7

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


