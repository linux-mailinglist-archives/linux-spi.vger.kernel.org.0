Return-Path: <linux-spi+bounces-8389-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD15AD1F16
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A9867A6595
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC01625A2C6;
	Mon,  9 Jun 2025 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqye44Wd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219225A2C3;
	Mon,  9 Jun 2025 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476441; cv=none; b=Ptfk92GvY/04PzGAzdKaUn0150XcqgWWBgFA2AfS9Ykj3dB99TvxFequamq669UixVCKCT5Wy6LVJk2z1+gcqSYzShnCcnqJmBR2DHK9YU9YKJ1ui5ijEYJ2AW2sW2TM03amoTr2N3ZdFJ7sW3/OJWI6EM9TfdJLzGDq+ut7uFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476441; c=relaxed/simple;
	bh=USKTZ9fCu55+R7oUXsUvPI1rp8t8D7GxZjI7Rx0Goo8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EN6qxEwGMgxg2yK/kMqbg8haqtPg2bRcbFRTR6Tfd68mEFLjAGt6BwQqtUJ3v7ycvWwjdwjSMfMMBFOz5/1MboiBtzdbu4bv2d+nclxned3Cno3nb8xKQRWYnc8TuJeRSWcOYgrGrbRW8jYFEjKd7c1DsvGh4W3G7OtCZVfCeVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqye44Wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B6BC4CEEB;
	Mon,  9 Jun 2025 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476441;
	bh=USKTZ9fCu55+R7oUXsUvPI1rp8t8D7GxZjI7Rx0Goo8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qqye44WdcSZaC33CxV+RJApyqXSqf6xUL/mYdjNUndm1X6wPO220aGJd6CkuuIlWs
	 FHzDcaWQrbKzdetZnEfGYasFWtZL3D57vxHtagfmdoBsMhMlt7Km4e/g8whrOrmmcv
	 ZcOeouxdyAyfPuqnVImHNlOQ+QndLQZo9csTlTcfbAODTAeypY45wYUWx7li6Mvx3t
	 wQYc3DH5oddfQeK8afOtHca3w0Cp2YyiNHuKewo+g1y3IKTpE8mzyhNzXyy7dZ/C43
	 SVPUbrShxkGPRjXta0cGgU9RkO2pDyB5uwMptXxe6/LfYQT/qpq5HwkRAvmuyfpKEj
	 XDZFUhJjBCBCA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: UNGLinuxDriver@microchip.com
In-Reply-To: <20250526104908.404564-1-thangaraj.s@microchip.com>
References: <20250526104908.404564-1-thangaraj.s@microchip.com>
Subject: Re: [PATCH v1 for-next] spi: spi-pci1xxxx: Add support for 25MHz
 Clock frequency in C0
Message-Id: <174947644039.127013.16420738597915018484.b4-ty@kernel.org>
Date: Mon, 09 Jun 2025 14:40:40 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Mon, 26 May 2025 16:19:08 +0530, Thangaraj Samynathan wrote:
> Adds support for 25MHz clock frequency. Support for this frequency
> is added in C0.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-pci1xxxx: Add support for 25MHz Clock frequency in C0
      commit: c459262159f39e6e6336797feb975799344b749b

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


