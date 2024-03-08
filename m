Return-Path: <linux-spi+bounces-1722-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB9D876164
	for <lists+linux-spi@lfdr.de>; Fri,  8 Mar 2024 10:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6B4B20BCE
	for <lists+linux-spi@lfdr.de>; Fri,  8 Mar 2024 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24378535BD;
	Fri,  8 Mar 2024 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIF+jrnp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2284535BA
	for <linux-spi@vger.kernel.org>; Fri,  8 Mar 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891807; cv=none; b=cGOY8Ah+l/W6YiHJ0Wk4C5mV/D2bbB/ZzzO2FXxhBJiRvEcyFGm/Xw+M8xvc6tfvU5rGc0cLq+nTXmWyjh1WYMaAbvNqlgvWDEIuXTzljQwrnICQ0+sMeOk2FciLT0IPu2tJXHBgqWmEz73qos4gEEgJyF5goIEStxwBwiKtVWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891807; c=relaxed/simple;
	bh=5O50V+ScumGgcfy+feoxuNNVoEmz/WIH0QMPZeFdXpw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qW6wsBGc6/1i/VlIrPhA1oRFlsXapc98+BfuWx3bo0GxGTLt58S2e9dlGF8c16hDPbbg9Kuep7KdZGHKjuHhtiwX3hjOSf6QX9ctaiYgxXmaw2ei8FQwHZsn+NnOfQpvHB8nuFpXLtNL7Uc4cGCMUa26Qal3GNnveJOL0IFu9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIF+jrnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 891A8C433F1;
	Fri,  8 Mar 2024 09:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709891806;
	bh=5O50V+ScumGgcfy+feoxuNNVoEmz/WIH0QMPZeFdXpw=;
	h=Subject:From:Date:To:From;
	b=kIF+jrnpJ3dGFV3Ek9J91VlFyrQTBa9IJHr8o65ZDrYhgjyHYzmpT91WRPvg4/i3N
	 FIop0NvKGiQBbAHeOGrreve4KE0qZB8GM+itUCI6myaMDRWvwmmCzkkrBNB8NPnN50
	 Y/hFS+3dmwgFFe/7PotiX8uUD+N8oNwggB5PY2qrg+dAGt+SFnGNenLI80jr3dmjtl
	 XEUEdQIKnH6McZI9E1G1wuHD4WM5tTfVw2S+HqQOWnglMyoX27TmGxTvSIsRJJhNER
	 Zy4q6VzYNG40+uakzTgpLT/AkZ2Vk50W7WmjPlQn3w5+36/H/+5u08a4n9Nxi9ChyO
	 Sd91TVbVPU6uA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 744F2D84BB7;
	Fri,  8 Mar 2024 09:56:46 +0000 (UTC)
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
 <170989180647.23534.17061285677214871615.git-patchwork-housekeeping@kernel.org>
Date: Fri, 08 Mar 2024 09:56:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add QPIC SPI NAND driver (2024-03-08T09:17:47)
  Superseding: [v3] Add QPIC SPI NAND driver (2024-03-07T04:17:21):
    [v3,1/5] spi: dt-bindings: add binding doc for spi-qpic-snand
    [v3,2/5] drivers: mtd: nand: Add qpic_common API file
    [v3,3/5] spi: spi-qpic: Add qpic spi nand driver support
    [v3,4/5] arm64: dts: qcom: ipq9574: Add SPI nand support
    [v3,5/5] arm64: dts: qcom: ipq9574: Disable eMMC node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


