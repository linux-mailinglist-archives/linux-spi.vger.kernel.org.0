Return-Path: <linux-spi+bounces-4955-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B829855FA
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 11:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F49EB2241B
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 09:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B515AD96;
	Wed, 25 Sep 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPK9tKEZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A5158DC6;
	Wed, 25 Sep 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254853; cv=none; b=P9TOaOnSPoMO/Jei8db2JXuvCbQPghgA3KBPgzeh8fV2j00gHDMtvSqM8acXPaUYzkZCECvnLPrc4KSjqNMmT+rwwcc/SJ+t+dV2UVykN0T6GArF4K2cLWR+rUDINnlSLnNi3z/qVSxh2JrnYwPEIyjXcfP/ZtyRKK4BuxfT9rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254853; c=relaxed/simple;
	bh=VqLPuSL1oxWsi+hIw5qlTAAZnKNuxbHJm1lQWzALhiE=;
	h=Message-ID:From:To:Cc:Subject:Date; b=VcgeuxgN8Bld8VW/6jH45tHK6Yk6BuNL9+p7eVw7nUl56FfuL9L2hKpSYX+aVoqhB2w8enEsk6Q3S0IsDtmJbzEeQJfSdNPHE9vX+yPKCfYLURjQ33YDI7lO8R3ODoVTvz/4CCExrJvAIQJP6sNjtdOexoJCgeNfyA6zJZMqtPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPK9tKEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D00C4CEC3;
	Wed, 25 Sep 2024 09:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727254853;
	bh=VqLPuSL1oxWsi+hIw5qlTAAZnKNuxbHJm1lQWzALhiE=;
	h=From:To:Cc:Subject:Date:From;
	b=aPK9tKEZrCJvrnO17ysxrgWIM/XPagIV6zQWsG2wEF31NbJGrCWJ7Pm+zKKFLaEnI
	 2MBWPuusl1nIdcVgRYb+9Wh1uwYfdGk5lCnkORiFm0Lt8mtKRAsLVBuFTc6JF/vxni
	 DD07AeqtTczJ0Qyo9WJANRQXPC7tPuo9ByIE9VInbFt4zGuAxC5QIEpXh39F6+RokW
	 HUMhDjCgEjK71BQ679hJfd1TTlHhAJVbOCyJXlQOqRIySujAJmUoGbbbOxGOa2G3Fr
	 tAlB/Q1zxqUyEVaB72iRvQaaSnphOu3JOnYmspWcTO5A4J+BFxS58zxrjIJxfQVTFi
	 +dhO2zn8S+TLg==
Message-ID: <5ae623a059a1f568473204bde232a815.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.12-merge-window
Date: Wed, 25 Sep 2024 11:00:43 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 07f1eb718db281c3e0cdb068ea7d73c30921a81c:

  spi: geni-qcom: Use devm functions to simplify code (2024-09-12 12:39:04 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.12-merge-window

for you to fetch changes up to 329ca3eed4a9a161515a8714be6ba182321385c7:

  spi: atmel-quadspi: Avoid overwriting delay register settings (2024-09-20 11:41:19 +0200)

----------------------------------------------------------------
spi: Fixes for v6.12

Some driver specific fixes that came in during the merge window. Lorenzo
Bianconi did some extra testing on the recently added arioha driver and
found some issues, Alexander Dahl fixed some issues with signal delays
in the Atmel QSPI driver and Jinjie Ruan has been fixing some nits with
runtime PM cleanup.

----------------------------------------------------------------
Alexander Dahl (1):
      spi: atmel-quadspi: Avoid overwriting delay register settings

Jinjie Ruan (2):
      spi: atmel-quadspi: Undo runtime PM changes at driver exit time
      spi: spi-fsl-lpspi: Undo runtime PM changes at driver exit time

Lorenzo Bianconi (3):
      spi: airoha: fix dirmap_{read,write} operations
      spi: airoha: fix airoha_snand_{write,read}_data data_len estimation
      spi: airoha: remove read cache in airoha_snand_dirmap_read()

 drivers/spi/atmel-quadspi.c   | 15 +++++++++------
 drivers/spi/spi-airoha-snfi.c | 43 ++++++++++++++++---------------------------
 drivers/spi/spi-fsl-lpspi.c   |  1 +
 3 files changed, 26 insertions(+), 33 deletions(-)

