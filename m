Return-Path: <linux-spi+bounces-1773-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA3B879970
	for <lists+linux-spi@lfdr.de>; Tue, 12 Mar 2024 17:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EDB6B2249E
	for <lists+linux-spi@lfdr.de>; Tue, 12 Mar 2024 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6DA7D074;
	Tue, 12 Mar 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilEdVLK8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166A9273FC
	for <linux-spi@vger.kernel.org>; Tue, 12 Mar 2024 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262639; cv=none; b=M8ZSvwrO0nlH8rud4unWRWW51hB5x5o3pu4W9ErcbtJHOmXkhuPwps2p4VErUcOugyBzIXSSrfKU4v9QLFXnEppMAG3SiCQjwWeF2gSMk9WAXAJltUpgrEii6vu+aidbZide0O3kZMlwCcudEOwVSBRXpB/mOX9UK7+4vtaZxsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262639; c=relaxed/simple;
	bh=Uy+8NclRUVuYSYZ3P3VjspEbnc7wm6extdS6k6ryi50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nSm9IBSHkGWsXi7NEqOEnIBVueK+qCVBLkbUm59vUZUFI5Dt9S75QDHJH+araYIIHCnGOWkj9THAl4liBbDHAKgxs6r1OPiwK65W61kRuD3vlR/wTFoWYqKNBrywNw9c75MFYbtfGgEA7haybd7Be3ELvEcoHP1zqaJ++ZiRZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilEdVLK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96B6C433C7;
	Tue, 12 Mar 2024 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710262638;
	bh=Uy+8NclRUVuYSYZ3P3VjspEbnc7wm6extdS6k6ryi50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ilEdVLK8kBpvRDbbUIutv27NaOHBzE0t7CyK91pwd8MZSciU7aiMG7IMEjMgQbXgL
	 M/fw+4cOPjCj1wpRiJ5+G1ks/FF/5Y6aAdzeFPmTibe3Xc7+VTFPoQpavTODBpPCn5
	 J3s6G1jTfDu0idGsSUmKzK22eJMxgc5Wts0VqJl7hb3FlJ9xgagqHnHdXJVm162qFl
	 N9Y3bN23NBhUHJHSY1NOlIeRX3CcB6vL11/5jcCYKY0VHNEug+f5dPn7sxQ/V6Xe7L
	 ydL9qparAbv7e6KaWJnUNKpBcQlRBb+kAvHp+UCYjR6+iYUGR+LhDTAAylpwsfdZsK
	 w8t4nPigNpjzw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, 
 "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>
In-Reply-To: <20240312112050.2503643-1-alexander.sverdlin@siemens.com>
References: <20240312112050.2503643-1-alexander.sverdlin@siemens.com>
Subject: Re: [PATCH] spi: lpspi: Avoid potential use-after-free in probe()
Message-Id: <171026263744.57722.16507958427135572229.b4-ty@kernel.org>
Date: Tue, 12 Mar 2024 16:57:17 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 12 Mar 2024 12:20:48 +0100, A. Sverdlin wrote:
> fsl_lpspi_probe() is allocating/disposing memory manually with
> spi_alloc_host()/spi_alloc_target(), but uses
> devm_spi_register_controller(). In case of error after the latter call the
> memory will be explicitly freed in the probe function by
> spi_controller_put() call, but used afterwards by "devm" management outside
> probe() (spi_unregister_controller() <- devm_spi_unregister() below).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: lpspi: Avoid potential use-after-free in probe()
      commit: 2ae0ab0143fcc06190713ed81a6486ed0ad3c861

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


