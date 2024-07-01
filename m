Return-Path: <linux-spi+bounces-3712-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237BC91E314
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 17:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546B71C2127F
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 15:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEB114C587;
	Mon,  1 Jul 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anzRdTH4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26614BF8F
	for <linux-spi@vger.kernel.org>; Mon,  1 Jul 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846029; cv=none; b=iyGXAq7bhR+1PEkEM0FzvEGEAFUTAVbqLWF6ZGcCwKPvsf5htIFBaw9HqWhrdRtfD3fWXYblrZruTiGLbGrycPCH06aeUgn/UjrtntizzNIvpOgc3zX+z+EC8zaa5eW+TgAuxvZaSJ60vJtvlJtd8MJqXF5wrw83N4DgYNZZ/pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846029; c=relaxed/simple;
	bh=R6yF3B4OgwAsZMl5pmibOfdTU7MIR1NYNR5aIQULOjo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ofewWkh9L19yIqzB1BtL9UrNNwPrta/dEaNpfdutWzF/FogO+nxw+eugXDBYwZ6yNga9k0fckll/GciF1ah7TYvvm8lYQ5Ic2eHWJdpKLr5oUDRv4MFJv+SeruZByCEbx+6D/kFHdgZmb0X359IifPZVLOJM9Qp1zj6VKdKzESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anzRdTH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F744C32781;
	Mon,  1 Jul 2024 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719846029;
	bh=R6yF3B4OgwAsZMl5pmibOfdTU7MIR1NYNR5aIQULOjo=;
	h=Subject:From:Date:To:From;
	b=anzRdTH4/HxN/m0NaBvCRmmGs/pBg3lMFKzGgAX/+gOQalhF4LuFer0lHhU6gEvLh
	 FFOQ3Bs0lU8MhEuNTqDxxigD0s0c0AyUXceuDyhVXOjBZy7pQ3azvRzh5DWIsXjc38
	 zwnyasZbjtww3+WzzaqFttQ0VS/3Varu3RzdX9VBHSNOnYO7awFgMarJEj3aqL5Zjg
	 qffLS8o0BBM8nPIjRUJ6mwrcGIoWTSoM81yZWaJECPL3f/v4Xdtw9TBBOSlJ84yY3Z
	 +M9tvqTWiiTBJeWkPRwvBH3/hbtYjeMp5Vs/D98KKmlHjsKhhfKUYU/dtFLD3ZNNE6
	 vxPE8h7tZcavw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40D98C43446;
	Mon,  1 Jul 2024 15:00:29 +0000 (UTC)
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
 <171984602921.19228.4960621797444313900.git-patchwork-summary@kernel.org>
Date: Mon, 01 Jul 2024 15:00:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: fsl-dspi: Convert to yaml format and use common SPI property
  Submitter: Frank Li <Frank.Li@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=865031
  Lore link: https://lore.kernel.org/r/20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com
    Patches: [v4,1/3] spi: fsl-dspi: use common proptery 'spi-cs-setup(hold)-delay-ns'
             [v4,2/3] spi: dt-bindings: fsl-dspi: Convert to yaml format


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



