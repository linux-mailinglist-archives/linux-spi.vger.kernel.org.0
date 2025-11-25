Return-Path: <linux-spi+bounces-11527-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAFFC86AED
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 19:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DE0B4E820A
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDC63328E3;
	Tue, 25 Nov 2025 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwLvTsdg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F163321DD
	for <linux-spi@vger.kernel.org>; Tue, 25 Nov 2025 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764096042; cv=none; b=LgXsU9sfNr1rCZNRRo6+xK8o/GoY2YxKF1A9aaGQuf+/yU2sVBBTOOmvd7Tl4fJJ1lL1sZ8DXwNlQgWxHckDpqpbc1oHFFMwa0l+eJaMHqlj+j8+JOyklAUAp3uslCAVTPfrirz94VCjDNV5Q3WL7fxjFigoUGI6YLZzXZfSo8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764096042; c=relaxed/simple;
	bh=oJUMA4sDGmMbU59ZzooqO3tGwZk77W1rg7373hlnQRc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=cH8gLyuPqT3yXqgfW3CTtmjL9d0REH8+4x0cMeCDxKMnGxqWmuVuXSxPXnM2xYgx47CIeSCHOAfvy4jo6v0XVMqT8YOUA2ZCVyols1Q2C7Ij2HjW/4uz3DeepRRKaKXPThCP0O53+tMuamQdMxytgoAuLhwBTVQg80c3LjAG5TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwLvTsdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E8CC4CEF1;
	Tue, 25 Nov 2025 18:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764096042;
	bh=oJUMA4sDGmMbU59ZzooqO3tGwZk77W1rg7373hlnQRc=;
	h=Subject:From:Date:To:From;
	b=qwLvTsdg2G7cFrcj/X9lPbo7Cr4kClKLoN9PwBBmsJ768rgTNcC3ifn7MSgYl16Vu
	 1usbOUKpxgbxiHstB+9qLCFFRsGCIDIqhvNRec4ZvoKILizFK0MPnr223ESXVj+LOP
	 HAROItOaNJxwDUY+AFjf+JGxkq1T7koRUjHPoRgqDtoGI1HZh8unVtQFaxbMXt7NAl
	 Xr4i2/wI7edyHSOZX4ASH09Ob6G/XTR5EEsSjx023JlrCl61qJKoX3RohPC1zU/YeO
	 YJEgfJP8DR6GDWhLLuuE0Eqebvw0b30BpYKkPCQ2IcuetIK+jIkEsvQmJcPlw26bf5
	 YOapJA78G6M6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EED60380AA73;
	Tue, 25 Nov 2025 18:40:05 +0000 (UTC)
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
 <176409600449.875668.4089644710239671571.git-patchwork-summary@kernel.org>
Date: Tue, 25 Nov 2025 18:40:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: microchip: Enable compile-testing for FPGA SPI controllers
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1027428
  Lore link: https://lore.kernel.org/r/6f96848b026f9a343b80d48179149b30c6b76d1d.1764086805.git.geert+renesas@glider.be


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



