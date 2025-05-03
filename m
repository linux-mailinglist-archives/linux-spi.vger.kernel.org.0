Return-Path: <linux-spi+bounces-7873-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B98AA808B
	for <lists+linux-spi@lfdr.de>; Sat,  3 May 2025 13:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2EA3A79B8
	for <lists+linux-spi@lfdr.de>; Sat,  3 May 2025 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBA31E570D;
	Sat,  3 May 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcgRG9qu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2718C03D
	for <linux-spi@vger.kernel.org>; Sat,  3 May 2025 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746273371; cv=none; b=LR2PbjLVyqWAyJCsgxn+1V3nynBNCfJRGx/PAFI7EOdbap1Xy6i4/GUaDcvfPTvpS7CufXHMD7a5oHgs3feXR0scJbD/yFY3rzwUFLUQ8srz6WPpRsFSAyFO3SzL7QjFQkt+KbAgKZBT5EAOoPz4YrdprU+jWENPnzvN2Pf5pW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746273371; c=relaxed/simple;
	bh=I7dogy+iGk0k/xpLcU+QtBiDG79LoORhRvskvJKGL2E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ORKHAZ8Ek3SkuqCMqze/n8iIJly3ftQgdk580Jw9RtWvSJN9I0bYQhy6Kk7zKIIAVZWQbIvhpTfET61VQo4Ogfjr3Bo1OZ1DQ/PfmJ6GeyvkAuSK9Vw2qxrIWWPc4PPHv5mgNHlMrSc7z9xqwrl0nwG2Ow6t1yT7b0XcZmYBp80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcgRG9qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88162C4CEE3;
	Sat,  3 May 2025 11:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746273369;
	bh=I7dogy+iGk0k/xpLcU+QtBiDG79LoORhRvskvJKGL2E=;
	h=Subject:From:Date:To:From;
	b=ZcgRG9quedbZbPih+yaQMGIy8kgUW32qnPK2OC8LbOVT3j8sMxCWtSVKMzuxeVmqa
	 q5Fy3FY8+wsH491KyFMx6e2tHM0FMEvS00Eopxnchl+bVRY0hNp8ICYU6fEb8ZSTe2
	 3Ayx8uwYjcRvZm2zAL2H3jcrCWr2MCNlYwT3vQelNEX0fDrpkZVmipMnAk5HAB+4w7
	 rgAYrKVka5uYnBAnAX9dmAv6ehJiRHOUT2fwEaSJMqMJmaK2EekMSG5o+6Fr30Zgl7
	 qYOlJLf3yQyRDWCQB+NsogaDIHrVsi2VTToNz+MsQvVsFbJ3l3941H1UqhiRg/jtD3
	 bqKJ4H7Z646dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE02380DBE9;
	Sat,  3 May 2025 11:56:49 +0000 (UTC)
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
 <174627340857.3856549.9238197767342204874.git-patchwork-housekeeping@kernel.org>
Date: Sat, 03 May 2025 11:56:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add support to load QUP SE firmware from (2025-05-03T11:10:25)
  Superseding: [v3] Add support to load QUP SE firmware from (2025-03-03T12:43:40):
    [v3,1/9] dt-bindings: qcom: geni-se: Add 'firmware-name' property for firmware loading
    [v3,2/9] dt-bindings: qcom: se-common: Add QUP Peripheral-specific properties for I2C, SPI, and SERIAL bus
    [v3,3/9] dt-bindings: i2c: qcom,i2c-geni: document qcom,gsi-dma-allowed
    [v3,4/9] spi: dt-bindings: document qcom,gsi-dma-allowed
    [v3,5/9] dt-bindings: serial: document qcom,gsi-dma-allowed
    [v3,6/9] soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem
    [v3,7/9] i2c: qcom-geni: Load i2c qup Firmware from linux side
    [v3,8/9] spi: geni-qcom: Load spi qup Firmware from linux side
    [v3,9/9] serial: qcom-geni: Load UART qup Firmware from linux side


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


