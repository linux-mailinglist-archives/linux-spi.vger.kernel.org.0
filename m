Return-Path: <linux-spi+bounces-7436-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA22A7E64F
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 18:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BF33B043A
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E25D20B21A;
	Mon,  7 Apr 2025 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6+8k+pT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1476C207E1B;
	Mon,  7 Apr 2025 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042547; cv=none; b=NbCANNTMFobf9ITXH7eITBshRHOr5DGRgD+0KJNvs9T4GVeMlgjolz0ZGQmVgpm96WK4gnr69QgfmKoHeS8SzgGejPlAY8QEtG7aEFadI6zUXYQGabv/sBhMKA9ChVolOFvZWZB29r28jzzmzOBE55Zo/U2WXaLp/nGdfweVeCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042547; c=relaxed/simple;
	bh=/vZrV4sTxkcoN28b/L2BHGZocW18xExXmkYKNBBY7JA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nMon/Vn/fDMLwP4WTRcrLZW//9U4iVTRcNvw3FQkLj7NrhcFWhs+XdH5EQYU4j7ok5PZD4KrDFKNpKbPIcIw+Zpv45lPI9MfD81IECO9TkY2iMXvxwz3FFg5ey1Z9oua/keQ0lFsqAe08pjxTs85fLBR5DBlri4HV/g3A3wl1Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6+8k+pT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E19CC4CEDD;
	Mon,  7 Apr 2025 16:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744042546;
	bh=/vZrV4sTxkcoN28b/L2BHGZocW18xExXmkYKNBBY7JA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m6+8k+pTP+eQ5L1rJZalS2n9o8JLaIHkqpYaDH4HWm5Jt8FAOftYvYzgYYntHdbgt
	 VRfxh6vTQhLfVW7KbLPtcSdrv+0O9cgh9hKGPzAR2SUUncF6Z1fMjBB/poXyzJjPy4
	 rZVUxatZDX9MyjueUQ3lwriMMxzoj7APJL6eZX4waS5/c7XryZuxLG3E4hw1zzkyyL
	 /dWEzGvDZqSVvncbLDPndVQfNRfzreNpqz1JaF3M0OD+NOuJlaxWy93Mxkx7Pdb6EL
	 Gm0ZC1FOYMQjkHVSSjTtTbp45X4bAtrsMaRM2fnyqbo1JhJr0zyi6FpiLMYzBCqDE6
	 5TDpTGvVM2HCw==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, linux-spi@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250320-qpic-snand-kmalloc-v1-1-94e267550675@gmail.com>
References: <20250320-qpic-snand-kmalloc-v1-1-94e267550675@gmail.com>
Subject: Re: [PATCH next] spi: spi-qpic-snand: use kmalloc() for OOB buffer
 allocation
Message-Id: <174404254509.780717.1127447329039664549.b4-ty@kernel.org>
Date: Mon, 07 Apr 2025 17:15:45 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 20 Mar 2025 19:11:59 +0100, Gabor Juhos wrote:
> The qcom_spi_ecc_init_ctx_pipelined() function allocates zeroed
> memory for the OOB buffer, then it fills the buffer with '0xff'
> bytes right after the allocation. In this case zeroing the memory
> during allocation is superfluous, so use kmalloc() instead of
> kzalloc() to avoid that.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: use kmalloc() for OOB buffer allocation
      commit: f48d80503504257682e493dc17408f2f0b47bcfa

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


