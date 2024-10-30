Return-Path: <linux-spi+bounces-5559-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B759B6392
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 13:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB741F222A7
	for <lists+linux-spi@lfdr.de>; Wed, 30 Oct 2024 12:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951871EBA1A;
	Wed, 30 Oct 2024 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5yEq+8Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0511EBA18
	for <linux-spi@vger.kernel.org>; Wed, 30 Oct 2024 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293004; cv=none; b=Z/HKFKJrWH5SUs9bl1ChgcfmpTfohkRv34MaSO6X7Qw0WiPss471CIudwj6UjgMq2hjxbKC1A+TbLOnaKLbuLnNX7Tq4HTes8oodAmp2QaTGvDfyaHZgXiEbeKWNMa1sEBSrfaVl9c+mJqN6FuM6kStyB4fq5KjOmAiX3tL+O2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293004; c=relaxed/simple;
	bh=jWY+9Y5gDx2kFKJMFtwT1tA1p6VSAl1GuJUwXBmABqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Y0sZs0aBm5w6A/uXrXLnhhBQe+Axbr1QnYdlCDj5D/MEl8ibAEZnXyCAqQgjcJ96MJNSSRlFs8a8JxfeHR1ke4KAcwwYCRrtSz7Vtt7JX2kCgCi0+wDYAys9gL3fX7Clz1kLwE8E9EBwu2NnjKNq/6pM1753rrQxt498Y6d+7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5yEq+8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E568C4CEE3;
	Wed, 30 Oct 2024 12:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730293004;
	bh=jWY+9Y5gDx2kFKJMFtwT1tA1p6VSAl1GuJUwXBmABqQ=;
	h=Subject:From:Date:To:From;
	b=b5yEq+8QD9b+ccaXtTI4uVTWWFT7jPfiL4gQKQZoANQyfFjcMu46A7IbctHSNgn+0
	 n2+hrh9uyv4HDxKKyL5UmKJOaYW27UuQaG20O7fodbBoM0pABEtVhdrtjNA6BglPA+
	 VDi1rTicBvQ0Ihzn0WX5YxwqNA+9T/zU/vNOp/ZxQ8vMYD66VQflN6dWgkqhPdZyIV
	 b6YOQ7xjG17BiYp4QCF0mrXqHNxJkY6tartQEqVA/A8uJsHAVZfRINadob+ZQVpQMU
	 MgGrsPiT9AB4QoGvcPOJrpktBRbam5hcoN6dsVjBqPQt7xYT+iRWOMu5iLI2QOKBwZ
	 0QS+7XYPef5ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF8B380AC22;
	Wed, 30 Oct 2024 12:56:52 +0000 (UTC)
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
 <173029301159.1331122.8471019362061776048.git-patchwork-housekeeping@kernel.org>
Date: Wed, 30 Oct 2024 12:56:51 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v13] Add QPIC SPI NAND driver (2024-10-30T12:19:12)
  Superseding: [v12] Add QPIC SPI NAND driver (2024-10-21T11:56:12):
    [v12,1/8] spi: dt-bindings: Introduce qcom,spi-qpic-snand
    [v12,2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
    [v12,3/8] mtd: rawnand: qcom: Add qcom prefix to common api
    [v12,4/8] mtd: nand: Add qpic_common API file
    [v12,5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
    [v12,6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
    [v12,7/8] arm64: dts: qcom: ipq9574: Add SPI nand support
    [v12,8/8] arm64: dts: qcom: ipq9574: Remove eMMC node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


