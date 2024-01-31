Return-Path: <linux-spi+bounces-927-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85288843D6C
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jan 2024 11:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241C81F21455
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jan 2024 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972B269944;
	Wed, 31 Jan 2024 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZlW53BG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733946F067
	for <linux-spi@vger.kernel.org>; Wed, 31 Jan 2024 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698590; cv=none; b=m+W8Glz1m/ETaG18kcUG4HfNCQ9qj/L3Uxng0Azw+jlBoM2LwkGateiUShDEtJa9n6RIWg43feznSqp2VIpXcw3Pa/ymnO5nKZKx33Ph61IBINKVrn7U1geABPMccmCy5Z4aytUb/pXcZNroBsZS7xBV4LMFrYaxXzR9CJqkmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698590; c=relaxed/simple;
	bh=etix3aeNtIM2XUFqEPoqwTwoTUI1j719Lf1L2I+VKFs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FM0Nz5F8CRZ/yLd/FGpM22JxHAC3o9o7e5TRWFIMnbd6/nVZQcOHugsiPGksSP4uJUL97zPRG2WZGzEZc11QEBitFrlmBbAtjRxgiNP0EtJkm6r83TxT3MTIJTcG/oZpsn51AXxadjre3InrI83GJYdMn7G7GZP24jr0ZOzBK4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZlW53BG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECBB7C43394;
	Wed, 31 Jan 2024 10:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706698590;
	bh=etix3aeNtIM2XUFqEPoqwTwoTUI1j719Lf1L2I+VKFs=;
	h=Subject:From:Date:To:From;
	b=UZlW53BGIUAKWqgVTnlxnTM7ygbvHZ6dUOghVPM6e3T9Zdhp02d8/bzICYaGX/RI7
	 nmyYml7qj0AriWgwCL2B5qXMkWgIAmy8GBQdR0+OjK2k4W0Htqr/dxwyt1gczasriC
	 NQMw3eyZrZfJPhAUwGfAa6tYDUFbfcXax3a7pNG5UEL5WKV8yRD0zfNR2xRjftahJ9
	 hBOr/vfoFMf9U3+E3it//7UnNLeInj5IV9MAHdBkD90X6ruSTYzV6vGhUHC+lR06d9
	 bAYeLk1y8XVNm2JivTXfE5nueu1vyW3mVT41O/72/JMNgARjuSnDGIQuqhf0DXSeMZ
	 nmhv661TBJQVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB560C4166F;
	Wed, 31 Jan 2024 10:56:29 +0000 (UTC)
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
 <170669858976.30956.17147061699511430222.git-patchwork-housekeeping@kernel.org>
Date: Wed, 31 Jan 2024 10:56:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: imx: fix the burst length at DMA mode and CPU mode (2024-01-31T10:19:16)
  Superseding: [v1] spi: imx: fix the burst length at DMA mode and CPU mode (2024-01-31T02:46:23):
    spi: imx: fix the burst length at DMA mode and CPU mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


