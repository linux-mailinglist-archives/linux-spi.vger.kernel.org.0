Return-Path: <linux-spi+bounces-4915-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C4B97E159
	for <lists+linux-spi@lfdr.de>; Sun, 22 Sep 2024 13:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73FE9B20C14
	for <lists+linux-spi@lfdr.de>; Sun, 22 Sep 2024 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37C4CE13;
	Sun, 22 Sep 2024 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tovZvvM1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C24C36C
	for <linux-spi@vger.kernel.org>; Sun, 22 Sep 2024 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727006206; cv=none; b=eyin/aQ+tKR87VM73A+a8S3E+2fW5ENE32POIGSdTGcsHViRzqIeBCvbtUhFrOeIjrRlqxL+kD5xAM0Fcj7UqnMI9Vwli9Uc/BoBBcORCLbmJrNO8GbRi7fTlzNJbf1uvoq5tQ//vm8UN+UNGILxHbd6dO3qwQ+k+yHIxKoQ4VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727006206; c=relaxed/simple;
	bh=+FAwtW7bxUjrzuGSbnStDjZIl8MynKU9LeN3r92iNkc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uraedNregZ+3BzTDaAWejvbMqGlj3k3dinnn/mOdUXPq5tC1AdX6QmzxojgaSmD+hEHBfYmxP9dXzaW0uw+eLbsX1zdSpUejj1lipG5gJ9vm5bN5TI2be/NrcWq080nNcj4Xgkyyyh0BT85Oc7wrm6bpqphDxUHtN7BGmzBm8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tovZvvM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC9DC4CEC3;
	Sun, 22 Sep 2024 11:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727006206;
	bh=+FAwtW7bxUjrzuGSbnStDjZIl8MynKU9LeN3r92iNkc=;
	h=Subject:From:Date:To:From;
	b=tovZvvM1ahBzbo3qgrG03gqRHd9Ni2OJC8dyFQgu+YB95Hc+NA/MWldAZYK+Yhg5i
	 lKPeDrNMz7bq8OtjMsQ2G2x7BUHAlWLYSndiYDR6cpF94NYP1ldvsYbP9ePujhCUjA
	 REQ+Ki/VK+LEY5XysClJ9gScDX7/E/DAuMGC9dMkS1yoEuGTQYSdi3qWgTa6VfGp6x
	 txSkb+QS1TI7Cf9fc9LF3u43g4piElMIScJDw1D4sKDmYlXcu7s8oZV9c46dcX/2Pn
	 6qxGonUsjLXKPYzvBAcnk8hiF7FVfC0j5CtAIsfLIcKcMOAlbIuWp4uIAfHbV7JvJ3
	 bJg5+o9AiXjTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C643806655;
	Sun, 22 Sep 2024 11:56:49 +0000 (UTC)
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
 <172700620811.2740032.7509033284075791352.git-patchwork-housekeeping@kernel.org>
Date: Sun, 22 Sep 2024 11:56:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v10] Add QPIC SPI NAND driver (2024-09-22T11:33:44)
  Superseding: [v9] Add QPIC SPI NAND driver (2024-09-12T06:14:56):
    [v9,1/8] spi: dt-bindings: Introduce qcom,spi-qpic-snand
    [v9,2/8] mtd: rawnand: qcom: cleanup qcom_nandc driver
    [v9,3/8] mtd: rawnand: qcom: Add qcom prefix to common api
    [v9,4/8] mtd: nand: Add qpic_common API file
    [v9,5/8] mtd: rawnand: qcom: use FIELD_PREP and GENMASK
    [v9,6/8] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
    [v9,7/8] arm64: dts: qcom: ipq9574: Add SPI nand support
    [v9,8/8] arm64: dts: qcom: ipq9574: Disable eMMC node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


