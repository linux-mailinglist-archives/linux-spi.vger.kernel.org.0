Return-Path: <linux-spi+bounces-7916-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D88AAB84C
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 08:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895D93A8387
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 06:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C042FC111;
	Tue,  6 May 2025 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNeq4+qu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D428CF42
	for <linux-spi@vger.kernel.org>; Mon,  5 May 2025 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489033; cv=none; b=pj3OR194nUwEREM3RZydOdNCb6gdlrWgoYfhuwW2PQkq8wC80De7f/aJd5Ol+DHV5CcjV4hpzQ+L+6S0JtamDjMVp52jlKhZS3fl7KMf42f/rPtFneQqVi7CrLCvgP7NkSPo146XX/5gE48gP7yDWy5tPjueNrywUiz6IciLwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489033; c=relaxed/simple;
	bh=RO+TlTza0sATNyJLtiK1rNrZDoob2tXvHfXcWXvtny4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=h+fiNhH6CFa9Z2bUV4nzIN52sPJYsZlTu0or1D7q8MZhLIjdV4WLIXE9HomlGr6seBHUOb/XQr7nKTWZLU2n5EAkfq8eM3EZWR1aRXoRP2G76O+6ySsw88GlhXnrrctQ4XsXi7HPoth6l4WKdVrOBexbZFmFJTF7SoRSw60pgvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNeq4+qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307F4C4CEE4;
	Mon,  5 May 2025 23:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746489033;
	bh=RO+TlTza0sATNyJLtiK1rNrZDoob2tXvHfXcWXvtny4=;
	h=Subject:From:Date:To:From;
	b=hNeq4+qunMr386uxYjuD7qKVEwOm4vxOgxVPQc8/coKj4/8d6mANlwlwQwSuw2gfy
	 Sw2AbyIJslHLg8RJNBpvtSIp1gK23157kXMGyzJRBut2mIsrT0KpYF2Qtaj/f6Q1Bs
	 DurkI1FStpoUZuyGi4WQLbEkA4LxOFdoX96IWDADBR80pLscP+3Y9ihuEgUB7VPS46
	 +Goni9cHRr7ivjU9MhEnx66VJOJReeEUmWZo3AZEN2Mdb3pANjcP1j/mGe9Z9IlBrj
	 S+GjZhnJLb4FyzW1+G+k4jHwhIGfpFtTP7tAFSdKO5T4wRk8lqYwL/6jPCpFXZvves
	 fSitmKYC9Y8kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74370380CFD9;
	Mon,  5 May 2025 23:51:13 +0000 (UTC)
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
 <174648907187.967302.3422172154509250445.git-patchwork-summary@kernel.org>
Date: Mon, 05 May 2025 23:51:11 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Minor smatch fixes
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=958815
  Lore link: https://lore.kernel.org/r/20250501-n-smatch-fixes-v2-0-d2ad9c1f2e67@linaro.org
    Patches: [v2,1/3] spi: atmel-quadspi: Fix printed error code during DMA setup
             [v2,2/3] spi: cs42l43: Make handling missing spk-id GPIOs explicit
             [v2,3/3] spi: cadence-quadspi: Assume device could match via platform

Patch: spi: loopback-test: Do not split 1024-byte hexdumps
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=959044
  Lore link: https://lore.kernel.org/r/37ee1bc90c6554c9347040adabf04188c8f704aa.1746184171.git.geert+renesas@glider.be


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



