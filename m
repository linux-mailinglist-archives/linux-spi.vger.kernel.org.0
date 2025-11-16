Return-Path: <linux-spi+bounces-11242-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DED1C61518
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 13:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04A084E3695
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 12:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E49B283FEA;
	Sun, 16 Nov 2025 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VocTk01d"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A35727FD6D
	for <linux-spi@vger.kernel.org>; Sun, 16 Nov 2025 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763297854; cv=none; b=eZL8f4kRLR51ukaq29ddBvHc5/RQsDRxo4sQbQoh3803MN5UJn8K3ghqS0OwaG3F2a8ohqkxZMRzGmnGEAfkUoAGrA5wt8mWSZZQQKe3ikGdITsxpcrgkPwOChEtLVLlPRKUQxjJEUW8spw1UEZoW8Sc6IMCN0etQnTfBRZctY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763297854; c=relaxed/simple;
	bh=SIAFabFqgUp+dH6qpAREJf66vC8VMjh4Ohst1uARgP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mf1wFVtmEkF63z5mV3EawKJpecrqdM1+d9D2vNftt0/hEWIharHE4EkSVSLQ1XxGWWTnWYM69CBFXtJ/JnTD/QqxGkoVWQwb0IDwrRkJ8hoQKYbrkYrs8jyzK/NFSnyDcC2O9JcUFXqXI/SaL1m+1VI+Sd97zlyTKQRgQZz2stA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VocTk01d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12E4C4CEF1;
	Sun, 16 Nov 2025 12:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763297853;
	bh=SIAFabFqgUp+dH6qpAREJf66vC8VMjh4Ohst1uARgP4=;
	h=Subject:From:Date:To:From;
	b=VocTk01dJZO4AI9wW7XiANsOLcmswCzjF/K2cCW2ZZdWU8CtC/lOHqeOF1d9yNES5
	 vvBLTSVlADyurbDR3aiwDpsNKP1ImBc5LFSXC0uYWEw83eRGJvc/X4kWXUukYXU5JB
	 Bq5Mm0+Hyx8Py80FAnkE1h3Jrfv/SV3rtizVUi8MmDPTVxSVPoHyP4FfJerEyvu8RC
	 iJ/PI8REMxGKwtx2bOC84+ysS6VYryq/q2oqt++QqVHlrZKia0ckVYVkQ5F1K4xNhb
	 sReOzucJYtPGTe/s9tLtEFvFmQyxlL3tQ5oRenehiNRjMV0ut1oN8UxdYvsZKktb4t
	 ouMcUvIbpvwQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74A423A78ACA;
	Sun, 16 Nov 2025 12:57:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176329782114.2239867.6878546871626367765.git-patchwork-housekeeping@kernel.org>
Date: Sun, 16 Nov 2025 12:57:01 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: airoha: add support of en7523 SoC (for 6.19) (2025-11-16T12:00:35)
  Superseding: [v1] spi: airoha: add support of en7523 SoC (for 6.19) (2025-11-14T23:34:28):
    [1/3] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
    [2/3] dt-bindings: spi: airoha: add compatible for EN7523
    [3/3] arm: dts: airoha: en7523: add SNAND node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


