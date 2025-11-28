Return-Path: <linux-spi+bounces-11653-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AFEC92DE1
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 19:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254B03ABD01
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 18:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2094423AE87;
	Fri, 28 Nov 2025 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgF56LMu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE87C21770A;
	Fri, 28 Nov 2025 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352910; cv=none; b=e4kk0MFLJMK45ZJOyap8e/tdzSxFIzmdTCXS8+hMD5pHAlRovMX3S9oUGuPiP1ZeofbdO48epsd8vIhmS7WbFApdvWOkWnVPxuqLTU84LGLUCPmHV/bvjJ7uw8iSVYllB/jUdZojh7qrpWdKUFOg7d/+RwlnRo7HejOA2hg67h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352910; c=relaxed/simple;
	bh=YmiO24X5iXRR2svKIw+ehK/CRNNPzeMjC7S/CmKD4VU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D3KHq+xAPuVU9rrtSm2r+yEQ+k+ipQXCgCB4gb0/UKxRjXZq84Qk3a3kLYU1ZtaFMbyZSTQEltDGbtD/F6jJSp3d8xkXMrkUGdqXTn3tp4X71WU85HAHskGbAhZrh5nUqxwlKJ2JG8oUDEdXU4G5mIQiHmCy9pElpvWVIakKKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgF56LMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE968C4CEF1;
	Fri, 28 Nov 2025 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764352909;
	bh=YmiO24X5iXRR2svKIw+ehK/CRNNPzeMjC7S/CmKD4VU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=lgF56LMuM7M2VLz49KClPYilwngd8gIonNBaAcnMDkqOWESm2wwEkQr6jWcVZX6t+
	 RkiHu0c8YBApqJpVWWPy6PkOegGoEM77nalm3Ox9SsytZg+fhFnKoTrtzbulhWKKPR
	 yDG8+raJpgwugYWUDRib+hI5h7XlOjRBZMf7yAHdfpfyUQ3eYQnLGESarZOlfNCPub
	 AVYInZp1Q/aGXIAxDInYi9zjO2NGyrIa6XZsOyrhp0GCpykg6MsDWbSgRqxI5wNqx/
	 wp0BA+JruBlnLG51TImbOCRcyBTCIRJA95nQ5aNyp09oCBSfHCQTosc/NIdyNP6DHU
	 EBEjOJzXDNxyA==
From: Mark Brown <broonie@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v2 0/6] spi: microchip-core: Code improvements
Message-Id: <176435290843.114164.15577325621746305983.b4-ty@kernel.org>
Date: Fri, 28 Nov 2025 18:01:48 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 26 Nov 2025 08:54:38 +0100, Andy Shevchenko wrote:
> While reading some other stuff, I noticed that this driver may
> be improved. Here is the set of refactoring and cleaning it up.
> 
> Changelog v2:
> - dropped device property agnostic API conversion change (Mark)
> 
> Andy Shevchenko (6):
>   spi: microchip-core: use min() instead of min_t()
>   spi: microchip-core: Refactor FIFO read and write handlers
>   spi: microchip-core: Replace dead code (-ENOMEM error message)
>   spi: microchip-core: Utilise temporary variable for struct device
>   spi: microchip-core: Use SPI_MODE_X_MASK
>   spi: microchip-core: Remove unneeded PM related macro
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: microchip-core: use min() instead of min_t()
      commit: e29aca7038f3c292c18048922c5f4436a034da99
[3/6] spi: microchip-core: Replace dead code (-ENOMEM error message)
      commit: 274b3458af1f9c665faae70b560852461c30acef
[4/6] spi: microchip-core: Utilise temporary variable for struct device
      commit: 06b010d3c778075108041074a8fb785074231ac4
[5/6] spi: microchip-core: Use SPI_MODE_X_MASK
      commit: 4db5a0705b1e03abb6ff4e7d7789b32c31384429
[6/6] spi: microchip-core: Remove unneeded PM related macro
      commit: f458fc9b1946bc882a217d65bfe5ba50787f253f

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


