Return-Path: <linux-spi+bounces-5921-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1759E57CA
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2024 14:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBE21881157
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2024 13:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B73218822;
	Thu,  5 Dec 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO7FmAzr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D680A1DED77
	for <linux-spi@vger.kernel.org>; Thu,  5 Dec 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406618; cv=none; b=e+K62gqQ2QppqqSAnZZbhbkUtJ8Qzkx9vQc9ZzR9EKT75p0NR+mgQ8l7w8KY1Xju3VjIfVrB8SM7JWbuWuk4mTkj23o5xVhvrphRgigBfKjpbZzgrGtuDZwfAejI2sh+Ch/g2DUeuA2Xuu5lF7ik6SnjMqSRnFzzP1Mz34zP7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406618; c=relaxed/simple;
	bh=XbPgS7igW9dl0Lnj5NgEyC0OVoTzG7a3uU3XcIiFqu4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YOzULUr7zuzbtXokGn08UJEbHU8P937xF01FXQsmgLVGTrRUxIsYIklXK+QkUhgwGNzKTMPF1DbxwYVpFLPaEwLtvN1b4UQj3QBBBRK5eNo/D38rZWXh0TuQ+CWDnhvRXaQGTQHd0vahv0wNYlryJeYWiMk8/IjQz/oPu9O0ZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO7FmAzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717D9C4CED1;
	Thu,  5 Dec 2024 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733406618;
	bh=XbPgS7igW9dl0Lnj5NgEyC0OVoTzG7a3uU3XcIiFqu4=;
	h=Subject:From:Date:To:From;
	b=fO7FmAzrQIF75kO0dbj9x/mQnVWrNgZtUG8u8Yc2ZVfCZELpT6nTEWHNb/rfHTXlo
	 XTGf7eNfPV6yL0PRRsaPPuWbuBK3aMZHYPFm3/XHOZA7XLbTm4+RCiqwZCdLi4/xrA
	 EaaC0YxcBjlItbkSz/uns6GvgNDvmzNBFab1GGSm42cwqyBeENfBwqyR2eqynLk5PN
	 boU+TTKjV43Z6CyfEDK1aRnbzFjoajNRytJ/AyLMxB4nY6OLKqJQH0ydGLwpWyphxZ
	 bThT57H/cCmA/A4IaQ2RNBaAoEYo+6PCJwcRGqCeDF7i6g/6jjJ2SRGqQUSpaORWaV
	 kTV74V/G7qHng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3D9A5380A950;
	Thu,  5 Dec 2024 13:50:34 +0000 (UTC)
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
 <173340663259.1609998.5092853825974975312.git-patchwork-summary@kernel.org>
Date: Thu, 05 Dec 2024 13:50:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: omap2-mcspi: Fix the IS_ERR() bug for devm_clk_get_optional_enabled()
  Submitter: None <psiddaiah@mvista.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=914797
  Lore link: https://lore.kernel.org/r/20241205070426.1861048-1-psiddaiah@mvista.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



