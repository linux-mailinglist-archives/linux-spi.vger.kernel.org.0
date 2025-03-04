Return-Path: <linux-spi+bounces-7025-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C60A4DF70
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 14:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CCA1787C1
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E62204090;
	Tue,  4 Mar 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnrTRuRW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643CB202F88
	for <linux-spi@vger.kernel.org>; Tue,  4 Mar 2025 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095598; cv=none; b=L5esHVf/N+UyeM0ZX1ODFxKLmLedFdgYf0GXafIWA4k0wZXhHD+dpt2iiONvXYw/PEeSJn6zzHgefOVHWyDGWGovDCqC/Fl0+VwnkMds1hECG5tC0a1kO6aroG9InfOGy4c6TDNUULg70g1dlWPxUfa5tUmbXcDnn+aZ3w/q+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095598; c=relaxed/simple;
	bh=s6MNCBdyyNNkobKaqGYB5/yiMikaS6DXfiGoEnE4Kpo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FUQ/86Atd5U/f0hOxqHrIZAKrhEaGRh1k+9cRYvIiaeLBizYMwiK25S9rERl4X4jMPDPn8+/9iMSXLyPG/xfvd74RH0HKn9adfIUMPw7fb1JeqgFFEjVfeXLyofghZkIEBWDQi7klqr2pDI1D6cwmLzGFibVKAwoXOnJeCof2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnrTRuRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E640FC4CEE5;
	Tue,  4 Mar 2025 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741095596;
	bh=s6MNCBdyyNNkobKaqGYB5/yiMikaS6DXfiGoEnE4Kpo=;
	h=Subject:From:Date:To:From;
	b=XnrTRuRWUBanrM84vEZJ8oWL6T/mGixjMt+KdNo63QS5PflNzu4gw5RO0vIv5xdVP
	 O+VL4WMLWavojobClMkk5iYNT75dtsAqvGnHVTGxHfNyx2g3bGulA0y8mAwmSMRFIt
	 N1qAmwC59XCcDUpoHroKtI0m1aJ+edSABD3TSvG1ryLMw5zvYVxM+3FhZI6DhcsBvK
	 XAIiUkBwaCf+hWeqHWSNdmlkYip6YDNqyovcMeEuvdeVvy/VqmFNmh2jfgvkKYCYoT
	 KPgIfK+yUPOU9OA4H7IDw2LEGD3E9JGuuW58mx+r7Hjrlzkcy1cI8DE6E4f4aDh7Kv
	 SwvR1oCBQg0Pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EEB42380AA7F;
	Tue,  4 Mar 2025 13:40:30 +0000 (UTC)
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
 <174109562941.146024.11158717420088060468.git-patchwork-summary@kernel.org>
Date: Tue, 04 Mar 2025 13:40:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add STM32MP25 SPI NOR support
  Submitter: Patrice CHOTARD <patrice.chotard@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=935460
  Lore link: https://lore.kernel.org/r/20250219080059.367045-1-patrice.chotard@foss.st.com
    Patches: [v5,1/8] dt-bindings: spi: Add STM32 OSPI controller
             [v5,2/8] spi: stm32: Add OSPI driver


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



