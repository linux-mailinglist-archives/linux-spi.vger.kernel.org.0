Return-Path: <linux-spi+bounces-10463-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3914EBC4394
	for <lists+linux-spi@lfdr.de>; Wed, 08 Oct 2025 11:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86033AA992
	for <lists+linux-spi@lfdr.de>; Wed,  8 Oct 2025 09:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF1D223DFF;
	Wed,  8 Oct 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIbF5GBj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7DC199FAB
	for <linux-spi@vger.kernel.org>; Wed,  8 Oct 2025 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917413; cv=none; b=VgKgC+x4CDm3Ny4sepiUy0vyG+C8BkvU5Cvs1L4wDNtLZOlAwy0aMBflhR8d/VN9phc+saIZWUC/2b6mHDVu2GHAQ4F3by2dJndAz8GwuPc4pEooFWGyOsrHk3hQRRBKvC2pg/Jgp935O/1IYWRKKsCZK/2P5Vh43/3Sqs67zZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917413; c=relaxed/simple;
	bh=IHlqDrjeaXUgO3uUEypC1VQRFou5kObYqsNG8bebzm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Qnp8Z91pBtiqpRr2lLngVouvj4PGmz7rXw5ez08OrJuhpiNpEvbSSOuFCDctfjRD+1KUSphgj++ZVhqEiKs+6EQhlSs3LY4govpNHkyOyLgvpEqe7ZLrEc/CjwyDHX+hpX68Ujm5RMAiQ5Pyv57IgpzELw6Ot0V1M87Z+lBOtV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIbF5GBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1EFC4CEF4;
	Wed,  8 Oct 2025 09:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759917412;
	bh=IHlqDrjeaXUgO3uUEypC1VQRFou5kObYqsNG8bebzm8=;
	h=Subject:From:Date:To:From;
	b=qIbF5GBjeKw4eJcghC1iGPec8xCDVqsl3QS7nLcl3CYL1V+IPjFuxklnSu6CrA9Jj
	 JD3Ci6sR8IziTMCdyi4vN4AiNFC1psI2AVn1TEplvznAvtnKjHInDD8NIW9SLmpVme
	 qcLX+S3ftdQRHcCUWZzJA514EZ86hacit3RTPPiiMBJTgc5iOLSrQMhMhc4N9NJBFT
	 JJMCLmpyhaLpAwVG1I2WJK+5fNcKjAJoXlUa+gBIfOGA0Ug3uFnrclXPSEIZDT+z1h
	 PurJ3B6b2Z916Ut23kNODbcZAUNlWa/YNpkYWYZJNVcF13B1uyYIHcawM7oMrGUBal
	 X/RnSIdTHrQpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F223A40FE8;
	Wed,  8 Oct 2025 09:56:42 +0000 (UTC)
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
 <175991740101.2992967.11929999103520072128.git-patchwork-housekeeping@kernel.org>
Date: Wed, 08 Oct 2025 09:56:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add QPIC SPI NAND support for IPQ5424 and IPQ5332 platforms (2025-10-08T09:04:04)
  Superseding: [v1] Add QPIC SPI NAND support for IPQ5424 and IPQ5332 platforms (2025-09-18T09:40:12):
    [1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424 compatible
    [2/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5332 compatible
    [3/9] dma: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+
    [4/9] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND controller support
    [5/9] arm64: dts: qcom: ipq5332: Add QPIC SPI NAND controller support
    [6/9] arm64: dts: qcom: ipq5424: Enable QPIC SPI NAND support
    [7/9] arm64: dts: qcom: ipq5332: Enable QPIC SPI NAND support
    [8/9] arm64: dts: qcom: ipq5424: Remove eMMC support
    [9/9] arm64: dts: qcom: ipq5332: Remove eMMC support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


