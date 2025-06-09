Return-Path: <linux-spi+bounces-8410-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33967AD26D3
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 21:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9F13B0090
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B09220F3A;
	Mon,  9 Jun 2025 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On4WlChj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D08B2F4A;
	Mon,  9 Jun 2025 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497632; cv=none; b=S25783NuQr4i1mGI3lYyeL8NqdklZ4o5obQNcHmI1878Tt2CfGe7PCXeb+SslBn8uR+q5o5UzmSbB33xV9IsvJY7OQrseHVE9knCFTF+5cROEBsRoCciKVdEQvvL0epmAZ438EIDN49t0U+9DR2g0AWjPh6GFCtUNTOBaS+LeNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497632; c=relaxed/simple;
	bh=TP4hyTs8h8YAb40w69Vr1lWI5iqkgDHn/WQE3QL865I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YNptEZLmUPUgzRPecKlzFlNFi+T4CdUT9Q13sdT3m/Uuw9DfcnCwmw3pcVsuDHZV8eqEeqHLD9X6WYvpWCBBdo8DSRZ1dz9XmlM+rEgOoZ8kvMTs/5oElguFPisAZgEz2RzzRegvGPOLA48gXwTm7RqEToT7wRuBZP2QphnI5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On4WlChj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C951EC4CEF2;
	Mon,  9 Jun 2025 19:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749497632;
	bh=TP4hyTs8h8YAb40w69Vr1lWI5iqkgDHn/WQE3QL865I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=On4WlChjQCtAwoelwqwcdRxT8v1VCfv9hDzz+aUVbE0NAnnPCdMwnRJZrHJAAsA87
	 9eICV9OPwQfMAKTi4FOITRspcsHnxzgdF/G4ysHnizfG59bTOcRM2to7g9eSP72FpM
	 0HoZwUL1uSkO4UUO2Nj+yqyp5Lz/irfY/Fyed2DioexiTtcS2R2q/4Lyet4ACuM2hv
	 C6Hx3fENqlFhOFbTX13N9nn/n3wbfWavsssxaitxiIZ40NRQY6UQG+dTlKUy7piqil
	 72Mv/sNZS2ylZ2657IXoYVXYrFs+1gduKYkaC7EBnuW1bQK4AnMx62fIg2uBma+8E5
	 PXUpxiUAgpwfg==
From: Mark Brown <broonie@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250609-b4-upstream_ospi_reset_update-v6-1-5b602b567e8a@foss.st.com>
References: <20250609-b4-upstream_ospi_reset_update-v6-1-5b602b567e8a@foss.st.com>
Subject: Re: [PATCH v6] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
Message-Id: <174949763058.256775.10348789503749491026.b4-ty@kernel.org>
Date: Mon, 09 Jun 2025 20:33:50 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Mon, 09 Jun 2025 17:05:04 +0200, Patrice Chotard wrote:
> As ospi reset is consumed by both OMM and OSPI drivers, use the reset
> acquire/release mechanism which ensure exclusive reset usage.
> 
> This avoid to call reset_control_get/put() in OMM driver each time
> we need to reset OSPI children and guarantee the reset line stays
> deasserted.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-ospi: Make usage of reset_control_acquire/release() API
      commit: cf2c3eceb757e3f28e6f1034f9bc178e1535f5cc

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


