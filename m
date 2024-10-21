Return-Path: <linux-spi+bounces-5282-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8B99A6946
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 14:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD70281DB7
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 12:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2998A1F585A;
	Mon, 21 Oct 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0fc1JmK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FB71F5859
	for <linux-spi@vger.kernel.org>; Mon, 21 Oct 2024 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515401; cv=none; b=nZHSi5INc622+nm4+WIoeDpCM2IfsRLfh7sLI+n7xBjVRHTw6J6WDpB8za/7idurqnGcmqXKBSV1nc8SMNqPftGTnpTvKYsZM+Ovxe/hiGTc4N5TwnzrejNUcAJnqIr06/ns1cTrFzcGmA11pFTNGrWpe20bjdcMeneTpZZhT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515401; c=relaxed/simple;
	bh=Ks+eTeNsfeXKdaOnisijsh3Kbi/jHKChKoSHUT+CKrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GcFXP3dCM1mF73LFHHKs7zfYsTf8jHPinRRwneIn0YsiZp2dK2/U5D632Jt0tvxpiRzUov1jcp8CAYDpenG2LbJEONgxpScnSPIvmgpBMWfjeYFK6F53EosYK9gSIWgqreUQnMIvB47qggWZrXhxMc98wZsRwAqciiZ8/wraT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0fc1JmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88343C4CEC3;
	Mon, 21 Oct 2024 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729515400;
	bh=Ks+eTeNsfeXKdaOnisijsh3Kbi/jHKChKoSHUT+CKrQ=;
	h=Subject:From:Date:To:From;
	b=d0fc1JmKdPkP2/YW34R4aruQ3hYq3lqoaNbuuJzkS21c7O0qi4FlGWDWa8z5pI+D6
	 z3F/FpFyd4JQuTU6L8BAuTzCrkOu0sGGeSM2LHfgRg2BAYoBDTxckDYGkQwqJ0U2x7
	 YUDtK+BjEFoZyElLszeOcLoqZobqkbUwF3aHy1H0wKIaLEwDs8W7GSl2KZMeFomMHY
	 ExGxoF3PrN9S2e4KpgU33rRCrcvvUTtfJIAvgMxfP64f5PbIfqR+YelVQnmxvXMmeB
	 PS9ZANkRfc+11Xt1+7lojn5CZ80WZx32nDT2I35kTTqzaOqlCalEb0jecsRSrzXkuG
	 jCZUpvUWD0Blw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0D83809A8A;
	Mon, 21 Oct 2024 12:56:47 +0000 (UTC)
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
 <172951540624.249306.16971486400125693421.git-patchwork-housekeeping@kernel.org>
Date: Mon, 21 Oct 2024 12:56:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v12] Add QPIC SPI NAND driver (2024-10-21T11:56:12)
  Superseding: [v11] Add QPIC SPI NAND driver (2024-10-10T07:05:02):
    [v11,1/8] spi: dt-bindings: Introduce qcom,spi-qpic-snand
    [v11,2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
    [v11,3/8] mtd: rawnand: qcom: Add qcom prefix to common api
    [v11,4/8] mtd: nand: Add qpic_common API file
    [v11,5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
    [v11,6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
    [v11,7/8] arm64: dts: qcom: ipq9574: Add SPI nand support
    [v11,8/8] arm64: dts: qcom: ipq9574: Disable eMMC node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


