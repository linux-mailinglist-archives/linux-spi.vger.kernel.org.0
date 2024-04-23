Return-Path: <linux-spi+bounces-2465-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4598AE32F
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 12:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD09D28C6A7
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2416B605CE;
	Tue, 23 Apr 2024 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbfLQaoG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00425629E6
	for <linux-spi@vger.kernel.org>; Tue, 23 Apr 2024 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869804; cv=none; b=HSFORUz7jjr1bozOzHd7ZeyBXmcjftZgB5h8mtOVfooZefjPwQsY70ibV8HNNkIZwmi1UGpdqf+/YXgAO5pu6V7rKvILoWJfOpwwmUeUzkpaA/Xz1Sx4FUAiNHunBeg4lYwQoOU7+7GGb4p4XYAzqQm+9CK6MIbQgEKWabxueWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869804; c=relaxed/simple;
	bh=UuVo3wC4k6kzhMyybMhA4kYophdR+w5Jk8pcEXABReU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=D6R6urhrB2hiEJlD5bM9qkWscyBr4f8nIoga2bUnp0ZQ3o+0IJtRJMElZiVJ2vjs43VC9RtmKKXoHVjt5ohZlQN3U0CLuZKQfM69ICtHBb7qe4o7ln3etbDqioubqpjFTvRe5CbI/5WhPBJKQMRVQQLMU5HoYdTxqvajroQLg84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbfLQaoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87E7EC116B1;
	Tue, 23 Apr 2024 10:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713869803;
	bh=UuVo3wC4k6kzhMyybMhA4kYophdR+w5Jk8pcEXABReU=;
	h=Subject:From:Date:To:From;
	b=pbfLQaoG5DFLSDfcjorXt6ajI9kT1kq7VG6hTx07EnPKLB7D4DYUjasHffPi/4dbs
	 nLqgj35M60HPobERQmzACYTAngOqu7lGw/8A4FY4EjYLTt3UtwTQhJwzfyJyPns/6o
	 LN7jAROU026QlvOi4PZCKdtDsAAHkrzj6onLJLZQz063fx4Za3CINgpBLCwonFyZYI
	 5oVLb/8k02Rk39221t5xdhny/ERGrkUGcgPH+OsWHgey+8OhHCWP5YjcVz7uuT9zt1
	 hsDqaN+dcbpH9glXuCclmZM33rA9trmQglnyrx8gm89KSK/fwJnaNO4SU/yfMrsTT5
	 jyyyH0gpz1RVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F639C4339F;
	Tue, 23 Apr 2024 10:56:43 +0000 (UTC)
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
 <171386980351.21871.7692761689279497855.git-patchwork-housekeeping@kernel.org>
Date: Tue, 23 Apr 2024 10:56:43 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: cadence-qspi: add Mobileye EyeQ5 support (2024-04-23T10:01:43)
  Superseding: [v3] spi: cadence-qspi: add Mobileye EyeQ5 support (2024-04-10T09:29:06):
    [v3,1/9] spi: dt-bindings: cdns,qspi-nor: sort compatibles alphabetically
    [v3,2/9] spi: dt-bindings: cdns,qspi-nor: add mobileye,eyeq5-ospi compatible
    [v3,3/9] spi: dt-bindings: cdns,qspi-nor: make cdns,fifo-depth optional
    [v3,4/9] spi: cadence-qspi: allow FIFO depth detection
    [v3,5/9] spi: cadence-qspi: add no-IRQ mode to indirect reads
    [v3,6/9] spi: cadence-qspi: add early busywait to cqspi_wait_for_bit()
    [v3,7/9] spi: cadence-qspi: add mobileye,eyeq5-ospi compatible
    [v3,8/9] MIPS: mobileye: eyeq5: Add SPI-NOR controller node
    [v3,9/9] MIPS: mobileye: eyeq5: add octal flash node to eval board DTS

Latest series: [v3] Add add SPI-NAND Flash controller driver for EN7581 (2024-04-23T10:16:34)
  Superseding: [v2] Add add SPI-NAND Flash controller driver for EN7581 (2024-04-17T06:45:49):
    [v2,1/3] dt-bindings: spi: airoha: Add YAML schema for SNFI controller
    [v2,2/3] arm64: dts: airoha: add EN7581 spi-nand node
    [v2,3/3] spi: airoha: add SPI-NAND Flash controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


