Return-Path: <linux-spi+bounces-7713-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEF1A96C37
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 15:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D1C3A98CF
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 13:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52064281371;
	Tue, 22 Apr 2025 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNxdMX7f"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF228136F
	for <linux-spi@vger.kernel.org>; Tue, 22 Apr 2025 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745327592; cv=none; b=HCWt3tqAbrhcqBH14UAh5uIVdk4EUV5VRUnZ5KuTnBb/yHrLC/qqldDreREjSE/a0cmmlQrF5eOVXKGEzbyDwv8Brfos70MS99BmfIRB2GM/jFFRJWiokBE5TLXcUasa2Rscj1qFmfXPa8JBSjwCnoA5FXf5W+Xtg66OPzkmGso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745327592; c=relaxed/simple;
	bh=zr1VbvzBVSB/gm+kuU++J0jcjwAJtY/78yOU2yeOKxk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aEuriSbE4watZCZ22j4F+Cm3k9+zZFcjJiPz5y6yECPmiU5OGdAtwzBcBLUIuFi90m+DVFl8UhMmQULy5Gx+/XOUUI8ZoO54m8Kv72pJz+k0S8olNIcTbUmsFSBmhu7NWM0C6jBtRFLPaoNS7d4kV1P4ZIwE7+uW+XcjrQZ73zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNxdMX7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B685AC4CEE9;
	Tue, 22 Apr 2025 13:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745327591;
	bh=zr1VbvzBVSB/gm+kuU++J0jcjwAJtY/78yOU2yeOKxk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sNxdMX7flK7+vD9WoMdj8YoGzqKBbZo6EpOcQBLDPNckpBt9nOBHvDj+4q+j85dnT
	 rnR+ZhqPtLWc8Jmmh14FODhKOY0IWVq3YMmUbV7uXyV7CZYZDtIjPuL/qg8YjG7Aer
	 f+pgBlugbp+eo+TV3stQGzZxoD0eqB4VxMj4g0cQWdaD/NweNPlBMRlJd39rTuXAQc
	 2SYxysL3NeTFaaOiIJuj8/c2P5E1HkF2q4IC7Kj6M+S4RCNZ2+AKsmFqqSVXQzoT+M
	 +/zM7m947QRvo3zSPdX9wSMx6ecCfkyiH8fQLd4l1n06LDyjhs/IgkjaLqJynt5FtN
	 v+hHII3wDt78A==
From: Mark Brown <broonie@kernel.org>
To: dlechner@baylibre.com, Andres Urian Florez <andres.emb.sys@gmail.com>
Cc: skhan@linuxfoundation.org, linux-spi@vger.kernel.org
In-Reply-To: <20250418171426.9868-1-andres.emb.sys@gmail.com>
References: <20250418171426.9868-1-andres.emb.sys@gmail.com>
Subject: Re: [PATCH] spi: offload: remove unnecessary check on trigger->ops
Message-Id: <174532759046.44373.12764926073369158621.b4-ty@kernel.org>
Date: Tue, 22 Apr 2025 14:13:10 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 18 Apr 2025 12:14:24 -0500, Andres Urian Florez wrote:
> Considering that trigger->ops = NULL happens only when the trigger is
> being removed from the list, and at that point the operation is protected
> with the spi_offload_triggers_lock, it is possible to remove the
> !trigger->ops check because it will never be true in
> spi_offload_trigger_get()
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: offload: remove unnecessary check on trigger->ops
      commit: 296e8d289bdd7eb0d832683ebd3e847fbb4c1b12

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


