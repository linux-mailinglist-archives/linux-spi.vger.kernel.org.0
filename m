Return-Path: <linux-spi+bounces-7402-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37262A7C013
	for <lists+linux-spi@lfdr.de>; Fri,  4 Apr 2025 16:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE04C3BB281
	for <lists+linux-spi@lfdr.de>; Fri,  4 Apr 2025 14:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A572B1F427D;
	Fri,  4 Apr 2025 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJV4CCCD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E11F3BBD
	for <linux-spi@vger.kernel.org>; Fri,  4 Apr 2025 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778585; cv=none; b=p5R4VOI6pCdRXhavILEyed8AnW106AHPrroZQ1/5XU5Wrtsp3hE1mMChbIqc4LwlaK2xRINEaTL5Jgrr0YerxKq3mejGOiNbAiAq5fRkQOIdYiFt9FCkfjta4+os7li8TxPSKIoBRgb+1PhsOkqX9GuwnS3QPBAJ8seTkrFzE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778585; c=relaxed/simple;
	bh=5q5nfAHSJdVeb71oUUF2QQ2JdNpvBt36DCuhcD6Pr9E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gpx65oQnFzroYbA9ceUhi0m4vXoPS3uNErCxfps+8zCdpRtT6M2kFDeohdwn0qWDccP787TMFpEm+iTzURbm0TgIbqlz8L9DbDzKhrfpgeiQowMMXcNDQPzTpK+Lb71UNPsB5+9DKdO9Rj0IzI+jdfCe4YiczwgcoxV7JulIZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJV4CCCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22B2C4CEDD;
	Fri,  4 Apr 2025 14:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743778584;
	bh=5q5nfAHSJdVeb71oUUF2QQ2JdNpvBt36DCuhcD6Pr9E=;
	h=Subject:From:Date:To:From;
	b=KJV4CCCD0LEzccxEndEIwSxhueGCVZ30SEvLhQTwRkM6d/6F5E/I5SPb3qvEiU1Rh
	 jxNf1MhthyIzbjJQDXKVYw/zrVoajrpsvyoeqEACcZemAtT6JLLygwQESkYVTlcjII
	 IHrw4bfbwKc+/HY5USfOq7tMzuAzb/mpTfACo5MboW03EJBubZA8Kce1csnPDaE0Ol
	 AMORktlgMFrWKLLHS43YeVX1p8E5KWKLi90NkA8JoUj6h7Z8eh2o+ToHzeysv7rMBt
	 kk94pGANcjzrJilhn0nwsTyQ6X1SUtER1KsxNLcmNDZGSuT+yKFOsvu700OEXyW26b
	 baXM7g/iNaSGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 272573822D28;
	Fri,  4 Apr 2025 14:57:03 +0000 (UTC)
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
 <174377862177.3288580.8800141778614648605.git-patchwork-housekeeping@kernel.org>
Date: Fri, 04 Apr 2025 14:57:01 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: Add support for Double Transfer Rate (DTR) mode (2025-04-04T13:54:27)
  Superseding: [v1] spi: Add support for Double Transfer Rate (DTR) mode (2025-03-26T08:39:54):
    [V1] spi: Add support for Double Transfer Rate (DTR) mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


