Return-Path: <linux-spi+bounces-2781-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1B68BF91F
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 10:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7F81F21454
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 08:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19923EA9C;
	Wed,  8 May 2024 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bfgogggr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE34C9476
	for <linux-spi@vger.kernel.org>; Wed,  8 May 2024 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715158591; cv=none; b=GHQjgFDDECOdK9LtiO/MU91itwKBdG5uX632R/jPJu8sJXKB0pWMmY5G39kCNJA6hTOdU7zJUsKJwAvxXPXFRUQV9EimH578bSbp16sPZbYkuDoerohlLcxAIrh9lKwPhNJjMyYWwHibUytNLSMplFy3riBdtQ+l7kKzB+cc44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715158591; c=relaxed/simple;
	bh=FWACZMl05c4YxZhSVLDN+mp5JaddHszkyiIsiKwJc/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=O7wRjH4aUdQ5NnraYPM4dagRU6JUdrMVCjSJOMNpeuY8M4t0Lacu9mu0BlBC3bKIhGfZrUDKc29hsI/IAuOTACoiBV1eIzkdT0+/lCjNBI/yICyuHTvNzRGFeJLhN+XQcrLQ+qB1wyf18FQ0hC4BGdM81YwP/qClqk+901dEQho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bfgogggr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5088EC113CC;
	Wed,  8 May 2024 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715158591;
	bh=FWACZMl05c4YxZhSVLDN+mp5JaddHszkyiIsiKwJc/c=;
	h=Subject:From:Date:To:From;
	b=BfgogggroIVPx/uCLav0wgzAweu4UvU319vSKSZpaeYm8EdrCewaObe186B0iYACO
	 T0xTlpgyIFa2K5rce/3l4duG7SQvVbgnGZTQ6YoIGeuPvJMglkiEpW6ng9ghBTyt/E
	 VvCEU4aJxuSeGh2ajL+Wp2aydEdcpBU7L1K17SgmCeA8i/Ce537pR2lwH8DyvnMom2
	 T3mcPy5z/73JwzAXc1jEEKI8PFMCVOJNBKfzCfwSBNvNQGOgv0Lc04MmBFZq8rDZPr
	 lm4lwZduJcedMQt0hqsI3Ogc+kf3OZQZbH11eXxhegreijlaNxTe3b0I87GwN8gk/W
	 ELyJhJIhGoNEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4250FC3275C;
	Wed,  8 May 2024 08:56:31 +0000 (UTC)
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
 <171515859125.1473.17971572443532764587.git-patchwork-housekeeping@kernel.org>
Date: Wed, 08 May 2024 08:56:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Add QPIC SPI NAND driver (2024-05-08T08:36:36)
  Superseding: [v4] Add QPIC SPI NAND driver (2024-03-08T09:17:47):
    [v4,1/5] spi: dt-bindings: Introduce qcom,spi-qpic-snand
    [v4,2/5] drivers: mtd: nand: Add qpic_common API file
    [v4,3/5] spi: spi-qpic: Add qpic spi nand driver support
    [v4,4/5] arm64: dts: qcom: ipq9574: Add SPI nand support
    [v4,5/5] arm64: dts: qcom: ipq9574: Disable eMMC node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


