Return-Path: <linux-spi+bounces-1668-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B78D874780
	for <lists+linux-spi@lfdr.de>; Thu,  7 Mar 2024 05:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC37D284F74
	for <lists+linux-spi@lfdr.de>; Thu,  7 Mar 2024 04:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38D611184;
	Thu,  7 Mar 2024 04:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq552jI2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1FD1BDC4
	for <linux-spi@vger.kernel.org>; Thu,  7 Mar 2024 04:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709787396; cv=none; b=Nv4Hg1dQ4lmIImOz1nVMltycPnLVw37irUumTGTcbgd3Uw37/8NYwaQppOzZBcdTx7iVqOwgJno9m5FyWkgvcrwg4EH4/w+8j8oDgyVFkv8xJZQykjQAFIGNsXm8/mPUFrBkkmRzlZw9xrCfrd3xF1dV0x7TWzMoIo0tKlFExQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709787396; c=relaxed/simple;
	bh=z0EuhK5fm/weTdBe/pkNJb4ss9cLsiv5VnApa48Hej8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=eZQysDLpXCusZaad1sZIa04GtCA1ZMVRdXpyxYgWmWzfPJG0kWHQvA5+lBbKOH1lzniHwxaE/IJfnZdlFtsONxCdpmmFAmgiQp04+8eGSrUF9BJk/FPWF3CRLB0Fw9vw6yPjAkTCoCMH9rtuabz0c9VwE7jv+IaQDnmd3BCjBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq552jI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A8BEC433F1;
	Thu,  7 Mar 2024 04:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709787396;
	bh=z0EuhK5fm/weTdBe/pkNJb4ss9cLsiv5VnApa48Hej8=;
	h=Subject:From:Date:To:From;
	b=Lq552jI2+ANqg9be8LkB5UzXVsQ83qBsTpvRF3WgbtDRi6N8fsCkIOrD9hSX+/9vn
	 IaBkMcxDXsQnqAvYqJoEzQOqprVWExU3w8HDj7DidyX61TME84wZ7FhS6GPX3A8oLZ
	 jM7qMabcpSJZW5xO5UZWavhnuwiqZM/DtKbnDsw2KvkpUja60R/i5ps2qPYxYfO9AS
	 DZ5hn6TIM2D1llp34q/gjWETItO6ow0+tLPap8d+j1GMAaAl8rhc1PFZPR09j6iUnA
	 7VwmiUrHaV+o9ZBUt7spgSBNhm+qaGV5/BEZ7FEmeEv5AwJbdB7IQDZC2dTJJk5Vq6
	 aXLrKJj/qJTGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80D36D9A4B5;
	Thu,  7 Mar 2024 04:56:36 +0000 (UTC)
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
 <170978739652.15335.809992494295887354.git-patchwork-housekeeping@kernel.org>
Date: Thu, 07 Mar 2024 04:56:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add QPIC SPI NAND driver (2024-03-07T04:17:21)
  Superseding: [v1] Add QPIC SPI NAND driver (2024-02-15T13:48:56):
    [1/5] spi: dt-bindings: add binding doc for spi-qpic-snand
    [2/5] drivers: mtd: nand: Add qpic_common API file
    [3/5] spi: spi-qpic: Add qpic spi nand driver support
    [4/5] arm64: dts: qcom: ipq9574: Add SPI nand support
    [5/5] arm64: dts: qcom: ipq9574: Disable eMMC node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


