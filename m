Return-Path: <linux-spi+bounces-11829-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E45CAFA0D
	for <lists+linux-spi@lfdr.de>; Tue, 09 Dec 2025 11:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1086F30B453E
	for <lists+linux-spi@lfdr.de>; Tue,  9 Dec 2025 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8D82EB5A1;
	Tue,  9 Dec 2025 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFPYuGCy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408B2C0270;
	Tue,  9 Dec 2025 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765275727; cv=none; b=eteDqa9vEIV9fjq3WnSi4vKReBIm7jRpGxEZ6oivSYq+uOs1/arn21IQJnpKDH+JjS6GyrhNeolKDu3WUbUq4E/BOUhO+h4Dtqtyv+Ia03kDvZ9Ax4GEgp7sroauARcdGepQBF4GenJ4I7WMnFS7KPpmkr2tbbtVxpfClc6cVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765275727; c=relaxed/simple;
	bh=BxGEzqB4zTaHJ1wmuJwo0vF4iXtuYZcWRVJf54n45lQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DpkJetEatiM5ZxHQADh8OS9VnsVWh7kxeagUwc25jsRKSwTSzOuSh12xIhH5OIS3ZQ2p70hLPtKIQkpDqxX97ruMND72+FZm7Hc5JzdI6nCLvOs/DgonL70H5cQmtOk/ir2fCOzwERhVMd+H37f+tx+gR7dvVF/TuM+Zrrg9nek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFPYuGCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6F6C4CEF5;
	Tue,  9 Dec 2025 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765275725;
	bh=BxGEzqB4zTaHJ1wmuJwo0vF4iXtuYZcWRVJf54n45lQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YFPYuGCyu9pk/PDSNSWtUslxpVcvbKmCKh0RjP0r6nj77Vnx/L7qTfki4sKd43Ljd
	 4X5f4sY0EtJW6H2zGA2trFgl+HK5oEW+G0NEjiCZnLP9l57WDx0VS+YjE+20in0a3g
	 z17WUtkluL5506+wsY8psPGaKteMb0hyL5ARW7XUmvqXyeIaj/PPUhp1jSt3nxvpiD
	 m5Us24nUYOroK9FSp1h4nM6rlx4UPdfj/H0cpOCnxfP+Pcc9OGm1tp7/Qmv2X372O5
	 3zb9FWgfMbejhUNI8gUlohInY2cmFrslJuD9nm0TwZT1LqmbH7UDuuMVQ0Krm3n4vL
	 J2XH3FdafLDgg==
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>, 
 Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-spi@vger.kernel.org
In-Reply-To: <a7aaff1f28a83303a288de2914724a874fe1a11e.1764969247.git.christophe.jaillet@wanadoo.fr>
References: <a7aaff1f28a83303a288de2914724a874fe1a11e.1764969247.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: microchip-core: Fix an error handling path in
 mchp_corespi_probe()
Message-Id: <176527571937.622968.1155008972776537715.b4-ty@kernel.org>
Date: Tue, 09 Dec 2025 19:21:59 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Fri, 05 Dec 2025 22:14:10 +0100, Christophe JAILLET wrote:
> mchp_corespi_init() calls mchp_corespi_enable_ints(), so
> mchp_corespi_disable_ints() should be called if an error occurs after
> calling mchp_corespi_init(), as already done in the remove function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: microchip-core: Fix an error handling path in mchp_corespi_probe()
      commit: 8cef9b451dc6fdf86b92c7a35d55a47465d500db

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


