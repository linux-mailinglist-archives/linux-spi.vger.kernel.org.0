Return-Path: <linux-spi+bounces-11119-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4D7C40B8E
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 17:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55BED34FF77
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AB726281;
	Fri,  7 Nov 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOM9jsVl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9122314A8E
	for <linux-spi@vger.kernel.org>; Fri,  7 Nov 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531232; cv=none; b=k8xT7BqirEqYCPaXxBhlU8iuJ9HqIFpmrAC0zR8SMXIbV0P5j5XMwtxhasxcCe3dDlQykUMoGeDMRUdGAhAG1exo4WOqgwyuP6riED3wuu7GU96Lv/cr9bzNmfmOBbHDRjySwhSQp6xrSMf7wCY4Tx8LxrIlfu2jho7VNnTZ3DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531232; c=relaxed/simple;
	bh=9RADuAAYdSAjPRgKvuelKZQ5aDA/ikUFJoC1aAV9LJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WKQKp2oOgVfp2vhnOMR1fXOyxvK9D0wZFvKyZp8/PEMK9i58U5onqrTzOntdqLXo+AxYauxjEPcUArX9gIBoiuFJHzMjU9XmTv7Q7yfoItKRGf3e1eOdkjTLDZ0yY80VD2rv/FddWoaG+1i/x3Q3//oprvGVgyOtxYlDJQNcRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOM9jsVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EC9C16AAE;
	Fri,  7 Nov 2025 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762531232;
	bh=9RADuAAYdSAjPRgKvuelKZQ5aDA/ikUFJoC1aAV9LJE=;
	h=Subject:From:Date:To:From;
	b=KOM9jsVlRdyujVSpJw499M8D/4r1JnATyN6EMPQ025Xlo0KKbw8l4xr77q7u/ekAT
	 iYPmT/pArN08B41L4ER+BXhV7o+ZbI+ozsvCLLMizeQnEDVT9z7VImp7XGvNxpJ81B
	 /nP7hru9yeXKxHeXiWQSdh73lz6YIhLhKpNZLMPRXzQ6own3nHkhfhz7xD+StIW/0Z
	 3KmM2mIPx98Sw82Yhe0AwjtmBrtz2I5XkzPw9YJGLiu7LWRKblSgISh4d8sD2uzbKB
	 k8yCG+YIYyIy/N9BN2gxqP/Rhw/ku5T+K6g/5SILADAPu2tpnlQ2WFpkV6gr3bWZja
	 j5+Ud7Q3jDruQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 75D8F39EFFCF;
	Fri,  7 Nov 2025 16:00:05 +0000 (UTC)
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
 <176253120403.1074496.6078741702236929479.git-patchwork-summary@kernel.org>
Date: Fri, 07 Nov 2025 16:00:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: xilinx: increase number of retries before declaring stall
  Submitter: Álvaro "G. M. <alvaro.gamez@hazent.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1020450
  Lore link: https://lore.kernel.org/r/20251106134545.31942-1-alvaro.gamez@hazent.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



