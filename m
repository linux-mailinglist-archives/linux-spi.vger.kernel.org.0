Return-Path: <linux-spi+bounces-7195-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F23A67691
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 15:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E657A8785
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 14:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BCD20E6E1;
	Tue, 18 Mar 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sevystGn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8520E339;
	Tue, 18 Mar 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308656; cv=none; b=mBe0EQg0F+lBpyB7jcDDeUqVPiG7ufzDddbCRX2Qp4iJU5HPD+wiB7gc4aX2w0fZSMCID2dOiFQi3TI9c3m232VRXzHGR/oCO0RIjiYQpyVyy9Gb+x9tsf+Q3KS44OtLe4IeLURbnXm8di+opiu85juUKDFBR7JOw1g3FjTdtnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308656; c=relaxed/simple;
	bh=NX4c/xiPn8V+9BjqrR5JwjDS1CkFsXXkJIJk9bxYP4U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gbKLA3qvHfLXHJ1yZCFhuboIyWkzy7ZfiNms+NmUnKzWr7ENguwdnpvua27xP8qGKKGg10FoJJhxvsFRwD+aGmfxRBtuN2VanqvX+Ohs7znLqykX63UdNB2eQNvc9KlyzQsPVbFX4fyk4w40UFb80IZllTlzVs7OztheQf671xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sevystGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D910CC4CEEE;
	Tue, 18 Mar 2025 14:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742308656;
	bh=NX4c/xiPn8V+9BjqrR5JwjDS1CkFsXXkJIJk9bxYP4U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sevystGn180FbiON8S/zJKGGF3BOsRnLdgGsUvnNWU8O3duETbTUCDSDd9Pmk9Drf
	 wr27QJbX/SilnlDN6FyFay7AmoJATbfM3Tt6bauURmkos++yd/++F4mejG9zY9jnH2
	 UIdFAZ7WN8cG/zXcs67XhDeUMgCPg0rIF5VpOIl00HEUVjyGGOjdkEV+MSpBD3tdOb
	 +95FzuLkYxB7LsKvEWIgV1DFZnh1Rd/rhXkiTuGR3mVCDnwgMGr5/bDR4alrwGffgX
	 3m7Mnnhadkp512WY+AAS5PKqGn/fG/JjEpmLJoY8042ibRznJKcqDC0FYWrXcz4cCm
	 g6PTnACR8ZfRg==
From: Mark Brown <broonie@kernel.org>
To: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20250318045549.1711502-1-peng.fan@oss.nxp.com>
References: <20250318045549.1711502-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH] spi: stm32-ospi: Include "gpio/consumer.h"
Message-Id: <174230865462.108912.8267700120820923591.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 14:37:34 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 18 Mar 2025 12:55:49 +0800, Peng Fan (OSS) wrote:
> of_gpio.h should be deprecated, use "gpio/consumer.h".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-ospi: Include "gpio/consumer.h"
      commit: cc1273dfac2697545adc9418c890ac194f18f523

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


