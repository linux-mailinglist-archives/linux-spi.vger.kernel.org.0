Return-Path: <linux-spi+bounces-7023-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2671A4DE23
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 13:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DE41700A2
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CCE1EF0B7;
	Tue,  4 Mar 2025 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8NJIsuc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1171EA7CE
	for <linux-spi@vger.kernel.org>; Tue,  4 Mar 2025 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092045; cv=none; b=D88gL6dM2rGFC/kN7Vjvq8fCOMc76HkFLcJ9af/nW0XHSGyPULPoXMiLo1HCyLpeImeUrgeQy2AODBoyFVTpVss2ep3IK7pSNr47UrTjh6XRqf7ssPhxpc2uJwrEoIggkSZdDOdQWCLLfffPvPZEhoIpEeiaXmQHD6fJMQnEFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092045; c=relaxed/simple;
	bh=7rRN42qGIvXUhT9mR68DgEU0s+uHwqxvcVkdtPxk2QY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ddm9DfYvpOqwOHGjdMwAKHpaSMeErOkmypRBOJq8HbDB7EorQzz5l0Px1y3VqD9htKGCvcS397NJeGbLc5sY38JFXLfhGsh9QzTQ6FsZc57E7E6GRQYFcWN+Ob4yAV8WpIJXnJzpeeb5Z5aqfaTPc8Woj2ehPBSp4+M8Dq2TjfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8NJIsuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF63C4CEE5;
	Tue,  4 Mar 2025 12:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741092041;
	bh=7rRN42qGIvXUhT9mR68DgEU0s+uHwqxvcVkdtPxk2QY=;
	h=Subject:From:Date:To:From;
	b=K8NJIsuc15ViUmnGwAEFyVKHThOgKpl+3u3OcqtPoE0BGxvjTPG5jN0oATby02vof
	 A5JQAJAYg0UX/vzdUmrLUMLli2N9WF6EJcnHu5elXokp1VuMlP5sbTw3t1OMFutUO0
	 HM2I+9yCjsz0nSlyWwaAJ63uaOWpQEJoXClZk138t1VYu3djWnzK6x4ixd0AafeRA3
	 l/x5gZsbDaRjAV6BQvsOp4teoZcAkY7so2ppZUlTSzTOLl9kTaTrw9F76yVT2dTe7C
	 hN07wADTg6+zeRU/riW2dwFjzjecW1g/tRYCjRiWzPwbme2H7cVL99GDkBt9wZzH72
	 HwZ1Cs2rgRp9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3C10380AA7F;
	Tue,  4 Mar 2025 12:41:15 +0000 (UTC)
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
 <174109207421.128336.17329572561587282384.git-patchwork-summary@kernel.org>
Date: Tue, 04 Mar 2025 12:41:14 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add QPIC SPI NAND driver
  Submitter: Md Sadre Alam <quic_mdalam@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=937013
  Lore link: https://lore.kernel.org/r/20250224111414.2809669-1-quic_mdalam@quicinc.com
    Patches: [v15,1/2] spi: dt-bindings: Introduce qcom,spi-qpic-snand
             [v15,2/2] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface

Patch: [v2] spi: microchip-core: prevent RX overflows when transmit size > FIFO size
  Submitter: Conor Dooley <conor.dooley@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=939540
  Lore link: https://lore.kernel.org/r/20250303-veal-snooper-712c1dfad336@wendy


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



