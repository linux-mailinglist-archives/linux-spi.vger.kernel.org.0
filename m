Return-Path: <linux-spi+bounces-11369-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B8C72385
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 05:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE1414E1104
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 04:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8FE86353;
	Thu, 20 Nov 2025 04:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXp/+pLh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D82AEF5
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 04:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763614670; cv=none; b=Pz26Kb7ZLHF4Gq7o2QiHMhSmHkOt/74KnY1YRkypY5rIfy9Fkrp3CnY2wQU/iCPTuy3fYZV6HiFkWSn5G73vPUlSxiIhtmypGZ6SVd7E7K68ctSr1DWb2GadDZREh5igj8TbX7igfMLhLkwTNbjPUGQyT07+Ci9oY5gg9ZjDU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763614670; c=relaxed/simple;
	bh=7t0skcU0G3PaEmvsC67EztBH3Y1JLBOOs4Zv1OhFa/8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GyQySFp1dB2utYJAhNirHYGRx1umFZK4hmyq7Aw3dyr23ZpoYtiW1MpfPajjoazAvSYiqssoCcavrfb+jrylO708Ljis6kDtDfTaPu/SbJDtz4C3byH3FcU23WczG+s7DLw32uDf3J1/QJWE4qDmTLeVEwBw8e1YJ48xV5aK7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXp/+pLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E19C4CEF1;
	Thu, 20 Nov 2025 04:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763614670;
	bh=7t0skcU0G3PaEmvsC67EztBH3Y1JLBOOs4Zv1OhFa/8=;
	h=Subject:From:Date:To:From;
	b=lXp/+pLhoEE2CwVgkBZToKHcFaDyBfu/4ExGfAVYaiM0De5lh758PkrvglTAKxbAp
	 UKg4sD6Ti60ahdiYcMnQRHDDx1NZNBWZl+mJ40aZXKWKpJhJuACZmZFGvLBKyqsVij
	 cteyKlyJRKneQ230l7ElwruzGQ0J7FiB+5NjfvPZU2oO7ikB15H4+uPDgLD9Tso4CK
	 TIpbt2LTCRHzRLjvNr2y+vCeCagOjRwMkd+SXtESqOQ6TQL+r9RB0LRDIK2wq87ieH
	 Q7ICANVc9HGlvoOLZOsZL+Q8Q77cCi/SheXf7ghWgP8kTPeq7s5U8TAOEd/PbK77Y4
	 nvvaNSPsVTdNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE60F39EF978;
	Thu, 20 Nov 2025 04:57:16 +0000 (UTC)
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
 <176361463554.1083112.16763650182911427610.git-patchwork-housekeeping@kernel.org>
Date: Thu, 20 Nov 2025 04:57:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: airoha: add support of en7523 SoC (for 6.19) (2025-11-20T04:27:50)
  Superseding: [v2] spi: airoha: add support of en7523 SoC (for 6.19) (2025-11-16T12:00:35):
    [v2,1/3] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
    [v2,2/3] dt-bindings: spi: airoha: add compatible for EN7523
    [v2,3/3] arm: dts: airoha: en7523: add SNAND node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


