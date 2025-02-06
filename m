Return-Path: <linux-spi+bounces-6645-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE203A2ABD9
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 15:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A267A4CB5
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 14:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FC02B9B9;
	Thu,  6 Feb 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk7izpiB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D15723644D
	for <linux-spi@vger.kernel.org>; Thu,  6 Feb 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738853403; cv=none; b=Dmid5smf3LTeo+O14gA/yazv6goX/6j0fraS1C8t9yB1uU4Ddm1tmdW2wq2POh8cuo0uas2+8bEKn/TO7OXtM/mtMNqrIE4/eH7Aasss0sNEaYFCRkKI4R2YsHT6FTTOrHJInB/lnlXI9mMxwoAA8ph1F9o58Cfbfr/cI9G6Z1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738853403; c=relaxed/simple;
	bh=BlWkDZcKwFwQVIKv5nbvyWilkjF+6DSMype4+4yF/8k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Os7nOP0a3qQNF4PmnVJkUJqdUTfYYFp6IXeqX9r4xn8VngRTtrutxZ3fP1KJD+WdrBNWLZU9tDZ5nKRg5dnG44/94m99Lhq7HwP4LMn7zX4iX5CfqJB+2X9JmkqkH7ENOB7vOI2VAHF0b3LNN1hN2VXzkQGUoo2+ST+RBdjzoUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gk7izpiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2164C4CEDD;
	Thu,  6 Feb 2025 14:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738853402;
	bh=BlWkDZcKwFwQVIKv5nbvyWilkjF+6DSMype4+4yF/8k=;
	h=Subject:From:Date:To:From;
	b=Gk7izpiBDLMHHtuR3kD0lZrkVQktW2SVntnS5USen7m8OCHOMfjeSfn0tSAaFa5Gs
	 W1+G+at18UtCoOUpjqCEbO13Tq7BCsmQndB6dToCGYPg9Re3jEXckdjTS3rsqRsVL4
	 P9QuHjggKInJf803wAq5IZA+7c5mb+yd/kXwg3yTzDIczO4QmXwd1FovFOBeCOEnJx
	 pJ79aGEB9v4nABqQbr/07sINU+jDsnWxpg0M0J6euHpS8zVk00Lo+pwPlbiXFGLwc/
	 qUKw4M6XnF3l7W8eDMUuGrzoM/5bKr4OvcjfaHFr64kBXZoWowOQnuhIwybbZJoCol
	 18AgfNqjq3dXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77A75380AADE;
	Thu,  6 Feb 2025 14:50:31 +0000 (UTC)
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
 <173885343002.1506195.14203074327377952348.git-patchwork-summary@kernel.org>
Date: Thu, 06 Feb 2025 14:50:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [RESEND,v1] spi: sn-f-ospi: Fix division by zero
  Submitter: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=931121
  Lore link: https://lore.kernel.org/r/20250206085747.3834148-1-hayashi.kunihiko@socionext.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



