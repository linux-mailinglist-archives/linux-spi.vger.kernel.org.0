Return-Path: <linux-spi+bounces-9759-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD88DB3AC89
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 23:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272F11894290
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8727238159;
	Thu, 28 Aug 2025 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGeVsaaP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8464A1A8F84
	for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415408; cv=none; b=WMRQ93GwZNQUgjJ9zfinYizPQ3BYxTWJ05BF0srw3qDrhH55YfFRpnTz48vI8SXJUfSoDrv9ESlH7Y68upr+78+SIt98qfaX+zzkPPbntcGz5dq+e9V+WyqntNZSLwKD+/3DJH3OvzmXVq8GYVSW00N/rslL5ebi7kcOBMheZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415408; c=relaxed/simple;
	bh=p31pBfVcy0+nxKFZPasiY66J69dDPOljHYGE17bKRVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=I1CGsFwhliPqegYkNYcDhklHT34K4VA4MgMG0Eca9b1NKGzkSW+TGjLlcjS7cax/Rcwsv7hpbhkE4KOP4RKvTu4Fgh0x/bBDHjqk3HDdETKBahz/Zs65U6KsRXboEgbKTMHkqUh71mQdBpG2PAzl9hw26KdlHnTuokTe425kCPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGeVsaaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B03BC4CEEB;
	Thu, 28 Aug 2025 21:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756415408;
	bh=p31pBfVcy0+nxKFZPasiY66J69dDPOljHYGE17bKRVI=;
	h=Subject:From:Date:To:From;
	b=aGeVsaaPmGPMzmCDshNli1nXtqs85bHrw07mUQU/WoBuSY+UKQfsOUwEhAneTdcO5
	 /FVCj4DZFHGgUJQoBo019IUrx3VaxuzBvbJQmVit0AO6xQRavHsrQy60EvALCo0b0G
	 OADvWWzBO3bA8ELsCExZc4uhHzNA1phSASIgbHruVnShN6q50ljCKrxEXiu23+IXiK
	 iUVpbwasuIsiX0NsmIqAPh22hboGZlTA/5QHG+n6H+nrDFJURb7BFN4scSOxm1Ga1K
	 QMPAPRoo+J9kIX84xX+ZqLC6qBaJ9nXQx9mMjE4y7IJk/7NaeyLBdUrzvBrFsirZ9A
	 vvwT5fxhIE1qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 385DA383BF75;
	Thu, 28 Aug 2025 21:10:16 +0000 (UTC)
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
 <175641541471.1614432.14477022690359354397.git-patchwork-summary@kernel.org>
Date: Thu, 28 Aug 2025 21:10:14 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: add COMPILE_TEST support
  Submitter: Rosen Penev <rosenp@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=995806
  Lore link: https://lore.kernel.org/r/20250826212413.15065-1-rosenp@gmail.com
    Patches: [PATCHv2,1/3] spi: rb4xx: depend on OF
             [PATCHv2,2/3] spi: rb4xx: add COMPILE_TEST support
             [PATCHv2,3/3] spi: rb4xx: use devm for clk_prepare_enable


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



