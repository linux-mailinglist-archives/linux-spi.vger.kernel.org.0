Return-Path: <linux-spi+bounces-11433-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 095F0C75881
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 18:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 183604E4BCF
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD1826E71E;
	Thu, 20 Nov 2025 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcujmnYw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EF72E6CC6
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763657880; cv=none; b=KZStCejX1zJqECKBLEa/Bxd0GcEfj357Bh8o6qNmIzyoaNHgKS+FttOlYLmqt4Lb4Knoh9Y2URh+tdQFj1N2UDjacrESmxxJDPm/dvaT6ea7vhj/f2x/LSlO4nhCZmKuKq/JozEBstnCl0IeghHiDCireG6WePZ1JJ8hMFGOAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763657880; c=relaxed/simple;
	bh=1jcFLtIdK8EJtbO2gqcMlSbCX8S6oc3XE5kyVnKR6S8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Tbqqh2JUwNVq0G6hgut+7Fpc2VC/HU6sk1aZCVFJ9I2C7/Si5gA8jjLyRokq19Ec6ixG16hr/ecjveOwGTbQBjGCFYJQhzCRdWE/jjAHuGkSLqthxfDOuz6LoHAf0aNfwdZB9KOJZ0MUdlAe85dUegoBWgsAU2UDq+8wALY3oDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcujmnYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB60AC4CEF1;
	Thu, 20 Nov 2025 16:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763657879;
	bh=1jcFLtIdK8EJtbO2gqcMlSbCX8S6oc3XE5kyVnKR6S8=;
	h=Subject:From:Date:To:From;
	b=KcujmnYwX9m7JN4668lTFcwOM81VKL1UuvS36tNNEVjExC3ROfu84RVarBqPAukXp
	 IqJvhpww0H4nlNXhQwqYt0/w79l4aKMhC7/fydZkgn8j8br2MeCZvU8NpBmcyiMGpd
	 OVZyiLTwGfAkOmmIb8VPw3bzFUSgbX+cP3cQCAk9+KbB6YA97ESOiAyU5zFrYLohXN
	 ojKPbslxzbfZe0P9qNGTviVycEujB1GHJdfXmD1eYpQy/4i0sTmL+sVx9yclfYA/NR
	 G/veJoEW87gElyNv828vPiuQ+vq0zuWuVU2P1ojbY7pIAqPhhxjQQGaeC2qnBi9zi8
	 IDBO9QM1FtCSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4159D3A40FD6;
	Thu, 20 Nov 2025 16:57:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176365784505.1708782.16933345900704292191.git-patchwork-housekeeping@kernel.org>
Date: Thu, 20 Nov 2025 16:57:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] arm64: qcom: add support for Arduino UnoQ SBC (2025-11-20T15:58:19)
  Superseding: [v2] arm64: qcom: add support for Arduino UnoQ SBC (2025-11-14T12:18:47):
    [v2,1/6] dt-bindings: vendor-prefixes: Add Arduino name
    [v2,2/6] dt-bindings: trivial-devices: add arduino spi mcu interface
    [v2,3/6] spi: spidev: add compatible for arduino spi mcu interface
    [v2,4/6] dt-bindings: arm: qcom: Add arduino imola, UnoQ codename
    [v2,5/6] arm64: dts: qcom: agatti: add uart2 node
    [v2,6/6] arm64: dts: qcom: qrb2210: add dts for Arduino unoq


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


