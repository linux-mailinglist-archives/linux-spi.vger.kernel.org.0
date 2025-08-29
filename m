Return-Path: <linux-spi+bounces-9787-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E7FB3C4BE
	for <lists+linux-spi@lfdr.de>; Sat, 30 Aug 2025 00:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1510A01023
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 22:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220FF27978D;
	Fri, 29 Aug 2025 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urG17Cu0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC56F278753;
	Fri, 29 Aug 2025 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756505976; cv=none; b=XR9hy3LLxoeYKIFlxyxG+JqthRJ1j+x128dVDIrSIdXpeV4NB5RvNQaD72O9FN20znBRbJ7RuTfVBrqfmxSP1vBF6sOpfm73/gfq1yhggjiWuEzODjTCtir44+2+MnWiXIwr56OoZB1yIiLMRLbXyKxoefXFE/4XE9xYCCp4N/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756505976; c=relaxed/simple;
	bh=A5C4e1z8sW6QvmbwOIiYp+LFhDtXndxxYvLSqp0kA+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uGo8PVf19CP2uuMTFl23IMEUnUghIIjjFNZI5PKURkUlGFA1CZeMx6bfpCSdHddaINz18Pvg+kCIQywIap8IWWD2S37mBSuiuRPB73/UCHuPQgp8pgI/O6AJ9lhwqqHU+peeofBfzEDVglPI7nFk5ZCGOvCcDsYHd45LQu3Z5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urG17Cu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDD1C4CEF0;
	Fri, 29 Aug 2025 22:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756505975;
	bh=A5C4e1z8sW6QvmbwOIiYp+LFhDtXndxxYvLSqp0kA+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=urG17Cu0QCZUQbFVDgXT3dCRnuMWmpPlmDvJdI4Abo8SJeu1hqVsGz86qT7t0Dy70
	 7uTWu4y1t2+5PYpGMEtI4AXStd1kWE03knzBjEZg26s9ZfgGMt1agb9zOD8YpfJ5yB
	 0pE8WCG3cLfJGk9gkjTNiK4bcW5aB55Sg15GnlBGdHh516u84vJa3CdMWBWnznhuxx
	 CQgXFE+uyX/Tlb8PTjzc2DaEKW0H7msNowSnc3ffO8AvGTO5uymNa0T58NiLt02wXo
	 Vw4KEY8fF9+cFGxM/vdVbqw2yIFQObk2Z5ujLwwzHfzUO05aqFV0MEUqPPJKFsXF6m
	 zjVW2xdI8r9Uw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org, 
 Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20250825-during-ploy-939bdd068593@spud>
References: <20250825-during-ploy-939bdd068593@spud>
Subject: Re: [PATCH v1] spi: microchip-core-qspi: stop checking viability
 of op->max_freq in supports_op callback
Message-Id: <175650597222.396097.13617844393392701589.b4-ty@kernel.org>
Date: Fri, 29 Aug 2025 23:19:32 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Mon, 25 Aug 2025 12:53:28 +0100, Conor Dooley wrote:
> In commit 13529647743d9 ("spi: microchip-core-qspi: Support per spi-mem
> operation frequency switches") the logic for checking the viability of
> op->max_freq in mchp_coreqspi_setup_clock() was copied into
> mchp_coreqspi_supports_op(). Unfortunately, op->max_freq is not valid
> when this function is called during probe but is instead zero.
> Accordingly, baud_rate_val is calculated to be INT_MAX due to division
> by zero, causing probe of the attached memory device to fail.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: microchip-core-qspi: stop checking viability of op->max_freq in supports_op callback
      commit: 89e7353f522f5cf70cb48c01ce2dcdcb275b8022

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


