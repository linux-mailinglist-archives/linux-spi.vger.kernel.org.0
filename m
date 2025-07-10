Return-Path: <linux-spi+bounces-9088-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8274B000CC
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jul 2025 13:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EFE3B3147
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jul 2025 11:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4685246795;
	Thu, 10 Jul 2025 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhYzp5NP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4082222AB
	for <linux-spi@vger.kernel.org>; Thu, 10 Jul 2025 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148184; cv=none; b=cOKzEl9zbiazrPfM6e4Q6vjrns/gh93WbcQpbmk7sppPc9Qn2G7WUCaLQZB0DjSqduvEhIpp/GVogM9RryZilT0zPrMhd5Px0HY4vZayVhN/jhuU81AGM4tIY8dtcH5kxkS3nGDUzeHi/4d5Dk7H+PD5mF31OjtZ+n7DMxmzdco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148184; c=relaxed/simple;
	bh=sXObONDXwFFPEmWmRAZ8KLJ/IhXQAXcVNxm2vYX8YkI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=f7yXgiQEQtRoKD5REGn/DGkXiBKQVp9WeTjYNSLwOntpNbG/Lzy4Arpnl8KUUkQjF5WMjm974edEBYUd6UBh4JhIwsTSfvWaKphQob1H3/wA54jcANUigNpMtBmXrH6fcHxJ5mxXEc92KMZQc1q+ZvcJvyqVYerkutHl6YS3eqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhYzp5NP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF14EC4CEE3;
	Thu, 10 Jul 2025 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752148184;
	bh=sXObONDXwFFPEmWmRAZ8KLJ/IhXQAXcVNxm2vYX8YkI=;
	h=Subject:From:Date:To:From;
	b=YhYzp5NP+i4jBYv/Z6BcKWzXLcVOkwq/E/ERtCgHqhy/cEgk0HGjQ5Kf1bfGVxf8b
	 VWkAziOklE+tDjENjNAT4RXicoE6i/oKmiRfr8iy7S2QVeVp1Q+m69lcme4qNB83sJ
	 THkV0VVnLWn1cUt25yPicrAI+bGbSM453gFU/opCJtyGXaAvhHYTbwM0WD2J7jjqjW
	 MNaVV517SYlQ0G/zDznz4nUEMiNkIYz0V+6wSrVUWC6WznfamN51moqDRfrhTigAnc
	 wk8fWmHX7tDsoRFRDkwg2XypnNtuZSrmg+/7C4gKp6oG01et1oKEiQQ+Iz4CZTF6BU
	 G9WDrQH4+hBXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5AF1D383B261;
	Thu, 10 Jul 2025 11:50:07 +0000 (UTC)
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
 <175214820601.1463119.7054102892112605183.git-patchwork-summary@kernel.org>
Date: Thu, 10 Jul 2025 11:50:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: xilinx: Fix block comment style and minor cleanups
  Submitter: Darshan Rathod <darshanrathod475@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=980845
  Lore link: https://lore.kernel.org/r/20250710045058.1325-1-darshanrathod475@gmail.com

Patch: spi: sh-msiof: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=980673
  Lore link: https://lore.kernel.org/r/108c136f2cab9aa8bc8ac90d14a05e66fb87deb0.1752087740.git.geert+renesas@glider.be

Patch: spi: rspi: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=980672
  Lore link: https://lore.kernel.org/r/0b64c1c3803e6d3eeb3ae9cd8921d4fe67f37118.1752087701.git.geert+renesas@glider.be


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



