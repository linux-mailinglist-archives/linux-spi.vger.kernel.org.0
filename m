Return-Path: <linux-spi+bounces-6635-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BEEA29D92
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 00:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49B43A7441
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 23:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFD6215067;
	Wed,  5 Feb 2025 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sysRDw3Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E6151992;
	Wed,  5 Feb 2025 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738798255; cv=none; b=NVoXk/6NCUwMPcsMebVXZjrYxD2YQbTH7EUZWc9Sq53Xscd4AUQRE2connBApDDcWMlu5odUHGEcSgB+lK/S0FZgy1Y8N5f73jziasJOxyAsNsrYzYSFZM9G63bdFwxCEs47zcD+ohoD3AAEWuNN/C/MMnww+Q6c5gf8JV4w1m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738798255; c=relaxed/simple;
	bh=8Z+j2ubldSVTilGuSsiMR9yARDIN27DSGshab1cAJfE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gLWxLw5MQ7EdYUHC9jNBmVzz6XqhXgWAnr7qiHoi7UE8aBbZb1Z53QRbpAj7Pu4qZ71HgHyI8QL8jHF0NJzrZ9xCTmETn+NKWfN5ZXVyCX1fbDi/Ow1NmtXR1YOrtF2lLwA2iasTJuXphZY4n0ABTT85VEm9cPURLtp5uYoTQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sysRDw3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DBBC4CED1;
	Wed,  5 Feb 2025 23:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738798255;
	bh=8Z+j2ubldSVTilGuSsiMR9yARDIN27DSGshab1cAJfE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=sysRDw3Zw8fFfeRvjGk85rOiimHRuB39+sSfRXLYJaveTfCeeyLzf4C9/p1JEu6NH
	 IUNIN9tLcS7zYR8BrqX9oYO7oFScNER46XsznuuOddo1GrimW5b/HZt437fZ+TSHMZ
	 +o1swfUih0jCAkEsNJmdMXgPU7a0vXRzDBo7ymR781wHQFxXltrcGh8xH5H1xb8rWM
	 BdRdibZmI75FPQ/71yPwbXdaza9a3WVuegFzzAOUXhhvk+CoHb+8CC46PU/DtE7K7T
	 IZpzbUnv928LPrgf6O822fJryWAZgFKej4fdtqoDbBDO8yEJ+yAKJEYa3tCjJbrIbD
	 TBRvKKjuf3Log==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250205130624.716039-1-andriy.shevchenko@linux.intel.com>
References: <20250205130624.716039-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: Replace custom fsleep() implementation
Message-Id: <173879825419.806563.5552035883619493895.b4-ty@kernel.org>
Date: Wed, 05 Feb 2025 23:30:54 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 05 Feb 2025 15:06:24 +0200, Andy Shevchenko wrote:
> _spi_transfer_delay_ns() partially reimplements what fsleep() does.
> Replace that code by calling fsleep() instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Replace custom fsleep() implementation
      commit: 215705db51eb23052c73126d2efb6acbc2db0424

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


