Return-Path: <linux-spi+bounces-5186-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF4D997FDE
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 10:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24F41C20FA1
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 08:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE389202F8E;
	Thu, 10 Oct 2024 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYJyUA9Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F04202F8C
	for <linux-spi@vger.kernel.org>; Thu, 10 Oct 2024 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546976; cv=none; b=qaTltxlOAXeojnPNbhiyVWzuH8bmxkn2PGNxGRKwwMpYt2AZd30iphe+chGAQxLYwkkJnTkQBkDBfvSFltzHtYU2XzvhWp5I5viMMuCHrOWNr0tIDlVieaBPAFDg7yITPomPu8naTThznHPzZen27ERrfveokgtPIZacR6LNvSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546976; c=relaxed/simple;
	bh=5mRT/rQ/CVOl/teggNvjY5Wc/x1fhaFt6y4nOGDR9B4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=R5sWb8yH/+/ZZjSuvmRARxzss1S94CL7yzDRye+lhyPc0UwIRiUwufrgrmYaQDTGRqxv+HMGa2GOesLHVSVm5qctdaSuq9N99/yKu6MSB0AJidEukNK1UYa4t8k/Nc3OyB0OlMUPovEK/LPwNdQy3dwEpB1KYg64hz49/4xTDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYJyUA9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA64C4CEC5;
	Thu, 10 Oct 2024 07:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728546976;
	bh=5mRT/rQ/CVOl/teggNvjY5Wc/x1fhaFt6y4nOGDR9B4=;
	h=Subject:From:Date:To:From;
	b=bYJyUA9Q1brSVmZGbrvbBJZ9kZ7fpP3KFAKYb01pZKwqje/ZATqMguyv/i9a878j3
	 CuIjtOHTAAK0HynV9Gc5IHT9WUZaHbOHhjTHmC0cku5j75RyfceXh5C1rtTMy4J4vW
	 UCXPmoxANmQ/uNuZGV4CPcccxTuprUFJ9iPT2fvZ2dpr5LtnsRT3+zCWzB1MrGDjIL
	 9XqZ9TcozyrDbzapGFomfKE+eu51yUK/yd+h6i+Yk+w8Xp9rgVY/9dNoMvRwdublly
	 s/XPI49L+1ysFS36SPtQbJ5s+psAbZOmfymYPK2w3IA3DcdXSfzOmPczUHgrnW2X1j
	 lCPYCiSmklrWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3563803263;
	Thu, 10 Oct 2024 07:56:21 +0000 (UTC)
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
 <172854698038.1917615.5911951440954928088.git-patchwork-housekeeping@kernel.org>
Date: Thu, 10 Oct 2024 07:56:20 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v11] Add QPIC SPI NAND driver (2024-10-10T07:05:02)
  Superseding: [v10] Add QPIC SPI NAND driver (2024-09-22T11:33:44):
    [v10,1/8] spi: dt-bindings: Introduce qcom,spi-qpic-snand
    [v10,2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
    [v10,3/8] mtd: rawnand: qcom: Add qcom prefix to common api
    [v10,4/8] mtd: nand: Add qpic_common API file
    [v10,5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
    [v10,6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
    [v10,7/8] arm64: dts: qcom: ipq9574: Add SPI nand support
    [v10,8/8] arm64: dts: qcom: ipq9574: Disable eMMC node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


