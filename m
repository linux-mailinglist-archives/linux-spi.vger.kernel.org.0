Return-Path: <linux-spi+bounces-2386-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83DC8A7ABD
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 04:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1271F21035
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB85D187F;
	Wed, 17 Apr 2024 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHx/0jME"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97999B657
	for <linux-spi@vger.kernel.org>; Wed, 17 Apr 2024 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713322233; cv=none; b=EHwAENZlTUGp7H86d6R0Kv0Gzn2PZAOD0CIxExNuSaT/L+eC3CRCEGChVwKlmotI1mGrGP4ZiDxkIktrEtsTk1gdotw/8N6aNZMi7G+WPwptEu4QRxOTjlk8cABs+vTMIsItWTqFJVR+l6Bg3BfQne96HKd5OME5Lq635x8lHNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713322233; c=relaxed/simple;
	bh=fl2V/ulUKM5Tsu2GXDcWmyGacmxln0OGET4sP3Wr+rc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JLyO9eyr8/tqg6Ewhn4P5ZtYex/aWl0fSK6zUBIO268so+Y65fpKPh7kRWu1ocPGdCi69uKqh3bkWjmpewmOv2aCTpulCpRhxeELGDMvJ6y4WcBR8qdcI8cWuvV6Spou92dGy/ig8a1xgwpbVfwe8II8bzd5g+vjySukG8RIuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHx/0jME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1366DC113CE;
	Wed, 17 Apr 2024 02:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713322233;
	bh=fl2V/ulUKM5Tsu2GXDcWmyGacmxln0OGET4sP3Wr+rc=;
	h=Subject:From:Date:To:From;
	b=IHx/0jMEvBeCd15J3wPMqHdKWqa56LZQ1yTP9Gxu5PeTcTgnd7gDoyJSu2LlM+G0w
	 lV6iGPce2fK4/Z2F5eTYTuPQKMKHKe1wMtXygGeFQPrvff4YDLq+BJGPWdL0L8rRmZ
	 /Q+5dg+nJ8ZX00+0YTyww3gAD2ttbylmfhaODIfMWj2WDtm09ZUPfAACsa2wnWjkTK
	 62L3SUABLUcRQV0qupw+gCQilGM0xtpSmqwehqRqq4UIgTq3Bq7thu85bY5oyX84D4
	 ajS3xXXnj4Lz3R0CCJwFeu0ozxCtlEp6VWeWwEJvkrUlTXnewzsMb9+0H8FwVOxpAR
	 tH5Dz7U1O6Y3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F267AD4F15D;
	Wed, 17 Apr 2024 02:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <171332223294.3394.10377618139837040171.git-patchwork-summary@kernel.org>
Date: Wed, 17 Apr 2024 02:50:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add bridged amplifiers to cs42l43
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=844996
  Lore link: https://lore.kernel.org/r/20240416100904.3738093-1-ckeepax@opensource.cirrus.com
    Patches: [v7,1/4] gpio: swnode: Add ability to specify native chip selects for SPI
             [v7,2/4] spi: Switch to using is_acpi_device_node() in spi_dev_set_name()
             [v7,3/4] spi: Update swnode based SPI devices to use the fwnode name
             [v7,4/4] spi: cs42l43: Add bridged cs35l56 amplifiers

Patch: spi: hisi-kunpeng: Delete the dump interface of data registers in debugfs
  Submitter: Devyn Liu <liudingyuan@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=844865
  Lore link: https://lore.kernel.org/r/20240416015839.3323398-1-liudingyuan@huawei.com


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



