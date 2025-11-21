Return-Path: <linux-spi+bounces-11457-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3D7C7A52B
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 15:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA0B74F4220
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4078634C127;
	Fri, 21 Nov 2025 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvvM2G/D"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D533554D
	for <linux-spi@vger.kernel.org>; Fri, 21 Nov 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736041; cv=none; b=ALIbsGwaLxSUdO6+y0q35T37/A7muyPyEhBTarm7TqN/vr4l5gArW6riiaSdu7mn0EXppqtLFYzqjBIXsVSwXxklNNhYlRWfO3KUKoyfwRWHL5IeTCB1eQvuM0v66xj8KO6IZKb9+8oOK7+NwyDBELAjbJOnntZ3UrmT6XxZJeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736041; c=relaxed/simple;
	bh=2apEUFsB/Fuh6i9G8+a/Y461wPfK9TpmGK6s5r/dbZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KOpwT1qiY5NLGyITv/0i2IpbIHDqi7ImWYJoY3HoQhTX8P/NZaLvVbDB5VPtd5EJ2u8sxGG6k4M5BXnazQUxCAzq20Ey6Jh2wa4H2NyEx5EEVGY28JSJ0U7AnVT1E4Qxu5CAki/3UfVjo3xKP2G3Mbyhww0IJQi1OXDNmWWgboU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvvM2G/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EA0C4CEF1;
	Fri, 21 Nov 2025 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763736040;
	bh=2apEUFsB/Fuh6i9G8+a/Y461wPfK9TpmGK6s5r/dbZY=;
	h=Subject:From:Date:To:From;
	b=QvvM2G/DthWmit5XnpeRhsEMJbR86G+GmQS1MHPpFhz35nv5FTuRanBWgQuwSB5Hj
	 rwH+plfj40goDHT1/ZHWGv+Dln8n+O6nBopF00aSiI9wJFmZHdFdcwtDMY9Tw82FSE
	 /hybBHEgDZ21x96vdgM2hM/2tx9y2PHPDNDJIVNKkohNZbyDsfc4BmEzdDn3jZplZR
	 oTV4gfcWB04eUMSkAF3Y5pKGH3KS/yD7Qak9Spln0XrC/XqP9t/Y3yODasVd7ly2YT
	 G9UHj4IcKU8HDArWCPQKCRI9v5dzX9tkCmKqjBfPwSsly8eZYVmWuNkYpN7J1N3UDO
	 TERixPVptTLCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 76B513A72A5E;
	Fri, 21 Nov 2025 14:40:06 +0000 (UTC)
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
 <176373600515.2455529.11312218673482609682.git-patchwork-summary@kernel.org>
Date: Fri, 21 Nov 2025 14:40:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: arm64: qcom: add support for Arduino UnoQ SBC
  Submitter: Riccardo Mereu <r.mereu.kernel@arduino.cc>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1025901
  Lore link: https://lore.kernel.org/r/20251120155825.121483-1-r.mereu.kernel@arduino.cc
    Patches: [v3,1/6] dt-bindings: vendor-prefixes: Add Arduino name
             [v3,2/6] dt-bindings: trivial-devices: add arduino spi mcu interface
             [v3,3/6] spi: spidev: add compatible for arduino spi mcu interface


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



