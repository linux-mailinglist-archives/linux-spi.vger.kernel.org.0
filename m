Return-Path: <linux-spi+bounces-12018-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D41B8CCB847
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 12:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74F133014DB3
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 10:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C21331210;
	Thu, 18 Dec 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpNT+biY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA81F9F70
	for <linux-spi@vger.kernel.org>; Thu, 18 Dec 2025 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055597; cv=none; b=plbxBOl/u7CESax2RJ+2iiCA0yFzZHfPaJPXQT9s1nYDPgYy2DmIYQlFb8OTm34RMMColIycB8NcMuQ8e1wRKwUCerR6KJ7XZrsOpbxNC5BPQlVt3BbBm7/3wkCD+ry6XTiYFle0uenUHvpChneti9MY7VUtdSCZtJZCsGP4dC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055597; c=relaxed/simple;
	bh=wWTXrHX1Ka2WC+Rf1Oy4jaYcbHCSz5Ph6UuHlWyfQrw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=UytTN5y6jBCpvvncx84ALiuDRu84Av7S/npBtng2rf3ZFGVXvVIXDuQtW99n56+pD/kDC+Z4r5MVGNRjKzn2ST4gHXnukT8ByOO+YHHTnpRl8O/INr5CBTS2BfASOwHUOaSZXTJt0mOYzt42TcAJQcycuPSFAABG4qF2cahzgBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpNT+biY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E2AC4CEFB;
	Thu, 18 Dec 2025 10:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766055597;
	bh=wWTXrHX1Ka2WC+Rf1Oy4jaYcbHCSz5Ph6UuHlWyfQrw=;
	h=Subject:From:Date:To:From;
	b=QpNT+biY3TSkUMk7uqE5LN0KT+sm7mTb0MARa25d+zeX/T0tPOxmz2LyYg3JsdjCd
	 hXuTFeHx+aYPVWcAnFf2dSt+oSXd4S4oc3bA0prYQWdHybNCByO2Rd9EaeUIDtooof
	 MrBS9rPLpUJU1hqFL6R75PCSH5j12uTWI8ZBBrqlkm3vqbTQ2Bmlk8RZx0srb6W2UO
	 k/ab6N0kQW1nhZDosb0kb8rwN7+vO+COIQZKBU8pd2dbc/xstFuWywxHbfeYnEF/4e
	 hH+p+6d81XmiebJmV3qJo2qITkr4yjkDdTlr5WeP1uoIT7iOwvHEDvJ5Au3QW1jvCX
	 mfEf/Blh7BQpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E988B3809ABF;
	Thu, 18 Dec 2025 10:56:47 +0000 (UTC)
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
 <176605540669.2503247.4657827018220744085.git-patchwork-housekeeping@kernel.org>
Date: Thu, 18 Dec 2025 10:56:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: stm32: stability & performance enhancements (2025-12-18T10:48:28)
  Superseding: [v1] spi: stm32: stability & performance enhancements (2025-12-17T21:51:30):
    [1/4] spi: stm32: fix Overrun issue at < 8bpw
    [2/4] spi: stm32: perform small transfer in polling mode
    [3/4] spi: stm32: properly fail on dma_request_chan error
    [4/4] ARM: dts: stm32: add spi1 sleep state pinctrl on stm32mp157c-ev1


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


