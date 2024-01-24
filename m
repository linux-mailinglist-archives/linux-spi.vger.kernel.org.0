Return-Path: <linux-spi+bounces-727-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6101E83B0F1
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jan 2024 19:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BB51C249A3
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jan 2024 18:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB41A12A174;
	Wed, 24 Jan 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrOn5YDf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C822312BF00
	for <linux-spi@vger.kernel.org>; Wed, 24 Jan 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120426; cv=none; b=TBy+HCEq7rulSJW0RENk921TX8l1GOhS3FQ0tnJLkU62+KDT+3PQaHeFFeDs3nFI/h8hUsPOMcG3Cz/GkR5AAtRlKEQRQ+bifcuOjlLwpXvkX7DHpZOFZ1jbQjX8ffWFGaMvFdiyU7vNIqan0YWmmoEK0ySvndESKJehOn3i2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120426; c=relaxed/simple;
	bh=dC/MuYTU31mxqVIIE4i9XwKACI/Z9GEJRL28I/5Zerk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=C9LvCROyXne5DXby1Jn4gqIDdQK1NLQWmgcrrg3VHVz8AudnAD1wOuubLIf3tJov1yHE7NvrQVh2QZGK0asoRBrzJosS1nW7yX8SWHu7XTh/gj7HF3PwTSQb6OWzDixRjwSaCC21OLu0hb/G5GH/5tIEZS+uUFNpSd3Zr4qtw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrOn5YDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 484ABC433F1;
	Wed, 24 Jan 2024 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706120426;
	bh=dC/MuYTU31mxqVIIE4i9XwKACI/Z9GEJRL28I/5Zerk=;
	h=Subject:From:Date:To:From;
	b=SrOn5YDfnQZtHtPn0Lx5Fsbx1Y6sxUVa7vvaA9cQUJIXYHlkKRjzga6aaKZ4BXMkZ
	 9Cnj+WIJ5+N5mH89ydOOtniSxNUWSwrXMN11hoX2JN0r5wmoxkw45ju/qlyqAFxtkm
	 OnMq0BiH+HGyRE5Hkm6qLUW6zY1oCcLZXk7/+OUrBths0t7cm7NbUmrl2Qa3mclpKD
	 zvAjsxAOLvDnm3pCqnz6j/b8ljzmxw6Qsp1Cy/p9QAdX0gCxPa3zFXEYIdd4lNCyKL
	 9xcL65VtEiaZBUZ3Yn1+bnaJdSrpEzL2RvT0ElbqSJLL/PA+FnuXLHSGJ4OfnT3sw2
	 riLUiE7D0S7rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 317A2DFF762;
	Wed, 24 Jan 2024 18:20:26 +0000 (UTC)
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
 <170612042615.22864.1012219313973425832.git-patchwork-summary@kernel.org>
Date: Wed, 24 Jan 2024 18:20:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: Raise limit on number of chip selects
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=819510
  Lore link: https://lore.kernel.org/r/20240124-spi-multi-cs-max-v2-1-df6fc5ab1abc@kernel.org

Patch: spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected
  Submitter: Devyn Liu <liudingyuan@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=818970
  Lore link: https://lore.kernel.org/r/20240123071149.917678-1-liudingyuan@huawei.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



