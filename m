Return-Path: <linux-spi+bounces-7763-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F76BA9D0F3
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 21:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB944A579C
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6089A21A45D;
	Fri, 25 Apr 2025 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfsGEhGO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D71BD9CE
	for <linux-spi@vger.kernel.org>; Fri, 25 Apr 2025 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607629; cv=none; b=ppu/qirDL5Ww69pFOZT55hPjL1yOl9F0ajBPKeUrDQoRQQfoYkWFBnDc/h79B3QoayfTT9ODVY6Uoi4h78OCGrYFxqGKFJ2Iy6XJDYXwtmSVtLB8KiDFeRHMhTGOcYi9ZYo1tEOZmloP1vaQNh0Vmoi3LUx23ctjJP84z2xcS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607629; c=relaxed/simple;
	bh=9LOkM6BqXHY+69a7DPJ2a9x1L+uieiCAe6LzIcAKmRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Fb8X9BcGPvTXPbB5+WKNRgkYeZww8UV0HHXO6wHjzqSdaE577IoDKxQrAHZgHbBrqqQpKkK3jV85ND1NaKPRCWhubVnHIS0eAV83Ss880rJxFvc93VaAJbbMT2o/YZmEoSWTpVwmwbEzNSV0ER+U0p0f/8mPKqs2jwA7nCTY4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfsGEhGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9D7C4CEE4;
	Fri, 25 Apr 2025 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745607629;
	bh=9LOkM6BqXHY+69a7DPJ2a9x1L+uieiCAe6LzIcAKmRk=;
	h=Subject:From:Date:To:From;
	b=tfsGEhGO+1SJVjhfyChNDTmle21cxcnMZnTioJ7ZA+WNrOqrF/a213CxGoasnR3zH
	 msAGKI6GoFpkxK125V/UqJqFNV9aicIBkL+y5wXIyX2KD8KbLMGwWKQD0K4WNt+vy/
	 7kx9Nv3mJ6me/keFduWLGXUbd60CRj8XgpOLhzMK09dcWI7jqFgXCRJiVwb/8PrtQU
	 dHA7h/YCEmuQO2cPf0OGtlPzNlFRe9OU/7qEAGBLXhl1WK/mASr1YYxmxbaKF9zK3Y
	 AZ0jxxqZs2NvK+g7YJKD1y6KNuKPnJLJj43PeMrGkQH/iT5iVKtuuGN5Z7AMtn0TiB
	 +asIHtmoM/QTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0FD380CFD7;
	Fri, 25 Apr 2025 19:01:08 +0000 (UTC)
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
 <174560766760.3803904.18168371245804180212.git-patchwork-summary@kernel.org>
Date: Fri, 25 Apr 2025 19:01:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-qpic-snand: propagate errors from qcom_spi_block_erase()
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=956324
  Lore link: https://lore.kernel.org/r/20250423-qpic-snand-propagate-error-v1-1-4b26ed45fdb5@gmail.com

Patch: spi: spi-mem: Add fix to avoid divide error
  Submitter: Rangoju, Raju <Raju.Rangoju@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=956613
  Lore link: https://lore.kernel.org/r/20250424121333.417372-1-Raju.Rangoju@amd.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



