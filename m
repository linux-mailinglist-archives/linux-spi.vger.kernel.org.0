Return-Path: <linux-spi+bounces-4475-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6A2966743
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 18:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514471C22F37
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 16:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C561B4C33;
	Fri, 30 Aug 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBwUpI+O"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972941B3B10;
	Fri, 30 Aug 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036393; cv=none; b=q7eUT7S5VEq9TdU72p/JAgq8jrfTPYUXpoaMJUJ/9LzJxoIPgJD29KrLoNUJBjWL0rY8UM2QXfKehtW9+2PTtyR8Xw8OFczHYdWUAiXNkUQ1WOakJJ2F2i5eow3Xq+yXAJJ3Xhng52um8Y3DRATDLrSaa/GvsKhkr8yhvgdGcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036393; c=relaxed/simple;
	bh=j2pAcpMVTJjKxG4sxxU8zeRMM4mJvAZnC2+vSeYq+sg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TEs4y2GRfafclvL2Cuu33k+YYmAYqHwQ5eD/IL8f+EqtKmQFbQJSYIt/xhsGOu2EK+TpZzCF/h9/JdPM1Ws+99ZuNzN4NnSu9RvF1FNEkVU//BDVE1qvHDgfjHE7/ts6jGbfa/rbSHJnn+R1K8fkBcK7y8dEnKLsBlk8+aqvVwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBwUpI+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB70C4CEC2;
	Fri, 30 Aug 2024 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725036393;
	bh=j2pAcpMVTJjKxG4sxxU8zeRMM4mJvAZnC2+vSeYq+sg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LBwUpI+O1L1OfbbLmMYpzgFJ+wD2pWOycAcUrqQXdvE3lGZHKbIWFPWYaCdbpoaNC
	 Y8pqd49yK8HFYmgPXzRJX1GKYjK6tuQGYHHmlShpp8S/alsXA/SEuqd/aZYGtb/gbY
	 zU0RZiSpBzOEc1yuhe+v2tNhsXlhJan2h35z2jC39dncTaPOK/TNfTZnlh/b9dPc8i
	 Keo5lSw11Zay25Xb56E31PRqO/OwQNpupW/4DmzL4nTZrHwLs/AFZ4c6lMDW7U13Mz
	 S+WFxL495tczRaPAHno19S1ef5Of+WY1nuYoxs4ejw1QH2anu3KqBhl4+obagihyYk
	 IFzuMPCukrbpA==
From: Mark Brown <broonie@kernel.org>
To: mika.westerberg@linux.intel.com, Charles Han <hanchunchao@inspur.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240830074106.8744-1-hanchunchao@inspur.com>
References: <20240830074106.8744-1-hanchunchao@inspur.com>
Subject: Re: [PATCH] spi: intel: Add check devm_kasprintf() returned value
Message-Id: <172503639203.177300.15277718564430681896.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 17:46:32 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Fri, 30 Aug 2024 15:41:06 +0800, Charles Han wrote:
> intel_spi_populate_chip() use devm_kasprintf() to set pdata->name.
> This can return a NULL pointer on failure but this returned value
> is not checked.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Add check devm_kasprintf() returned value
      commit: 2920294686ec23211637998f3ec386dfd3d784a6

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


