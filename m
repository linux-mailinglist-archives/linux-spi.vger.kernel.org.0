Return-Path: <linux-spi+bounces-8678-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C2AE0C55
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 20:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A064A5426
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C1E30E821;
	Thu, 19 Jun 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkUzkEXa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCBC30E820
	for <linux-spi@vger.kernel.org>; Thu, 19 Jun 2025 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750356578; cv=none; b=f1wPIih7JXF78CbW3ntrhUmlmZ/5OCLJdF/x8AGbOhiXQaC3YJfWPL6fwubuZRgWiBrHDk/EBK6PyjZpr6zWhARFjZ2K6iCyegqNCDTPsRbBIOfnDYPHZDuZjrdJxKVYpPnOn4Ps+y1M3RtW6Qf6VdpMvQ4/7qTq4C7t3isUIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750356578; c=relaxed/simple;
	bh=SqPh+DKFW5lIM20/KpPRe74BxP7gzJohBDUDUmj97Lk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VxJ2WT+3bZR55hWuZd6437Sj3LCFlQKbAJvadcx961QSSfMlBb+PvEfMVuWl+LGu2/VAEUa3QrxMNwTK4Md1hH/Sk6kirnuXMtYzvft4vl3jCfSFpvwJHIiFzOoQDa/S9dPubcIYmFdcoNpZgx5DfpTZor0SK7d+yEIq0IOC4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkUzkEXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99779C4CEEA;
	Thu, 19 Jun 2025 18:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750356577;
	bh=SqPh+DKFW5lIM20/KpPRe74BxP7gzJohBDUDUmj97Lk=;
	h=Subject:From:Date:To:From;
	b=kkUzkEXa3p0LV+qANIp+30kEVXd6xGPoHUCMqr7dj0HTqTiMJSUeDct0spLkrgl8w
	 lQAB/zetdF61A1zR2xXjOYlr3I8NEEaQWhtayvQsNinXBMt/FivqRTtz6YHD6SlEpQ
	 bpWBc86yw8PT8VE1+AuTTbeXaS0m7ryhgYKk8/vR18VHJTDcArAPsp6o1XbYxFGZu1
	 T9f6WLkf+L6n+NgYI6Lbnfxwu9Dq2QkLc8d3QTWYkxOZYa0v9wHRbLVxxYG6gjFkzX
	 YrDJxZ/WTsa7d+iNKZHx6IX6r9K2h09rX62ddRbQCJiMJgTl3tnpagESazHbndn0K9
	 c0HjveDiAQZwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B17DB38111DD;
	Thu, 19 Jun 2025 18:10:06 +0000 (UTC)
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
 <175035660517.946806.7218033088270923996.git-patchwork-summary@kernel.org>
Date: Thu, 19 Jun 2025 18:10:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: MIPS: some compilation fixes for the Lantiq platform
  Submitter: Shiji Yang <yangshiji66@outlook.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=973484
  Lore link: https://lore.kernel.org/r/OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com
    Patches: [01/16] MIPS: lantiq: xway: mark ltq_ar9_sys_hz() as static
             [16/16] spi: falcon: mark falcon_sflash_xfer() as static


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



