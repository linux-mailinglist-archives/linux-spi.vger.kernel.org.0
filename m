Return-Path: <linux-spi+bounces-11901-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99767CBE9C4
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72812306D88D
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EFC332EBD;
	Mon, 15 Dec 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkZ4sisO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FC3332EB6;
	Mon, 15 Dec 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807178; cv=none; b=Bl1UtyXP2PgIAJO8KWYIbqAFv22FDaG4pRqB4l6ZIRacBa937GIsdV8lCniUsKq9t2+m+IeJL3krEGnVAEkr+R8AfissInsTiHxeM2gEjQlUQlOG0POEYvYHwnoAmBc4AeGj3YXLIlR9mimsCLN/38+uIx0+xUkzPCEKcKrD4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807178; c=relaxed/simple;
	bh=KJvZzhKrn8uZz3eEveVdsonmL/mTsWm49pT4/VAg3L4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ghp7xpcW75cikNp4+jXrgjVy9eTMfbBGnr24YsMYq1Z06VJbXzqvQ8fozXR9YGO0vVUHs936lnaREG0NUXdyXJcjpYyXViVBAYjAhjjz5CyC1A16SbLtXuFt/LG5MclSvaRuGySfm/JTxgxiTmefIBtsMRw3lm5fTz10L8jtygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkZ4sisO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02431C4CEFB;
	Mon, 15 Dec 2025 13:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807178;
	bh=KJvZzhKrn8uZz3eEveVdsonmL/mTsWm49pT4/VAg3L4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mkZ4sisOnb2X/+73p4W7RG33/m0KdAAxaWy0Vx8x9Uigmgy1Pkcr1GSLVRSWoVBqW
	 WZXqsNtl0Y2KWB1Piz0AALA/NyKjpu3kFf+OCxZbWrXV0kXMczYgQeTS8koY4iiHFS
	 DUEZWBJgJJYKS5F9FlEKI5B6XresijefCyC47W71P7ajzA7mIa4BHf3cVYPvPM1Ib6
	 I598KPNr4t28bylz954NfqJqPX1HugeeTz1DzJVl0iAC0dNcSg0+SvLshdzWYPmoy2
	 RqDBJGOP2D2/+qjKWao1eQrlCDRCMsce+IjFRKI9o9950WkP8z32D+hj1CpVPva2DC
	 opL1x0NLliBhw==
From: Mark Brown <broonie@kernel.org>
To: Frank.Li@nxp.com, daniel.baluta@nxp.com, andriy.shevchenko@intel.com, 
 david.laight@runbox.com, Carlos Song <carlos.song@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251209055634.3845602-1-carlos.song@nxp.com>
References: <20251209055634.3845602-1-carlos.song@nxp.com>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: convert min_t() to simple min()
Message-Id: <176580717644.161463.14088769832395670607.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:36 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 09 Dec 2025 13:56:34 +0800, Carlos Song wrote:
> Convert min_t() to simple min() for better readability.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: convert min_t() to simple min()
      commit: b884e34994ca41f7b7819f3c41b78ff494787b27

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


