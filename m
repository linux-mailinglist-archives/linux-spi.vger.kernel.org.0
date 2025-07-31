Return-Path: <linux-spi+bounces-9251-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B38FB1772B
	for <lists+linux-spi@lfdr.de>; Thu, 31 Jul 2025 22:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE9A5A131F
	for <lists+linux-spi@lfdr.de>; Thu, 31 Jul 2025 20:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5EB25F984;
	Thu, 31 Jul 2025 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuGphA9r"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E0C19ABAC;
	Thu, 31 Jul 2025 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993878; cv=none; b=iWm2e3H3IjZ16uYDQ2xFeiyxlOCBHl2x7cYrAUEXGd+IWbo2CoTOVVbb3JNdt1ovIm+A3jJ0QkcX26xGdyfZsEpdsZgcKoRtBhnKvgveSoH23XFnq3VAmLurQOOuuwmHYXMGCFiIu/AQDzYcLWF1Ww8G7Ln81NJmpucJqX7citw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993878; c=relaxed/simple;
	bh=6Z7i5YajHNTIkkMs+weIqxL2dvnDzhrWWIA+qiSFCgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I1LTqN56OY9fq/Nbr1Jdg9mxI44KPnLGUzgcyHjexRNR8fDZctHzFKTmmLpUlJ9VfB4foFwd8ZL7vnLHeh/6qtFTW0plqOxNck8XiaheiTbPCbmJCJMTOMEYDD97ycKqY/XksPiYPNqFArsmIZXyYajx2RLfaB2YuSudhzYwIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuGphA9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBB9C4CEF4;
	Thu, 31 Jul 2025 20:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753993876;
	bh=6Z7i5YajHNTIkkMs+weIqxL2dvnDzhrWWIA+qiSFCgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iuGphA9rS3S7mKH6ysy2QJya1DG1fUPcHpIE2kds1BOd/w5drscSXcIwv2k/9eSAE
	 kcvM+Z+xgQDVWcy91MLg0CrcC319I1pSxb0YrYrqLBLqLOdXLfQoLSZ+0RODT2dRpN
	 i4+6S7/zjeBraQ/uaglXYL/psy5Q/CcedK5LqHxQEqreHumOhattZ7F++xQS/0417t
	 DYq9lsxxa/q7GRorWUnATAZH+ePWxCcM5U2bMAgfJAWmCW0QkuhXJrq/coSkL9HCVJ
	 bEFGEDgl/BLL97HN8gIaezIuCRIWJVFH0c5QpkOi/frFKHsDhxBRfP5NtDWHXwLcPP
	 ny67fa1/XbJLg==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20250731160109.1547131-1-simont@opensource.cirrus.com>
References: <20250731160109.1547131-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH] spi: cs42l43: Property entry should be a
 null-terminated array
Message-Id: <175399387554.235090.10856142124114737348.b4-ty@kernel.org>
Date: Thu, 31 Jul 2025 21:31:15 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 31 Jul 2025 16:01:09 +0000, Simon Trimmer wrote:
> The software node does not specify a count of property entries, so the
> array must be null-terminated.
> 
> When unterminated, this can lead to a fault in the downstream cs35l56
> amplifier driver, because the node parse walks off the end of the
> array into unknown memory.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] spi: cs42l43: Property entry should be a null-terminated array
      commit: a735ee58c0d673d630a10ac2939dccb54df0622a

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


