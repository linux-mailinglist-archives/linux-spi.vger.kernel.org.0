Return-Path: <linux-spi+bounces-5459-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA719B032B
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 14:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8552BB22933
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13498206502;
	Fri, 25 Oct 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzS8b0y+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B6206501
	for <linux-spi@vger.kernel.org>; Fri, 25 Oct 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860629; cv=none; b=UY/SSR2wgjv9cb9/nWWaLYoIALJFF0UEYsS+MdgVICkfmp3tHmDTdQDq6U7exnZ+XfLgXtblgNgc4iUg9Ub0oBtN2aFwGiWIJIswm6Apz4dI5SpyEeNhEfu4VWg9WtxUIKSTITnWi3H/CUYrzeQAjGHSfy49+KRBuZnTtPsbSG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860629; c=relaxed/simple;
	bh=SM1tcmGt55hw/pSqLgykkK5NBGccHwxeWVBu081Q+Kk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SoB78XJSYD3z8tOS8Kl6liuEO/UFy6DKS100EYBw6KWC8BwDNXHe1vs0GxVk+X1dLUhHiBsqN8bBgi/HX03eG4Etrvv10/rgEBFIeElUvBRmZaWt/8WVpG3k93HVHohum3XMUb17e+WNABDGqk2Oy+XrwfPm5Ns1cB0FLYyYlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzS8b0y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A105C4CEC3;
	Fri, 25 Oct 2024 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729860627;
	bh=SM1tcmGt55hw/pSqLgykkK5NBGccHwxeWVBu081Q+Kk=;
	h=Subject:From:Date:To:From;
	b=SzS8b0y+dStHBW2ZaKLNQw1uZLjNNtTtUWJtIy3wmGufPYaEzqti13lHw439O8Esp
	 kwmgN+kjS+N/glcGI7IalBZ2LvGj3yfAC1ObkUiZ1yZ6nJtp7fY8r6MkGpsgBBgTXR
	 n2xANKYEwvx+XQjA8fDwBEF0odmaOphbrisBp/tMR95AzqGG9qWCHCPgADeu2OUlRn
	 WZ/n1osM9npwr0kvI6+kTr1TT7jz9L+E5AGU1iVlX0ffmhgXOSumTXaca0HQH11z3D
	 0ZaGJqOZ40nda0tZ+G1vlV3JbTZriA7G1l21OoyoDXX4rcLPtp8ihYDUBDJatmI3TB
	 OeZb9X21+W6GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3ADD13809A8A;
	Fri, 25 Oct 2024 12:50:35 +0000 (UTC)
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
 <172986063382.2894477.4494756948221563316.git-patchwork-summary@kernel.org>
Date: Fri, 25 Oct 2024 12:50:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Replace deprecated PCI functions
  Submitter: Philipp Stanner <pstanner@redhat.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=902750
  Lore link: https://lore.kernel.org/r/20241024140426.157444-2-pstanner@redhat.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



