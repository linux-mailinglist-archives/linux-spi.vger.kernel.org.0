Return-Path: <linux-spi+bounces-7786-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B4AA9EE71
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 12:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC7A3B4540
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5371525F796;
	Mon, 28 Apr 2025 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFbjI2bb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24925E80F
	for <linux-spi@vger.kernel.org>; Mon, 28 Apr 2025 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745837772; cv=none; b=FJj5qdA/Ja9jYlViMrbgU5pwn24PLTmmLm5VmSMZtRveHAPoqHiXkXb+Lv2S8VrUNvVGvD46ZQVFhBcJUab0Jw6I5kQrVHLqSIcb5Y6XYPT7P4nVOBmCW6LrvWord7ZPIwfvrWGj+JfGnef7xQDJal3kzg8GRk2j8P5yhsbgorY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745837772; c=relaxed/simple;
	bh=OpAxfLbWOwFq1jWVPg+swF1TzVC/HzS4bbogAdgJpF0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Y/dmWs7rJLCV3U/D3Ri/qcrFoF/94ju8XiuQCFFzI4WA0cDrW/6sFsM9QxXRMEBJdsC9HrNRj5JKtpfLuwX1uOsR05+orAYGAuRYb8EWPrx0P5MyhQTd5qTjrhKsPTasiBq/n2wcYsq60wCVVxj0+47GECWOZdCOfYJvnfj6L9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFbjI2bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2700C4CEE4;
	Mon, 28 Apr 2025 10:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745837771;
	bh=OpAxfLbWOwFq1jWVPg+swF1TzVC/HzS4bbogAdgJpF0=;
	h=Subject:From:Date:To:From;
	b=DFbjI2bb8N7NJv2NQ7+Qn8VOlgt5mhRdqZ2CVe5dAr385i+ihftBMeXkILKNnq3Oa
	 rU6sns9ay5+SY1LhOYxrIkVKa5lVkFIGW5xRfTsfmYpsWrEQbjfksRX171oCMNsSPS
	 PbRSw+POGAjgvCjgDK0n7l7ej2B441ej4hECHGhk+5VCbIZq/gC+n07xU8g7rFA3m7
	 y5TrYXx4luUOvkK69f9KPlQqy1dafZ2BJ4Y7nSZry10FIOHS5QYma6rMqv7Dz4CJ+O
	 cE6UALK+dKSlUDWi2Fgso2f8wOb+iV/NrlhNldS96q+ez8kfz01wHGAed2hBwP/Ty+
	 9RxNfCZksIGyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE2B3806651;
	Mon, 28 Apr 2025 10:56:51 +0000 (UTC)
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
 <174583781015.535276.13484770993579909504.git-patchwork-housekeeping@kernel.org>
Date: Mon, 28 Apr 2025 10:56:50 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] This patch set did some clean up and add runtime pm support for flexspi driver (2025-04-28T10:06:42)
  Superseding: [v2] This patch set did some clean up and add runtime pm support for flexspi driver (2025-04-24T07:33:24):
    [v2,1/5] spi: spi-nxp-fspi: remove the goto in probe
    [v2,2/5] spi: spi-nxp-fspi: enable runtime pm for fspi
    [v2,3/5] spi: spi-nxp-fspi: use guard(mutex) to simplify the code
    [v2,4/5] spi: spi-nxp-fspi: remove the unchecked return value for nxp_fspi_clk_disable_unprep
    [v2,5/5] spi: nxp-fspi: use devm instead of remove for driver detach


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


