Return-Path: <linux-spi+bounces-4795-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3619761F1
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 08:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5654B1F23333
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 06:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BB5188937;
	Thu, 12 Sep 2024 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9qMfoyy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E15282FB
	for <linux-spi@vger.kernel.org>; Thu, 12 Sep 2024 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124215; cv=none; b=mpHJe5FHMi3mEbYNbhxagZ+wctMkiA73hq/ffv7GZElrP2s3q3na4PqFH+Q2aLlsEF+2x92AedYJE2jAMx0cGjZB6HUDPnHYxltB35MvVVEUP9buQI/mXRMG/5vlSKMnqQUf+QskCfeJhNHwhQfzYiJZutWDaqH0t2AMlCgX0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124215; c=relaxed/simple;
	bh=qTrQtNgYVThCZIDtv8Tzhq7pmBGPytr3162PS+EW0po=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YZRDRcyS8kPwkA4L7h6lDegZbwWPz+dfXwL6RHIgqqkJ3WEuY2z8e1Aq4YhjI5X5ygkiUOksppcIFax0RfoEiRgZ6Jz+MS9sfXJ9xeExq2pDWZY2RT0cKtnI/LJZcW374mLANCM0Chg0MH+pjF9LQCV+wLLRZTjXWiCqCrvYnzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9qMfoyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FB1C4CEC3;
	Thu, 12 Sep 2024 06:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726124215;
	bh=qTrQtNgYVThCZIDtv8Tzhq7pmBGPytr3162PS+EW0po=;
	h=Subject:From:Date:To:From;
	b=G9qMfoyygKq4sZLadYnbWZ1SVd8gXqxcSIusBNlUJADV5y8tYjHQEw9H4SMalPxdB
	 wbXhxuRJOTJbVKGnc5+Wu0OutMbe2gMuLHxseG0ByJCJ0adeVDDEqmDGdOyXgyL4g6
	 wWKpUujFkIS/wSqKztnGkgv8G/a/2h/5T9x2vlQs/U8yciAiK0CNkto5a5cr0GX8nt
	 73mjAQApxAX13RAXuLR0RGPv6r7ZtabcMKgQlB/fcVFGfDORg6u6OFOs/EQbPMY3fW
	 /Ys8EAJahaDROTsKlwNpvvqaXN7p1OlLnaEAWeXizPA8+20/u+lxHXuKKJ1nRgGjso
	 alxffp1YdmIPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB43806656;
	Thu, 12 Sep 2024 06:56:57 +0000 (UTC)
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
 <172612421596.1190367.13373687023362185787.git-patchwork-housekeeping@kernel.org>
Date: Thu, 12 Sep 2024 06:56:55 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v9] Add QPIC SPI NAND driver (2024-09-12T06:14:56)
  Superseding: [v8] Add QPIC SPI NAND driver (2024-08-20T10:42:31):
    [v8,1/8] spi: dt-bindings: Introduce qcom,spi-qpic-snand
    [v8,2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
    [v8,3/8] mtd: rawnand: qcom: Add qcom prefix to common api
    [v8,4/8] mtd: nand: Add qpic_common API file
    [v8,5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
    [v8,6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
    [v8,7/8] arm64: dts: qcom: ipq9574: Add SPI nand support
    [v8,8/8] arm64: dts: qcom: ipq9574: Disable eMMC node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


