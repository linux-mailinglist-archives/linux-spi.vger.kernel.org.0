Return-Path: <linux-spi+bounces-4426-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85444964476
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 14:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FC3287A40
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBF8195FF0;
	Thu, 29 Aug 2024 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhrNKTty"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAF18DF61
	for <linux-spi@vger.kernel.org>; Thu, 29 Aug 2024 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934694; cv=none; b=RSFk+6fz+cqjXxleNV8qqE0PmDytm4eFQHUA3J9WbNXcwRDhJ6U2tGs6fyMd8YdmHcacaBqYyv4jrB+hkHz0ogJlwubpuQh23MHTpkX5U2EQ1/R/0zLm+tmiajihzofRW01ERmZPcXxmiD15mdXxxd4EW0Ra22zQT4IZsy7XSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934694; c=relaxed/simple;
	bh=AlG+Eg3FK0A/1KI9jWcikdbOQrMKA/8dcqaN6qDDzcU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JfOTzYWzKB5nMGyc87oHta1gt11/gnR4pXSrgEe8Fh/lGQdHZR8/a+CsBhAV5sdm4eNwr08P5DMgmChTdqmMws6xdH+qEP1AdDz8IGlln/8ptL9IjtmlJ4/Ifhz+FlK5QaLUa2sYRB+pfwSahQUNHWKZQY0ACnAdQcAFqQY9g4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhrNKTty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E4BC4CEC1;
	Thu, 29 Aug 2024 12:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724934694;
	bh=AlG+Eg3FK0A/1KI9jWcikdbOQrMKA/8dcqaN6qDDzcU=;
	h=Subject:From:Date:To:From;
	b=fhrNKTtyXUCqsNLxvfOl00h2vHC861dOUwUoC3QETcFY5Xf6DUwrwceRHJM9Mdkk/
	 W56pWVWuPo7E6bgpiK00esWDaHtpofx+TBAdt78sN1iUjHhCthiDylmVykZO/Ut2zx
	 qVl0nO5eNcHqBLMeHsK8osHf450OsA7D7ZRddP3wj/DXJ3whvweHoDcGFPXGuxg8o1
	 yZWOrWWcGGGOFLuqmlPb6ePgcZxn1KpoqMa7hKLGtAjtAgzpbFHi62jRM7k5ybu1g6
	 rhdtlntZjzDN756hBdFB46Iaa+qQtGe+6nhKIejNNSWiTZoXlQdlOnRXwZIcLokDgJ
	 hS/FIu74QeWAQ==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8D3D23822D6A;
	Thu, 29 Aug 2024 12:31:35 +0000 (UTC)
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
 <172493469551.1933850.2672441386876487697.git-patchwork-summary@kernel.org>
Date: Thu, 29 Aug 2024 12:31:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: ALSA: Add support for new HP G12 laptops
  Submitter: Richard Fitzgerald <rf@opensource.cirrus.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=876273
  Lore link: https://lore.kernel.org/r/20240802152215.20831-1-rf@opensource.cirrus.com
    Patches: [v2,1/3] spi: Add empty versions of ACPI functions
             [v2,3/3] ALSA: hda/realtek: Add support for new HP G12 laptops

Patch: [v3] spi: rockchip: Resolve unbalanced runtime PM / system PM handling
  Submitter: Brian Norris <briannorris@chromium.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=883912
  Lore link: https://lore.kernel.org/r/20240827171126.1115748-1-briannorris@chromium.org


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



