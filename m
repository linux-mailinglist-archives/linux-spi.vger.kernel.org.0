Return-Path: <linux-spi+bounces-6331-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5FCA0BE36
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 18:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9C63A2B46
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEEC1FBBD3;
	Mon, 13 Jan 2025 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6PLWGcj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A220AF71
	for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2025 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787646; cv=none; b=e+UsJM7oHdaSm00ikS9y8HQZqU4sO2d8VcaqEmkslhizsBUQ/RqjEL0/y4gxj9KXdz6F5sIx8XM+lfSDiYhWKDfSzjcAJ8+a4DOgtpR+qJn8G5gsfXiHt/DIDQ97slnI/R/+Y6q+hUbRXR7bw4uMWc9N1/uxqle3NaZDFLzoccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787646; c=relaxed/simple;
	bh=IiKGnKa9obKHI6dq2dPAgDx2p0R1wDeF6BBFNxOQnaY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=EkwgVYNpuymQno3ULiAI/kM6ov8337khcS3tVnLk0a7uWRVbJ8CRvTRMJZvjqs+uttU6VNGPXKfFcdxcQ5wweTARj1WqhojpasmZtSHHiXTGZvTs2qQvTjpwjdBWcqEAQFFkRxGG6wuP6V+fh34H2VS3HyqLR1vG6LUSFBX+AUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6PLWGcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64A5C4CEE3;
	Mon, 13 Jan 2025 17:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736787645;
	bh=IiKGnKa9obKHI6dq2dPAgDx2p0R1wDeF6BBFNxOQnaY=;
	h=Subject:From:Date:To:From;
	b=u6PLWGcjRGP1589oVVGZIFcflxBQEjw++bDqVxtHtHCFBUPQXnY5UuBolwwS01mmh
	 7wC6UbBF8BKCT/5UUptTI3am/3El4QSm+t428agRdaTG6Jh1qOkIakljcLsBEuyNoH
	 yu8Vq8Qejf7D8feMccJ2+9zWsOXAGdrHQIq7t+zrQioazMVUSMbbEmXYCF7GPl8jXZ
	 SxG77UBT85OHOKs2FMpnZzGfLYIufeesYRI1ndXNx+7nh6vZ7F88M8P+qg7xJ99nR3
	 WOGZccODXeF8ixpYBJlRIzCJzRZq5UbTROIt00F8YRBk6gd0dWiw/j4qd69lqAZilf
	 viiOrCHBXseSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3CDEA380AA5F;
	Mon, 13 Jan 2025 17:01:09 +0000 (UTC)
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
 <173678766761.3562158.14317669026953070341.git-patchwork-summary@kernel.org>
Date: Mon, 13 Jan 2025 17:01:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: amd: Fix -Wuninitialized in amd_spi_exec_mem_op()
  Submitter: Nathan Chancellor <nathan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=924562
  Lore link: https://lore.kernel.org/r/20250111-spi-amd-fix-uninitialized-ret-v1-1-c66ab9f6a23d@kernel.org

Patch: spi: ti-qspi: Use syscon_regmap_lookup_by_phandle_args
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=924559
  Lore link: https://lore.kernel.org/r/20250111185400.183760-1-krzysztof.kozlowski@linaro.org


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



