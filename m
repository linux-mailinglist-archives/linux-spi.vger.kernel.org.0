Return-Path: <linux-spi+bounces-7939-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 039B2AACD92
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 20:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7015B50053E
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 18:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9547E28541F;
	Tue,  6 May 2025 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0vJSOaG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E6227EAB
	for <linux-spi@vger.kernel.org>; Tue,  6 May 2025 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557791; cv=none; b=Jj7KRv9ghXZBghrBhkqIH0CXgtakAwI8DVwayB5FEARjAB3DOj4E4pWqTuKqLSj+gvaDsssw2NV5rm1bPQPghRvNvnlC44gVcBGDfSDGTDvrrCw2tyX+YYJLxthkg7ILaepf4UqbKhnyzTQ4M6KU/j9785fg3vRZGMyz6GGrzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557791; c=relaxed/simple;
	bh=Z9+6cTNT6abM+MnWhaqSyqKcKLc4teKAMCOdlFPF1L0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=keloMZ9s/tf5c/zrv54smFrCBZm+NQN1BoXhj40sFY/jDJgQp8AcIWYS0m6pK/OMTAUowBSUBj6cd/Q0FCqWRhmLfv6y0tEhZKgusr1OSnW/7AZIZwQs3MkzseOXBQGT0tWqaovR0GjkrXWmjkZkbq1kWYCmnXRR05TwZUmOtRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0vJSOaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7D6C4CEE4;
	Tue,  6 May 2025 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746557790;
	bh=Z9+6cTNT6abM+MnWhaqSyqKcKLc4teKAMCOdlFPF1L0=;
	h=Subject:From:Date:To:From;
	b=l0vJSOaGA/yVscp8NJm1ybLpoWdLNgYVE5CsXMWQZp/1QQoH7DkVNUvv8Ka2bNbER
	 qNU1Sc9HCKkZVbQ9uA0LeyP+SUw4/Oc38yVcH6rS76XqRez194XbfVCPOGRYRBHlR+
	 sRyenIsnMvPMxGSg8WsH89fK64yJovgfj3KSNs0LR1O5TFDEeNB+DKwyCEU7+vtqax
	 Fiq73z3KWJDmC+E2XYlqa8yPuGEx2O1meZdx5v34vagWWUU1UUDIMZO1wbwUzocG7J
	 JkZAf8d7+hkspgzPxTCKnrtf5DddtGJ1b24cCPFia7fPe7MB31ocbGWUqxJjBHmYhK
	 p4I6La7+2Uvgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF6380CFD7;
	Tue,  6 May 2025 18:57:11 +0000 (UTC)
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
 <174655782969.1621430.9234896895587309246.git-patchwork-housekeeping@kernel.org>
Date: Tue, 06 May 2025 18:57:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] dt-bindings: spi: nvidia,tegra210-quad: Add IOMMU property for Tegra234 (2025-05-06T18:08:48)
  Superseding: [v2] dt-bindings: spi: nvidia,tegra210-quad: Add IOMMU property for Tegra234 (2025-05-06T17:58:13):
    [v2] dt-bindings: spi: nvidia,tegra210-quad: Add IOMMU property for Tegra234


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


