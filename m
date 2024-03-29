Return-Path: <linux-spi+bounces-2114-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F7D891BE9
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 14:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022161C208F7
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9F11386D2;
	Fri, 29 Mar 2024 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPCRnXRM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345B913280D
	for <linux-spi@vger.kernel.org>; Fri, 29 Mar 2024 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716040; cv=none; b=obvyTJvH+7OQjJdUACL49WcIByJPYcuVKwWOj8R7x9FxEVvVZwOqtEYz+T6KgtKUXCYrQDLCrMbcKmVe1A1RnkyGgqut/OiUb2cPB/aGoHo2JCzIZvCe+4RdfzOEcUuxFoVpsvfav/gDnNWY3VLFI0VEcscmaWHHJz2333XHX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716040; c=relaxed/simple;
	bh=EII1X7CnWQbCPxWNLaP7XeApUckRgsI1TZehAf+iICQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GQfixeGhuGZwLLm0fGNzBGONPfmMiL4MluNlK0C0vWjFQrUrXq+1mLTrNHHXxcFukC3L9X5ey6mVck2g/mgkYYAyJTIoV+Uoiah6F+iltXrUgaIak49obxkVJpDJ0xkPY6qBT41XgJS0azwB9NfUyo1A7N6j+WYGLiZY1fjoqBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPCRnXRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0C24C43390;
	Fri, 29 Mar 2024 12:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716039;
	bh=EII1X7CnWQbCPxWNLaP7XeApUckRgsI1TZehAf+iICQ=;
	h=Subject:From:Date:To:From;
	b=HPCRnXRMqRra7XHD+F6KnbbG/i3OlQtOAb4rCtA977WZb6ss/geXSaYHg08YxyaVj
	 FucMUb1/PK9TU6M0TsHMLEvYuAkEgrXtk1hH8ln+Y9imDBKJWjGADTd7mtgQJWNnJl
	 PEEAm4JAKCgFV7T4+SE7jW0maX4JuSd/m+jH27jQui/QDLD2DwG0vpM0435W2uD3qn
	 nFdtvDnVpAjjVUSrFkH94ogk6bBHvjgqLbJdE8Sn6Snzc6zvoUaUR7R0c88zRTyX++
	 HSUisia6puUza73ckvPyJLiNxXQK/sKifHRx/XFauzky622DIVIpEKuR8syHOHMBqe
	 h32Ul96gh17LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97668D2D0EE;
	Fri, 29 Mar 2024 12:40:39 +0000 (UTC)
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
 <171171603956.583.6120239295593448844.git-patchwork-summary@kernel.org>
Date: Fri, 29 Mar 2024 12:40:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add multi mode support for omap-mcspi
  Submitter: Louis Chauvet <louis.chauvet@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=838776
  Lore link: https://lore.kernel.org/r/20240327-spi-omap2-mcspi-multi-mode-v3-0-c4ac329dd5a2@bootlin.com
    Patches: [v3,1/3] spi: spi-omap2-mcspi.c: revert "Toggle CS after each word"
             [v3,2/3] spi: omap2-mcspi: Add support for MULTI-mode
             [v3,3/3] spi: omap2-mcpsi: Enable MULTI-mode in more situations

Series: spi: more tx_buf/rx_buf removal
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=839544
  Lore link: https://lore.kernel.org/r/20240328-spi-more-tx-rx-buf-cleanup-v1-0-9ec1ceedf08c@baylibre.com
    Patches: [1/2] spi: au1550: t->{tx,rx}_dma checks
             [2/2] spi: fsl: remove is_dma_mapped checks


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



