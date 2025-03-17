Return-Path: <linux-spi+bounces-7181-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5FBA65E7C
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 20:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F31189A966
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 19:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EF01DD88E;
	Mon, 17 Mar 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3zKwJeS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E21A01D4
	for <linux-spi@vger.kernel.org>; Mon, 17 Mar 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742241091; cv=none; b=MaDdzW3URvjyCA9RathvkJfcwNc4WNZf9X9SKbSlcKb3AG6sywbn+HEMcLZ/YD9QKKc5HIxWsF8NeSL+fz/J4yR85B0SokVe3vmYd5mogpXM90k7AKTQk2ENpmZwykynFhMhE07NvHjUtUNA8L6iWwOHpGqapPwpGSkiS2EIq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742241091; c=relaxed/simple;
	bh=AjxihUH86BLp2asnb5s8PY1ZSNlSYT/IBD7Wk76o0lc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ID4+wHUA08RwWiy8I5h5SrRHIq+nUwx1oY5uLVpnNPyxgUHNDgAIRBYaqqgql+c+JE6Z+lNTf+9g4FIo9pHr/6eCLwPG5UNOJQcFFLF75MMB6UTMPU//sYKaB7IbqtGReeHW/AdBEiVZ6yFjISKV9Jbm065lwbKnbAYo5neJMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3zKwJeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145FEC4CEE3;
	Mon, 17 Mar 2025 19:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742241091;
	bh=AjxihUH86BLp2asnb5s8PY1ZSNlSYT/IBD7Wk76o0lc=;
	h=Subject:From:Date:To:From;
	b=o3zKwJeSaGIAjD+3sgVdtthk8Ko2xiWrVQXqvRaQtm8RRKhSCpY0cn31zsi7D2TPi
	 N58saVUe0mlP/f17OH4LjfltZv9gsTVqNZgfP6cSYJ31r6FLZnzB84T3qggJdxodhS
	 9Pm4xekmKDQ3EBkCqYAfqPGioZqSj+SMnPS/7QVpMJoxbBe6l8jKxSFYpc33MtOsyZ
	 LdilmLvge6O5TXpe219pdHKfOwipwIcZMf78C0pn9Nw0+o21QR4W5Zs+vfLhokMoaT
	 kiuw9w4BfBkjLQD+Ahfc/SHiGB63on/4zIufqZIBvur6X6mzfWOzvdkWNxOKoq19I1
	 xIYftBegRnhEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 752BD380DBE3;
	Mon, 17 Mar 2025 19:52:07 +0000 (UTC)
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
 <174224112598.3892265.11664826353434593088.git-patchwork-summary@kernel.org>
Date: Mon, 17 Mar 2025 19:52:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: spi-mux: Fix coverity issue, unchecked return value
  Submitter: Sergio Perez Gonzalez <sperezglz@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=944373
  Lore link: https://lore.kernel.org/r/20250316054651.13242-1-sperezglz@gmail.com

Patch: [next] spi: spi-qpic-snand: avoid memleak in qcom_spi_ecc_init_ctx_pipelined()
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=943667
  Lore link: https://lore.kernel.org/r/20250313-qpic-snand-memleak-fix-v1-1-e54e78d1da3a@gmail.com

Patch: spi: sophgo: fix incorrect type for ret in sg2044_spifmc_write()
  Submitter: Qasim Ijaz <qasdev00@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=943704
  Lore link: https://lore.kernel.org/r/20250313214545.7444-1-qasdev00@gmail.com

Series: spi: sg2044-nor: fix a couple static checker bugs
  Submitter: Dan Carpenter <dan.carpenter@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=943914
  Lore link: https://lore.kernel.org/r/79c71b81-73a9-407d-be6f-481da27180bc@stanley.mountain
    Patches: [1/2] spi: sg2044-nor: fix signedness bug in sg2044_spifmc_write()


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



