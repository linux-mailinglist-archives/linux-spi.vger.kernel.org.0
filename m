Return-Path: <linux-spi+bounces-614-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3717F8375D4
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 23:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A09C1C23F53
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 22:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA148CE0;
	Mon, 22 Jan 2024 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Via6OR8S"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967348CDF
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961235; cv=none; b=i8aCa7Rjotg+M6QHw5hi6mnY/6nBgMe4L4e2yQsaAeQq0kNbC31wfU91deBC6w5JlSq3IktbC8YCjSSeR8H8sHLcXjDniZVJX66WzIdU3xpUKpxRwSWuLM/6ybm6Tsp2uABDzXxcELsR6u5DA0c6xeZOiYnLoRq/b6+yw8HzTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961235; c=relaxed/simple;
	bh=/QI/u/RNM21UUGNNLcPgMUg0EeXfQN/V6P9PGejhrsw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uYdbv0Mu5kgkjLNlwSCLFEcKEu3Rh2WKHf5WAsTUVfEQ6RdKwaCyInQ5zUnaaPSNI4klBp7Wu1bZ5S+PlmtoYKS+3XSbXkrxuyXN7FvtvTFgPJMkRrJF7FXh3DXjMCLrP0xGP5aID9P05L2k7xIUZq+8AvIGuLg8eVyinSwHYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Via6OR8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8EEC43390;
	Mon, 22 Jan 2024 22:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705961235;
	bh=/QI/u/RNM21UUGNNLcPgMUg0EeXfQN/V6P9PGejhrsw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Via6OR8S7WFEZe81XpDoQ5uF8l5V/GwmP/cFXpCV2KehiVBOtC2D4BScdkOfNziAX
	 m8WlhVkM11/AM6DbJfbWYuaI4QkWGHKimemyjpZKdq8D3kTmvKhDH49xSrW2xZvJFU
	 RdZgB9vOO6OZlmxfoJBmvRYM7iPJdg3APiPx2rjH+XXYhzQ6YQCYbjpyo+1zN+MffT
	 6iJlnWrAIKDrDGR/6x2m6mX75glSvDHdwXQIDttoFVS490Cgwy9NmRtDGQaoAcPTjx
	 FcZLQkk5oFBQq/ICKHzmIIUlnFMq0O2AQZmjbvpAwxoB21mip5iBjwzcF1ju4JwjpG
	 bbTpGrUrN5Rtw==
From: Mark Brown <broonie@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <20240122120034.2664812-2-mika.westerberg@linux.intel.com>
References: <20240122120034.2664812-1-mika.westerberg@linux.intel.com>
 <20240122120034.2664812-2-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] spi: intel-pci: Remove Meteor Lake-S SoC PCI ID
 from the list
Message-Id: <170596123396.165612.12046167689716658162.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 22:07:13 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 22 Jan 2024 14:00:33 +0200, Mika Westerberg wrote:
> Turns out this "SoC" side controller does not support certain commands,
> such as reading chip JEDEC ID, so the controller is pretty much unusable
> in Linux. We should be using the "PCH" side controller instead. For this
> reason remove this PCI ID from the list.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: intel-pci: Remove Meteor Lake-S SoC PCI ID from the list
      commit: 6c314425b9ef6b247cefd0903e287eb072580c3b
[2/2] spi: intel-pci: Add support for Arrow Lake SPI serial flash
      commit: 8afe3c7fcaf72fca1e7d3dab16a5b7f4201ece17

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


