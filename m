Return-Path: <linux-spi+bounces-6927-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7BBA44E13
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 21:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EC31893AA3
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 20:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B2A1A0BCD;
	Tue, 25 Feb 2025 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgTV/rWQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4FDF59
	for <linux-spi@vger.kernel.org>; Tue, 25 Feb 2025 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516982; cv=none; b=JUfdPX2/dj80WXjUcf8wHItfXU/LIjyFxTsqCd+6sykt3aHcogblvm9VJP4XNvUlXzJs+OzQiX0y+0KsVNbQTcdsur+jJQw4HtcP1YrifAWJDYnnVYpeHHT89PdOk4rf4nlaYFh4qbEvbf+JF8wn1UjUWMsoCuFD3gkqsn7c0P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516982; c=relaxed/simple;
	bh=XeLpCyakC0JcWJtU8cU4XH9U4vXJU8HP1QDNs2mv3+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gvX10QB7x7+ZI3W1yMH2jr8GB1ZXfXuW4qLwHz8eWUbMopX3VwflGwkE/WfNcL3aMwkv8kogZ6J3KvXK29KBlTsdrWnpyav6H/Rd9v71EcESMAjuMQ3BG0mtg7uEJnpekigLICZhq5q218IirQUVFx4vCIlpP/TetsmsDNz2uFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgTV/rWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EE0C4CEDD;
	Tue, 25 Feb 2025 20:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740516981;
	bh=XeLpCyakC0JcWJtU8cU4XH9U4vXJU8HP1QDNs2mv3+A=;
	h=Subject:From:Date:To:From;
	b=XgTV/rWQ6aKjwxNyZJ81Ywz4hb9Rb9k50Bq6NOHeBcsbAgAdCaMJXx0pfw1cV0M49
	 bzuKMyIUIsLfFoONga3H/gTz52ivuhJ5CIb+OzmsR/DNh1lGvBm2CsRCYkgL13UaRo
	 sk4C+viD8NV5sCYZteE3lIXtX+LlFSdbPmSSjejwbulCPEfc3oj06sajsI22toQrq/
	 /J0sOjvDfif3WSS8DIRMQF25pLAwDWMvhzdqSUSfhzaLlRY97ykuBRnbuobcrYoCFR
	 CQtz+82nTpx1eLAnBZ9zqrDzqjLcZxD6oyaK1EsMGSwVuP9heASyC4pyeRoFk2mTxR
	 uI/gjDk1zOGpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711DC380CEE8;
	Tue, 25 Feb 2025 20:56:54 +0000 (UTC)
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
 <174051701305.123395.11441865229931825152.git-patchwork-housekeeping@kernel.org>
Date: Tue, 25 Feb 2025 20:56:53 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Converge on using secs_to_jiffies() part two (2025-02-25T20:17:15)
  Superseding: [v1] Converge on using secs_to_jiffies() part two (2025-01-28T18:21:45):
    [01/16] coccinelle: misc: secs_to_jiffies: Patch expressions too
    [02/16] scsi: lpfc: convert timeouts to secs_to_jiffies()
    [03/16] accel/habanalabs: convert timeouts to secs_to_jiffies()
    [04/16] ALSA: ac97: convert timeouts to secs_to_jiffies()
    [05/16] btrfs: convert timeouts to secs_to_jiffies()
    [06/16] rbd: convert timeouts to secs_to_jiffies()
    [07/16] libceph: convert timeouts to secs_to_jiffies()
    [08/16] libata: zpodd: convert timeouts to secs_to_jiffies()
    [09/16] xfs: convert timeouts to secs_to_jiffies()
    [10/16] power: supply: da9030: convert timeouts to secs_to_jiffies()
    [11/16] nvme: convert timeouts to secs_to_jiffies()
    [12/16] spi: spi-fsl-lpspi: convert timeouts to secs_to_jiffies()
    [13/16] spi: spi-imx: convert timeouts to secs_to_jiffies()
    [14/16] platform/x86/amd/pmf: convert timeouts to secs_to_jiffies()
    [15/16] platform/x86: thinkpad_acpi: convert timeouts to secs_to_jiffies()
    [16/16] RDMA/bnxt_re: convert timeouts to secs_to_jiffies()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


