Return-Path: <linux-spi+bounces-12020-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7E6CCBC0C
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 13:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83ACA300FE0C
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 12:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5894A32E6A0;
	Thu, 18 Dec 2025 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6p+CDvy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462132E13B
	for <linux-spi@vger.kernel.org>; Thu, 18 Dec 2025 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059997; cv=none; b=COGzovzafes6pTGcoUzmvMifdOMgf+ICCrX2nmfJ7LxHqc/2LeUOpRPFsqXLKmnanSht4M2dMjblKqADHe1QAyXepGGm9wDpOguCeuTwyI/r7lB3Sb3pibhvfln6bRC/WzuqKR2YS//y9YhFJLBuQ+NgWUCH9weNv/W8T0+ylmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059997; c=relaxed/simple;
	bh=mPmoaTXAGSOVYuJiyJeHcRD2fl+6nuQNh05kDi8gJgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Nj3VrQ9lplnJCg9SICxJYXnoXWRvPZjdSJG8uZmJ0ZGWuW4XJklCCBsCu/XD/wD5vg8tm6hIn6frr9ZquZzfDPv+k2yuhSikbGiJgkFI8kSateDQLxdmWButKjLWmqMxwbakM4znoSzmLOzsqHGfBDqCqeqQoZpmIpx/W94Y6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6p+CDvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4962C4CEFB;
	Thu, 18 Dec 2025 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766059995;
	bh=mPmoaTXAGSOVYuJiyJeHcRD2fl+6nuQNh05kDi8gJgY=;
	h=Subject:From:Date:To:From;
	b=i6p+CDvykaUmY04VdI76cnOhkVH+DWwP/37bw07WbXoT5gBaK7c2yVk+AXY5cYieL
	 00sqH+jr8YcdX4xwsCE4bUMxJTzYanm9AsKT6UXbKuQSpUDG2oCvKFZldaCe/+r8Ju
	 PdPJ03VWdQwoW0CltJDXpJVqGh4mC+7NnxgqNztShWucD4pqafkNiMrNGtm78mPGNW
	 2KyvowJG+6avtNA1PceUWrMeO/V6i1azH3u+fIfXElBf7ilg7omfZzQHtPgrEZ/X4B
	 RasAHSqtFVuusxVHstyBPaXh+EDBegsGcRLQfs64UkXjVR55ro1wsT/456tvgZFGjv
	 QcFgNSUaHu7Hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 413BF380A945;
	Thu, 18 Dec 2025 12:10:06 +0000 (UTC)
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
 <176605980473.2924846.17534951408357473835.git-patchwork-summary@kernel.org>
Date: Thu, 18 Dec 2025 12:10:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: atcspi200: Add support for Andes ATCSPI200 SPI controller
  Submitter: CL Wang <cl634@andestech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1033259
  Lore link: https://lore.kernel.org/r/20251215132349.513843-1-cl634@andestech.com
    Patches: [V3,1/3] dt-bindings: spi: Add support for ATCSPI200 SPI controller
             [V3,2/3] spi: atcspi200: Add ATCSPI200 SPI controller driver
             [V3,3/3] MAINTAINERS: Add MAINTAINERS entry for the ATCSPI200 SPI controller driver


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



