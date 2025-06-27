Return-Path: <linux-spi+bounces-8808-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F14AEB605
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 13:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5317C564C78
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79162980B4;
	Fri, 27 Jun 2025 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkQ9UN54"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3D1DE2AD
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022579; cv=none; b=s9UQ9f2PbDnQDr6Xmn/IXWbiZvoV0WbyjGNIza2FSfUrHRg9UdWnrvev/iymXB32OyH+eD6519P3W0Yj0Zc9ylDHpBdLIMWXiAMh8jozM3VnQqYEil6wTndJQYkNGXM9rvOHziwYcguVoecwrxVkqbgOobL/oDGx/UjGDcuUt/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022579; c=relaxed/simple;
	bh=MWLSd1nLeiDyGdriFe8wEdJh0F0tF1t23X8GqTXVPig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZxV2htOyH0dYETyLnG6kydjo1n32jcL3iGWVhFAd2wAU2PUmrrfflPpN397GAqM0SEMRCqiU50n3nZos/g4vy+oPPVRQ99yHGEvuwsqepuXoCtBJML9pxDHOXJDDqlgHT+7PUd/r2qfDe3GLhznBt4T5Glin0SYC/QMYbGRri0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkQ9UN54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034B0C4CEE3;
	Fri, 27 Jun 2025 11:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751022578;
	bh=MWLSd1nLeiDyGdriFe8wEdJh0F0tF1t23X8GqTXVPig=;
	h=Subject:From:Date:To:From;
	b=qkQ9UN542QdWd4FFeUFml5rMqgsASiPH+32XgLlpURHPA7/bkGY0VPstCgsTeoSXO
	 zvFgZi+j+dVPQVOSK4ysZYdzSjN5wvtzd/OuRYFGSKs8feEqwP7uTcSoWaGgE/O51T
	 f+PA9pi6CS31URI5y7FRd9I9gZyRYjfzaXSPNPkjTPkcpBTyDg8UevLv6HNQ7Iuq8L
	 x627E+M4HS5nwdYk2Zox+GYkMBlLrMLARyaJ6XTSU3n90YgcrDNTLmg8tSsn0Foomu
	 /dtYoihSWIPPI94AgzHgHfIZtrhV0yUSfLKiYO68z9kwyjyuPpjgRgd7gHYEc9Tk6a
	 FMqU0HaKEVL6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 380F3380DBEE;
	Fri, 27 Jun 2025 11:10:05 +0000 (UTC)
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
 <175102260382.1885559.3360950230513796726.git-patchwork-summary@kernel.org>
Date: Fri, 27 Jun 2025 11:10:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [1/1] spi: dt-bindings: add nxp,lpc3220-spi.yaml
  Submitter: Frank Li <Frank.Li@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=975987
  Lore link: https://lore.kernel.org/r/20250625215255.2640538-1-Frank.Li@nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



