Return-Path: <linux-spi+bounces-12182-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9D2CF43B3
	for <lists+linux-spi@lfdr.de>; Mon, 05 Jan 2026 15:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C834330C4D3D
	for <lists+linux-spi@lfdr.de>; Mon,  5 Jan 2026 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B1C33B6D5;
	Mon,  5 Jan 2026 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czbmKYn+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC033ADA0;
	Mon,  5 Jan 2026 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622117; cv=none; b=KTe+NQceX1eH4m6i4MLDz1dIw0MV143upA480NloYULWW5DUzCTGZeKfejd834A3FnnG8BEGSVAiBFyhs3AqdUibm5kGeI2fcNdy89YbmGg9CTqweU08YGizKfS7jDnMCiWEzfW2TlIm4Y/MSPKDiITR4SFmrdpob6+ZJxlejyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622117; c=relaxed/simple;
	bh=fA8iZVmp6FG+0x4WWdqEhtCEmf0AzlPRgIyhqeuEwKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHRUzfE+/ertoYT3OkPb8qoLu2XfvqsxHTcMo7MxTR33EM1t9ZqLC6Zc+DFRI6oYPl6B/p5Dx2W+5xT401C/SOtWQfIC4L/ckRX5FlQNz8pox9+kjiTenmqcNqIA4reLZwsDpKmgezdyphO4qR55jM+5NMewKcrEZz0f6hikOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czbmKYn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4386C2BCFA;
	Mon,  5 Jan 2026 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767622115;
	bh=fA8iZVmp6FG+0x4WWdqEhtCEmf0AzlPRgIyhqeuEwKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=czbmKYn++78QRFPJk92OFEUbyvjNIE1NGpWIyKBBn17o4Dpqmtp6OxObFkd4Rlhuh
	 XNCYi6yszjZGPaj5+hMCLxcLGElhgp96MEjQAJ2rdDm++S9yVXanGUbPWPHqDa1Dmw
	 EQLXv6Cp1OGpCiVFFEoWbMgFBZFdEJF0mWeSr7Cb6hbNfV1MrclH1a4QxTF0WHlRJ6
	 Sema3m+RhZxWJXN6kTLFI6RRXEGtICscLLnCrBLfHiK4jnRW6m2OlIb/0siYvcIIf0
	 ciFVgQg/jCkJP8SgCHdtQjRImoPVqWlOLsgsXl2NbH9cYGwLRet/3+pgRgi6qc1hfW
	 VwuNyibVHHVIw==
From: Bjorn Andersson <andersson@kernel.org>
To: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org,
	Riccardo Mereu <r.mereu.kernel@arduino.cc>
Cc: linux@roeck-us.net,
	Jonathan.Cameron@huawei.com,
	wenswang@yeah.net,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	nuno.sa@analog.com,
	chou.cosmo@gmail.com,
	grantpeltier93@gmail.com,
	eajames@linux.ibm.com,
	farouk.bouabid@cherry.de,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	m.facchin@arduino.cc,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: (subset) [PATCH v3 0/6] arm64: qcom: add support for Arduino UnoQ SBC
Date: Mon,  5 Jan 2026 08:07:37 -0600
Message-ID: <176762206403.2923194.16796715404880463820.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
References: <20251120155825.121483-1-r.mereu.kernel@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 20 Nov 2025 16:58:19 +0100, Riccardo Mereu wrote:
> From: Riccardo Mereu <r.mereu@arduino.cc>
> 
> This patch series adds support for Arduino UnoQ single board computer.
> UnoQ combines Qualcomm QRB2210 microprocessor and STMicroelectronics
> STM32U585 microcontroller.
> 
> In some files we decided to keep UnoQ code name as "imola".
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: vendor-prefixes: Add Arduino name
      commit: d16ffac771715a8c94611b6f8088a3e800bcf5bf
[4/6] dt-bindings: arm: qcom: Add arduino imola, UnoQ codename
      commit: 311d173da672397a58498841299ec613ff9eb96b
[5/6] arm64: dts: qcom: agatti: add uart2 node
      commit: 925ac1f6ec75a773e0ec8b91673b647f6d456ccb
[6/6] arm64: dts: qcom: qrb2210: add dts for Arduino unoq
      commit: 3f745bc0f11f66465e3fa19eb0c808c5b39cb0e5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

