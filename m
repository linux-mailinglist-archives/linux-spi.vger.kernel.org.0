Return-Path: <linux-spi+bounces-4004-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98CA93C5CE
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941E81F21067
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jul 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF10D19D090;
	Thu, 25 Jul 2024 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5H0o7LV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BECF1DFF7
	for <linux-spi@vger.kernel.org>; Thu, 25 Jul 2024 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919392; cv=none; b=SCygI0AsPXflpf99T5P1JY3oinLvsUhxrJWjGZ3oaYSXbuX4FiNBrlM7xlIksL+zkqez8j2diGoy3uOw1Wckldp0VbEkpxV3x0FB9D2tfumQU3ZxTLSY7l3LCwwwmSGqFpFgIDNcK29cAtT5B71/rnpmaGsMnC6P5JgvD8WhgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919392; c=relaxed/simple;
	bh=hBTkNwoEfR6tAskPTB/lIkJCHrhT+CRTKAipGkt7Kuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=C7WXWGFcfsUcmvZLAFCPD1U+4C67RwVAhiVAc4BOe0ZspeZHhPQpg+ypz2O8FOG7IiBIgCqKs3AQdPEKweAhH/MF77+Es/8qCgaoy4FocUfMC2RUGgpqJfO4NLAwRSpOYV0sMvo7rpcoCLT0+940gpDO5OQW7roHkmTtp/LK7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5H0o7LV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60636C4AF07;
	Thu, 25 Jul 2024 14:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721919392;
	bh=hBTkNwoEfR6tAskPTB/lIkJCHrhT+CRTKAipGkt7Kuc=;
	h=Subject:From:Date:To:From;
	b=c5H0o7LV5SCcDVmmWctZg5X6isnMxqB4d2stL6qvN95QotcG9LX2zdFy7onBSIPao
	 cm29gbkuNkF6tAF+eP4rGeRXlyXeyMMfGGC4ULn38f6N8YhqJ/6q/AE8WxoEyyp5BI
	 ylpbgb9Y/5B1aUMvnGuAS1xGDqL8vJjPzPKJR/1VTNMt1EnFrYbNZmMnaKPqVMNOcV
	 ucYA3wWCvmQZqppeaGxmeR7mEWqqQ/YVHrY8DOwrl+ImJ0gUD9QhR/6Y/3/ew8nZRk
	 7Ry7z5YyM3IlRiu1zcNUFU4aQTo4UuewC88Loq1QbD0+B6VR9ofwufAhCMq+74gQky
	 gEe9+oimCcB1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4978DC4332C;
	Thu, 25 Jul 2024 14:56:32 +0000 (UTC)
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
 <172191939223.2691.254979506309742638.git-patchwork-housekeeping@kernel.org>
Date: Thu, 25 Jul 2024 14:56:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: add driver for Intel discrete graphics (2024-07-25T13:56:45)
  Superseding: [v2] spi: add driver for Intel discrete graphics (2024-07-24T14:00:02):
    [v2,01/12] spi: add driver for intel graphics on-die spi device
    [v2,02/12] spi: intel-dg: implement region enumeration
    [v2,03/12] spi: intel-dg: implement spi access functions
    [v2,04/12] spi: intel-dg: spi register with mtd
    [v2,05/12] spi: intel-dg: implement mtd access handlers
    [v2,06/12] spi: intel-dg: align 64bit read and write
    [v2,07/12] spi: intel-dg: wake card on operations
    [v2,08/12] drm/i915/spi: add spi device for discrete graphics
    [v2,09/12] drm/i915/spi: add intel_spi_region map
    [v2,10/12] drm/i915/spi: add support for access mode
    [v2,11/12] drm/xe/spi: add on-die spi device
    [v2,12/12] drm/xe/spi: add support for access mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


