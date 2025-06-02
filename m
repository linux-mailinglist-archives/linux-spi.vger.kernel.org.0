Return-Path: <linux-spi+bounces-8357-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7936ACB8F4
	for <lists+linux-spi@lfdr.de>; Mon,  2 Jun 2025 17:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFFC169997
	for <lists+linux-spi@lfdr.de>; Mon,  2 Jun 2025 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F721DEFF5;
	Mon,  2 Jun 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm+Hxg67"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C436C20E026;
	Mon,  2 Jun 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748879456; cv=none; b=QjffLStNvEDHgLObz8p2esZSQ+TiROdD+j3KVi/pgr5fhQ3vprAVtID+eA4DTUMrb+3rhEcjTcJhkc97+RS1B9Izgbae6sk9Fm1U0XPLHX3kYDadsvCG3aoP/jghZ2cmWE1vIOU8uAGMYGtxBXkp3po7Z6/DXGLNWoTL4G8bPiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748879456; c=relaxed/simple;
	bh=YEPHIKlGLClOFLF3x9dL/ailZKjYUZH2cpkfYEmXJxw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L7ZnANiaxFllvPBLP8LSNpjJejc0kc1z3DWEYDscn29wFTHBN9iT3+3ZRFsKGwkNFFqmdI1/e7CEHtpUKm6QHDhEheowiP2PDnEuIpcmGTYATfhH1HPxWtVrwYurZ9sSk1BXWD4ygWM4AoXApYyaELlhbQA10gmoBdnpEuz92TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm+Hxg67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95282C4CEEB;
	Mon,  2 Jun 2025 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748879456;
	bh=YEPHIKlGLClOFLF3x9dL/ailZKjYUZH2cpkfYEmXJxw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fm+Hxg67Svs9O77QDuWaZdE5wzZ3qE+sSAUBwYIt9isqkYP2Ly312pLBdPmcZnx/o
	 DRTKLg+mE+dknYQXr8Glkl/Q1tWhlqOtMS6OiheU3LyV2D1i9UvxfGODNYlt0rec8k
	 98o461YMkXtyMac0hoDd/YemsneaNt9c38NwzPHtS1nKSk66+0hCZ7Tt2WezasTB2L
	 LYxiYUWQhcko+9qEKPLEApdNp8RljEbwEZmwEO/Pvp4uveYRZtxhJIh7QRM9nPOzaR
	 6MATg6ZO8yuU4zAVVe5s3lfjNmtZvbVpV9tSLxTcycozDovJ9oAF+8sFt6pIL+VABl
	 F1lCCQyRs7JXg==
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Gabor Juhos <j4g8y7@gmail.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250527-qpic-snand-limited-biterr-caps-v1-1-61f7cf87be1e@gmail.com>
References: <20250527-qpic-snand-limited-biterr-caps-v1-1-61f7cf87be1e@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: document the limited bit error
 reporting capability
Message-Id: <174887945434.88179.3123674776894271663.b4-ty@kernel.org>
Date: Mon, 02 Jun 2025 16:50:54 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Tue, 27 May 2025 13:08:16 +0200, Gabor Juhos wrote:
> The QPIC hardware is not capable of reporting the exact number of the
> corrected bit errors, it only reports the number of the corrected bytes.
> 
> Document this behaviour in the code, and also issue a warning message
> to inform the user about it.
> 
> No functional changes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: document the limited bit error reporting capability
      commit: 57cf46cd1fe351846e1b065ca9546eef66675ecd

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


