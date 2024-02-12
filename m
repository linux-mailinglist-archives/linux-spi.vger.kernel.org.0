Return-Path: <linux-spi+bounces-1290-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D634851765
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 15:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3BA1C21504
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6823BB51;
	Mon, 12 Feb 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmXMwLLX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7633BB47
	for <linux-spi@vger.kernel.org>; Mon, 12 Feb 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749783; cv=none; b=dr8nnsx7GiFeL2pzzPuWwu4PuuPDykt92pVEMy2TqjBua6Bs4eTtkd2BHI45vEVrY4CmsGhZXtpMybS2qbGnMnyT0vLKPxBTyDKO0Air7Jo97K/UJoVB/eMfqR4QxfyUECYILKEmV4qNt6jSlQTtJTgW+5t7AMwIFRmaze+k0TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749783; c=relaxed/simple;
	bh=51VjflcDt3T15Hokph/CqdEWYezSite4fUZ+zQI5Fas=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TeJl/oRRyoW4LYgARp/ExXc9fCAiC621beDBkCWSHu1PPaprx06h6Av9bmwp0ikqX4QDY3uWTMJScR4DrqMqsXuhekkdSGe3YRWwbocvUewuyENU/3h2bSN2PoflRPivMnhuBLAGpHxK+9sUsEE2djYVE+wugEOgC4iJQzbGzes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmXMwLLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85EDCC433F1;
	Mon, 12 Feb 2024 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707749782;
	bh=51VjflcDt3T15Hokph/CqdEWYezSite4fUZ+zQI5Fas=;
	h=Subject:From:Date:To:From;
	b=PmXMwLLXpv6RyU8O6Y1PWtHlq1IZ4s+0i1mvVOloPjXvyb57f3+ozs8Xbnp2/YPV3
	 TobEIXMdDHmx1jRAaZYBXOnjvD1IJjIkMj0MajPwvCm55ccg+npr1OP9GeqRLn1nmV
	 1Sq/Cbo2L9Vnbc3rDRhxiLCoeYDbmzgFKfknSz1nGwwJh/y7mtum3JotfFgDW5Lpgw
	 SnHHLiHKn4qXJGMdBHacFLPnh9+sT4JlpSFQgivCU9j1jmPrZiKbXh/EriqejpYAkh
	 gL6rjGJbpBByOUSHK5tCjDWw7Tkut9m/IR+cIrp/6W4mefdiuKIbhJZFZ3KtR0ZKiz
	 EDKjqaBHcmatA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68111C4166E;
	Mon, 12 Feb 2024 14:56:22 +0000 (UTC)
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
 <170774978242.21665.5940871540806390710.git-patchwork-housekeeping@kernel.org>
Date: Mon, 12 Feb 2024 14:56:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: s3c64xx: remove OF alias ID dependency (2024-02-12T14:03:19)
  Superseding: [v1] spi: s3c64xx: remove OF alias ID dependency (2024-02-08T13:50:34):
    [01/12] spi: dt-bindings: introduce the ``fifo-depth`` property
    [02/12] spi: s3c64xx: define a magic value
    [03/12] spi: s3c64xx: allow full FIFO masks
    [04/12] spi: s3c64xx: determine the fifo depth only once
    [05/12] spi: s3c64xx: retrieve the FIFO depth from the device tree
    [06/12] spi: s3c64xx: allow FIFO depth to be determined from the compatible
    [07/12] spi: s3c64xx: let the SPI core determine the bus number
    [08/12] spi: s3c64xx: introduce s3c64xx_spi_set_port_id()
    [09/12] spi: s3c64xx: get rid of the OF alias ID dependency
    [10/12] spi: s3c64xx: deprecate fifo_lvl_mask, rx_lvl_offset and port_id
    [11/12] spi: s3c64xx: switch gs101 to new port config data
    [12/12] spi: s3c64xx: switch exynos850 to new port config data


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


