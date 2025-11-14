Return-Path: <linux-spi+bounces-11217-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC3CC5E927
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 18:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 051A14F81DE
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 17:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4DB33F368;
	Fri, 14 Nov 2025 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFfWDvi5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3D338F54;
	Fri, 14 Nov 2025 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140027; cv=none; b=XxlO46sk2SulfLkluunjMV6ErEcA2Hjxyl9Vt3vD8oKlEPprda0JAAQlblqGcLQA6f4Xhsv3vbSKOddaYkClCssp9kJrP9zjsre5vhpikh+3S6sEVgRqIcnIuL60K/NxXM8QpaQ5pOBBpXuMy3f2QP1snd7Ymfr+RP3uDxX2AtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140027; c=relaxed/simple;
	bh=ga44oaeQFbH7wASZKjv+ryueYrWRV/VVMvZPstiCLTA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Am+lJdfWjipVYpOxu6MM7dKUyd/ne05u0kh6tYMHx//LxHaVhINHbN/LizDtS/SZ+05vM4Ywo7MI8SNJSuvtUyQewS0CNOrj4o4FsRGxCu6p+QV1izM5JqSzOhBrOLMiRd3PZ0tFcaSH6z5gn1WK/vAp/5HtoGWbiL0MQbM9ZdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFfWDvi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D910C4CEF1;
	Fri, 14 Nov 2025 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140027;
	bh=ga44oaeQFbH7wASZKjv+ryueYrWRV/VVMvZPstiCLTA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GFfWDvi56HBMPyHhDFEQ3UIwI9ulm2tDs7ilvjUGPIsUiol2TuVeg3qGPAIUHZMn1
	 /w1lHu/hH4SrD8vT1c8KyGAswcPRKtTbUcHB5RVRepCJGzZ4+cWp7jZywCosB2kVbc
	 3y6LqdZaVFtUBjcLJDvjWPKdNABCffxsfn/KXei86ZZLTP60LhYeiSb2q5Ep2issBj
	 PfrhmsU54EZQW3rtfWsX39X2b/u0LItq1HM5AABFjKVt/Votex6ZuQLPDdHfK3tx5W
	 Hl5ipoNQ2K/eRt/8iYJzORY7O/TwqVj4cLP/a0w4F5JWujjvhRHjQCD3rvn/6scl+u
	 8yC7BRcPeIWKA==
From: Mark Brown <broonie@kernel.org>
To: peter.chen@cixtech.com, fugang.duan@cixtech.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, Jun Guo <jun.guo@cixtech.com>
Cc: linux-spi@vger.kernel.org, michal.simek@amd.com, 
 cix-kernel-upstream@cixtech.com, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251031073003.3289573-1-jun.guo@cixtech.com>
References: <20251031073003.3289573-1-jun.guo@cixtech.com>
Subject: Re: (subset) [PATCH v3 0/3] spi-cadence: support transmission with
 bits_per_word of 16 and 32
Message-Id: <176314002487.180192.8916984509259656715.b4-ty@kernel.org>
Date: Fri, 14 Nov 2025 17:07:04 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Fri, 31 Oct 2025 15:30:00 +0800, Jun Guo wrote:
> The Cadence SPI IP supports configurable FIFO data widths during
> integration. On some SoCs, the FIFO data width is designed to be 16 or
> 32 bits at the chip design stage. However, the current driver only
> supports communication with an 8-bit FIFO data width. Therefore, these
> patches are added to enable the driver to support communication with
> 16-bit and 32-bit FIFO data widths.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: spi: spi-cadence: update DT binding docs to support cix sky1 SoC
      commit: 55b5d192bab5e152bda8f8cefe837c4ed0ec60c5
[2/3] spi: spi-cadence: supports transmission with bits_per_word of 16 and 32
      commit: 4e00135b2dd1d7924a58bffa551b6ceb3bd836f2

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


