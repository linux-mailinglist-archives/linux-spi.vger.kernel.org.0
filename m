Return-Path: <linux-spi+bounces-6241-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABDAA03E66
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 12:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFB03A48F3
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 11:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3241EF0AC;
	Tue,  7 Jan 2025 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAT+FU4k"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85D31EF09B;
	Tue,  7 Jan 2025 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251105; cv=none; b=a6YK0l5ZU70pVXDjKUtvfZpmPjbrqrbX/6ljeo+pL0KDvq2FWMj3j2ZbaItSOQKRL0e0BrB3pDjjIAUBa6kJCRRHtmIjkSpaXfCqMZG9UEt/xfb9+gl6+H31ZpktEVuWEIi41ju9mcgTXxTpA9ppKLhFfmuLqB36NIYe6YTf3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251105; c=relaxed/simple;
	bh=so+HujlspHZPsLZPdW8vF7bkAMuF/wBwtDZCcbrPMnc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CwzOn2EHRQGkyUURrc11Vzwaw6GMNxiiKl8c7ib2A/2BSm48+udcuiwD1nx4g/maT8SjY7PpF9DDuBf6arSLOAFrg7Tm9RBj/E4zEjL01SuifjI3TFckjPn6HloBiKOqn7ufy8gsNhT5UHeW3PW/L7q7kom61AV5cMt7rjFaQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAT+FU4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D09C4CEDF;
	Tue,  7 Jan 2025 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736251105;
	bh=so+HujlspHZPsLZPdW8vF7bkAMuF/wBwtDZCcbrPMnc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XAT+FU4kNfv4jRQeJpyYObRGMjF5LfkFMWxPDxsUp+ikH7GoO5r1I032/wGEyv64P
	 nt5X0A+yLpbs752WYSZNz+qf0jUnjRgbJYL//LmwkWk73UDbf84aJEKQSR4OoWHlvp
	 XTexbGAdFkvcmy6iIZtMpf7j/n2uGGOmrZQJpsocawJIaiDfy5hGjqSU3LxiAD/E7F
	 h4ZgIJXFmOs7WTf3Sv02TU8Zrr3nj7nhuuHzou/4XkGle6YVR7iLrvtV13JMZw7Ogx
	 R3GKpdFMhivNA0S7N8H8FKk7x2zvkk6sFEsRZL6/CpaNqcrzNkojZQf3dO5D8Oc7rU
	 IzZrr/4yaXhGA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241219142851.430959-1-csokas.bence@prolan.hu>
References: <20241219142851.430959-1-csokas.bence@prolan.hu>
Subject: Re: [PATCH] spi: atmel-quadspi: Use devm_ clock management
Message-Id: <173625110421.23847.10158575651527678755.b4-ty@kernel.org>
Date: Tue, 07 Jan 2025 11:58:24 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 19 Dec 2024 15:28:51 +0100, Bence Csókás wrote:
> Clean up error handling by using the new devm_
> clock handling functions. This should make it
> easier to add new code, as we can eliminate the
> "goto ladder" in probe().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel-quadspi: Use devm_ clock management
      commit: a38509fd5cdc125ef54562760a05c68ebd4812bc

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


