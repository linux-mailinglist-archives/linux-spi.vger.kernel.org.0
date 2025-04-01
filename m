Return-Path: <linux-spi+bounces-7384-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AC4A780DE
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 18:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784E1188A081
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 16:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75D520D4F4;
	Tue,  1 Apr 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jweWDnzR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A186620AF67
	for <linux-spi@vger.kernel.org>; Tue,  1 Apr 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526464; cv=none; b=Xnlv3it3q47wcbYvATPf/fvuCRR9TtFBkCBVQkphTa++OczCrdO24XmYDO2yKsaTDII9xAEvgapndL3dMvFJFA2nxgiu6MJqNxqHcr77x+ma8z8DdGlaSRib5lTApD3rYlhfAJkh4QJtc9Z2KmjHS8XiJVlFjofRL82+nlsCpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526464; c=relaxed/simple;
	bh=VGIJx1b7PJdGbnGNJoFls6qak59TH2cfXdqTtskCcxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rkb6HNffYosWA3gln0s1vNL/rIYoqz5Pe+3teVeg/X2e1nHULzEHg+a2MdbdRJO6oXsc1rlIG5vhbNdbX1x0s3MEmFxa6H0MkREWG+SbTzucnJGOu3tCbuqNUrhGQVAy7fUTWAfZTLmZw48nNpmH124zLuT2XV6fKWpUoVvxVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jweWDnzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC4FC4CEE5;
	Tue,  1 Apr 2025 16:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743526464;
	bh=VGIJx1b7PJdGbnGNJoFls6qak59TH2cfXdqTtskCcxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jweWDnzRMDlazkQW8o/mui5gl+gYKg6PoAWMqheHANGIlqSS7lo50wSit9q1gmD4M
	 04OJu/QTQ/OsSHvnsMxBwS6wCoATF6XvDQkoODiJCvZBOlrRsNEI4cn4JFxE3qqDty
	 oPYk2BAJGpciapFYMzYA8XthxsOtif/BqHIgm/l/zJY8pAIwf4H5OxpsCTdGcX17Ed
	 VgNCdiDs0ywnvepiUAZjkTz7m6GOpBm2MStoll0JSqOzv9EnjYXHBMmNmnEwTmGa8M
	 9owznyEB/xu0iwET1vkd7L6OdqZxvYgR5Xed9x9v32TSuU5zCeQJtfrTw7V2/cGRnf
	 mW5BVZtxoHMMw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Steam Lin <stlin2@winbond.com>
In-Reply-To: <20250401134748.242846-1-miquel.raynal@bootlin.com>
References: <20250401134748.242846-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2] spi: cadence-qspi: revert "Improve spi memory
 performance"
Message-Id: <174352646277.108117.10591254154615830800.b4-ty@kernel.org>
Date: Tue, 01 Apr 2025 17:54:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Tue, 01 Apr 2025 15:47:47 +0200, Miquel Raynal wrote:
> During the v6.14-rc cycles, there has been an issue with syscons which
> prevented TI chipid controller to probe, itself preventing the only DMA
> engine on AM62A with the memcpy capability to probe, which is needed for
> the SPI controller to work in its most efficient configuration.
> 
> The SPI controller on AM62A can be used in DAC and INDAC mode, which are
> some kind of direct mapping vs. CPU-controlled SPI operations,
> respectively. However, because of hardware constraints (some kind of
> request line not being driven), INDAC mode cannot leverage DMA without
> risking to underflow the SPI FIFO. This mode costs a lot of CPU
> cycles. On the other side however, DAC mode can be used with and without
> DMA support, but in practice, DMA transfers are way more efficient
> because of the burst capabilities that the CPU does not have.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-qspi: revert "Improve spi memory performance"
      commit: 3cb2a2f7eebbb0752a834708e720a914e61841a1

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


