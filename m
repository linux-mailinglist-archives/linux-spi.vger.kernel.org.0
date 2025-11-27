Return-Path: <linux-spi+bounces-11631-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76622C8FD86
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 19:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715E83A9DC4
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A192F7446;
	Thu, 27 Nov 2025 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHL8IK8j"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19562F747B
	for <linux-spi@vger.kernel.org>; Thu, 27 Nov 2025 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764266447; cv=none; b=NgU8VDF+DPSswdyNV6EV355WTM1ROPW59pCV3BfK28ZXxvHOFzZegCKF4tr+oBw1z+4dJ7b+ln8eERQ2hW8TX7fHMT8N8QkQmw0y+oA2NJU6wDZuLmdFpR9Tpwmd4lab7/dhFoGr26MvehcjlG5pSZA4MhzVEK3+LoyRA75FGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764266447; c=relaxed/simple;
	bh=wK5kh9pTC0mfvb70WUKqtB1dMHiI8ZpHwVDX/RYkXlk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=u9jdRF+YFOCuNaLOqiq32m7bypFQCfZvFfSH0P84kXBHlgFVeWs8WVhXqigxnkxi92raRlNCUBYRuj8XSwrAtTCsIOW7wHvJmTUs/XKU5ejrcDabRh/pQrP2ncx5gh2r5aQwb+HsHHe8ZP8E4HvBW8/JO4aV2j3aXbiUr1rWL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHL8IK8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CBEC4CEF8;
	Thu, 27 Nov 2025 18:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764266445;
	bh=wK5kh9pTC0mfvb70WUKqtB1dMHiI8ZpHwVDX/RYkXlk=;
	h=Subject:From:Date:To:From;
	b=iHL8IK8jUBQsciyTicINCPEhE71EMwQytbpOIx5yzt7gXnv8oVN/mgDM1oCLhN0Oh
	 v9Jlyp1fO10DlLWOkaKmgQbfPp1REp1XHltDeVQcnWU8nh1mwW74KgwjxChQxHgQu0
	 f5vVfk4AUCHFt9+e6YBBIEXuzssh46egioIy0HxUeZt1Aj2rbBtvKmbbKPs8dD0O2a
	 TFIcj8ieAkqQLY/GYo6zDqMaWpJkSsO8pOSaee9+gh3iCocVpv4jJqwsCYTG6TCch6
	 V3uDiRFLb9HQHNVwFQ40YgaajKH65Q9OrCmpbsFobrazDgsS/x3vbCWqaxSSO8bFoa
	 nwLPRkvwJ/qvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF7D1380DBD5;
	Thu, 27 Nov 2025 18:00:07 +0000 (UTC)
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
 <176426640657.2671507.10669679519932709114.git-patchwork-summary@kernel.org>
Date: Thu, 27 Nov 2025 18:00:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: airoha: driver fixes & improvements
  Submitter: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1010422
  Lore link: https://lore.kernel.org/r/20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu
    Patches: [v10,01/16] spi: airoha: return an error for continuous mode dirmap creation cases
             [v10,15/16] dt-bindings: spi: airoha: add compatible for EN7523

Series: spi: airoha: add support of en7523 SoC (for 6.19)
  Submitter: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1027581
  Lore link: https://lore.kernel.org/r/20251125234047.1101985-1-mikhail.kshevetskiy@iopsys.eu
    Patches: [v6,1/3] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
             [v6,2/3] dt-bindings: spi: airoha: add compatible for EN7523


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



