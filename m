Return-Path: <linux-spi+bounces-3513-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9C2910F7F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 19:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3C61F22C34
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 17:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A61B3F20;
	Thu, 20 Jun 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgDCc9nO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903A1B3F1B
	for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2024 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906186; cv=none; b=alarFhNkpNueBfIIlAMm/ej0dJ3FDgeOUCbnZTCbEVqY7b7IrizciuxiP70Q2PQx1xgSSp8IFBgWtgrotSmJdPdePccZEQ5B6/gUiPg7UJlltzhxr3dLWLYboRRQexgXO5l/Rkf+WF2f/9ewfET0/it05naiG5wT/mvpGm6sCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906186; c=relaxed/simple;
	bh=slKVrhQ549ihpfNGIrUkZwcdX88KhnNzhZefDCgB8+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=t+bkZGiXh6j01guIeLFuxWmsuMQOhTNQFOoJm83qFPvKn3Ne5NcbAnveczSv5ertRdJkIw3i46ZE1hYV2+ZnnR836Elfx3EsgO9CEBUfvvGW6vIDJ2ZuixuNIf1PfS5wLG9v+yndD6NyqE8WWUNoTthw6Bjee/0Y7Jd7NTxeVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgDCc9nO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB70FC2BD10;
	Thu, 20 Jun 2024 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718906184;
	bh=slKVrhQ549ihpfNGIrUkZwcdX88KhnNzhZefDCgB8+s=;
	h=Subject:From:Date:To:From;
	b=bgDCc9nOAGE2Dh3HPWbzNe3DkxHektXZigRJ+KErjSbIcGdbBcMJB54iegfkmSCFh
	 xMWrWsfWdwe2RpK28cZ/ca/9z8mb2nFXZ6lRHlJki1fbMKDZH9OGji2ENTs0l6cRhb
	 cplhbQRo05PAiLXrneedPH+8Ievju+kBGTyzzEkEbQwIe+Fyih48jpoyTYL90RCrfL
	 3ZOR3uKfTMKh1xbqkHQFjLx6bjzpiRITJacCJyKiadjIcRzDsXFVyTpU0RMB9KOOWw
	 Yk1K/htvRMYb5duqgux2hOGvjyXDvW2yFEIDXjL3Q4KLg8z/MYTbJxAuyNDRKgZ2ld
	 W9Qr/x7c16KBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4272CF3B97;
	Thu, 20 Jun 2024 17:56:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <171890618465.30741.14247858368803049961.git-patchwork-housekeeping@kernel.org>
Date: Thu, 20 Jun 2024 17:56:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: fsl-dspi: Convert to yaml format and use common SPI property (2024-06-20T16:58:26)
  Superseding: [v2] spi: fsl-dspi: Convert to yaml format and use common SPI property (2024-06-13T19:00:36):
    [v2,1/3] spi: fsl-dspi: use common proptery 'spi-cs-setup(hold)-delay-ns'
    [v2,2/3] spi: dt-bindings: fsl-dspi: Convert to yaml format
    [v2,3/3] arm64: dts: fsl-ls1043a-rdb: use common spi-cs-setup(hold)-delay-ns


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


