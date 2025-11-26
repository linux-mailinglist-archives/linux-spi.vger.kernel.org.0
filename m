Return-Path: <linux-spi+bounces-11611-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FBEC8BA6A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 20:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3FCF35A2DE
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 19:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA5D341066;
	Wed, 26 Nov 2025 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Enc8Lb+x"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9881341045
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186042; cv=none; b=FnZFDS451KAwbM/4gFCtCth4bJfLSdr6mETyDLwBJ1fI3D8lCQbd8IzSnrTt9hpDGB5twrhdcBugl0z2ORFwJzzhY9WLcM/NynTUVleTidwkdvgHgXjEG9w0wfO+DiEiZLEL/bM1UeyGOb20SLHAIlDj9/qGdD1IznxUXdcZU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186042; c=relaxed/simple;
	bh=29qczsCs6bO0MCKhevGXyZ3muR1++sguzr86NpaBGBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=u3Vb+pSt2N4IpgA/CqEXvJZxqPWp8vyT11KQiejo64GX0uCiAxuK8SAz8+99DnGPie43LKW3y/Kmygo+oA9/+jnDDWh5PFWIN+dvhHdyCjM4F4oYI1EmasNL4RTYPDkXF8vTWoCKuLI9aOHsWRnKulfXWYYGf+PnNWcHzO4jDp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Enc8Lb+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BDDC4CEF7;
	Wed, 26 Nov 2025 19:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764186042;
	bh=29qczsCs6bO0MCKhevGXyZ3muR1++sguzr86NpaBGBI=;
	h=Subject:From:Date:To:From;
	b=Enc8Lb+xYfY7o0cuiPYnu88B/LdcvdPi/pu5K05xjnOuQqItV+HQw85A+CJlDSDiI
	 jYlfFnas+5nMqkqf3dts6PuegBY8MLwdgzIjVncnaD8LCDztJlsTf/UD/IRNfpQkps
	 ZU3+KrXbe0kTTQgMwgksMHbApIp1O7ysP/xQQ/4QuBIoyCltxwZpDuEwLzDBjqy+kJ
	 NmUnfT3MQ7kXKddKhXnwG8sQ5hn9P7NtMwYD9cDVxzF6I2k3ek1TTpvLBuE0Hy71Rs
	 7PQghzcAGkdbiGXWipqmdvgNPj1o1seswIwGCFz7icA1ztocjBPoowW8sjVUsdMght
	 HXhqJWjDNfWOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74935380CEF4;
	Wed, 26 Nov 2025 19:40:05 +0000 (UTC)
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
 <176418600401.1815966.8177982863177560390.git-patchwork-summary@kernel.org>
Date: Wed, 26 Nov 2025 19:40:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/V2N SoC support
  Submitter: Lad, Prabhakar <prabhakar.csengg@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1027846
  Lore link: https://lore.kernel.org/r/20251126131619.136605-1-prabhakar.mahadev-lad.rj@bp.renesas.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



