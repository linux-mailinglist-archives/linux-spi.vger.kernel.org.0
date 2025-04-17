Return-Path: <linux-spi+bounces-7650-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E046A92C8E
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A6C442B54
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 21:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9461BEF7D;
	Thu, 17 Apr 2025 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8wb0u3G"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61F718D63E;
	Thu, 17 Apr 2025 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924581; cv=none; b=IiaX3j5f37KKVS3Hwi5muAYMY1Zat6tU125+gm47snF59x0qXXSWlsZHYvN/ZHz3epv6zY6QRM8TjYgTwEg5u9DAER10ByONtlksJ2mpL0vJgo0/gnfB4b43l53DsahPpqjCiS4wl/8ydm2pIG/DbStgHibmXpCyK5qCshbP24A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924581; c=relaxed/simple;
	bh=eZkEV26HEMG6QDimOrqTRv4PVSP8eRQSfQX42CYvtN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gl3tGXrISr3IgxR03Ny3G3jAnnO2nlhQ7J9krAoZhSkq7ljtEnv35djZ5JxETDUUyHJvu5MoqMaukH+L1BH/GBXsVrfw+TbGew9UsiT37uPAEVBUrYDEwak82Ne7C/Xu/b1JQZ0zcgoOiXNKBPS1emOACHYguB41MaDRPKTWpyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8wb0u3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FC3C4CEE4;
	Thu, 17 Apr 2025 21:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744924578;
	bh=eZkEV26HEMG6QDimOrqTRv4PVSP8eRQSfQX42CYvtN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b8wb0u3G6u46w0HKEUoSL92HBTLjm4Wxn9SunITkNLDIRs8vNU9uwb8MuljUJ80CS
	 EoIBqiMuwZM/NTU7KgggXyX+btApxNWei8SmFRxOmlrlhD/nNSOmx7UiVj2aF/8s7c
	 Vu6kfcsTbIRkUc3ZnC0VbK06nIEH2hyxUbQKB8NRvaAqkhRljUWd2p8ouSgU2lvm8K
	 kMjvVneTWiLfH7NsbZqmrQ7B/qPjOrf3YJuA4NEw9ElDs9mWRe5o6cyUYWMu03nGd1
	 Ua99stb/301QFSgvsAJvXLHbqj5YOVGTlSSco4Uz+kOKIclaZhAQ/W468d/isn3zOV
	 kbyfvyRb4yP5A==
From: Mark Brown <broonie@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250417083902.23483-2-phasta@kernel.org>
References: <20250417083902.23483-2-phasta@kernel.org>
Subject: Re: [PATCH 1/2] spi: spi-cavium-thunderx: Use non-hybrid PCI
 devres API
Message-Id: <174492457740.248895.3318833401427095151.b4-ty@kernel.org>
Date: Thu, 17 Apr 2025 22:16:17 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 17 Apr 2025 10:39:02 +0200, Philipp Stanner wrote:
> cavium-thunderx enables its PCI device with pcim_enable_device(). This,
> implicitly, switches the function pci_request_regions() into managed
> mode, where it becomes a devres function.
> 
> The PCI subsystem wants to remove this hybrid nature from its
> interfaces. To do so, users of the aforementioned combination of
> functions must be ported to non-hybrid functions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-cavium-thunderx: Use non-hybrid PCI devres API
      commit: 23812bbd7d5fe27b6b2e0fe5a8ba4c6f37f26671
[2/2] spi: pci1xxxx: Use non-hybrid PCI devres API
      commit: d981e7b3f25fbabca9cdd02aa2a8f16d6f235fc2

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


