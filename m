Return-Path: <linux-spi+bounces-9032-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7932CAF7D7A
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jul 2025 18:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177C554608B
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jul 2025 16:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CCE19DF4A;
	Thu,  3 Jul 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEvBfpDg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344D1607AC
	for <linux-spi@vger.kernel.org>; Thu,  3 Jul 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558981; cv=none; b=Jrtg5pMlkj8hZcYeANrHXplOBa/c4cSRD25OVAEPz7d8gXt93flzrwX7OXJdK3QzdMK/XdMOXEAbYJJq2YDguWyxvA93mYQN9pnRSZZ/Ao3c4BLgv683wxzjbahzA20O5m6nZ11iYsF3URQ6T1pAXpfZqHSBywNCc9zZK5ggtNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558981; c=relaxed/simple;
	bh=bL8E3Di/2P9CqwA8F2kLnz3fuc9PNas84EPA7rDPFcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KRDXzzghu1RmUsNI8+4XpIqdJ8QEwW1ZcejdcUhls5X+VX2GHySlKew5rjH18R1i4AscFEMTeuWRjYxiG4KwCgz2Ny7/KHptN97cQMZM/v2w6+oNoUV+4KuO0SAgVmx9lL6mGFgsbUkFfc9tdDCaIuaua2YDJdRCo4ky7ZFOxwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEvBfpDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A885C4CEE3;
	Thu,  3 Jul 2025 16:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751558981;
	bh=bL8E3Di/2P9CqwA8F2kLnz3fuc9PNas84EPA7rDPFcQ=;
	h=Subject:From:Date:To:From;
	b=cEvBfpDgVjxO8uePUI/owNpkbdfvx0BqSOcgl/76rzpb6XUBOvjGDTu5Dsp+49LDX
	 UJ3vtzofX7Nmv2PJDtdFqK1xQ7dgZcmO5FDMqDbCyiNbJMslc4rMvF7fIy5pwatVAX
	 MGXCoLI4WwUKSkalkL7IWgrIntWiq4JwrBpIuFzwYKufykOqJkmc1WhygRI5ytVkb9
	 ZCseulP1Vk9t20Q7ys4dYO1UyU+btDeIK2UVCEVPb2GgeCXFymh21cCfDIEukurc+F
	 3dc7keyYl/nme2oLcz1UccR/Kq5CLOSo0iO7tSpGLzM/xyBK+8HnfeehgZgGzkjUTn
	 HHLxZZ4zTc+uQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 760F6383B274;
	Thu,  3 Jul 2025 16:10:06 +0000 (UTC)
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
 <175155900499.1541683.10723611140843281944.git-patchwork-summary@kernel.org>
Date: Thu, 03 Jul 2025 16:10:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: dt-bindings: Convert marvell,orion-spi to DT schema
  Submitter: Rob Herring (Arm) <robh@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=978395
  Lore link: https://lore.kernel.org/r/20250702222643.2761617-1-robh@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



