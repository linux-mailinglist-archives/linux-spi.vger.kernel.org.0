Return-Path: <linux-spi+bounces-9981-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B47AB527F1
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 06:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50511C80416
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 04:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D4724DD15;
	Thu, 11 Sep 2025 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5fRvLEN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2CA23D7EA
	for <linux-spi@vger.kernel.org>; Thu, 11 Sep 2025 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757566615; cv=none; b=es+6SA7iQ2JTK9iFiNsxbb5lnmZNC0MwL8I44RaLvjFw4Lvqh1AZK5jtGumeH3bMyrjxtLFwhWQMxTv0BdFHZhhe4rRkeqAZKzHKFt7Un8CFuEEsOC5v4XXyLKD09+6y+hr/R46r2npFWvcJ+elWNOcxkODgd3wOD48xVpGW+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757566615; c=relaxed/simple;
	bh=by2Dd+iXbJ4cw5LN++tSgdP45TIBhpXcLtxYEtywsug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=vEujQm/+nFDlC9vgXxqxCyKURyP4ztXChRTgLilmgsZG+K2D8JqR3FE3qJWCLMpYwtk2B4LoDizNnC0hD+72hnTuueE7Yvs41444vx7g686fLQaFiwO6DoKOw0I96x7vSvnsos2iuezkajd0tyoYfKwjPo+MKdqXwc3cJ7rby98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5fRvLEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0307FC4CEF1;
	Thu, 11 Sep 2025 04:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757566615;
	bh=by2Dd+iXbJ4cw5LN++tSgdP45TIBhpXcLtxYEtywsug=;
	h=Subject:From:Date:To:From;
	b=D5fRvLENw3t5sXd/Fr7AaHyzrYEGMBVJxqOpOxf9rnhy6V/bobuBO1840Yq3zy0da
	 xzbjh54xMvKB8IWQ1fATA4dYbqj4yzqfltsReC6PnQnWPLerdhfd9yNcdVJQEaOJZN
	 rVppqBoqhemwghnDM7W9HNe6s3fQ/2val2I6ITfbPBR71e/KBzt9wYXf8UsE93LCcS
	 LLYU8RimTAZ83S8eqK+GXbzsZdpaHoRKHJOHCybUr3HtPSgdIbkE7bhNSNM/rVtwk7
	 sEx667039wliyfmtKPX/3ysaZyUwppUFQbCIuVHTgoqkqsGEj1VL6Miuo0fRHZ2WfB
	 1+AJUxJf+RiKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF5A383BF69;
	Thu, 11 Sep 2025 04:56:58 +0000 (UTC)
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
 <175756661740.1661287.13789857483478882841.git-patchwork-housekeeping@kernel.org>
Date: Thu, 11 Sep 2025 04:56:57 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] Add support to load QUP SE firmware from (2025-09-11T04:32:50)
  Superseding: [v6] Add support to load QUP SE firmware from (2025-08-22T07:26:45):
    [v6,1/6] dt-bindings: qcom: se-common: Add QUP Peripheral-specific properties for I2C, SPI, and SERIAL bus
    [v6,2/6] soc: qcom: geni-se: Cleanup register defines and update copyright
    [v6,3/6] soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem
    [v6,4/6] i2c: qcom-geni: Load i2c qup Firmware from linux side
    [v6,5/6] spi: geni-qcom: Load spi qup Firmware from linux side
    [v6,6/6] serial: qcom-geni: Load UART qup Firmware from linux side


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


