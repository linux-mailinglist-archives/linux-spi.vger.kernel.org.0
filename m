Return-Path: <linux-spi+bounces-2146-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3B3895CE1
	for <lists+linux-spi@lfdr.de>; Tue,  2 Apr 2024 21:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1154D1F21822
	for <lists+linux-spi@lfdr.de>; Tue,  2 Apr 2024 19:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C80B15B985;
	Tue,  2 Apr 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5LjbAtz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777C15B980
	for <linux-spi@vger.kernel.org>; Tue,  2 Apr 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086829; cv=none; b=orBiJ2PwwfcOQUF7YlfrILgJX9E8ulT/f9QvxQZIBBmeC7MQffOsygOv/nDhEgIbt48PloBub+mOkKca6Yjh2b/6C8iB1YQvBli2C/Td9Kk3Qi02t/oq50Y0TEz7cr10XqVtKoTrInOiLzrWUUtozclyZ9sGIhdb1Kr3qrzvQxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086829; c=relaxed/simple;
	bh=AggSFIaENEh/UvSESlH7+GXHcUgkVWpmLuV5Vvp4xI0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=cO9TnnS509nYjX12OwuJ4ULFC6Cch9elwLOuDJenrDSzaqOjKdTCMUM6bgzobPByzHSg2s+vV9obt5DqVT+Zdk4GRp1JKY6nAPDLQiFNOI8xfpIe1Ueibq5p8LlDX9MNsGidSGoLLLRUA1PXX+Ci3jr/f2SOTxzNd3Rc3aT7Xe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5LjbAtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2F6DC433C7;
	Tue,  2 Apr 2024 19:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086828;
	bh=AggSFIaENEh/UvSESlH7+GXHcUgkVWpmLuV5Vvp4xI0=;
	h=Subject:From:Date:To:From;
	b=C5LjbAtz/yi71l/wFyBGAIdAHYY+SzkcgIpvD43KiCc58A/3kkr7HICd9spgbOV+s
	 Yd5D7lPODk7kzj+audeu2YCoUQhBs6wqk7oCGvNNhA36mhgADoVZwitfUOWlghUbOX
	 Rak60PP45nEalS5g4j4cer6VqAkibNaBR/4y5sagKzELpaG9R0YRnIqIooCkmJL27g
	 gMRq8FoQol+m9blWo8AlduMwlOxWyjHRam88u8BQtPAzzDrRMNyXnHrejmWid2XxHK
	 UyXZuUDxpe9yukZZb/402rR1hGngHperQGfwaNjaTtUtthSHHUBHUpdVU8yHYAMc1F
	 PgcY2PsGr1Jig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C948DD9A155;
	Tue,  2 Apr 2024 19:40:28 +0000 (UTC)
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
 <171208682876.11992.1440979308028775918.git-patchwork-summary@kernel.org>
Date: Tue, 02 Apr 2024 19:40:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: docs: drop driver owner initialization
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=839539
  Lore link: https://lore.kernel.org/r/20240328203927.156184-1-krzysztof.kozlowski@linaro.org

Patch: [v1,1/1] spi: pxa2xx: Call pxa_ssp_free() after getting the SSP type
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=840680
  Lore link: https://lore.kernel.org/r/20240402144523.3402063-1-andriy.shevchenko@linux.intel.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



