Return-Path: <linux-spi+bounces-2979-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE16E8CADB6
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 13:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B4B1C220BD
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AACF6CDC4;
	Tue, 21 May 2024 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDhsVSQX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4B487BC
	for <linux-spi@vger.kernel.org>; Tue, 21 May 2024 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292601; cv=none; b=fWAn+38kUPG6jpJkkX2Q5L2e0N/r7ORugYzvm0O9UCWgRozb2F/Y6DhITsiHlCClAOIHYX5/dSthJbhJf1gF/Rcl4wBKASlBMvZw64SVxz1vabzm3sA38/t4BfAsvYs6iySLeU18iPPBB2aQKbCvESCLGAjDTQRD8kvVDXIOZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292601; c=relaxed/simple;
	bh=5dMklATHOY51J7JACBUTX4Lr5F++GJOuY2wa0BIyUDg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Fx8yH4NeA/hIRi2KmwGH3kOiX1lugiFNFQBWdkUHzWIT/Uu5q1AmqsgwNj3XcPDdbmCbDoYHhB6jihazM+4ndjuLtiDzrW/R6ngEQyS9X/3aBkqRY3IPHqpgPQ+PwAVQIOZO3ffewUgvP6KPgQ+f2oxlmQagvOd7aFYN0cJCC2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDhsVSQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DB91C2BD11;
	Tue, 21 May 2024 11:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292600;
	bh=5dMklATHOY51J7JACBUTX4Lr5F++GJOuY2wa0BIyUDg=;
	h=Subject:From:Date:To:From;
	b=HDhsVSQXMIk86ttbMpNxfZ/NioDvlN0eAp2utT2OX56PGF+8uJvp0xbKvCp8Qr7zF
	 6RhjTT2sbKjg3RCZr1FGaCJDLNjxX/X0hCgFKd2XjD8Hgt8fQryo4Zz+katyQ9G+ny
	 HNJXWjDvbAAWwsWvcsm8msF1KtEGHbYHxnYbIzLbygsCN9fztM18qax9TJekEqmL5S
	 MDR0YFXNueX3Ac+hGy3yFOcj+u3SDmUmffVU2M4KUbcPTG8QZ4W52tGPNvz83WXhyy
	 1WQp/KyQn+Jyb2AaMN/GWZxTG7LZQkwWznhzSN00SOMAwP81vLThSy1Z4ludInVrBr
	 2vtvv99jCFKMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7949EC54BB1;
	Tue, 21 May 2024 11:56:40 +0000 (UTC)
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
 <171629260049.12868.4443870093761160160.git-patchwork-housekeeping@kernel.org>
Date: Tue, 21 May 2024 11:56:40 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] Add QPIC SPI NAND driver (2024-05-21T10:55:24)
  Superseding: [v5] Add QPIC SPI NAND driver (2024-05-08T08:36:36):
    [v5,1/7] spi: dt-bindings: Introduce qcom,spi-qpic-snand
    [v5,2/7] mtd: rawnand: qcom: cleanup qcom_nandc driver
    [v5,3/7] mtd: rawnand: qcom: Add qcom prefix to common api
    [v5,4/7] drivers: mtd: nand: Add qpic_common API file
    [v5,5/7] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
    [v5,6/7] arm64: dts: qcom: ipq9574: Add SPI nand support
    [v5,7/7] arm64: dts: qcom: ipq9574: Disable eMMC node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


