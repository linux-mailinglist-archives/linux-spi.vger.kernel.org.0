Return-Path: <linux-spi+bounces-10622-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD090BD9285
	for <lists+linux-spi@lfdr.de>; Tue, 14 Oct 2025 13:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8D73E3F48
	for <lists+linux-spi@lfdr.de>; Tue, 14 Oct 2025 11:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2472DE1E5;
	Tue, 14 Oct 2025 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGLievE0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C513D539
	for <linux-spi@vger.kernel.org>; Tue, 14 Oct 2025 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443009; cv=none; b=V9ta0aF9FHcQ6GgBvQSWza333Pt4IO/BEoYF1KQ+KMjV2aQxnfRJUys3H1Q4lukvbic7PgMURh/gRXwXevcDYAk8Y+6Yx5/RXzNEKE5zZcsTvuMRzHU9MyWmX94eih02TEGC7hGP2F4isxXm9QzR5HdJuS1jN0xjbanjvl9/ZrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443009; c=relaxed/simple;
	bh=xxedY9PodSTngWkAo3JXjt8lShParKS0bnueO+pw0Dc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KcuTJCU7BkowoUu5ZgMGwvw4Y4P2f7DHdOYos16w9PF3NdZGWHgtoC9QJZljeIkvKEigpBWzkpIAQfqSQNyj9DB39JiMA8Tmq8wr2v9X1uKPQKNlW0Is0jRC1B6U8ipcBFVAukAdlkfskFng3XkIm379HZO5ZCBHUPD6nqvLu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGLievE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61254C4CEFE;
	Tue, 14 Oct 2025 11:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760443009;
	bh=xxedY9PodSTngWkAo3JXjt8lShParKS0bnueO+pw0Dc=;
	h=Subject:From:Date:To:From;
	b=rGLievE0m5Ta5ZOIQ2Oj59ugvxEVQnRft7optMa3a3zhJdxnONebdRBpkJ4oEeM/n
	 FSTIXK7oPAB3vepnLkIY8y0N/c1q0bKpaJxWi6s4jF2ZUdu6qhjFBxjmGA73RxCqo/
	 0j7rCPopw4MR0ZH2ZDWaUFOqL8pjDwBfvAargMBF1sKp+yK1ntjyMrUiiN0yyGeIGF
	 O32D/DOOh8kbhLqzwN9WAv2z+8Dx0MlOvO6Y9vz8smLGGbnyy/Je2/TyyiKoMZZeRM
	 5F+l2z759UGOoiHWT9AojJCTOHuf49xIZb/Q8Sstf+gJMJaK3Wbcf8K1bJdEaQwo84
	 UL13532HNdUZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1C380AA50;
	Tue, 14 Oct 2025 11:56:35 +0000 (UTC)
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
 <176044299444.3705812.9943178381112226040.git-patchwork-housekeeping@kernel.org>
Date: Tue, 14 Oct 2025 11:56:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add QPIC SPI NAND support for IPQ5424 and IPQ5332 platforms (2025-10-14T11:05:25)
  Superseding: [v2] Add QPIC SPI NAND support for IPQ5424 and IPQ5332 platforms (2025-10-08T09:04:04):
    [v2,1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424 compatible
    [v2,2/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5332 compatible
    [v2,3/9] dma: qcom: bam_dma: Fix command element mask field for BAM v1.6.0+
    [v2,4/9] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND controller support
    [v2,5/9] arm64: dts: qcom: ipq5332: Add QPIC SPI NAND controller support
    [v2,6/9] arm64: dts: qcom: ipq5424-rdp466: Enable QPIC SPI NAND support
    [v2,7/9] arm64: dts: qcom: ipq5332: Enable QPIC SPI NAND support
    [v2,8/9] arm64: dts: qcom: ipq5424-rdp466: Remove eMMC support
    [v2,9/9] arm64: dts: qcom: ipq5332-rdp442: Remove eMMC support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


