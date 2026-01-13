Return-Path: <linux-spi+bounces-12334-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DA2D19443
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9B5A3016671
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1B039282D;
	Tue, 13 Jan 2026 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eH7p4gGF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4CAD5A
	for <linux-spi@vger.kernel.org>; Tue, 13 Jan 2026 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313013; cv=none; b=VbZQpDlDmx6pcrMIkvtUca6mMU0nIr8FysjNwdhFrpr8SS7p2wVenDhjGOZZMHVqEpLov1P8QgifwVedyDDDivRzTXWNBuAHR0FRz7KxP9h3tDG8BsFj7QGYMYlnpDGo0AGsWAKoppInTHeLsntqdZhf8CO+EF6Kq9YKsUXEbNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313013; c=relaxed/simple;
	bh=2Pw0Bl1YbZTrMWn5PLrW+5IWF9xNf7LoelKAMmKtYwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Gte6/y6nxEKoJNlOvbFmORX0qrDdaIkdVj9t29RAKN2XT8E37diVcbM99qJfW9UeQ91uuXGvSDfl0jkkGtu7dRLIXX13EpEp8BYhkdrZqXtq1+4xsXnrBgHqtP+Nz3TR5f067d59X2knPfcrO//qlnQHcovO6791kehoE0Mno5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eH7p4gGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAFCC116C6;
	Tue, 13 Jan 2026 14:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768313012;
	bh=2Pw0Bl1YbZTrMWn5PLrW+5IWF9xNf7LoelKAMmKtYwo=;
	h=Subject:From:Date:To:From;
	b=eH7p4gGFJv9gGJEigpR+GhdDQykJNqPdbmqWCE008mFeudVVVYPAX3iykvfj0KJFF
	 Cvj5FZgo//az4tphle55d7y6bw8LcTVBJidd1DA+rai1jEaf+JeS1dBUCSxzQa0oOy
	 1l71tRkkIpoMuQ+o87jokiIaMaWuzrFB8NBSVQB3uaBKmuOliYop1E64RA8aHrRejN
	 z3GiLWV14E9JAzo4beZKzcAQCFzzqCCHa9sArNCuCNiTtQLXZPScUVMdVpVo4/K4D/
	 a1pkdtcgtq6vlk0nGpLMxdNO7p+H0PvvpKxkra5Aanu7NEVli1IY1HrMFi0bfZCTqh
	 m8lKxUCOOwW1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7FF403808200;
	Tue, 13 Jan 2026 14:00:07 +0000 (UTC)
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
 <176831280637.2255609.2777853020140385405.git-patchwork-summary@kernel.org>
Date: Tue, 13 Jan 2026 14:00:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: fsi: Simplify with scoped for each OF child loop
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1036364
  Lore link: https://lore.kernel.org/r/20251224110240.56803-2-krzysztof.kozlowski@oss.qualcomm.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



