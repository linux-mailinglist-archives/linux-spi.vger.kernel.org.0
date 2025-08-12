Return-Path: <linux-spi+bounces-9371-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0C2B22562
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 13:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96541B61ABB
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 11:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E652ED174;
	Tue, 12 Aug 2025 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG7eSuT4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F4E2F1FC7;
	Tue, 12 Aug 2025 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996756; cv=none; b=G4UPlBhw8qtl2DSks+D7Fa6eNVmJQp2G61H54hg4swF/46KTG+oKtHEiVWd6o/7cny07Ok80RpYVviRX6lpAPGM+kSNHOhAf+emF8od8nY4PL07otEzp/nyVlOkfvZzWnj7HPl/VrREeIQ+IUz5Dzwqcz74yi9Lri3ygUbIpje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996756; c=relaxed/simple;
	bh=IiX5eEon6+kqFcZZVEkYN3deUOeo0W+mmdMD6i1pE2c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QaNJifCdz2efIMB7H7hp4kY0f7I+zqhM/3ZWZSD6iGidwWRChzgvgKjbDiGw8ztovP9H35lZOIUCOUKETd/LvAR+ik5dj1+c8kTRU8e13u0wIaV4R9BOrJ4yVCwTR7gZoH9NQgluNAgWnT8YTm/VVOXFbTlF7g4VSZQaQvH0IpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG7eSuT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22470C4CEF0;
	Tue, 12 Aug 2025 11:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996755;
	bh=IiX5eEon6+kqFcZZVEkYN3deUOeo0W+mmdMD6i1pE2c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oG7eSuT4yXo2oDDG4fCTUJqUppEymAAspevaUnVZHEVzYZvc1NNkzwx1LMzIHeTQi
	 4vDnfZ+1b1CbL0gSA2qqhw2ypJtogpDZXSsN91d9OOtIXkGW5M1R0Zn0Q40NfIKSoM
	 eov1jJONLvkDDe2z24uVY+EcJHWFqiByRd5x8Yt4BigIkf1amS7xrSb8KO17rzUt6m
	 nVU17SxKCSTCE/1xElVKJkfsdx8STw5V++6JsvRrReZkg8ubfidEbB86sY2B/XV4jc
	 6RNygyngEByP3U7hHTH+MLVHqQ+sPj6GUcWbhO4seCuKB6EZHac3KmLIBqaWnq8ZKv
	 z16OqNnoW+xMw==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250808-qpic-snand-double-assign-fix-v2-1-1a3d0ed0d404@gmail.com>
References: <20250808-qpic-snand-double-assign-fix-v2-1-1a3d0ed0d404@gmail.com>
Subject: Re: [PATCH v2] spi: spi-qpic-snand: avoid double assignment in
 qcom_spi_probe()
Message-Id: <175499675487.16293.7425649112451486885.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:05:54 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 08 Aug 2025 15:15:32 +0200, Gabor Juhos wrote:
> The snandc->dev pointer is being assigned twice in the qcom_spi_probe()
> function. Remove the second assignment as that uses the same pointer
> value than the first one.
> 
> No functional changes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: avoid double assignment in qcom_spi_probe()
      commit: a1d0b0ae65ae3f32597edfbb547f16c75601cd87

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


