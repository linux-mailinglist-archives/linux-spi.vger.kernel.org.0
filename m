Return-Path: <linux-spi+bounces-3960-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C7F93B0C6
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 13:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BD2281D19
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 11:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9455C156C5E;
	Wed, 24 Jul 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOuYlm62"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712B45695
	for <linux-spi@vger.kernel.org>; Wed, 24 Jul 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721822189; cv=none; b=tKpI5/EiAEH0iXSG1uLot73u11LYzmuOd3N4AKrORHsTHefvl+XyByA9ZNUrdUCj/RNrsMlQv8KLpTk2LnhSPQOTkpJeHi+hmioorXQsmaoaMRaB+Q16ui+njUbhREd8nmGcaeM5Dclb03j0JqgymkaCNjQpDbshIy8+3cvJDCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721822189; c=relaxed/simple;
	bh=UY17nCOSUypMIdy7+0QeSHGFSiCktoIh+dh61v7yHSw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=dXjYGLdmE4OJAOyjZxEjbiBBT6sL5yqHLZIbFhnXWboA2lIPGBSdgd5wkkUuYIhjlP4p+lSVY0hwk37+v99LyaoRvlIxrQqEnlK+ojGe4GiniQrOGWn2VI0RenPilimnWx200xQzzMmMSMY4of7sipEv2M/laVN5XwVXDJrQdxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOuYlm62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E08D4C4AF0E;
	Wed, 24 Jul 2024 11:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721822188;
	bh=UY17nCOSUypMIdy7+0QeSHGFSiCktoIh+dh61v7yHSw=;
	h=Subject:From:Date:To:From;
	b=NOuYlm62AV0K1Le4z/Lm83NMoa+s1s3Sk/l2NS6f7Eb7/BD9Mrreo6jFdrDygeK9Q
	 8f1z98KHr80DBmF2zKZCOKi+jrt8BrGQOvIP2YnJu6ZN0YtNiM+Jc5Gxt2iivCLbzY
	 NkUYICjZfZCaFnnQAJZVscJs1ODavyRVttTerE0H8TJ34y7SzHrj/Jw4r8+ClayGGD
	 RSdZauzKPnxR/1QAjqlA1BCJIa1iytAt1tO41w15L2HDKQnUc9L0YsNKho53RAl5/z
	 hE7o1eC8SnMRxY/h9LfxkXz7T2P5Ez8JjtsSRsU9ORn6cbMn2gRgIl6vPDiPDDb4DV
	 JOP9FZU9vVg1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8701C43445;
	Wed, 24 Jul 2024 11:56:28 +0000 (UTC)
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
 <172182218881.22713.4996475854841512629.git-patchwork-housekeeping@kernel.org>
Date: Wed, 24 Jul 2024 11:56:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] Add QPIC SPI NAND driver (2024-07-24T11:42:24)
  Superseding: [v6] Add QPIC SPI NAND driver (2024-05-21T10:55:24):
    [v6,1/8] spi: dt-bindings: Introduce qcom,spi-qpic-snand
    [v6,2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
    [v6,3/8] mtd: rawnand: qcom: Add qcom prefix to common api
    [v6,4/8] drivers: mtd: nand: Add qpic_common API file
    [v6,5/8] drivers: mtd: nand: use FIELD_PREP and GENMASK
    [v6,6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
    [v6,7/8] arm64: dts: qcom: ipq9574: Add SPI nand support
    [v6,8/8] arm64: dts: qcom: ipq9574: Disable eMMC node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


