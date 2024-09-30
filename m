Return-Path: <linux-spi+bounces-5068-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5820298B132
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 01:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1471C1F24E39
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 23:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0D318BC00;
	Mon, 30 Sep 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeNwDNBE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9C183CD6;
	Mon, 30 Sep 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727740284; cv=none; b=UhpUXFG4aIGuA13wld66WRZID7oafxJoVBBz8Vh8v4BjgBzFYhiZkzoSkmyLibvSWH1v+aTqLTKt0mJEg1ezNa/Tow7cVlRQgKJ3SRIdkvJlzhxD5ODUg4756SAhvmi9M7gtp4DmaQnbfCIX9r/1QXEHGYVg38uNWRgzzdPaZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727740284; c=relaxed/simple;
	bh=Uk3PdLg955dZQoJQ41DO3BnDpQDkq1+7444DCrTBGho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NWdYWihoS5UqinozH7TV+ZQ+tjWK/TwHrBgD7HSDzVJBc3eId8MuSzVNXAJ4MXueajFoQphHw0pNP7CVn91U4XopepOsbhNb+ezD2K3xK5kTSoPdTiJqmxPGbJOLLvnC9iCNIjfxX8Yakjz5SsHn5YCVXsADUGb9f0gJxg3D3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeNwDNBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08876C4CECD;
	Mon, 30 Sep 2024 23:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727740284;
	bh=Uk3PdLg955dZQoJQ41DO3BnDpQDkq1+7444DCrTBGho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GeNwDNBE/ojHUnZC6Qd+BMOvWeeC4wUy+nvWxmDk79FcTx/fnq6Kn7iP04dYowyLq
	 pWI/5Ya3Gs+JywsqT8yHtKFKgVdM4ghrzUcSlAZ1+ynwFrTPJdhcHHO7cBEeVhFRaO
	 aIxZJaJlPByBVhrr9//dT+WODI9Bv+ICU4pUwXZ8jsVF9kJrOD+Y2KTLYzkPQ4B4bl
	 TzO/Upe08aVZDifDpHk73MUJ80Ae1lGQKwJWPb/+aoMhcUX8z7bSIJDVqlEUZLVUvd
	 SGkOa1FA4OAYhrs6XvwSk/hTKDrrCYk89QI9eqPUGMVp98Zh62OUqvbtMVvGqWXvlR
	 zHh+T6Dhi7Hng==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-kernel@vger.kernel.org, sanju.mehta@amd.com, 
 krishnamoorthi.m@amd.com, akshata.mukundshetty@amd.com
In-Reply-To: <20240925133644.2922359-1-Raju.Rangoju@amd.com>
References: <20240925133644.2922359-1-Raju.Rangoju@amd.com>
Subject: Re: [PATCH V2 0/8] spi: spi_amd: Performance Optimization Patch
 Series
Message-Id: <172774028281.2264837.3500240007154078331.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 00:51:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 25 Sep 2024 19:06:36 +0530, Raju Rangoju wrote:
> AMD SPI controller’s index mode performance is constrained by the
> hardware limitation of the FIFO queue length. This patch series introduces
> optimizations to the spi_amd driver, aiming to maximize throughput and
> enhance overall performance. The changes includes,
> 
> - Enable SPI dual and quad I/O modes and update SPI-MEM support function to
> reflect AMD SPI0 hardware capabilities.
> - Utilize efficient kernel APIs to streamline SPI I/O operations for
> enhanced performance.
> - Refine the set tx/rx count functions to optimize SPI I/O throughput.
> - Minimize the number of data read calls by efficiently retrieving data
> from FIFO queues, improving SPI I/O efficiency.
> - Add changes to support AMD HID2 SPI controller and update SPI-MEM support
> function to reflect AMD HID2 hardware capabilities.
> - Add changes to set SPI controller address mode before initiating the
> commands
> - Add changes to implement HIDDMA read operation support for HID2 SPI
> controller
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/8] spi: spi_amd: Sort headers alphabetically
      commit: d6dc8b7534d5c9dec80fdd7d4af20fd71602d7cb
[2/8] spi: spi_amd: Enable dual and quad I/O modes
      commit: 769c16fa86f135542e08610e94015ed0f10afae4
[3/8] spi: spi_amd: Replace ioread/iowrite calls
      commit: efd9834b86a65f9229e90727fd61a5576c08389c
[4/8] spi: spi_amd: Updates to set tx/rx count functions
      commit: 8cd9141ad4e053d361c854cc24a18a9ca050e0a1
[5/8] spi: spi_amd: Optimize IO operations
      commit: d97735d42ab00e2f9ac4bf7cd374249cde9cb193
[6/8] spi: spi_amd: Add support for HID2 SPI controller
      commit: 145d61c0ab3344f7f76f5f8cdd1134477c1def98
[7/8] spi: spi_amd: Set controller address mode
      commit: 9674f1694e644aa5cc50e1009481cb4c5b4e8f8f
[8/8] spi: spi_amd: Add HIDDMA basic read support
      commit: 6c30eee359127c31cd8c6b586c8c3ced9f50f74b

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


