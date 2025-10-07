Return-Path: <linux-spi+bounces-10448-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17912BC240F
	for <lists+linux-spi@lfdr.de>; Tue, 07 Oct 2025 19:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDAD519A0D6D
	for <lists+linux-spi@lfdr.de>; Tue,  7 Oct 2025 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D8D2E8E01;
	Tue,  7 Oct 2025 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPnnbUk5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E762E7F0D
	for <linux-spi@vger.kernel.org>; Tue,  7 Oct 2025 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858216; cv=none; b=TPl//3nS2xvR+kHDRCFQ+10NjsbNi/Qr5OuUzhz8/HRnnwpet7CHFN6b+4jjhMb5FXDa91LuTsbzRnW2c3s07wfP7DfxVVBQkSxuDE8aLV+EuXbbQFBuolg757BAP+HwD6IAcbLRhZYJxMS7CxvzxPTLAqMlUe7orR1+bbAgmDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858216; c=relaxed/simple;
	bh=IE5mfTyADtLWonQoyVt9hPyljqoTb7EchkmLbNQKMFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Px1RWWk3Cidhifhc5i3CYRQtzyMK1aTsQPwb2nRtmXocIWicSzbgJK9cdspE6Yj+oDTtRwN3oFOZfSIjL17vBOSilfdA5hyrTOqWnHMJ/+Ed1Dv2H3vsqvU9eBfeUt3ed1L+Jq4UZS0eO2kTp+rrFU9PkCBNMTxR8Lf3MSrmf8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPnnbUk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9479C4CEFF;
	Tue,  7 Oct 2025 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759858215;
	bh=IE5mfTyADtLWonQoyVt9hPyljqoTb7EchkmLbNQKMFc=;
	h=Subject:From:Date:To:From;
	b=OPnnbUk5PB79j1qNDJgadyXIGZyxQJWuK40lYbObexOInZpYOLDyZ3apL52DVdD8S
	 Opxi/U5c4V6Ougr/aYiP2XATd6LXIoPpx4C3y6KRx74PuMH/MKcue7oof3AW06LFW9
	 E/CkBuEHTHqMWoGjz4DaOx1U2eII6S/qeXdWhwCGREzXVg1vEswFnPmDsqxvnr8qDF
	 RsDUIQIuCjBYOCZUunlzY9LWnye3SwUFzPwOCEb8daudoqDg5q24fWToTd9n5hYHqf
	 +YCuWESYVPLiC/DV2ZHdCj7Ha+YeLXB2KblyHKJ9NPkJYfUrOSp7TLXFUaXLZ41AJy
	 naKNZj3MsxZaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF99539FEB6E;
	Tue,  7 Oct 2025 17:30:05 +0000 (UTC)
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
 <175985820442.2709711.9452970096311892782.git-patchwork-summary@kernel.org>
Date: Tue, 07 Oct 2025 17:30:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: dw-mmio: add error handling for reset_control_deassert()
  Submitter: Artem Shimko <a.shimko.dev@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1008978
  Lore link: https://lore.kernel.org/r/20251007101134.1912895-1-a.shimko.dev@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



