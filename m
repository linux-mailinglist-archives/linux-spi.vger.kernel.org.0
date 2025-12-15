Return-Path: <linux-spi+bounces-11897-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92793CBE89A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71AC7304CC20
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44353321B5;
	Mon, 15 Dec 2025 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwvl8iBg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E53314C2;
	Mon, 15 Dec 2025 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807173; cv=none; b=ffMM77BwefREDJd7JRPjl4GO3C1W4GHrQS8hffK14UinUYlUV1b3inT1/Tfi/R7c069h7yQ0kGb/vt84PaR6NV4r7Y+4BHnoaLPBfC6PX9hvcX2EYbONxEqIiQ7JEllkHxlBbofKyOm5sr+IPdor5TpvBwxTXROLqhWPRL+PBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807173; c=relaxed/simple;
	bh=X8bSPkSn54gl5nm6i0LYZaDo4hg0moqVmaxzKL4v99o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YLNAvYwZaNEK2DTibPTeilRDCiQmN6ZR70BtdIpWLOWEeLkbro+rsGppYq6jQ9MFkKMAWZAmi3OY2+H8lnXIWRXmahmz6HQbdGghlbQAVc4logz4omJwsGkjHhjk/rODK0i9+7cwxZP1xawcpPcy0TmETPCJgzTvdOS+wbcuejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwvl8iBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0D3C4CEFB;
	Mon, 15 Dec 2025 13:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807172;
	bh=X8bSPkSn54gl5nm6i0LYZaDo4hg0moqVmaxzKL4v99o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iwvl8iBgu+44+2mrFTRq7DsILnmh9WsWrxJ7FmMphGh4FfjG4tmO+V34NacuArIUF
	 m2pVgwx6tvl9Na7dwU7fwhRteO99B/KhsHUoD56Iml+avy/aMHJnvX5eZuF7Zq9wNG
	 oq2znZ3YNJCiK89oSmjtUKUNcKnKxNDpE4VhNM3apDGTKGYxt1PcxnrlhCdRw0BDGD
	 kCPhy0mDpCk8NzAW4Ez247ov2XZkOoUZxue96xbPQfnHgkV0aJYTS9E5lVxsMJ68AT
	 mVG23SQ8NC/EZzsy0AOtP83ttMIl09fTp4Qqq1s/Z5rffxgQlZ7aHFHFJbSSCm+VlR
	 L+7AMYNKxIM7g==
From: Mark Brown <broonie@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251205-upstream_qspi_ospi_updates-v1-0-7e6c8b9f5141@foss.st.com>
References: <20251205-upstream_qspi_ospi_updates-v1-0-7e6c8b9f5141@foss.st.com>
Subject: Re: [PATCH 0/8] spi: stm32: Update for OSPI and QSPI drivers
Message-Id: <176580717045.161463.13864912582865667097.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:30 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Fri, 05 Dec 2025 10:04:50 +0100, Patrice Chotard wrote:
> This serie applies the following updates on the spi-stm32-ospi and
> spi-stm32-qspi dirvers :
> 
>   _ Update FIFO accesses using u16 and u32 when possible instead of u8
>     only to optimize throughput.
>   _ Replace Transmit Complete and Transmit Error interrupt management by
>     usage of read_poll_timeout_atomic() to optimize throughtput.
>   _ Simplify Status Match interrupt check.
>   _ Set DMA burst configuration dynamically.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/8] spi: stm32-ospi: Set DMA maxburst dynamically
      commit: e35a7607e05d59d35e937b80532ae93d1dd2493f
[2/8] spi: stm32-ospi: Optimize FIFO accesses using u16 or u32
      commit: cfe58ffc95a601988702df6f3462cb54dde467e9
[3/8] spi: stm32-ospi: Remove CR_TCIE and CR_TEIE irq usage
      commit: f6ed06926b510f54a0817567ffd458194ed90bd6
[4/8] spi: stm32-ospi: Simplify SMIE interrupt test
      commit: e2f0ea18e560e5fa6180f52dffe434525a0cf86b
[5/8] spi: stm32-qspi: Set DMA maxburst dynamically
      commit: 4ef80c71c62ab841db9b1a9d74ffe043c60f6222
[6/8] spi: stm32-qspi: Optimize FIFO accesses using u16 or u32
      commit: 1ca91281649547efa4be34584a304974c9601df1
[7/8] spi: stm32-qspi: Remove CR_TCIE and CR_TEIE irq usage
      commit: c5f76d888810bca2d46297a7b942e10bc8cc69dd
[8/8] spi: stm32-qspi: Simplify SMIE interrupt test
      commit: fee876b2ec75dcc18fdea154eae1f5bf14d82659

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


