Return-Path: <linux-spi+bounces-12190-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF7CCF84D4
	for <lists+linux-spi@lfdr.de>; Tue, 06 Jan 2026 13:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B20C30056C2
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jan 2026 12:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354BC30DEA4;
	Tue,  6 Jan 2026 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxBbnVgD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C492741DF
	for <linux-spi@vger.kernel.org>; Tue,  6 Jan 2026 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702264; cv=none; b=aeTQl7YfroOmaBIXAn3V05U8sTMWEEPfEOqvRJH8FCL4wnKdCCAbuxpqfxJItcOFm8hjjwzhauX0wCVj26c2ePo/sQuNH/mknGA1nrm5cgesEskndx7yzGSqT3vzgEDUG68cuqMQpzjkJct7vaZxIx1tTn+VFfcMBMBiR/oeT2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702264; c=relaxed/simple;
	bh=tXKMikyqmUfRTPIvm/XdzhBv17yvutkzeLn18iGUNRc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=g/9He7PntJ9XkPvGmx7uhIUhQ40m0x2v3hqSlh7sjQ0M2Y9srIhCqQHEHmtyYpWw6FvPWmROiDTgIQ3g+H7bD3wkSZEBbz89ik6BWxFpJ/LrQJ3IEpaFK2OXfRwTrLXaIKrKAii82WvtrknW2cJmDrHBweyNvefkq9zSqFN7vvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxBbnVgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9446FC16AAE;
	Tue,  6 Jan 2026 12:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767702263;
	bh=tXKMikyqmUfRTPIvm/XdzhBv17yvutkzeLn18iGUNRc=;
	h=Subject:From:Date:To:From;
	b=uxBbnVgDKV6zipCydEIh/H3MeUOkbBgsFCa88KGOnRjQUSx6pM47Y+8yin/sSuoHv
	 /CLXk8u/AlUnTMkI10kOVILVW08lrIMxUJmuGxxPzD4gHCMY7IGOedJFsY6vQrlDzw
	 0OJHW20m9q3rT/oN+h4lCYI6A3JZSEWvUwS/DTnHMJkVSFtNeIBB90l9xBBW+hsFVK
	 IcD2sRtqq+V+mfJ1KMmL0CzFYIK8O66D/QldZLRnoR6/vLvb0DEO14kKCzDz4ohH+6
	 Noqm8nVtRNzaHiDfmlZwaEXiRaT9KLRooLiakErD3gS0HiHN3UFwq0uTTd1GJNfGf8
	 2DcmrZu880Okg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D4FC380CEC9;
	Tue,  6 Jan 2026 12:21:02 +0000 (UTC)
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
 <176770206098.1940354.10823969582438443737.git-patchwork-summary@kernel.org>
Date: Tue, 06 Jan 2026 12:21:00 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v2,01/19] include: dt-bindings: add LAN969x clock bindings
  Submitter: Robert Marko <robert.marko@sartura.hr>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1033379
  Lore link: https://lore.kernel.org/r/20251215163820.1584926-1-robert.marko@sartura.hr
    Patches: [v2,01/19] include: dt-bindings: add LAN969x clock bindings
             [v2,08/19] dt-bindings: spi: at91: add microchip,lan9691-spi

Series: Add support for Microchip LAN969x
  Submitter: Robert Marko <robert.marko@sartura.hr>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1037170
  Lore link: https://lore.kernel.org/r/20251229184004.571837-1-robert.marko@sartura.hr
    Patches: [v4,01/15] dt-bindings: usb: Add Microchip LAN969x support
             [v4,04/15] dt-bindings: spi: at91: add microchip,lan9691-spi


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



