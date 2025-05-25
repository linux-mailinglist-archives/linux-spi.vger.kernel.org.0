Return-Path: <linux-spi+bounces-8284-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1134AC3592
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 17:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8EF7AB240
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D4A46447;
	Sun, 25 May 2025 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYrzYQ6/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5FE12B73
	for <linux-spi@vger.kernel.org>; Sun, 25 May 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748188577; cv=none; b=GQu00ME7G8XdIxHygxDKx2u8aPqjjEi+wSkasa5ZP7m8zdWDdJfT1wgJVDyws+yMKvB8y2k/TjyBKzCK2WVg9g2HUDB63zOkVrDB3zlDGUYVGfrsFdqOCrMCvOKYAT9FI5MWapyFXN0W3f8IQIRZSUhl/ZpXzPaDBzi3ABqqQy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748188577; c=relaxed/simple;
	bh=8yfP/QOdcoNpY+caA8QnMPfzZ+oZyPldh2aLFhI9YzE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=cFVDuveGU3XccOlUyhzjAn9MTK6ZDAnfLGAnSrFDFXKCZOAwjJw2y68cwk2YnkeJs2WOBxS2jgV3t31lVlU3kutIFr/2y+H+ke/FO4i5qCbLfT7WIIZgzbK4HYgfjRzl4XQeQtqlWPJL1DetVtaj1+UqlhBbAPu2QKd9rDXTsco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYrzYQ6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C6BC4CEEA;
	Sun, 25 May 2025 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748188576;
	bh=8yfP/QOdcoNpY+caA8QnMPfzZ+oZyPldh2aLFhI9YzE=;
	h=Subject:From:Date:To:From;
	b=iYrzYQ6/45HCLsabm/pxpCn1E/+hwcw+nTOqyt8J1PX0IXDgUOIuosmN61+87burF
	 6gX/MZu5Lm3BD8YCCc124yhxJX8BjLRe8dPzYyWGvS++tqvUeUFbpUAJFADPdTECc6
	 29MJ9/0bfUVU/KIYhNrkItpTmVO8qquHbTdkeSI3A0ivAIwB7mn/7IwXNINnMRGlMW
	 0aMOVwSSkmTrrDWMdC8cJhlhYXsEt9SG9TPvbHICINMqOD6wCz+k1LtD/001baTJI0
	 5voIF2UgsTjp6khnEwhM/ZOha6Cbpd8SRb7ztnXcRCeIyzA3E3kjkvdiNcHeQ1ksdG
	 8x9WepIiBb3jA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE36E380AAFA;
	Sun, 25 May 2025 15:56:52 +0000 (UTC)
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
 <174818861126.4165819.2114360754389115111.git-patchwork-housekeeping@kernel.org>
Date: Sun, 25 May 2025 15:56:51 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: sophgo: Add SPI NOR controller for SG2042 (2025-05-25T14:58:40)
  Superseding: [v1] spi: sophgo: Add SPI NOR controller for SG2042 (2025-05-23T10:54:48):
    [1/3] dt-bindings: spi: Add bindings for SOPHGO SG2042
    [2/3] mtd: spi-nor: Add GD25LB512ME GigaDevice flash_info
    [3/3] riscv: dts: sophgo: Add SPI NOR node for SG2042


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


