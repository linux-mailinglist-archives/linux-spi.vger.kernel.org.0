Return-Path: <linux-spi+bounces-8048-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB91AB1BD2
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 19:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8BD3A9ABE
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8C022F75F;
	Fri,  9 May 2025 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccfbBG6H"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7178F45
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813373; cv=none; b=ndGa7/v+Tbz/8Srh/879vJhvpcsuakKQp2Ke5NyvjM1WHeGgACc+KYeDqYcJkoYY3K37+mLvrZ7uzqw8Kn9vQQ6CTtD7Chq2pm4mntzUdNJTQ2hxVoHBnpBc6qLuXDDg0wlbYpRuUc9lkQqox6PZ1mbjewPTNTnr5Tg/GoSpIY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813373; c=relaxed/simple;
	bh=URO3GWjQYt1llTOtkcgNN2zPqr5TvYAc3JotnyamwBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=dAN3bBveT4v3xcUZtkfHi/r/kKECoOQ0xKTm1meljbFPZX8l+nxPgTl0OS3X3kbiY2B28PmyxJa5/aQQIjtEX+BtovtltUkDyS41VPsxyyBn/Tg6+IXKOx8Tdg1OiEnrrkN/KwBsny3QQjy5hsHK9Gl5zmKDZqR77Em7iRVSut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccfbBG6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25118C4CEE4;
	Fri,  9 May 2025 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746813373;
	bh=URO3GWjQYt1llTOtkcgNN2zPqr5TvYAc3JotnyamwBI=;
	h=Subject:From:Date:To:From;
	b=ccfbBG6H6wbTPmPVlH8QfFIGgZ/fFMekXoEZYIDL/CDDZMiZaeJ0IHspKUvWCkEmA
	 Ifoir8bFReZ71Nha0KuB2eGEXIvJkqTDgNxsUfT0gdFF6Rj/oVjChj2dmWmUHznlmr
	 eqD+6gR1oyeMSLX9bQjcUWymI6sRDLoiiWgiShEBQZG2AsRFYQP0RwhCxG2e3Wwx9a
	 1pUKHXEDht8b4FNOf/zO4g9Q//TL8nc77NO5x2z7WodOyliZ4KmXuRF0BgxdzAxSwx
	 0Glrsdr5PSKtBsKIQCYZt1saw1n67te7xWRUuKhBZt+YLzawp2I3X9PqoTtPpmmUux
	 ZQc+zZyKAHJfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B131B380DBCB;
	Fri,  9 May 2025 17:56:52 +0000 (UTC)
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
 <174681341116.3703445.13752688939362777140.git-patchwork-housekeeping@kernel.org>
Date: Fri, 09 May 2025 17:56:51 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] dt-bindings: spi: tegra: Document IOMMU property for Tegra234 QSPI (2025-05-09T16:54:08)
  Superseding: [v3] dt-bindings: spi: tegra: Document IOMMU property for Tegra234 QSPI (2025-05-09T12:35:20):
    [v3] dt-bindings: spi: tegra: Document IOMMU property for Tegra234 QSPI


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


