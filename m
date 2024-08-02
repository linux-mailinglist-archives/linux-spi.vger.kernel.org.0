Return-Path: <linux-spi+bounces-4131-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12574946598
	for <lists+linux-spi@lfdr.de>; Fri,  2 Aug 2024 23:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A999EB235EF
	for <lists+linux-spi@lfdr.de>; Fri,  2 Aug 2024 21:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513371ABEB7;
	Fri,  2 Aug 2024 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMeJkAYS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213CC137930
	for <linux-spi@vger.kernel.org>; Fri,  2 Aug 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635433; cv=none; b=Fu/578WQka3N++wZCADGstMG3SR+mm26spYUy6TaG5FH/jAqh/d+Td/lngHVbe/IYBs7hxw3C95lfIhpjYLzZoMiCNwdaV+XAL3SoUnIFqJU+SyQgs8WVms05u6XB3zpPI9oDqi7C7sUsZbW9/R8n56X/kaz6rqyDYytbOro2Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635433; c=relaxed/simple;
	bh=4Ad4FX9X7h1Sed5Mr0TyiRqE8ufNn8U8mPwrV+e5UAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XCK2X9m9lyZw7vVgdxUpnlr1yGe3BFSZOXE0EJ37dbU2W1Jt1N+S8bbUnUwH74O+KuwZ7mVoYkM1h+1Hp6fDORB/sMjOALVMvSPCTDPywA9MTj4zd9bHIC1IrtiBAvroqwBSS53dSqzMz8Ypbz5D78UCeapSI/he3lSTyiPFzQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMeJkAYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A35CBC4AF09;
	Fri,  2 Aug 2024 21:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722635432;
	bh=4Ad4FX9X7h1Sed5Mr0TyiRqE8ufNn8U8mPwrV+e5UAU=;
	h=Subject:From:Date:To:From;
	b=uMeJkAYS3iMzZlMkk3n6yQf7l7eEEq5Ferjb/ybfEwzW6d2HznlHpkfdNvgUjb4rM
	 q8D/L6kA/oWxLuUv5/Uo1N4aXFhqMO4nQdoDZT1nSt9z0jsDf0ukMkNLG5DS8LXMUC
	 hym/vLR2hFDbY/d+RPX7nuTrIfWbg1dP1FOszbgjJGhvUd+zthv2W6ngGoa6NB/A4k
	 b46Pm0Cm/j3ZwDhMgP33W5qFPIW6UwEDNTukDTbAwTEmtzvax+N3iQTXMInR1NL+gk
	 V+YltA7JMdwiXxgzBdy7mHh4+exRIhXFYYKqsx3PURz2VzjXnBDY2x5Zdjv87lFfj5
	 XVjud7viQe6FA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B4A9D0C60C;
	Fri,  2 Aug 2024 21:50:32 +0000 (UTC)
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
 <172263543248.6159.13989779872142920107.git-patchwork-summary@kernel.org>
Date: Fri, 02 Aug 2024 21:50:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: ALSA: Add support for new HP G12 laptops
  Submitter: Richard Fitzgerald <rf@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=876273
  Lore link: https://lore.kernel.org/r/20240802152215.20831-1-rf@opensource.cirrus.com
    Patches: [v2,1/3] spi: Add empty versions of ACPI functions


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



