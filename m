Return-Path: <linux-spi+bounces-11821-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79353CAC713
	for <lists+linux-spi@lfdr.de>; Mon, 08 Dec 2025 09:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40333301AB18
	for <lists+linux-spi@lfdr.de>; Mon,  8 Dec 2025 07:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B7C2D94AB;
	Mon,  8 Dec 2025 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgRE17y2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AE12D9496
	for <linux-spi@vger.kernel.org>; Mon,  8 Dec 2025 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765180794; cv=none; b=udJvvTFaDVAf1DvFvYt1hUu+WZOUtykwH5OhMBajnalwAIovo8oy3oy3AM3SHhISWab261z4ffVmxmWuXvkm/7tunE0jMn2WTXwusn8kpm9mAb97MZM2ea6/A5RvCTDwdYg9sOI1tDnxU3paClwnnoXLt2LoGPcyhbol64uOYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765180794; c=relaxed/simple;
	bh=8BRTNdG/5jKrTQRaClyZRQSd/l0xy7AOIt6d8CbQ7Ns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pMhdMlEPMBmLRD/HNocRXoJr8WZyZRiHswyniQ8lt0JIU9JCmQlHW7XHNLygm3nkKVutAl5aLZG+07ftaCmTJufrzB5oyellL/Kh64nSUEfXS8gNZv68bY/VckqXnIwS/I3tqPtuICTatdXwWlzi5bj3CNmuqRnv/xSLA1cXpRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgRE17y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2271C4CEF1;
	Mon,  8 Dec 2025 07:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765180793;
	bh=8BRTNdG/5jKrTQRaClyZRQSd/l0xy7AOIt6d8CbQ7Ns=;
	h=Subject:From:Date:To:From;
	b=dgRE17y2ajAAkOSb/ZwAdS/aV20vX17fui0YMOzKpxlr6UwvF9s5N3Xx8mGCnvhhu
	 TIWWj1n7hbGpN9BE52QXrEcSukkPLLzQYOn9dLpM75str4s4lVxMGvH0OttZpPtQEA
	 QJbWFfu38RTj79lnjTm6lxUizyFdhTbvmOUG7DrS3vpdYs/JD4kQ2f77Id6ywWYbyX
	 c+XPdzwUkdmy+KgvJBnEJL+5gulZle5J1NUn4BbAoSv3R/hFAUxyDJ1yLePBES/ho7
	 NsE4gRFCIB6q7y0Udm35UO64y86RaVfR5YnQ0TPmF/Vk4vZPHhUtHrobfIG5XdclH6
	 spIngWBgZbfTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2E923808200;
	Mon,  8 Dec 2025 07:56:50 +0000 (UTC)
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
 <176518060950.3066259.15004032160029843650.git-patchwork-housekeeping@kernel.org>
Date: Mon, 08 Dec 2025 07:56:49 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: stm32: Update for OSPI and QSPI drivers (2025-12-08T07:29:11)
  Superseding: [v1] spi: stm32: Update for OSPI and QSPI drivers (2025-12-05T09:04:53):
    [1/8] spi: stm32-ospi: Set DMA maxburst dynamically
    [2/8] spi: stm32-ospi: Optimize FIFO accesses using u16 or u32
    [3/8] spi: stm32-ospi: Remove CR_TCIE and CR_TEIE irq usage
    [4/8] spi: stm32-ospi: Simplify SMIE interrupt test
    [5/8] spi: stm32-qspi: Set DMA maxburst dynamically
    [6/8] spi: stm32-qspi: Optimize FIFO accesses using u16 or u32
    [7/8] spi: stm32-qspi: Remove CR_TCIE and CR_TEIE irq usage
    [8/8] spi: stm32-qspi: Simplify SMIE interrupt test


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


