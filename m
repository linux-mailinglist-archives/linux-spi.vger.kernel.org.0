Return-Path: <linux-spi+bounces-10163-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54F3B89DC1
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 16:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4927E3B2BBD
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0B920E005;
	Fri, 19 Sep 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgtClIsa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901F1F3FEC
	for <linux-spi@vger.kernel.org>; Fri, 19 Sep 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291605; cv=none; b=mdFv1+vr0T9s/ovuEUxp1Jw3DKQ5rRS+t+IMjsg04Ur3vzm7QmNSddZeorvqhvooclTTX8tksHn+nsP94FuidJTiGZZLpJK9BZjQu7rRbDaniYMkobq9iqcxuc8z7Ufp9IDjRQrgeZqqb0V+WUZKPcACxOpGxaRp5Nunx8pqCoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291605; c=relaxed/simple;
	bh=aJSPAK/gLC8eb1zNxYwWmofxAU4lHV7OAj08Wmcm6sY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=s7MaoWaGV7JRpgatN6uE8p71jU1LSQCIfa7OxEXMRtvD2LT8xrJzmX/InsvMS3cz98ES9CbJuvAXOARrHY3HzL0g/Hf59M5lLV+vMhidS2yAxe6sUxOxTbWGc/fu5gWKkXbs1E0j+1ckjItkY0DMvlE3YKxUVkiML85zdsT2SmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgtClIsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BF0C4CEF0;
	Fri, 19 Sep 2025 14:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758291604;
	bh=aJSPAK/gLC8eb1zNxYwWmofxAU4lHV7OAj08Wmcm6sY=;
	h=Subject:From:Date:To:From;
	b=WgtClIsa8L8MTNMR1UdviLa6U70vX0CXemREsMi9Dur+6vRxC5lVxbnQD/sonrb86
	 oFn63kjGdoROtvXhg8mPT0Y6xtxlLEc3msoAs2OHaV5yDDD82dk7tBPElrpLMp1nK/
	 nl2ZiVvoDyFNHHZY7EHaMZE484N72M5xHm/D3ROX/8WINBFb6Eq7yqYflpKoglxxp+
	 wpiMcPL8HVPuguyiYF4ksbMOUoiAQwszAa1Kp1aAS3zbWDQM5cPOvdd4M8YmlWovgT
	 NEBHvtFTNMIrM3M0oOBiXOZ9KioinbJgCMpNFSTAS3DLOv1fmdBLOKmRwFIrXYm8dH
	 DtEq5gs7gM7wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3739B39D0C20;
	Fri, 19 Sep 2025 14:20:05 +0000 (UTC)
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
 <175829160373.3214890.9400267301514372628.git-patchwork-summary@kernel.org>
Date: Fri, 19 Sep 2025 14:20:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-qpic-snand: simplify clock handling by using devm_clk_get_enabled()
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1003026
  Lore link: https://lore.kernel.org/r/20250916-qpic-snand-devm_clk_get_enabled-v1-1-09953493b7f1@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



