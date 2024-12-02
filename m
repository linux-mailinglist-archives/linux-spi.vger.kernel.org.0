Return-Path: <linux-spi+bounces-5882-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C279E0AB1
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 19:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E2CB267E8
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A802AE99;
	Mon,  2 Dec 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTYp86Vl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD21125B9
	for <linux-spi@vger.kernel.org>; Mon,  2 Dec 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158817; cv=none; b=EXTtbJhJ+UqCaFpxbs+uXTJsClswYYrpDUlbevD/i0sb/ceR6QUBtAEc6lYBYMFW4mdE4F21/P03x9DW0ygPyFxX/euJP0vPASzc9NjHXLeYCIdsi9Bja8cBscVfmJjLEIKXkg7T1Flmiq/eIvNZIQkwUuDXsDr1nVf+cRShh3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158817; c=relaxed/simple;
	bh=rEIB/HhZeCodGMQ9JVyX1qKHaZ5K7vYZovPGlmUGqrw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=r6sn3fa/J3QcGK7QlV1QQEqFFNy9u8XlSjq7E0e48oAowHTIuZSnybTVlnozHSQNhiPGl0vNs3geQDsv+mHyLlJ7aYl62QNjpNCwKrn8/m/nX9UE2o+09nQECdkYSQQ1wWKfvxdcVkSL7eU+gq9uKbZXmLgMBfEwFeivA26gEc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTYp86Vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E52BC4CED1;
	Mon,  2 Dec 2024 17:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158817;
	bh=rEIB/HhZeCodGMQ9JVyX1qKHaZ5K7vYZovPGlmUGqrw=;
	h=Subject:From:Date:To:From;
	b=CTYp86VlgVqLgFX364AoNUVN75mCN35BmEa+WS+HMOi3e25AP/bSYraTtzzE+xQBC
	 xIzNsfm7Fl2eiZRNhtD9e2thdrb1jVCtTNXvNpcchaMN/FCUnlkwNtgnu2WBTKgKwF
	 OFwXbProRkKMAAMQgnErH+u4AICapNR8Iv7g9QgTbPyu8/vJx67XySRqWmIcj8wYGh
	 VT/EjyLs6XJHoStNYDZC8I+NWjtRCx79DLPFU64uQ+poOQTIgcDOefTgec0JOWL+vA
	 dYMAhHmkm3CCVp0DOInMao2rZCMENYgJw3T+g/euEjqpz7fPGyxWrB1N2KLmSpL4mq
	 TMlMfHQGbXj8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7630B3806656;
	Mon,  2 Dec 2024 17:00:32 +0000 (UTC)
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
 <173315883083.3756663.14222978814864204235.git-patchwork-summary@kernel.org>
Date: Mon, 02 Dec 2024 17:00:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/3] dt-bindings: misc: lwn,bk4-spi: Add binding
  Submitter: Fabio Estevam <festevam@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=902213
  Lore link: https://lore.kernel.org/r/20241023120015.1049008-1-festevam@gmail.com
    Patches: [1/3] dt-bindings: misc: lwn,bk4-spi: Add binding
             [2/3] spi: spidev: Add an entry for lwn,bk4-spi

Patch: [v1,1/1] spi: sc18is602: Switch to generic firmware properties and drop of_match_ptr()
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=909752
  Lore link: https://lore.kernel.org/r/20241114205051.3747458-1-andriy.shevchenko@linux.intel.com

Patch: spi: rockchip-sfc: Support ACPI
  Submitter: Jon Lin <jon.lin@rock-chips.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=911120
  Lore link: https://lore.kernel.org/r/20241120012208.1193034-1-jon.lin@rock-chips.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



